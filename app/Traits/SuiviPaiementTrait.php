<?php

namespace App\Traits;

use App\Models\AnneeScolaire;
use App\Models\Paiement;
use App\Models\TypePaiement;

trait SuiviPaiementTrait
{
    /**
     * Construit la structure complète de suivi des paiements pour un élève donné.
     */
    public function buildSuiviPaiements($eleve, $annee): array
    {
        $moisList    = AnneeScolaire::getMoisScolaires($annee);
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

        $types = TypePaiement::whereIn('code', ['INSCR', 'MENS', 'CANT', 'TRANSP'])
            ->get()->keyBy('code');

        $paiements = Paiement::where('eleve_id', $eleve->id)
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
                'id'        => $eleve->id,
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
            'total_general_du'   => $montantDuInscr + $totalDuMens + ($cantine_block ? $tarifCant * count($moisList) : 0) + ($transport_block ? $tarifTransp * count($moisList) : 0),
            'total_general_paye' => $paiements->sum('montant_paye'),
            'historique_paiements' => $paiements->sortByDesc('date_paiement'),
        ];
    }
}
