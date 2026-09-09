<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Http\Requests\Emploi\StoreEmploiRequest;
use App\Models\EmploiDuTemps;
use App\Models\Classe;
use App\Models\Enseignant;
use App\Models\Matiere;
use App\Models\Salle;
use Illuminate\Http\Request;

use App\Models\AnneeScolaire;

class EmploiController extends Controller
{
    public function index(Request $request)
    {
        $classes = Classe::visible()->where('active', true)->with('matieres')->get();
        $enseignants = Enseignant::with('user')->get();
        $salles = Salle::all();

        $selected_classe_id = $request->get('classe_id');
        $emplois = [];

        // Charger les matières de la classe sélectionnée uniquement
        $matieres = collect();
        if ($selected_classe_id) {
            $classeObj = $classes->firstWhere('id', $selected_classe_id);
            if ($classeObj) {
                $matieres = $classeObj->matieres;
            }

            $emplois = EmploiDuTemps::with(['matiere', 'enseignant.user', 'salle'])
                ->where('classe_id', $selected_classe_id)
                ->get()
                ->groupBy('jour');
        }

        // Mapping classe_id => matières pour le JS
        $classeMatieres = [];
        foreach ($classes as $c) {
            $classeMatieres[$c->id] = $c->matieres->map(function ($m) {
                return ['id' => $m->id, 'nom' => $m->nom, 'code' => $m->code];
            })->values()->toArray();
        }

        return view('emplois.index', compact('classes', 'enseignants', 'matieres', 'salles', 'emplois', 'selected_classe_id', 'classeMatieres'));
    }

    public function store(StoreEmploiRequest $request)
    {
        $activeYear = AnneeScolaire::where('active', true)->first();
        
        if (!$activeYear) {
            return back()->with('error', 'Aucune année scolaire active configurée.');
        }

        $data = $request->validated();
        $data['annee_scolaire_id'] = $activeYear->id;

        // Mapper les jours si envoyés en texte
        $joursMap = [
            'Lundi' => 1, 'Mardi' => 2, 'Mercredi' => 3, 'Jeudi' => 4,
            'Vendredi' => 5, 'Samedi' => 6, 'Dimanche' => 7
        ];

        if (isset($joursMap[$data['jour']])) {
            $data['jour'] = $joursMap[$data['jour']];
        }

        // --- VÉRIFICATIONS DE COLLISIONS ---
        $debut = $data['heure_debut'];
        $fin = $data['heure_fin'];
        $jour = $data['jour'];

        $collisionQuery = function($query) use ($debut, $fin, $jour, $activeYear) {
            return $query->where('annee_scolaire_id', $activeYear->id)
                         ->where('jour', $jour)
                         ->where(function($q) use ($debut, $fin) {
                             $q->where(function($q2) use ($debut, $fin) {
                                 $q2->where('heure_debut', '<', $fin)
                                    ->where('heure_fin', '>', $debut);
                             });
                         });
        };

        // 1. Vérification Classe
        if ($collisionQuery(EmploiDuTemps::where('classe_id', $data['classe_id']))->exists()) {
            return back()->with('error', 'La classe a déjà un cours prévu sur cette plage horaire.');
        }

        // 2. Vérification Enseignant
        if ($collisionQuery(EmploiDuTemps::where('enseignant_id', $data['enseignant_id']))->exists()) {
            return back()->with('error', 'Cet enseignant est déjà occupé ailleurs durant cette période.');
        }

        // 3. Vérification Salle
        if ($data['salle_id'] && $collisionQuery(EmploiDuTemps::where('salle_id', $data['salle_id']))->exists()) {
            return back()->with('error', 'Cette salle est déjà occupée par une autre classe.');
        }
        
        EmploiDuTemps::create($data);

        return back()->with('success', 'Cours ajouté à l\'emploi du temps !');
    }

    public function destroy(EmploiDuTemps $emploi)
    {
        $emploi->delete();
        return back()->with('success', 'Cours retiré.');
    }
}
