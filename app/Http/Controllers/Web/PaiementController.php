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

        // Mois par défaut
        $currentMonthYear = date('m/Y');
        $defaultMois = array_key_exists($currentMonthYear, $moisList) ? $currentMonthYear : array_key_first($moisList);
        $selected_mois = $request->get('mois', $defaultMois);

        // Onglet actif : mensualite | cantine | transport
        $tab = $request->get('tab', 'mensualite');

        $is_export   = $request->has('export');
        $retards_only = $request->has('retards_only');

        // Charger les types de paiement
        $typeMensualite = TypePaiement::where('code', 'MENS')->orWhere('nom', 'like', '%Mensualit%')->first();
        $typeCantine    = TypePaiement::where('code', 'CANT')->orWhere('nom', 'like', '%Cantine%')->first();
        $typeTransport  = TypePaiement::where('code', 'TRANSP')->orWhere('nom', 'like', '%Transport%')->first();

        // Choisir le type selon l'onglet
        $typeActif = match($tab) {
            'cantine'   => $typeCantine,
            'transport' => $typeTransport,
            default     => $typeMensualite,
        };

        $eleves     = collect();
        $totalReste = 0;

        if ($typeActif) {
            // Pour cantine et transport, on ne filtre que les élèves inscrits avec l'option
            $query = Eleve::with([
                'paiements' => function ($q) use ($typeActif, $selected_mois, $annee) {
                    $q->where('type_paiement_id', $typeActif->id)
                      ->where('mois', $selected_mois)
                      ->where('annee_scolaire_id', $annee ? $annee->id : 0);
                },
                'inscriptionActuelle',
                'classe.niveau'
            ])->where('statut', 'actif');

            if ($selected_classe_id) {
                $query->where('eleves.classe_id', $selected_classe_id);
            }

            // Pour cantine / transport, filtrer uniquement les élèves qui ont souscrit
            if ($tab === 'cantine') {
                $query->whereHas('inscriptionActuelle', fn($q) => $q->where('avec_cantine', true));
            } elseif ($tab === 'transport') {
                $query->whereHas('inscriptionActuelle', fn($q) => $q->where('avec_transport', true));
            }

            $eleves = $query->join('classes', 'eleves.classe_id', '=', 'classes.id')
                            ->orderBy('classes.nom')
                            ->orderBy('eleves.nom')
                            ->select('eleves.*')
                            ->get();

            $eleves->map(function ($eleve) use ($typeActif, $annee) {
                $tarifBase = $this->calculateTarifBase($eleve, $typeActif, $annee);

                $remise = 0;
                if ($eleve->inscriptionActuelle) {
                    if ($typeActif->code === 'INSCR') {
                        $remise = $eleve->inscriptionActuelle->remise_inscription;
                    } elseif ($typeActif->code === 'MENS') {
                        $remise = $eleve->inscriptionActuelle->remise_mensualite;
                    }
                }
                $eleve->montant_attendu = max(0, $tarifBase - $remise);

                $paiement = $eleve->paiements->first();
                $eleve->montant_paye  = $paiement ? $paiement->montant_paye : 0;
                $eleve->reste_a_payer = max(0, $eleve->montant_attendu - $eleve->montant_paye);

                if ($eleve->reste_a_payer == 0)    $eleve->statut_paiement = 'Payé';
                elseif ($eleve->montant_paye > 0)   $eleve->statut_paiement = 'Incomplet';
                else                                 $eleve->statut_paiement = 'Impayé';

                return $eleve;
            });

            if ($retards_only || $is_export) {
                $eleves = $eleves->filter(fn($e) => $e->reste_a_payer > 0);
            }

            $totalReste = $eleves->sum('reste_a_payer');

            if ($is_export) {
                $pdf = Pdf::loadView('paiements.export_retards', compact(
                    'eleves', 'selected_mois', 'totalReste', 'selected_classe_id', 'classes'
                ));
                return $pdf->stream('retards_paiement_' . str_replace('/', '_', $selected_mois) . '.pdf');
            }
        }

        return view('paiements.suivi', compact(
            'classes', 'selected_classe_id', 'selected_mois',
            'eleves', 'typeActif', 'typeMensualite', 'typeCantine', 'typeTransport',
            'totalReste', 'retards_only', 'moisList', 'tab'
        ));
    }


    private function calculateTarifBase($eleve, $type, $annee)
    {
        $tarifBase = $type->montant_defaut;

        if ($eleve && $eleve->classe) {
            $code = $type->code;
            $classe = $eleve->classe;
            
            // Montants effectifs des services optionnels (Classe > Niveau > 0)
            $montantCantine = $classe->getEffectiveTarif('CANT') ?? 0;
            $montantTransport = $classe->getEffectiveTarif('TRANSP') ?? 0;

            // Calcul des options supplémentaires
            $optionsAmount = 0;
            if ($eleve->inscriptionActuelle) {
                if ($eleve->inscriptionActuelle->avec_cantine) {
                    $optionsAmount += $montantCantine;
                }
                if ($eleve->inscriptionActuelle->avec_transport) {
                    $optionsAmount += $montantTransport;
                }
            }

            if ($code === 'INSCR') {
                $base = $classe->getEffectiveTarif('INSCR') ?? $tarifBase;
                $tarifBase = $base + $optionsAmount;
            } elseif ($code === 'MENS') {
                $base = $classe->getEffectiveTarif('MENS') ?? $tarifBase;
                $tarifBase = $base + $optionsAmount;
            } elseif ($code === 'CANT') {
                $tarifBase = ($eleve->inscriptionActuelle && $eleve->inscriptionActuelle->avec_cantine) 
                    ? $montantCantine 
                    : 0;
            } elseif ($code === 'TRANSP') {
                $tarifBase = ($eleve->inscriptionActuelle && $eleve->inscriptionActuelle->avec_transport) 
                    ? $montantTransport 
                    : 0;
            } else {
                if ($classe->niveau && $annee) {
                    $tarifConfig = \App\Models\Tarif::where('annee_scolaire_id', $annee->id)
                        ->where('niveau_id', $classe->niveau->id)
                        ->where('type_paiement_id', $type->id)
                        ->first();
                    if ($tarifConfig) {
                        $tarifBase = (float) $tarifConfig->montant;
                    }
                }
            }
        }

        return $tarifBase;
    }
}
