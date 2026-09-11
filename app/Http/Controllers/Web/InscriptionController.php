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
        $anneeActive = AnneeScolaire::where('active', true)->first();
        $selected_eleve = $request->get('eleve_id');
        $selected_classe_id = $request->get('classe_id');

        $query = Eleve::visible()->orderBy('nom')->orderBy('prenom');

        if ($anneeActive) {
            $query->where(function ($q) use ($anneeActive, $selected_eleve) {
                $q->whereDoesntHave('inscriptions', function ($sub) use ($anneeActive) {
                    $sub->where('annee_scolaire_id', $anneeActive->id);
                });
                if ($selected_eleve) {
                    $q->orWhere('id', $selected_eleve);
                }
            });
        }

        $eleves = $query->get();
        $classes = Classe::visible()->where('active', true)->with('niveau')->orderBy('nom')->get();
        $annees = AnneeScolaire::all();

        return view('inscriptions.create', compact('eleves', 'classes', 'annees', 'selected_eleve', 'selected_classe_id', 'anneeActive'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'eleve_id' => 'required|exists:eleves,id',
            'classe_id' => 'required|exists:classes,id',
            'annee_scolaire_id' => 'required|exists:annee_scolaires,id',
            'date_inscription' => 'required|date',
            'remise_inscription' => 'nullable|numeric|min:0',
            'remise_mensualite' => 'nullable|numeric|min:0',
        ]);

        // Vérifier si déjà inscrit pour cette année
        $exists = Inscription::where('eleve_id', $request->eleve_id)
            ->where('annee_scolaire_id', $request->annee_scolaire_id)
            ->exists();

        if ($exists) {
            return redirect()->back()->with('error', 'Cet élève est déjà inscrit pour cette année scolaire.');
        }

        $data = $request->all();
        $data['avec_cantine'] = $request->boolean('avec_cantine');
        $data['avec_transport'] = $request->boolean('avec_transport');

        $inscription = Inscription::create($data);

        // Mettre à jour la classe actuelle de l'élève (si c'est l'année en cours)
        $anneeActive = AnneeScolaire::where('active', true)->first();
        if ($anneeActive && $anneeActive->id == $request->annee_scolaire_id) {
            $eleve = Eleve::find($request->eleve_id);
            $eleve->update([
                'classe_id' => $request->classe_id,
                'annee_scolaire_id' => $request->annee_scolaire_id
            ]);
        }

        if ($request->has('redirect_to_classes')) {
            $classe = Classe::find($request->classe_id);
            $eleve = Eleve::find($request->eleve_id);
            $eleveName = $eleve ? "{$eleve->prenom} {$eleve->nom}" : "L'élève";
            $classeName = $classe ? $classe->nom : "la classe";
            return redirect()->route('classes.index')
                ->with('success', "{$eleveName} a été inscrit(e) dans {$classeName} avec succès !");
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
