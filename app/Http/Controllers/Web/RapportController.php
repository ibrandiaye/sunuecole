<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Paiement;
use App\Models\TypePaiement;
use App\Models\AnneeScolaire;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class RapportController extends Controller
{
    public function financier(Request $request)
    {
        $anneeActive = AnneeScolaire::where('active', true)->first();
        $date_debut = $request->get('date_debut', now()->startOfMonth()->format('Y-m-d'));
        $date_fin = $request->get('date_fin', now()->format('Y-m-d'));

        // 1. Chiffres clés (Total, du mois, du jour)
        $totalJournalier = Paiement::whereDate('date_paiement', now())->sum('montant_paye');
        $totalMensuel = Paiement::whereMonth('date_paiement', now()->month)->whereYear('date_paiement', now()->year)->sum('montant_paye');
        $totalAnnuel = $anneeActive ? Paiement::where('annee_scolaire_id', $anneeActive->id)->sum('montant_paye') : 0;

        // 2. Répartition par Type de Paiement
        $statsParType = Paiement::select('types_paiements.nom', DB::raw('SUM(montant_paye) as total'))
            ->join('types_paiements', 'paiements.type_paiement_id', '=', 'types_paiements.id')
            ->whereBetween('date_paiement', [$date_debut, $date_fin])
            ->groupBy('types_paiements.nom')
            ->get();

        // 3. Répartition par Mode de Paiement
        $statsParMode = Paiement::select('mode_paiement', DB::raw('SUM(montant_paye) as total'))
            ->whereBetween('date_paiement', [$date_debut, $date_fin])
            ->groupBy('mode_paiement')
            ->get();

        // 4. Évolution des paiements (Dernières 30 jours)
        $evolutionPaiements = Paiement::select(DB::raw('DATE(date_paiement) as date'), DB::raw('SUM(montant_paye) as total'))
            ->where('date_paiement', '>=', now()->subDays(30))
            ->groupBy('date')
            ->orderBy('date')
            ->get();

        // 5. TOP 10 des derniers encaissements
        $derniersPaiements = Paiement::with(['eleve', 'typePaiement'])
            ->orderBy('date_paiement', 'desc')
            ->limit(10)
            ->get();

        return view('rapports.financier', compact(
            'totalJournalier', 'totalMensuel', 'totalAnnuel', 
            'statsParType', 'statsParMode', 'evolutionPaiements', 
            'derniersPaiements', 'date_debut', 'date_fin'
        ));
    }
}
