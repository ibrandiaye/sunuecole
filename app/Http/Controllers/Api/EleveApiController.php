<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class EleveApiController extends Controller
{
    /**
     * Récupérer le profil complet de l'élève (infos, classe, moyennes).
     */
    public function getProfil()
    {
        $user = Auth::user();
        
        // On cherche l'élève lié par user_id
        $eleve = \App\Models\Eleve::where('user_id', $user->id)->with(['classe.salle', 'classe.niveau'])->first();

        if (!$eleve) {
            return response()->json(['message' => 'Élève non trouvé'], 404);
        }

        return response()->json([
            'status' => 'success',
            'data' => [
                'identite' => [
                    'nom' => $eleve->nom,
                    'prenom' => $eleve->prenom,
                    'matricule' => $eleve->matricule,
                    'photo' => $eleve->photo_url,
                ],
                'scolarité' => [
                    'classe' => $eleve->classe->nom ?? 'N/A',
                    'niveau' => $eleve->classe->niveau->nom ?? 'N/A',
                ],
                'statistiques' => [
                    'moyenne_generale' => $this->calculerMoyenne($eleve),
                    'absences_compte' => $eleve->absences()->count(),
                ]
            ]
        ]);
    }

    /**
     * Récupérer l'emploi du temps de la classe de l'élève.
     */
    public function getEmploiDuTemps()
    {
        $user = Auth::user();
        $eleve = \App\Models\Eleve::where('user_id', $user->id)->first();

        if (!$eleve || !$eleve->classe_id) {
            return response()->json(['message' => 'Classe non trouvée'], 404);
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

    private function calculerMoyenne($eleve)
    {
        // Logique simplifiée pour l'API
        return $eleve->notes()->avg('valeur') ?? 0;
    }

    /**
     * Récupérer les notes de l'élève connecté.
     */
    public function getNotes()
    {
        $user = Auth::user();
        $eleve = \App\Models\Eleve::where('user_id', $user->id)->first();

        if (!$eleve) {
            return response()->json(['message' => 'Élève non trouvé'], 404);
        }

        $notes = \App\Models\Note::where('eleve_id', $eleve->id)->with('matiere')->get();

        return response()->json([
            'status' => 'success',
            'data' => $notes
        ]);
    }

    /**
     * Récupérer les absences de l'élève connecté.
     */
    public function getAbsences()
    {
        $user = Auth::user();
        $eleve = \App\Models\Eleve::where('user_id', $user->id)->first();

        if (!$eleve) {
            return response()->json(['message' => 'Élève non trouvé'], 404);
        }

        $absences = \App\Models\Absence::where('eleve_id', $eleve->id)->get();

        return response()->json([
            'status' => 'success',
            'data' => $absences
        ]);
    }

    /**
     * Récupérer les convocations et sanctions de l'élève connecté.
     */
    public function getConvocations()
    {
        $user = Auth::user();
        $eleve = \App\Models\Eleve::where('user_id', $user->id)->first();

        if (!$eleve) {
            return response()->json(['message' => 'Élève non trouvé'], 404);
        }

        $convocations = \App\Models\Convocation::where('eleve_id', $eleve->id)
                            ->orderBy('date_convocation', 'desc')
                            ->get();

        return response()->json([
            'status' => 'success',
            'data' => $convocations
        ]);
    }

    /**
     * Suivi des paiements de l'élève connecté.
     * Retourne : inscription, 9 mois de mensualités, cantine et transport.
     */
    public function getPaiements()
    {
        $user = Auth::user();
        $eleve = \App\Models\Eleve::where('user_id', $user->id)
            ->with(['classe.niveau', 'inscriptionActuelle.anneeScolaire'])
            ->first();

        if (!$eleve) {
            return response()->json(['message' => 'Élève non trouvé'], 404);
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
     * Construit la structure de suivi des paiements pour un élève donné.
     */
    private function buildSuiviPaiements($eleve, $annee): array
    {
        $moisList   = \App\Models\AnneeScolaire::getMoisScolaires($annee);
        $inscription = $eleve->inscriptionActuelle;
        $classe      = $eleve->classe;

        // --- Helper : tarif effectif ---
        $tarifInscr  = $classe ? ($classe->getEffectiveTarif('INSCR')  ?? 0) : 0;
        $tarifMens   = $classe ? ($classe->getEffectiveTarif('MENS')   ?? 0) : 0;
        $tarifCant   = $classe ? ($classe->getEffectiveTarif('CANT')   ?? 0) : 0;
        $tarifTransp = $classe ? ($classe->getEffectiveTarif('TRANSP') ?? 0) : 0;

        // Remises éventuelles
        $remiseInscr = $inscription ? (float) $inscription->remise_inscription : 0;
        $remiseMens  = $inscription ? (float) $inscription->remise_mensualite  : 0;
        $avecCantine  = $inscription ? (bool) $inscription->avec_cantine   : false;
        $avecTransp   = $inscription ? (bool) $inscription->avec_transport  : false;

        // Types de paiement (IDs)
        $types = \App\Models\TypePaiement::whereIn('code', ['INSCR', 'MENS', 'CANT', 'TRANSP'])
            ->get()->keyBy('code');

        // Tous les paiements de l'élève pour l'année active
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
        $montantMensuelBase = $tarifMens - $remiseMens;
        $montantMensuelBase = max(0, $montantMensuelBase);

        $mensualites = [];
        foreach ($moisList as $code => $label) {
            $paiMens = $paiements
                ->where('type_paiement_id', optional($types->get('MENS'))->id)
                ->where('mois', $code)
                ->first();

            $montantPaye = $paiMens ? (float) $paiMens->montant_paye : 0;
            $statut = $montantPaye >= $montantMensuelBase && $montantMensuelBase > 0
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

        // --- CANTINE (mensuel si souscrit) ---
        $cantine_block = null;
        if ($avecCantine && $tarifCant > 0) {
            $cantineMois = [];
            foreach ($moisList as $code => $label) {
                $paiCant = $paiements
                    ->where('type_paiement_id', optional($types->get('CANT'))->id)
                    ->where('mois', $code)
                    ->first();
                $montantPaye = $paiCant ? (float) $paiCant->montant_paye : 0;
                $cantineMois[] = [
                    'mois_code'  => $code,
                    'mois_label' => $label,
                    'montant_du' => $tarifCant,
                    'montant_paye' => $montantPaye,
                    'reste'      => max(0, $tarifCant - $montantPaye),
                    'statut'     => $montantPaye >= $tarifCant ? 'paye' : ($montantPaye > 0 ? 'partiel' : 'impaye'),
                    'date_paiement' => $paiCant?->date_paiement?->format('d/m/Y'),
                ];
            }
            $payesCantine = collect($cantineMois)->where('statut', 'paye')->count();
            $cantine_block = [
                'tarif_mensuel' => $tarifCant,
                'mois_payes'    => $payesCantine,
                'mois_total'    => count($moisList),
                'detail'        => $cantineMois,
            ];
        }

        // --- TRANSPORT (mensuel si souscrit) ---
        $transport_block = null;
        if ($avecTransp && $tarifTransp > 0) {
            $transpMois = [];
            foreach ($moisList as $code => $label) {
                $paiTransp = $paiements
                    ->where('type_paiement_id', optional($types->get('TRANSP'))->id)
                    ->where('mois', $code)
                    ->first();
                $montantPaye = $paiTransp ? (float) $paiTransp->montant_paye : 0;
                $transpMois[] = [
                    'mois_code'  => $code,
                    'mois_label' => $label,
                    'montant_du' => $tarifTransp,
                    'montant_paye' => $montantPaye,
                    'reste'      => max(0, $tarifTransp - $montantPaye),
                    'statut'     => $montantPaye >= $tarifTransp ? 'paye' : ($montantPaye > 0 ? 'partiel' : 'impaye'),
                    'date_paiement' => $paiTransp?->date_paiement?->format('d/m/Y'),
                ];
            }
            $payesTransp = collect($transpMois)->where('statut', 'paye')->count();
            $transport_block = [
                'tarif_mensuel' => $tarifTransp,
                'mois_payes'    => $payesTransp,
                'mois_total'    => count($moisList),
                'detail'        => $transpMois,
            ];
        }

        // --- RÉSUMÉ GLOBAL ---
        $totalDuMens    = $montantMensuelBase * count($moisList);
        $totalPayeMens  = collect($mensualites)->sum('montant_paye');
        $moisPayes      = collect($mensualites)->where('statut', 'paye')->count();

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
            'cantine'   => $cantine_block,
            'transport' => $transport_block,
            'avec_cantine'  => $avecCantine,
            'avec_transport' => $avecTransp,
        ];
    }
}

