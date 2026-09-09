<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class EnseignantApiController extends Controller
{
    /**
     * Voir les classes assignées à l'enseignant.
     */
    public function getClasses()
    {
        $user = Auth::user();
        $enseignant = \App\Models\Enseignant::where('user_id', $user->id)->first();

        if (!$enseignant) {
            return response()->json(['message' => 'Profil enseignant non trouvé'], 404);
        }

        // On récupère les classes assignées via la table pivot classe_matiere
        $classeIds = \Illuminate\Support\Facades\DB::table('classe_matiere')
            ->where('enseignant_id', $enseignant->id)
            ->pluck('classe_id')
            ->unique();

        $classes = \App\Models\Classe::whereIn('id', $classeIds)
            ->where('active', true)
            ->with('niveau') // to populate classe.niveau.nom if needed
            ->get();

        // Attacher les matières assignées pour chaque classe
        $pivotData = \Illuminate\Support\Facades\DB::table('classe_matiere')
            ->where('enseignant_id', $enseignant->id)
            ->get()
            ->groupBy('classe_id');

        foreach ($classes as $classe) {
            $matieresIds = $pivotData->get($classe->id, collect())->pluck('matiere_id');
            $classe->matieres_enseignees = \App\Models\Matiere::whereIn('id', $matieresIds)->get();
        }

        return response()->json([
            'status' => 'success',
            'data' => $classes
        ]);
    }

    /**
     * Enregistrer une absence depuis le mobile.
     */
    public function storeAbsence(Request $request)
    {
        $request->validate([
            'eleve_id' => 'required|exists:eleves,id',
            'date_absence' => 'required|date',
            'motif' => 'nullable|string'
        ]);

        $user = Auth::user();
        $enseignant = \App\Models\Enseignant::where('user_id', $user->id)->first();

        if (!$enseignant) {
            return response()->json(['message' => 'Non autorisé'], 403);
        }

        $absence = \App\Models\Absence::create([
            'eleve_id' => $request->eleve_id,
            'enseignant_id' => $enseignant->id,
            'date_absence' => $request->date_absence,
            'motif' => $request->motif,
            'justifiee' => false,
            'annee_scolaire_id' => \App\Models\AnneeScolaire::where('active', true)->first()->id ?? null
        ]);

        return response()->json([
            'status' => 'success',
            'message' => 'Absence enregistrée avec succès',
            'data' => $absence
        ]);
    }
    /**
     * Consulter le planning de l'enseignant.
     */
    public function getPlanning()
    {
        $user = Auth::user();
        $enseignant = \App\Models\Enseignant::where('user_id', $user->id)->first();
        if (!$enseignant) return response()->json(['message' => 'Non autorisé'], 403);

        $emplois = \App\Models\EmploiDuTemps::where('enseignant_id', $enseignant->id)
            ->with(['matiere', 'classe'])
            ->get()
            ->groupBy('jour');

        return response()->json([
            'status' => 'success',
            'data' => $emplois
        ]);
    }

    /**
     * Gérer les notes (Ajouter une note)
     */
    public function storeNote(Request $request)
    {
        $request->validate([
            'eleve_id' => 'required|exists:eleves,id',
            'matiere_id' => 'required|exists:matieres,id',
            'valeur' => 'required|numeric|min:0|max:20',
            'type_evaluation' => 'required|string',
            'semestre' => 'required|integer',
        ]);

        $note = \App\Models\Note::create($request->all());

        return response()->json([
            'status' => 'success',
            'message' => 'Note ajoutée avec succès',
            'data' => $note
        ]);
    }
    
    /**
     * Obtenir les cahiers de textes (séances) d'une classe pour cet enseignant
     */
    public function getCahierTextesByClasse($id)
    {
        $user = Auth::user();
        $enseignant = \App\Models\Enseignant::where('user_id', $user->id)->first();
        if (!$enseignant) {
            return response()->json(['status' => 'error', 'message' => 'Enseignant non trouvé'], 404);
        }

        $cahiers = \App\Models\CahierTexte::with(['matiere'])
            ->where('classe_id', $id)
            ->where('enseignant_id', $enseignant->id)
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json([
            'status' => 'success',
            'data' => $cahiers
        ]);
    }

    /**
     * Ajouter une séance de cours (CahierTexte)
     */
    public function storeSeance(Request $request)
    {
        $request->validate([
            'classe_id' => 'required|exists:classes,id',
            'matiere_id' => 'required|exists:matieres,id',
            'titre_lecon' => 'required|string',
            'contenu_lecon' => 'required|string',
            'date_cours' => 'required|date',
        ]);
        
        $user = Auth::user();
        $enseignant = \App\Models\Enseignant::where('user_id', $user->id)->first();
        
        $data = $request->all();
        $data['enseignant_id'] = $enseignant->id;

        $seance = \App\Models\CahierTexte::create($data);

        return response()->json([
            'status' => 'success',
            'message' => 'Séance ajoutée avec succès',
            'data' => $seance
        ]);
    }
    
    /**
     * Mettre à jour les informations de l'enseignant
     */
    public function updateProfil(Request $request)
    {
        $user = Auth::user();
        $enseignant = \App\Models\Enseignant::where('user_id', $user->id)->first();
        if (!$enseignant) return response()->json(['message' => 'Non autorisé'], 403);
        
        $enseignant->update($request->only(['telephone', 'adresse']));
        
        return response()->json([
            'status' => 'success',
            'message' => 'Profil mis à jour',
            'data' => $enseignant
        ]);
    }
    /**
     * Obtenir la liste des élèves d'une classe spécifique
     */
    public function getElevesByClasse($id)
    {
        $classe = \App\Models\Classe::find($id);
        if (!$classe) return response()->json(['message' => 'Classe non trouvée'], 404);

        // Récupérer les élèves via Inscription ou relation directe, selon la DB
        // Supposons que Eleve a classe_id directement ou via inscription
        $eleves = \App\Models\Eleve::where('classe_id', $id)->get();

        return response()->json([
            'status' => 'success',
            'data' => $eleves
        ]);
    }

    /**
     * Obtenir les matières assignées à l'enseignant pour une classe
     */
    public function getMatieresByClasse($id)
    {
        $user = Auth::user();
        $enseignant = \App\Models\Enseignant::where('user_id', $user->id)->first();

        if (!$enseignant) return response()->json(['message' => 'Non autorisé'], 403);

        $matieresIds = \Illuminate\Support\Facades\DB::table('classe_matiere')
            ->where('enseignant_id', $enseignant->id)
            ->where('classe_id', $id)
            ->pluck('matiere_id');

        $matieres = \App\Models\Matiere::whereIn('id', $matieresIds)->get();

        return response()->json([
            'status' => 'success',
            'data' => $matieres
        ]);
    }

    /**
     * Créer une évaluation (Devoir/Composition)
     */
    public function storeEvaluation(Request $request)
    {
        $request->validate([
            'classe_id' => 'required|exists:classes,id',
            'matiere_id' => 'required|exists:matieres,id',
            'titre' => 'required|string',
            'type_evaluation' => 'required|string',
            'date_evaluation' => 'required|date',
            'semestre' => 'required|string', // Support for semestre
        ]);

        $user = Auth::user();
        $enseignant = \App\Models\Enseignant::where('user_id', $user->id)->first();

        // Récupération automatique du coefficient
        $pivot = \Illuminate\Support\Facades\DB::table('classe_matiere')
            ->where('classe_id', $request->classe_id)
            ->where('matiere_id', $request->matiere_id)
            ->first();

        $coef = 1;
        if ($pivot && $pivot->coefficient_override) {
            $coef = $pivot->coefficient_override;
        } else {
            $matiere = \App\Models\Matiere::find($request->matiere_id);
            if ($matiere && $matiere->coefficient) {
                $coef = $matiere->coefficient;
            }
        }

        $data = $request->except('coefficient'); // Ignore client-provided coef if any
        $data['enseignant_id'] = $enseignant->id;
        $data['annee_scolaire_id'] = \App\Models\AnneeScolaire::where('active', true)->first()->id ?? null;
        $data['coefficient'] = $coef;

        $evaluation = \App\Models\Evaluation::create($data);

        return response()->json([
            'status' => 'success',
            'message' => 'Évaluation créée avec succès',
            'data' => $evaluation
        ]);
    }

    /**
     * Obtenir les évaluations d'une classe (pour cet enseignant)
     */
    public function getEvaluationsByClasse($id)
    {
        $user = Auth::user();
        $enseignant = \App\Models\Enseignant::where('user_id', $user->id)->first();

        // 1. Auto-migration : créer des "Evaluations" pour les notes saisies depuis le Web (qui n'ont pas d'evaluation_id)
        $orphanNotes = \App\Models\Note::where('classe_id', $id)
            ->where('enseignant_id', $enseignant->id)
            ->whereNull('evaluation_id')
            ->get()
            ->groupBy(function($n) {
                return $n->matiere_id . '_' . $n->type_evaluation . '_' . $n->periode . '_' . $n->numero_devoir;
            });

        foreach ($orphanNotes as $key => $notesGroup) {
            $firstNote = $notesGroup->first();
            $titre = ucfirst($firstNote->type_evaluation);
            if ($firstNote->numero_devoir) {
                $titre .= ' ' . $firstNote->numero_devoir;
            }
            
            $eval = \App\Models\Evaluation::create([
                'classe_id' => $id,
                'matiere_id' => $firstNote->matiere_id,
                'enseignant_id' => $enseignant->id,
                'annee_scolaire_id' => $firstNote->annee_scolaire_id,
                'titre' => $titre,
                'type_evaluation' => $firstNote->type_evaluation,
                'date_evaluation' => $firstNote->date_evaluation ?? $firstNote->created_at,
                'coefficient' => $firstNote->coefficient ?? 1,
                'semestre' => $firstNote->periode,
            ]);

            // Lier les notes à cette nouvelle évaluation
            \App\Models\Note::whereIn('id', $notesGroup->pluck('id'))->update(['evaluation_id' => $eval->id]);
        }

        // 2. Retourner la liste complète des évaluations
        $evaluations = \App\Models\Evaluation::where('classe_id', $id)
            ->where('enseignant_id', $enseignant->id)
            ->orderBy('date_evaluation', 'desc')
            ->get();

        return response()->json([
            'status' => 'success',
            'data' => $evaluations
        ]);
    }

    /**
     * Obtenir les notes existantes pour une évaluation précise
     */
    public function getEvaluationNotes($id)
    {
        $user = Auth::user();
        $enseignant = \App\Models\Enseignant::where('user_id', $user->id)->first();

        // Sécurité : vérifier que l'évaluation appartient bien à cet enseignant
        $evaluation = \App\Models\Evaluation::where('id', $id)
            ->where('enseignant_id', $enseignant->id)
            ->first();

        if (!$evaluation) {
            return response()->json(['message' => 'Évaluation non trouvée ou accès interdit'], 403);
        }

        $notes = \App\Models\Note::where('evaluation_id', $id)->get();

        return response()->json([
            'status' => 'success',
            'data' => $notes
        ]);
    }

    /**
     * Enregistrer des notes en lot pour une évaluation
     */
    public function storeNotesBatch(Request $request, $evaluation_id)
    {
        $request->validate([
            'notes' => 'required|array',
            'notes.*.eleve_id' => 'required|exists:eleves,id',
            'notes.*.valeur' => 'required|numeric|min:0|max:20',
        ]);

        $evaluation = \App\Models\Evaluation::findOrFail($evaluation_id);

        foreach ($request->notes as $noteData) {
            \App\Models\Note::updateOrCreate(
                [
                    'evaluation_id' => $evaluation->id,
                    'eleve_id' => $noteData['eleve_id'],
                ],
                [
                    'matiere_id' => $evaluation->matiere_id,
                    'classe_id' => $evaluation->classe_id,
                    'enseignant_id' => $evaluation->enseignant_id,
                    'type_evaluation' => $evaluation->type_evaluation,
                    'date_evaluation' => $evaluation->date_evaluation,
                    'coefficient' => $evaluation->coefficient,
                    'valeur' => $noteData['valeur'],
                    'periode' => $evaluation->semestre, // Utilise la période sélectionnée lors de la création
                ]
            );
        }

        return response()->json([
            'status' => 'success',
            'message' => 'Notes enregistrées avec succès'
        ]);
    }

    /**
     * Obtenir le planning de l'enseignant pour une classe spécifique
     */
    public function getPlanningByClasse($id)
    {
        $user = Auth::user();
        $enseignant = \App\Models\Enseignant::where('user_id', $user->id)->first();

        $emplois = \App\Models\EmploiDuTemps::where('classe_id', $id)
            ->where('enseignant_id', $enseignant->id)
            ->with(['matiere'])
            ->orderBy('jour')
            ->orderBy('heure_debut')
            ->get();

        return response()->json([
            'status' => 'success',
            'data' => $emplois
        ]);
    }

    /**
     * Enregistrer un lot d'absences pour une séance spécifique
     */
    public function storeAbsencesBatch(Request $request)
    {
        $request->validate([
            'classe_id' => 'required|exists:classes,id',
            'matiere_id' => 'required|exists:matieres,id',
            'date_absence' => 'required|date',
            'heure_debut' => 'required',
            'heure_fin' => 'required',
            'titre_lecon' => 'required|string',
            'contenu_lecon' => 'nullable|string',
            'eleves_absents' => 'array' // Liste des objets {eleve_id, type}
        ]);

        $user = Auth::user();
        $enseignant = \App\Models\Enseignant::where('user_id', $user->id)->first();
        $annee_scolaire_id = \App\Models\AnneeScolaire::where('active', true)->first()->id ?? null;

        // 1. Enregistrement du Cahier de Textes
        $cahier = \App\Models\CahierTexte::updateOrCreate(
            [
                'classe_id' => $request->classe_id,
                'matiere_id' => $request->matiere_id,
                'date_cours' => $request->date_absence,
                'heure_debut' => $request->heure_debut,
                'annee_scolaire_id' => $annee_scolaire_id,
            ],
            [
                'enseignant_id' => $enseignant->id,
                'heure_fin' => $request->heure_fin,
                'titre_lecon' => $request->titre_lecon,
                'contenu_lecon' => $request->contenu_lecon,
            ]
        );

        // 2. Gestion des absences/retards
        if (!empty($request->eleves_absents)) {
            foreach ($request->eleves_absents as $data) {
                // Supprimer si ça existe (pour pouvoir mettre à jour)
                \App\Models\Absence::where([
                    'eleve_id' => $data['eleve_id'],
                    'date_absence' => $request->date_absence,
                    'heure_debut' => $request->heure_debut,
                    'matiere_id' => $request->matiere_id
                ])->delete();

                // Créer le nouvel enregistrement
                \App\Models\Absence::create([
                    'eleve_id' => $data['eleve_id'],
                    'classe_id' => $request->classe_id,
                    'enseignant_id' => $enseignant->id,
                    'matiere_id' => $request->matiere_id,
                    'date_absence' => $request->date_absence,
                    'heure_debut' => $request->heure_debut,
                    'heure_fin' => $request->heure_fin,
                    'annee_scolaire_id' => $annee_scolaire_id,
                    'type' => $data['type'] ?? 'absent',
                    'justifie' => false,
                    'cahier_texte_id' => $cahier->id
                ]);
            }
        }

        return response()->json([
            'status' => 'success',
            'message' => 'Appel enregistré avec succès'
        ]);
    }
}
