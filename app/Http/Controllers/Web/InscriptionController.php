<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Inscription;
use App\Models\Eleve;
use App\Models\Classe;
use App\Models\AnneeScolaire;
use Illuminate\Http\Request;

class InscriptionController extends Controller
{
    public function index()
    {
        $inscriptions = Inscription::with(['eleve', 'classe', 'anneeScolaire'])
            ->latest()
            ->paginate(20);
        return view('inscriptions.index', compact('inscriptions'));
    }

    public function create(Request $request)
    {
        $eleves = Eleve::orderBy('nom')->get();
        $classes = Classe::where('active', true)->get();
        $annees = AnneeScolaire::all();
        $selected_eleve = $request->get('eleve_id');

        return view('inscriptions.create', compact('eleves', 'classes', 'annees', 'selected_eleve'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'eleve_id' => 'required|exists:eleves,id',
            'classe_id' => 'required|exists:classes,id',
            'annee_scolaire_id' => 'required|exists:annee_scolaires,id',
            'date_inscription' => 'required|date',
        ]);

        // Vérifier si déjà inscrit pour cette année
        $exists = Inscription::where('eleve_id', $request->eleve_id)
            ->where('annee_scolaire_id', $request->annee_scolaire_id)
            ->exists();

        if ($exists) {
            return redirect()->back()->with('error', 'Cet élève est déjà inscrit pour cette année scolaire.');
        }

        $data = $request->all();
        $data['avec_cantine'] = $request->has('avec_cantine') ? true : false;
        $data['avec_transport'] = $request->has('avec_transport') ? true : false;

        Inscription::create($data);

        // Mettre à jour la classe actuelle de l'élève (si c'est l'année en cours)
        $anneeActive = AnneeScolaire::where('active', true)->first();
        if ($anneeActive && $anneeActive->id == $request->annee_scolaire_id) {
            $eleve = Eleve::find($request->eleve_id);
            $eleve->update([
                'classe_id' => $request->classe_id,
                'annee_scolaire_id' => $request->annee_scolaire_id
            ]);
        }

        return redirect()->route('inscriptions.index')
            ->with('success', 'Inscription enregistrée avec succès !');
    }

    public function destroy(Inscription $inscription)
    {
        $inscription->delete();
        return redirect()->route('inscriptions.index')
            ->with('success', 'Inscription annulée.');
    }
}
