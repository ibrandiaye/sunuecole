<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Http\Requests\Matiere\StoreMatiereRequest;
use App\Models\Matiere;
use Illuminate\Http\Request;

class MatiereController extends Controller
{
    public function index()
    {
        $matieres = Matiere::withCount('enseignants')->latest()->get();
        $cycles = \App\Models\Cycle::all();
        return view('matieres.index', compact('matieres', 'cycles'));
    }

    public function store(StoreMatiereRequest $request)
    {
        Matiere::create($request->validated());

        return redirect()->route('matieres.index')
            ->with('success', 'Matière ajoutée avec succès !');
    }

    public function destroy(Matiere $matiere)
    {
        if ($matiere->classes()->count() > 0) {
            return back()->with('error', 'Impossible de supprimer une matière liée à des classes.');
        }

        $matiere->delete();
        return redirect()->route('matieres.index')
            ->with('success', 'Matière supprimée.');
    }
}
