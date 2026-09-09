<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Http\Requests\Note\StoreNoteRequest;
use App\Models\Note;
use App\Models\Eleve;
use App\Models\Classe;
use App\Models\Matiere;
use App\Models\AnneeScolaire;
use Illuminate\Http\Request;

class NoteController extends Controller
{
    public function index(Request $request)
    {
        $classes = Classe::where('active', true)->with('matieres')->get();
        
        $selected_classe_id = $request->get('classe_id');
        $selected_matiere_id = $request->get('matiere_id');
        $selected_periode = $request->get('periode', 'Premier Semestre');
        $selected_evaluation_id = $request->get('evaluation_id');
        
        // Charger les matières de la classe sélectionnée
        $matieres = collect();
        if ($selected_classe_id) {
            $classeObj = $classes->firstWhere('id', $selected_classe_id);
            if ($classeObj) {
                $matieres = $classeObj->matieres;
            }
        }

        // Préparer le mapping classe_id => matières pour JS
        $classeMatieres = [];
        foreach ($classes as $c) {
            $classeMatieres[$c->id] = $c->matieres->map(function ($m) {
                return ['id' => $m->id, 'nom' => $m->nom];
            })->values()->toArray();
        }

        $evaluationsExistantes = collect();
        if ($selected_classe_id && $selected_matiere_id && $selected_periode) {
            // Auto-migration optionnelle si on veut être certain
            $this->syncOrphanNotes($selected_classe_id, $selected_matiere_id, null);

            $evaluationsExistantes = \App\Models\Evaluation::where('classe_id', $selected_classe_id)
                ->where('matiere_id', $selected_matiere_id)
                ->where('semestre', $selected_periode)
                ->orderBy('date_evaluation', 'desc')
                ->get();
        }

        $eleves = collect();
        $notesExistantes = collect();
        $selectedEvaluation = null;

        if ($selected_evaluation_id) {
            $selectedEvaluation = \App\Models\Evaluation::find($selected_evaluation_id);
            if ($selectedEvaluation) {
                $eleves = Eleve::where('classe_id', $selectedEvaluation->classe_id)->orderBy('nom')->get();
                $notesExistantes = Note::where('evaluation_id', $selectedEvaluation->id)->get()->keyBy('eleve_id');
            }
        }

        return view('notes.index', compact(
            'classes', 'matieres', 'eleves', 'notesExistantes',
            'selected_classe_id', 'selected_matiere_id', 'selected_periode',
            'selected_evaluation_id', 'evaluationsExistantes', 'classeMatieres', 'selectedEvaluation'
        ));
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'evaluation_id'       => 'required|exists:evaluations,id',
            'notes'               => 'required|array',
            'notes.*.eleve_id'    => 'required|exists:eleves,id',
            'notes.*.valeur'      => 'nullable|numeric|min:0|max:20',
            'notes.*.commentaire' => 'nullable|string|max:255',
        ]);
        
        $evaluation = \App\Models\Evaluation::findOrFail($data['evaluation_id']);
        $annee = AnneeScolaire::where('active', true)->first();
        
        foreach ($data['notes'] as $noteData) {
            if (isset($noteData['valeur']) && $noteData['valeur'] !== null && $noteData['valeur'] !== '') {
                Note::updateOrCreate(
                    [
                        'eleve_id' => $noteData['eleve_id'],
                        'evaluation_id' => $evaluation->id,
                    ],
                    [
                        'valeur' => $noteData['valeur'],
                        'commentaire' => $noteData['commentaire'] ?? null,
                        'classe_id' => $evaluation->classe_id,
                        'matiere_id' => $evaluation->matiere_id,
                        'type_evaluation' => $evaluation->type_evaluation,
                        'periode' => $evaluation->semestre,
                        'coefficient' => $evaluation->coefficient,
                        'annee_scolaire_id' => $annee?->id,
                        'date_evaluation' => $evaluation->date_evaluation ?? now(),
                    ]
                );
            }
        }

        return redirect()->route('notes.index', [
            'classe_id' => $evaluation->classe_id,
            'matiere_id' => $evaluation->matiere_id,
            'periode' => $evaluation->semestre,
            'evaluation_id' => $evaluation->id,
        ])->with('success', 'Notes enregistrées avec succès !');
    }
    /* ---------------------------------------------------------------
     * Helpers privés (Mobile)
     * --------------------------------------------------------------- */

    /** Retourne l'enseignant lié au user connecté, ou null si admin. */
    private function getEnseignant(): ?\App\Models\Enseignant
    {
        return \App\Models\Enseignant::where('user_id', auth()->id())->first();
    }

    /** Extrait le coefficient depuis le pivot classe_matiere. */
    private function getCoefficient(int $classeId, int $matiereId): float
    {
        $pivot = \DB::table('classe_matiere')
            ->where('classe_id', $classeId)
            ->where('matiere_id', $matiereId)
            ->first();
        $matiere = Matiere::find($matiereId);
        return (float) ($pivot?->coefficient_override ?? $matiere?->coefficient ?? 1);
    }

    /* ---------------------------------------------------------------
     * Étape 1 : Sélection classe / matière / semestre
     * --------------------------------------------------------------- */
    public function mobileIndex(Request $request)
    {
        $enseignant = $this->getEnseignant();

        if ($enseignant) {
            // Professeur : uniquement ses cours (classe_matiere)
            $coursRows = \DB::table('classe_matiere')
                ->where('enseignant_id', $enseignant->id)
                ->get();

            $classeIds  = $coursRows->pluck('classe_id')->unique();
            $classes    = Classe::whereIn('id', $classeIds)->where('active', true)->get();

            $classeMatieres = [];
            foreach ($classes as $c) {
                $pivots = $coursRows->where('classe_id', $c->id);
                $matiereIds = $pivots->pluck('matiere_id');
                $matieres   = Matiere::whereIn('id', $matiereIds)->get()->keyBy('id');

                $classeMatieres[$c->id] = $pivots->map(function ($row) use ($matieres) {
                    $m = $matieres->get($row->matiere_id);
                    return [
                        'id'          => $m?->id,
                        'nom'         => $m?->nom,
                        'coefficient' => (float) ($row->coefficient_override ?? $m?->coefficient ?? 1),
                    ];
                })->filter(fn($x) => $x['id'])->values()->toArray();
            }
        } else {
            // Admin / Directeur : toutes les classes actives
            $classes = Classe::where('active', true)->with('matieres')->get();
            $classeMatieres = [];
            foreach ($classes as $c) {
                $pivots = \DB::table('classe_matiere')->where('classe_id', $c->id)->get()->keyBy('matiere_id');
                $classeMatieres[$c->id] = $c->matieres->map(function ($m) use ($pivots) {
                    $p = $pivots->get($m->id);
                    return [
                        'id'          => $m->id,
                        'nom'         => $m->nom,
                        'coefficient' => (float) ($p?->coefficient_override ?? $m->coefficient ?? 1),
                    ];
                })->values()->toArray();
            }
        }

        return view('professeur.notes_index', compact('classes', 'classeMatieres', 'enseignant'));
    }

    /* ---------------------------------------------------------------
     * Création d'une évaluation (Web)
     * --------------------------------------------------------------- */
    public function storeEvaluationWeb(Request $request)
    {
        $data = $request->validate([
            'classe_id' => 'required|exists:classes,id',
            'matiere_id' => 'required|exists:matieres,id',
            'titre' => 'required|string',
            'type_evaluation' => 'required|in:devoir,composition,examen',
            'periode' => 'required|in:Premier Semestre,Second Semestre',
            'date_evaluation' => 'required|date'
        ]);

        $enseignant = $this->getEnseignant();
        $enseignant_id = $enseignant ? $enseignant->id : null;

        // Si ce n'est pas un professeur connecté (ex: Admin), on cherche le professeur de cette matière
        if (!$enseignant_id) {
            $pivot = \Illuminate\Support\Facades\DB::table('classe_matiere')
                ->where('classe_id', $data['classe_id'])
                ->where('matiere_id', $data['matiere_id'])
                ->first();
                
            if (!$pivot || !$pivot->enseignant_id) {
                return back()->withErrors(['matiere_id' => 'Impossible de créer l\'évaluation : Aucun enseignant n\'est assigné à cette matière pour cette classe.'])->withInput();
            }
            $enseignant_id = $pivot->enseignant_id;
        }
        
        $eval = \App\Models\Evaluation::create([
            'classe_id' => $data['classe_id'],
            'matiere_id' => $data['matiere_id'],
            'enseignant_id' => $enseignant_id,
            'annee_scolaire_id' => AnneeScolaire::where('active', true)->first()?->id,
            'titre' => $data['titre'],
            'type_evaluation' => $data['type_evaluation'],
            'semestre' => $data['periode'],
            'date_evaluation' => $data['date_evaluation'],
            'coefficient' => $this->getCoefficient($data['classe_id'], $data['matiere_id']),
        ]);

        if (str_contains(url()->previous(), '/professeur')) {
            return redirect()->route('professeur.notes.saisie', ['evaluation_id' => $eval->id])
                             ->with('success', 'Évaluation créée. Vous pouvez maintenant saisir les notes.');
        }

        return redirect()->route('notes.index', [
            'classe_id' => $data['classe_id'],
            'matiere_id' => $data['matiere_id'],
            'periode' => $data['periode'],
            'evaluation_id' => $eval->id
        ])->with('success', 'Évaluation créée avec succès.');
    }

    /**
     * Synchronise les anciennes notes Web vers la table evaluations.
     */
    private function syncOrphanNotes($classe_id, $matiere_id, $enseignant_id)
    {
        $query = Note::where('classe_id', $classe_id)
            ->where('matiere_id', $matiere_id)
            ->whereNull('evaluation_id');
            
        if ($enseignant_id) {
            $query->where('enseignant_id', $enseignant_id);
        }

        $orphanNotes = $query->get()->groupBy(function($n) {
            return $n->type_evaluation . '_' . $n->periode . '_' . $n->numero_devoir;
        });

        foreach ($orphanNotes as $key => $notesGroup) {
            $firstNote = $notesGroup->first();
            $titre = ucfirst($firstNote->type_evaluation);
            if ($firstNote->numero_devoir) {
                $titre .= ' ' . $firstNote->numero_devoir;
            }

            $resolved_enseignant_id = $firstNote->enseignant_id;
            if (!$resolved_enseignant_id) {
                $pivot = \Illuminate\Support\Facades\DB::table('classe_matiere')
                    ->where('classe_id', $classe_id)
                    ->where('matiere_id', $matiere_id)
                    ->first();
                $resolved_enseignant_id = $pivot ? $pivot->enseignant_id : null;
            }

            if ($resolved_enseignant_id) {
                $eval = \App\Models\Evaluation::create([
                    'classe_id' => $classe_id,
                    'matiere_id' => $matiere_id,
                    'enseignant_id' => $resolved_enseignant_id,
                    'annee_scolaire_id' => $firstNote->annee_scolaire_id,
                    'titre' => $titre,
                    'type_evaluation' => $firstNote->type_evaluation,
                    'date_evaluation' => $firstNote->date_evaluation ?? $firstNote->created_at,
                    'coefficient' => $firstNote->coefficient ?? $this->getCoefficient($classe_id, $matiere_id),
                    'semestre' => $firstNote->periode,
                ]);

                Note::whereIn('id', $notesGroup->pluck('id'))->update(['evaluation_id' => $eval->id]);
            }
        }
    }

    /* ---------------------------------------------------------------
     * Étape 2 : Liste des évaluations (devoirs + compo) du cours
     * --------------------------------------------------------------- */
    public function mobileDevoirs(Request $request)
    {
        $classe_id  = $request->get('classe_id');
        $matiere_id = $request->get('matiere_id');
        $periode    = $request->get('periode', 'Premier Semestre');

        if (!$classe_id || !$matiere_id) {
            return redirect()->route('professeur.notes.index');
        }

        $classe      = Classe::findOrFail($classe_id);
        $matiere     = Matiere::findOrFail($matiere_id);
        $enseignant  = $this->getEnseignant();
        $eleveIds    = Eleve::where('classe_id', $classe_id)->pluck('id');
        $coefficient = $this->getCoefficient($classe_id, $matiere_id);
        $totalEleves = count($eleveIds);

        // Auto-migration
        $this->syncOrphanNotes($classe_id, $matiere_id, $enseignant ? $enseignant->id : null);

        $query = \App\Models\Evaluation::withCount('notes')
            ->where('classe_id', $classe_id)
            ->where('matiere_id', $matiere_id)
            ->where('semestre', $periode);
            
        if ($enseignant) {
            $query->where('enseignant_id', $enseignant->id);
        }

        $evaluations = $query->orderBy('date_evaluation', 'desc')->get();

        return view('professeur.notes_devoirs', compact(
            'classe', 'matiere', 'periode', 'coefficient', 'totalEleves', 'evaluations'
        ));
    }

    /* ---------------------------------------------------------------
     * Étape 3 : Formulaire de saisie des notes
     * --------------------------------------------------------------- */
    public function mobileSaisie(Request $request)
    {
        $evaluation_id = $request->get('evaluation_id');
        if (!$evaluation_id) {
            return redirect()->route('professeur.notes.index')->with('warning', 'Évaluation non spécifiée.');
        }

        $evaluation = \App\Models\Evaluation::findOrFail($evaluation_id);
        
        $classe      = Classe::findOrFail($evaluation->classe_id);
        $matiere     = Matiere::findOrFail($evaluation->matiere_id);
        $eleves      = Eleve::where('classe_id', $classe->id)->orderBy('nom')->get();
        $coefficient = $evaluation->coefficient;

        // Fetch existing notes for this evaluation
        $notesExistantes = Note::where('evaluation_id', $evaluation->id)->get()->keyBy('eleve_id');

        return view('professeur.notes_saisie', compact(
            'evaluation', 'classe', 'matiere', 'eleves', 'notesExistantes', 'coefficient'
        ));
    }

    /* ---------------------------------------------------------------
     * Étape 4 : Enregistrement / mise à jour des notes
     * --------------------------------------------------------------- */
    public function mobileStore(Request $request)
    {
        $data = $request->validate([
            'evaluation_id'       => 'required|exists:evaluations,id',
            'notes'               => 'required|array',
            'notes.*.eleve_id'    => 'required|exists:eleves,id',
            'notes.*.valeur'      => 'nullable|numeric|min:0|max:20',
            'notes.*.commentaire' => 'nullable|string|max:255',
        ]);

        $evaluation  = \App\Models\Evaluation::findOrFail($data['evaluation_id']);
        $annee       = AnneeScolaire::where('active', true)->first();
        $enseignant  = $this->getEnseignant();

        $saved = 0;
        foreach ($data['notes'] as $noteData) {
            if (!isset($noteData['valeur']) || $noteData['valeur'] === null || $noteData['valeur'] === '') {
                continue;
            }

            Note::updateOrCreate(
                [
                    'eleve_id'      => $noteData['eleve_id'],
                    'evaluation_id' => $evaluation->id,
                ],
                [
                    'matiere_id'       => $evaluation->matiere_id,
                    'classe_id'        => $evaluation->classe_id,
                    'type_evaluation'  => $evaluation->type_evaluation,
                    'periode'          => $evaluation->semestre,
                    'valeur'           => $noteData['valeur'],
                    'commentaire'      => $noteData['commentaire'] ?? null,
                    'annee_scolaire_id'=> $annee?->id,
                    'date_evaluation'  => $evaluation->date_evaluation,
                    'coefficient'      => $evaluation->coefficient,
                    'enseignant_id'    => $evaluation->enseignant_id ?? $enseignant?->id,
                ]
            );
            $saved++;
        }

        $msg = $saved > 0
            ? "{$saved} note(s) enregistrée(s) avec succès !"
            : 'Aucune note saisie — toutes les cases étaient vides.';

        return redirect()->route('professeur.notes.devoirs', [
            'classe_id'  => $evaluation->classe_id,
            'matiere_id' => $evaluation->matiere_id,
            'periode'    => $evaluation->semestre,
        ])->with($saved > 0 ? 'success' : 'warning', $msg);
    }
}
