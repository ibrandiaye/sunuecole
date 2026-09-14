<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Http\Requests\Absence\StoreAbsenceRequest;
use App\Models\Absence;
use App\Models\Eleve;
use App\Models\Classe;
use Illuminate\Http\Request;

class AbsenceController extends Controller
{
    public function index(Request $request)
    {
        $classes = Classe::where('active', true)->get();
        $selected_classe_id = $request->get('classe_id');
        $date_absence = $request->get('date_absence', date('Y-m-d'));

        $eleves = collect();
        $matieres = collect();

        if ($selected_classe_id) {
            $classe = Classe::with('matieres')->find($selected_classe_id);
            if ($classe) {
                $eleves = Eleve::where('classe_id', $selected_classe_id)->get();
                $matieres = $classe->matieres; // only subjects taught in this class
            }
        }

        return view('absences.index', compact('classes', 'eleves', 'matieres', 'selected_classe_id', 'date_absence'));
    }

    public function store(Request $request)
    {
        // Validation basique
        $data = $request->validate([
            'classe_id' => 'required|exists:classes,id',
            'date_absence' => 'required|date',
            'heure_debut' => 'required|date_format:H:i',
            'heure_fin' => 'required|date_format:H:i|after:heure_debut',
            'matiere_id' => 'required|exists:matieres,id',
            'titre_lecon' => 'required|string|max:255',
            'contenu_lecon' => 'nullable|string',
            'absences' => 'required|array',
            'absences.*.eleve_id' => 'required|exists:eleves,id',
            'absences.*.statut' => 'required|in:present,absent,retard'
        ]);

        $activeYear = \App\Models\AnneeScolaire::where('active', true)->first();

        // Si aucune année active n'est trouvée, on gère l'erreur
        if (!$activeYear) {
            return back()->with('error', "Aucune année scolaire active n'est définie.");
        }
        
        // 1. Enregistrement du Cahier de Textes
        $cahierTexte = \App\Models\CahierTexte::updateOrCreate(
            [
                'classe_id' => $data['classe_id'],
                'matiere_id' => $data['matiere_id'],
                'date_cours' => $data['date_absence'],
                'heure_debut' => $data['heure_debut'],
                'heure_fin' => $data['heure_fin'],
                'annee_scolaire_id' => $activeYear->id,
            ],
            [
                'enseignant_id' => auth()->user()->enseignant_id ?? null, // Si l'user est lié à un enseignant
                'titre_lecon' => $data['titre_lecon'],
                'contenu_lecon' => $data['contenu_lecon'],
            ]
        );

        // 2. Enregistrement des présences/absences
        foreach ($data['absences'] as $absData) {
            if ($absData['statut'] != 'present') {
                $absence = Absence::updateOrCreate(
                    [
                        'eleve_id' => $absData['eleve_id'],
                        'date_absence' => $data['date_absence'],
                        'heure_debut' => $data['heure_debut'],
                        'heure_fin' => $data['heure_fin'],
                        // optionnel: on lie aussi à la matière pour qu'il n'y ait pas de conflit si on fait l'appel 2 fois dans la journée pour 2 matières diff.
                        'matiere_id' => $data['matiere_id']
                    ],
                    [
                        'classe_id' => $data['classe_id'],
                        'annee_scolaire_id' => $activeYear->id,
                        'type' => $absData['statut'],
                        'justifie' => false,
                        'cahier_texte_id' => $cahierTexte->id,
                    ]
                );

                if ($absence->wasRecentlyCreated) {
                    $eleveModel = Eleve::find($absData['eleve_id']);
                    if ($eleveModel) {
                        $notifService = app(\App\Services\NotificationService::class);
                        $typeAbs = $absData['statut'] == 'retard' ? 'en retard' : 'absent(e)';
                        $titre = $absData['statut'] == 'retard' ? "Retard enregistré" : "Absence enregistrée";
                        $msg = "{$eleveModel->prenom} {$eleveModel->nom} a été marqué {$typeAbs} le " . date('d/m/Y', strtotime($data['date_absence'])) . " de {$data['heure_debut']} à {$data['heure_fin']}.";
                        $notifService->sendToEleveAndTuteur($eleveModel, $titre, $msg, 'absence');
                    }
                }
            } else {
                // Si l'élève était marqué absent/en retard pour CETTE matière et on le remet présent
                Absence::where('eleve_id', $absData['eleve_id'])
                    ->where('date_absence', $data['date_absence'])
                    ->where('heure_debut', $data['heure_debut'])
                    ->where('heure_fin', $data['heure_fin'])
                    ->where('matiere_id', $data['matiere_id'])
                    ->delete();
            }
        }

        return redirect()->route('absences.index', ['classe_id' => $data['classe_id'], 'date_absence' => $data['date_absence']])
            ->with('success', 'Appel et Cahier de textes enregistrés avec succès !');
    }
}
