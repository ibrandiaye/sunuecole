<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Http\Requests\Classe\StoreClasseRequest;
use App\Models\Classe;
use App\Models\Niveau;
use App\Models\Serie;
use App\Models\Salle;
use App\Models\AnneeScolaire;
use App\Models\Matiere;
use Illuminate\Http\Request;

class ClasseController extends Controller
{
    public function index()
    {
        $classes = Classe::with(['niveau', 'serie', 'salle', 'anneeScolaire'])
            ->latest()
            ->get();
            
        return view('classes.index', compact('classes'));
    }

    public function create()
    {
        $niveaux = Niveau::all();
        $series = Serie::all();
        $salles = Salle::where('disponible', true)->get();
        return view('classes.create', compact('niveaux', 'series', 'salles'));
    }

    public function store(StoreClasseRequest $request)
    {
        $data = $request->validated();
        
        // On lie automatiquement à l'année scolaire active si non précisé
        $activeYear = AnneeScolaire::where('active', true)->first();
        $data['annee_scolaire_id'] = $activeYear->id;

        Classe::create($data);

        return redirect()->route('classes.index')
            ->with('success', 'Classe créée avec succès !');
    }
    public function show(Classe $classe)
    {
        $classe->load(['niveau', 'serie', 'salle', 'professeurPrincipal', 'matieres']);
        $matieres_disponibles = \App\Models\Matiere::where('cycle_id', $classe->niveau->cycle_id)->get();
        $enseignants_disponibles = \App\Models\Enseignant::with('user')->get();

        return view('classes.show', compact('classe', 'matieres_disponibles', 'enseignants_disponibles'));
    }

    public function edit(Classe $classe)
    {
        $niveaux = Niveau::all();
        $series = Serie::all();
        $salles = Salle::all();
        return view('classes.edit', compact('classe', 'niveaux', 'series', 'salles'));
    }

    public function update(Request $request, Classe $classe)
    {
        $data = $request->validate([
            'nom' => 'required|string|max:100',
            'niveau_id' => 'required|exists:niveaux,id',
            'serie_id' => 'nullable|exists:series,id',
            'salle_id' => 'nullable|exists:salles,id',
            'effectif_max' => 'required|integer|min:1',
            'active' => 'required|boolean',
            'montant_inscription' => 'nullable|numeric|min:0',
            'montant_mensualite' => 'nullable|numeric|min:0',
            'montant_cantine' => 'nullable|numeric|min:0',
            'montant_transport' => 'nullable|numeric|min:0',
        ]);

        $classe->update($data);

        return redirect()->route('classes.index')
            ->with('success', 'Classe mise à jour !');
    }

    public function attachMatiere(Request $request, Classe $classe)
    {
        $data = $request->validate([
            'matiere_id' => 'required|exists:matieres,id',
            'enseignant_id' => 'nullable|exists:enseignants,id',
            'coefficient_override' => 'nullable|numeric|min:0.5|max:10',
            'heures_semaine' => 'required|integer|min:1',
        ]);

        $classe->matieres()->syncWithoutDetaching([
            $data['matiere_id'] => [
                'enseignant_id' => $data['enseignant_id'] ?: null,
                'coefficient_override' => $data['coefficient_override'] ?: null,
                'heures_semaine' => $data['heures_semaine'],
            ]
        ]);

        return back()->with('success', 'Matière associée à la classe avec succès.');
    }

    public function detachMatiere(Classe $classe, Matiere $matiere)
    {
        $classe->matieres()->detach($matiere->id);
        return back()->with('success', 'Matière retirée de la classe.');
    }

    public function destroy(Classe $classe)
    {
        if ($classe->eleves()->count() > 0) {
            return back()->with('error', 'Impossible de supprimer une classe contenant des élèves.');
        }
        
        $classe->delete();
        return redirect()->route('classes.index')
            ->with('success', 'Classe supprimée.');
    }
}
