<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ParentApiController extends Controller
{
    /**
     * Récupérer le profil complet du parent et la liste de ses enfants.
     */
    public function getProfil()
    {
        $user = Auth::user();
        
        $parent = \App\Models\ParentEleve::where('user_id', $user->id)
            ->with(['eleves.classe.niveau', 'eleves.classe.salle'])
            ->first();

        if (!$parent) {
            return response()->json(['message' => 'Parent non trouvé'], 404);
        }

        return response()->json([
            'status' => 'success',
            'data' => [
                'identite' => [
                    'nom' => $parent->nom,
                    'prenom' => $parent->prenom,
                    'telephone' => $parent->telephone,
                ],
                'enfants' => $parent->eleves->map(function($eleve) {
                    return [
                        'id' => $eleve->id,
                        'nom' => $eleve->nom,
                        'prenom' => $eleve->prenom,
                        'matricule' => $eleve->matricule,
                        'classe' => $eleve->classe->nom ?? 'N/A',
                        'niveau' => $eleve->classe->niveau->nom ?? 'N/A',
                    ];
                })
            ]
        ]);
    }

    /**
     * Récupérer les notes d'un enfant spécifique
     */
    public function getNotesEnfant($enfantId)
    {
        $user = Auth::user();
        $parent = \App\Models\ParentEleve::where('user_id', $user->id)->first();
        
        if (!$parent) return response()->json(['message' => 'Non autorisé'], 403);
        
        $eleve = \App\Models\Eleve::where('id', $enfantId)->where('parent_id', $parent->id)->first();
        
        if (!$eleve) return response()->json(['message' => 'Enfant non trouvé'], 404);

        $notes = \App\Models\Note::where('eleve_id', $eleve->id)->with('matiere')->get();

        return response()->json([
            'status' => 'success',
            'data' => $notes
        ]);
    }
    
    /**
     * Récupérer les absences d'un enfant spécifique
     */
    public function getAbsencesEnfant($enfantId)
    {
        $user = Auth::user();
        $parent = \App\Models\ParentEleve::where('user_id', $user->id)->first();
        
        if (!$parent) return response()->json(['message' => 'Non autorisé'], 403);
        
        $eleve = \App\Models\Eleve::where('id', $enfantId)->where('parent_id', $parent->id)->first();
        
        if (!$eleve) return response()->json(['message' => 'Enfant non trouvé'], 404);

        $absences = \App\Models\Absence::where('eleve_id', $eleve->id)->get();

        return response()->json([
            'status' => 'success',
            'data' => $absences
        ]);
    }

    /**
     * Récupérer l'emploi du temps d'un enfant spécifique
     */
    public function getEmploiDuTempsEnfant($enfantId)
    {
        $user = Auth::user();
        $parent = \App\Models\ParentEleve::where('user_id', $user->id)->first();
        
        if (!$parent) return response()->json(['message' => 'Non autorisé'], 403);
        
        $eleve = \App\Models\Eleve::where('id', $enfantId)->where('parent_id', $parent->id)->first();
        
        if (!$eleve || !$eleve->classe_id) {
            return response()->json(['message' => 'Classe non trouvée pour cet enfant'], 404);
        }

        $emplois = \App\Models\EmploiDuTemps::where('classe_id', $eleve->classe_id)
            ->with(['matiere', 'enseignant.user'])
            ->get()
            ->groupBy('jour');

        return response()->json([
            'status' => 'success',
            'data' => $emplois
        ]);
    }

    /**
     * Récupérer les convocations d'un enfant spécifique
     */
    public function getConvocationsEnfant($enfantId)
    {
        $user   = Auth::user();
        $parent = \App\Models\ParentEleve::where('user_id', $user->id)->first();
        
        if (!$parent) return response()->json(['message' => 'Non autorisé'], 403);
        
        $eleve = \App\Models\Eleve::where('id', $enfantId)->where('parent_id', $parent->id)->first();
        
        if (!$eleve) return response()->json(['message' => 'Enfant non trouvé'], 404);

        $convocations = \App\Models\Convocation::where('eleve_id', $eleve->id)
            ->orderBy('date_convocation', 'desc')
            ->get();

        return response()->json([
            'status' => 'success',
            'data'   => $convocations
        ]);
    }

    /**
     * Récupérer le suivi des paiements d'un enfant spécifique.
     * Retourne inscription + 9 mois de mensualités + cantine + transport.
     */
    public function getPaiementsEnfant($enfantId)
    {
        $user   = Auth::user();
        $parent = \App\Models\ParentEleve::where('user_id', $user->id)->first();

        if (!$parent) {
            return response()->json(['message' => 'Non autorisé'], 403);
        }

        $eleve = \App\Models\Eleve::where('id', $enfantId)
            ->where('parent_id', $parent->id)
            ->with(['classe.niveau', 'inscriptionActuelle.anneeScolaire'])
            ->first();

        if (!$eleve) {
            return response()->json(['message' => 'Enfant non trouvé'], 404);
        }

        $annee = \App\Models\AnneeScolaire::where('active', true)->first();
        if (!$annee) {
            return response()->json(['message' => 'Aucune année scolaire active'], 404);
        }

        return response()->json([
            'status' => 'success',
            'data'   => $this->buildSuiviPaiements($eleve, $annee),
        ]);
    }

    /**
     * Sommaire des paiements de tous les enfants du parent connecté.
     */
    public function getPaiementsSommaire()
    {
        $user   = Auth::user();
        $parent = \App\Models\ParentEleve::where('user_id', $user->id)
            ->with(['eleves.classe.niveau', 'eleves.inscriptionActuelle'])
            ->first();

        if (!$parent) {
            return response()->json(['message' => 'Non autorisé'], 403);
        }

        $annee = \App\Models\AnneeScolaire::where('active', true)->first();
        if (!$annee) {
            return response()->json(['message' => 'Aucune année scolaire active'], 404);
        }

        $sommaires = $parent->eleves->map(function ($eleve) use ($annee) {
            $data = $this->buildSuiviPaiements($eleve, $annee);

            // Calcul d'un score synthétique
            $moisPayes = $data['mensualites']['mois_payes'];
            $moisTotal = $data['mensualites']['mois_total'];
            $inscrStatut = $data['inscription']['statut'];

            return [
                'eleve_id'       => $eleve->id,
                'nom'            => $eleve->nom,
                'prenom'         => $eleve->prenom,
                'matricule'      => $eleve->matricule,
                'classe'         => $eleve->classe?->nom,
                'inscription'    => [
                    'statut'       => $inscrStatut,
                    'montant_du'   => $data['inscription']['montant_du'],
                    'montant_paye' => $data['inscription']['montant_paye'],
                ],
                'mensualites'    => [
                    'mois_payes'  => $moisPayes,
                    'mois_total'  => $moisTotal,
                    'total_du'    => $data['mensualites']['total_du'],
                    'total_paye'  => $data['mensualites']['total_paye'],
                    'reste_total' => $data['mensualites']['reste_total'],
                ],
                'avec_cantine'   => $data['avec_cantine'],
                'avec_transport' => $data['avec_transport'],
            ];
        });

        return response()->json([
            'status' => 'success',
            'data'   => [
                'annee_scolaire' => $annee->libelle,
                'enfants'        => $sommaires,
            ],
        ]);
    }

    /**
     * Construit la structure complète de suivi des paiements pour un élève.
     */
    private function buildSuiviPaiements($eleve, $annee): array
    {
        $moisList    = \App\Models\AnneeScolaire::getMoisScolaires($annee);
        $inscription = $eleve->inscriptionActuelle;
        $classe      = $eleve->classe;

        $tarifInscr  = $classe ? ($classe->getEffectiveTarif('INSCR')  ?? 0) : 0;
        $tarifMens   = $classe ? ($classe->getEffectiveTarif('MENS')   ?? 0) : 0;
        $tarifCant   = $classe ? ($classe->getEffectiveTarif('CANT')   ?? 0) : 0;
        $tarifTransp = $classe ? ($classe->getEffectiveTarif('TRANSP') ?? 0) : 0;

        $remiseInscr  = $inscription ? (float) $inscription->remise_inscription : 0;
        $remiseMens   = $inscription ? (float) $inscription->remise_mensualite  : 0;
        $avecCantine  = $inscription ? (bool) $inscription->avec_cantine   : false;
        $avecTransp   = $inscription ? (bool) $inscription->avec_transport  : false;

        $types = \App\Models\TypePaiement::whereIn('code', ['INSCR', 'MENS', 'CANT', 'TRANSP'])
            ->get()->keyBy('code');

        $paiements = \App\Models\Paiement::where('eleve_id', $eleve->id)
            ->where('annee_scolaire_id', $annee->id)
            ->get();

        // --- INSCRIPTION ---
        $paiInscr = $paiements->where('type_paiement_id', optional($types->get('INSCR'))->id)->first();
        $montantDuInscr = max(0, $tarifInscr - $remiseInscr);
        $montantPayeInscr = $paiInscr ? (float) $paiInscr->montant_paye : 0;
        $inscription_block = [
            'type'          => 'Inscription',
            'montant_du'    => $montantDuInscr,
            'montant_paye'  => $montantPayeInscr,
            'reste'         => max(0, $montantDuInscr - $montantPayeInscr),
            'statut'        => $montantPayeInscr >= $montantDuInscr && $montantDuInscr > 0 ? 'paye' : ($montantPayeInscr > 0 ? 'partiel' : 'impaye'),
            'date_paiement' => $paiInscr?->date_paiement?->format('d/m/Y'),
            'reference'     => $paiInscr?->reference,
        ];

        // --- MENSUALITÉS (9 mois) ---
        $montantMensuelBase = max(0, $tarifMens - $remiseMens);
        $mensualites = [];
        foreach ($moisList as $code => $label) {
            $paiMens     = $paiements
                ->where('type_paiement_id', optional($types->get('MENS'))->id)
                ->where('mois', $code)->first();
            $montantPaye = $paiMens ? (float) $paiMens->montant_paye : 0;
            $statut      = $montantPaye >= $montantMensuelBase && $montantMensuelBase > 0
                ? 'paye'
                : ($montantPaye > 0 ? 'partiel' : 'impaye');
            $mensualites[] = [
                'mois_code'     => $code,
                'mois_label'    => $label,
                'montant_du'    => $montantMensuelBase,
                'montant_paye'  => $montantPaye,
                'reste'         => max(0, $montantMensuelBase - $montantPaye),
                'statut'        => $statut,
                'date_paiement' => $paiMens?->date_paiement?->format('d/m/Y'),
                'reference'     => $paiMens?->reference,
            ];
        }

        // --- CANTINE ---
        $cantine_block = null;
        if ($avecCantine && $tarifCant > 0) {
            $cantineMois = [];
            foreach ($moisList as $code => $label) {
                $paiCant     = $paiements
                    ->where('type_paiement_id', optional($types->get('CANT'))->id)
                    ->where('mois', $code)->first();
                $montantPaye = $paiCant ? (float) $paiCant->montant_paye : 0;
                $cantineMois[] = [
                    'mois_code'     => $code,
                    'mois_label'    => $label,
                    'montant_du'    => $tarifCant,
                    'montant_paye'  => $montantPaye,
                    'reste'         => max(0, $tarifCant - $montantPaye),
                    'statut'        => $montantPaye >= $tarifCant ? 'paye' : ($montantPaye > 0 ? 'partiel' : 'impaye'),
                    'date_paiement' => $paiCant?->date_paiement?->format('d/m/Y'),
                ];
            }
            $cantine_block = [
                'tarif_mensuel' => $tarifCant,
                'mois_payes'    => collect($cantineMois)->where('statut', 'paye')->count(),
                'mois_total'    => count($moisList),
                'detail'        => $cantineMois,
            ];
        }

        // --- TRANSPORT ---
        $transport_block = null;
        if ($avecTransp && $tarifTransp > 0) {
            $transpMois = [];
            foreach ($moisList as $code => $label) {
                $paiTransp   = $paiements
                    ->where('type_paiement_id', optional($types->get('TRANSP'))->id)
                    ->where('mois', $code)->first();
                $montantPaye = $paiTransp ? (float) $paiTransp->montant_paye : 0;
                $transpMois[] = [
                    'mois_code'     => $code,
                    'mois_label'    => $label,
                    'montant_du'    => $tarifTransp,
                    'montant_paye'  => $montantPaye,
                    'reste'         => max(0, $tarifTransp - $montantPaye),
                    'statut'        => $montantPaye >= $tarifTransp ? 'paye' : ($montantPaye > 0 ? 'partiel' : 'impaye'),
                    'date_paiement' => $paiTransp?->date_paiement?->format('d/m/Y'),
                ];
            }
            $transport_block = [
                'tarif_mensuel' => $tarifTransp,
                'mois_payes'    => collect($transpMois)->where('statut', 'paye')->count(),
                'mois_total'    => count($moisList),
                'detail'        => $transpMois,
            ];
        }

        // --- TOTAUX ---
        $totalDuMens   = $montantMensuelBase * count($moisList);
        $totalPayeMens = collect($mensualites)->sum('montant_paye');
        $moisPayes     = collect($mensualites)->where('statut', 'paye')->count();

        return [
            'eleve' => [
                'nom'       => $eleve->nom,
                'prenom'    => $eleve->prenom,
                'matricule' => $eleve->matricule,
                'classe'    => $eleve->classe?->nom,
                'niveau'    => $eleve->classe?->niveau?->nom,
            ],
            'annee_scolaire' => $annee->libelle,
            'inscription'    => $inscription_block,
            'mensualites'    => [
                'tarif_mensuel' => $montantMensuelBase,
                'mois_payes'    => $moisPayes,
                'mois_total'    => count($moisList),
                'total_du'      => $totalDuMens,
                'total_paye'    => $totalPayeMens,
                'reste_total'   => max(0, $totalDuMens - $totalPayeMens),
                'detail'        => $mensualites,
            ],
            'cantine'        => $cantine_block,
            'transport'      => $transport_block,
            'avec_cantine'   => $avecCantine,
            'avec_transport' => $avecTransp,
        ];
    }
}

