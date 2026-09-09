<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Niveau;
use Illuminate\Http\Request;

class NiveauController extends Controller
{
    public function index()
    {
        $activeYear = \App\Models\AnneeScolaire::where('active', true)->first();
        
        $niveaux = Niveau::with(['cycle', 'tarifs' => function($q) use ($activeYear) {
            $q->where('annee_scolaire_id', $activeYear ? $activeYear->id : 0);
        }])->orderBy('ordre')->get();
        
        $cycles = \App\Models\Cycle::all();
        $types_paiement = \App\Models\TypePaiement::all();
        
        return view('niveaux.index', compact('niveaux', 'cycles', 'types_paiement'));
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'nom' => 'required|string|unique:niveaux,nom',
            'code' => 'required|string|unique:niveaux,code',
            'cycle_id' => 'required|exists:cycles,id',
            'ordre' => 'required|integer',
        ]);

        Niveau::create($data);

        return back()->with('success', 'Niveau ajouté avec succès !');
    }

    public function destroy(Niveau $niveau)
    {
        if ($niveau->classes()->count() > 0) {
            return back()->with('error', 'Impossible de supprimer un niveau lié à des classes.');
        }

        $niveau->delete();
        return back()->with('success', 'Niveau supprimé.');
    }

    public function updateTarifs(Request $request, Niveau $niveau)
    {
        $activeYear = \App\Models\AnneeScolaire::where('active', true)->first();
        if (!$activeYear) {
            return back()->with('error', 'Aucune année scolaire active.');
        }

        $request->validate([
            'tarifs' => 'required|array',
            'tarifs.*' => 'numeric|min:0'
        ]);

        foreach ($request->tarifs as $type_id => $montant) {
            \App\Models\Tarif::updateOrCreate(
                [
                    'annee_scolaire_id' => $activeYear->id,
                    'niveau_id' => $niveau->id,
                    'type_paiement_id' => $type_id
                ],
                [
                    'montant' => $montant
                ]
            );
        }

        return back()->with('success', 'Tarifs mis à jour avec succès.');
    }
}
