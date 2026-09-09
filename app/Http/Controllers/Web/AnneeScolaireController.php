<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\AnneeScolaire;
use Illuminate\Http\Request;

class AnneeScolaireController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $annees = AnneeScolaire::orderBy('date_debut', 'desc')->get();
        return view('annee_scolaires.index', compact('annees'));
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'libelle' => 'required|string|max:100|unique:annee_scolaires,libelle',
            'date_debut' => 'required|date',
            'date_fin' => 'required|date|after:date_debut',
        ]);

        if ($request->has('active') && $request->active) {
            AnneeScolaire::where('active', true)->update(['active' => false]);
            $data['active'] = true;
        }

        AnneeScolaire::create($data);

        return redirect()->route('annee_scolaires.index')->with('success', 'Année scolaire créée.');
    }

    public function update(Request $request, AnneeScolaire $anneeScolaire)
    {
        $data = $request->validate([
            'libelle' => 'required|string|max:100|unique:annee_scolaires,libelle,' . $anneeScolaire->id,
            'date_debut' => 'required|date',
            'date_fin' => 'required|date|after:date_debut',
        ]);

        $anneeScolaire->update($data);

        return redirect()->route('annee_scolaires.index')->with('success', 'Année scolaire mise à jour.');
    }

    public function activate(AnneeScolaire $anneeScolaire)
    {
        AnneeScolaire::where('active', true)->update(['active' => false]);
        $anneeScolaire->update(['active' => true]);

        return back()->with('success', "L'année {$anneeScolaire->libelle} est désormais l'année active.");
    }

    public function destroy(AnneeScolaire $anneeScolaire)
    {
        if ($anneeScolaire->active) {
            return back()->with('error', 'Impossible de supprimer l\'année scolaire active.');
        }
        $anneeScolaire->delete();
        return redirect()->route('annee_scolaires.index')->with('success', 'Année scolaire supprimée.');
    }
}
