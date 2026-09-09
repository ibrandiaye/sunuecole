<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Http\Requests\Paiement\StorePaiementRequest;
use App\Models\Paiement;
use App\Models\Eleve;
use App\Models\Classe;
use App\Models\TypePaiement;
use App\Models\AnneeScolaire;
use Illuminate\Http\Request;
use Barryvdh\DomPDF\Facade\Pdf;

class PaiementController extends Controller
{
    public function index(Request $request)
    {
        $query = Paiement::with(['eleve', 'typePaiement'])->latest();
        
        if ($request->has('search')) {
            $search = $request->get('search');
            $query->whereHas('eleve', function($q) use ($search) {
                $q->where('nom', 'like', "%{$search}%")->orWhere('matricule', 'like', "%{$search}%");
            });
        }
        
        if ($request->has('eleve_id')) {
            $query->where('eleve_id', $request->eleve_id);
        }

        $paiements = $query->get();
        return view('paiements.index', compact('paiements'));
    }

    public function create(Request $request)
    {
        $eleves = Eleve::all();
        $types = TypePaiement::all();
        $selected_eleve_id = $request->get('eleve_id');
        $selected_type_id = $request->get('type_paiement_id');
        $selected_mois = $request->get('mois');

        $activeYear = AnneeScolaire::where('active', true)->first();
        $moisList = AnneeScolaire::getMoisScolaires($activeYear);

        // S'assurer que le mois sélectionné est présent dans la liste s'il a été passé en paramètre
        if ($selected_mois && !array_key_exists($selected_mois, $moisList)) {
            $moisList[$selected_mois] = $selected_mois;
        }

        return view('paiements.create', compact('eleves', 'types', 'selected_eleve_id', 'selected_type_id', 'selected_mois', 'moisList'));
    }

    public function store(StorePaiementRequest $request)
    {
        $annee = AnneeScolaire::where('active', true)->first();
        $baseData = $request->validated();
        
        // Recalculer le montant dû selon les tarifs et remises
        $eleve = Eleve::with('inscriptionActuelle', 'classe.niveau')->find($baseData['eleve_id']);
        $type = TypePaiement::find($baseData['type_paiement_id']);
        
        $tarifBase = $this->calculateTarifBase($eleve, $type, $annee);
        
        $remise = 0;
        if ($eleve->inscriptionActuelle) {
            if ($type->code === 'INSCR') {
                $remise = $eleve->inscriptionActuelle->remise_inscription;
            } elseif ($type->code === 'MENS') {
                $remise = $eleve->inscriptionActuelle->remise_mensualite;
            }
        }
        $montantDu = max(0, $tarifBase - $remise);
        $restePayer = max(0, $montantDu - $baseData['montant_paye']);
        $statut = 'partiel';
        if ($restePayer <= 0) $statut = 'paye';
        else if ($baseData['montant_paye'] == 0) $statut = 'impaye';

        $paiement = Paiement::create($baseData + [
            'reference' => 'PAY-' . strtoupper(uniqid()),
            'annee_scolaire_id' => $annee ? $annee->id : null,
            'montant_du' => $montantDu,
            'reste_a_payer' => $restePayer,
            'statut' => $statut,
            'encaisse_par' => auth()->id()
        ]);

        return redirect()->route('paiements.index')
            ->with('success', "Paiement de {$paiement->montant_paye} FCFA encaissé avec succès !");
    }

    public function receipt(Paiement $paiement)
    {
        $paiement->load(['eleve.classe', 'typePaiement']);
        $pdf = Pdf::loadView('paiements.receipt_template', compact('paiement'));
        return $pdf->stream("recu_{$paiement->reference}.pdf");
    }

    public function getAmount(Request $request)
    {
        $eleveId = $request->get('eleve_id');
        $typePaiementId = $request->get('type_paiement_id');

        if (!$eleveId || !$typePaiementId) {
            return response()->json(['montant' => 0]);
        }

        $eleve = Eleve::with('inscriptionActuelle', 'classe.niveau')->find($eleveId);
        $type = TypePaiement::find($typePaiementId);

        if (!$eleve || !$type) {
            return response()->json(['montant' => 0]);
        }

        $activeYear = \App\Models\AnneeScolaire::where('active', true)->first();
        
        $tarifBase = $this->calculateTarifBase($eleve, $type, $activeYear);

        $remise = 0;
        if ($eleve->inscriptionActuelle) {
            if ($type->code === 'INSCR') {
                $remise = $eleve->inscriptionActuelle->remise_inscription;
            } elseif ($type->code === 'MENS') {
                $remise = $eleve->inscriptionActuelle->remise_mensualite;
            }
        }

        $montantFinal = max(0, $tarifBase - $remise);

        return response()->json([
            'montant_base' => $tarifBase,
            'remise' => $remise,
            'montant_final' => $montantFinal
        ]);
    }

    public function suivi(Request $request)
    {
        $classes = Classe::where('active', true)->get();
        $selected_classe_id = $request->get('classe_id');
        $annee = AnneeScolaire::where('active', true)->first();
        $moisList = AnneeScolaire::getMoisScolaires($annee);

        // Déterminer le mois sélectionné par défaut parmi les 9 mois scolaires
        $currentMonthYear = date('m/Y');
        $defaultMois = array_key_exists($currentMonthYear, $moisList) ? $currentMonthYear : array_key_first($moisList);
        $selected_mois = $request->get('mois', $defaultMois);

        $is_export = $request->has('export');
        $retards_only = $request->has('retards_only');

        $eleves = collect();
        $typeMensualite = TypePaiement::where('code', 'MENS')
            ->orWhere('nom', 'like', '%Mensualité%')
            ->orWhere('nom', 'like', '%Mensualite%')
            ->first();

        $totalReste = 0;

        if ($typeMensualite) {
            $query = Eleve::with(['paiements' => function ($query) use ($typeMensualite, $selected_mois, $annee) {
                    $query->where('type_paiement_id', $typeMensualite->id)
                          ->where('mois', $selected_mois)
                          ->where('annee_scolaire_id', $annee ? $annee->id : 0);
                }, 'inscriptionActuelle', 'classe.niveau'])
                ->where('statut', 'actif');

            if ($selected_classe_id) {
                $query->where('eleves.classe_id', $selected_classe_id);
            }

            $eleves = $query->join('classes', 'eleves.classe_id', '=', 'classes.id')
                            ->orderBy('classes.nom')
                            ->orderBy('eleves.nom')
                            ->select('eleves.*') 
                            ->get();

            $eleves->map(function($eleve) use ($typeMensualite, $annee) {
                $tarifBase = $this->calculateTarifBase($eleve, $typeMensualite, $annee);
                
                $remise = $eleve->inscriptionActuelle ? $eleve->inscriptionActuelle->remise_mensualite : 0;
                $eleve->montant_attendu = max(0, $tarifBase - $remise);
                
                $paiement = $eleve->paiements->first();
                $eleve->montant_paye = $paiement ? $paiement->montant_paye : 0;
                $eleve->reste_a_payer = max(0, $eleve->montant_attendu - $eleve->montant_paye);
                
                if ($eleve->reste_a_payer == 0) $eleve->statut_paiement = 'Payé';
                elseif ($eleve->montant_paye > 0) $eleve->statut_paiement = 'Incomplet';
                else $eleve->statut_paiement = 'Impayé';

                return $eleve;
            });

            if ($retards_only || $is_export) {
                $eleves = $eleves->filter(function($eleve) {
                    return $eleve->reste_a_payer > 0;
                });
            }

            $totalReste = $eleves->sum('reste_a_payer');

            if ($is_export) {
                $pdf = Pdf::loadView('paiements.export_retards', compact('eleves', 'selected_mois', 'totalReste', 'selected_classe_id', 'classes'));
                return $pdf->stream("retards_paiement_".str_replace('/', '_', $selected_mois).".pdf");
            }
        }

        return view('paiements.suivi', compact('classes', 'selected_classe_id', 'selected_mois', 'eleves', 'typeMensualite', 'totalReste', 'retards_only', 'moisList'));
    }

    private function calculateTarifBase($eleve, $type, $annee)
    {
        $tarifBase = $type->montant_defaut;

        if ($eleve && $eleve->classe) {
            $code = $type->code;
            $classe = $eleve->classe;
            
            // Calcul des options supplémentaires
            $optionsAmount = 0;
            if ($eleve->inscriptionActuelle) {
                if ($eleve->inscriptionActuelle->avec_cantine && $classe->montant_cantine !== null) {
                    $optionsAmount += $classe->montant_cantine;
                }
                if ($eleve->inscriptionActuelle->avec_transport && $classe->montant_transport !== null) {
                    $optionsAmount += $classe->montant_transport;
                }
            }

            if ($code === 'INSCR') {
                $base = $classe->montant_inscription !== null ? $classe->montant_inscription : $tarifBase;
                $tarifBase = $base + $optionsAmount;
            } elseif ($code === 'MENS') {
                $base = $classe->montant_mensualite !== null ? $classe->montant_mensualite : $tarifBase;
                $tarifBase = $base + $optionsAmount;
            } elseif ($code === 'CANT') {
                $tarifBase = ($eleve->inscriptionActuelle && $eleve->inscriptionActuelle->avec_cantine && $classe->montant_cantine !== null) 
                    ? $classe->montant_cantine 
                    : 0;
            } elseif ($code === 'TRANSP') {
                $tarifBase = ($eleve->inscriptionActuelle && $eleve->inscriptionActuelle->avec_transport && $classe->montant_transport !== null) 
                    ? $classe->montant_transport 
                    : 0;
            } else {
                if ($classe->niveau && $annee) {
                    $tarifConfig = \App\Models\Tarif::where('annee_scolaire_id', $annee->id)
                        ->where('niveau_id', $classe->niveau->id)
                        ->where('type_paiement_id', $type->id)
                        ->first();
                    if ($tarifConfig) {
                        $tarifBase = $tarifConfig->montant;
                    }
                }
            }
        }

        return $tarifBase;
    }
}
