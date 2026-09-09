<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Eleve;
use App\Models\Classe;
use App\Models\Enseignant;
use App\Models\AnneeScolaire;
use App\Models\Paiement;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function index()
    {
        $activeYear = AnneeScolaire::where('active', true)->first();
        
        $stats = [
            'total_eleves' => Eleve::visible()->count(),
            'total_classes' => Classe::visible()->count(),
            'total_enseignants' => Enseignant::count(), // Les profs sont souvent transversaux
            'recettes_mois' => Paiement::whereHas('eleve', fn($q) => $q->visible())
                                       ->whereYear('date_paiement', date('Y'))
                                       ->whereMonth('date_paiement', date('m'))
                                       ->sum('montant_paye'),
        ];

        // Dernières inscriptions
        $recent_inscriptions = Eleve::visible()->with('classe')->latest()->take(5)->get();

        // Répartition par cycle réelle
        $cyclesData = \App\Models\Cycle::withCount(['eleves' => function($q) {
            $q->visible();
        }])->get();

        return view('dashboard', compact('stats', 'recent_inscriptions', 'cyclesData', 'activeYear'));
    }
}
