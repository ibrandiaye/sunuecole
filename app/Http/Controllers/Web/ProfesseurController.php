<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Absence;
use App\Models\AnneeScolaire;
use App\Models\CahierTexte;
use App\Models\Classe;
use App\Models\Eleve;
use App\Models\EmploiDuTemps;
use App\Models\Enseignant;
use App\Models\Matiere;
use App\Models\Note;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ProfesseurController extends Controller
{
    /* ---------------------------------------------------------------
     * Helper : enseignant connecté
     * --------------------------------------------------------------- */
    private function enseignant(): ?Enseignant
    {
        return Enseignant::where('user_id', auth()->id())->first();
    }

    /** Retourne les lignes classe_matiere de ce prof, ou toutes si admin. */
    private function coursRows(?Enseignant $ens)
    {
        if ($ens) {
            return DB::table('classe_matiere')->where('enseignant_id', $ens->id)->get();
        }
        return DB::table('classe_matiere')->get();
    }

    /* ===============================================================
     * DASHBOARD
     * =============================================================== */
    public function dashboard()
    {
        $enseignant = $this->enseignant();
        $cours      = $this->coursRows($enseignant);
        $annee      = AnneeScolaire::where('active', true)->first();

        $classeIds  = $cours->pluck('classe_id')->unique();
        $classes    = Classe::whereIn('id', $classeIds)->where('active', true)->get();

        $today      = now()->format('Y-m-d');

        // Cours du jour (cahier de textes)
        $coursDuJour = CahierTexte::whereIn('classe_id', $classeIds)
            ->where('date_cours', $today)
            ->when($enseignant, fn($q) => $q->where('enseignant_id', $enseignant->id))
            ->with(['classe', 'matiere'])
            ->orderBy('heure_debut')
            ->get();

        // Absences du jour (total)
        $absencesAujourdhui = Absence::whereIn('classe_id', $classeIds)
            ->where('date_absence', $today)
            ->count();

        // Total notes saisies ce mois
        $notesMois = Note::whereIn('classe_id', $classeIds)
            ->when($enseignant, fn($q) => $q->where('enseignant_id', $enseignant->id))
            ->whereYear('date_evaluation', now()->year)
            ->whereMonth('date_evaluation', now()->month)
            ->count();

        // Nombre total d'élèves dans ses classes
        $totalEleves = Eleve::whereIn('classe_id', $classeIds)->count();

        return view('professeur.dashboard', compact(
            'enseignant', 'classes', 'coursDuJour',
            'absencesAujourdhui', 'notesMois', 'totalEleves', 'today'
        ));
    }

    /* ===============================================================
     * ABSENCES — Sélection du cours
     * =============================================================== */
    public function absencesIndex()
    {
        $enseignant = $this->enseignant();
        $cours      = $this->coursRows($enseignant);

        $classeIds  = $cours->pluck('classe_id')->unique();
        $classes    = Classe::whereIn('id', $classeIds)->where('active', true)->get();

        // Construire la map classe → matières avec le pivot
        $classeMatieres = [];
        foreach ($classes as $c) {
            $rows = $cours->where('classe_id', $c->id);
            $matiereIds = $rows->pluck('matiere_id');
            $matieres   = Matiere::whereIn('id', $matiereIds)->get()->keyBy('id');

            $classeMatieres[$c->id] = $rows->map(fn($r) => [
                'id'  => $r->matiere_id,
                'nom' => $matieres->get($r->matiere_id)?->nom ?? '—',
            ])->values()->toArray();
        }

        return view('professeur.absences_index', compact('classes', 'classeMatieres', 'enseignant'));
    }

    /* ===============================================================
     * ABSENCES — Appel (formulaire élèves)
     * =============================================================== */
    public function absencesAppel(Request $request)
    {
        $classe_id  = $request->get('classe_id');
        $matiere_id = $request->get('matiere_id');
        $date       = $request->get('date', now()->format('Y-m-d'));
        $heure_debut = $request->get('heure_debut', '08:00');
        $heure_fin   = $request->get('heure_fin', '10:00');

        if (!$classe_id || !$matiere_id) {
            return redirect()->route('professeur.absences.index');
        }

        $classe  = Classe::findOrFail($classe_id);
        $matiere = Matiere::findOrFail($matiere_id);
        $eleves  = Eleve::where('classe_id', $classe_id)->orderBy('nom')->get();

        // Absences déjà enregistrées pour ce créneau
        $absencesExistantes = Absence::where('classe_id', $classe_id)
            ->where('matiere_id', $matiere_id)
            ->where('date_absence', $date)
            ->where('heure_debut', $heure_debut)
            ->get()
            ->keyBy('eleve_id');

        // Cahier de textes déjà enregistré pour ce créneau
        $cahier = CahierTexte::where('classe_id', $classe_id)
            ->where('matiere_id', $matiere_id)
            ->where('date_cours', $date)
            ->where('heure_debut', $heure_debut)
            ->first();

        return view('professeur.absences_appel', compact(
            'classe', 'matiere', 'eleves', 'date',
            'heure_debut', 'heure_fin',
            'absencesExistantes', 'cahier'
        ));
    }

    /* ===============================================================
     * ABSENCES — Enregistrement de l'appel
     * =============================================================== */
    public function absencesStore(Request $request)
    {
        $data = $request->validate([
            'classe_id'     => 'required|exists:classes,id',
            'matiere_id'    => 'required|exists:matieres,id',
            'date_absence'  => 'required|date',
            'heure_debut'   => 'required|date_format:H:i',
            'heure_fin'     => 'required|date_format:H:i|after:heure_debut',
            'titre_lecon'   => 'required|string|max:255',
            'contenu_lecon' => 'nullable|string|max:2000',
            'eleves'        => 'required|array',
            'eleves.*'      => 'required|in:present,absent,retard',
        ]);

        $annee      = AnneeScolaire::where('active', true)->first();
        $enseignant = $this->enseignant();

        // 1. Cahier de textes
        $cahier = CahierTexte::updateOrCreate(
            [
                'classe_id'        => $data['classe_id'],
                'matiere_id'       => $data['matiere_id'],
                'date_cours'       => $data['date_absence'],
                'heure_debut'      => $data['heure_debut'],
                'annee_scolaire_id'=> $annee?->id,
            ],
            [
                'enseignant_id'  => $enseignant?->id,
                'heure_fin'      => $data['heure_fin'],
                'titre_lecon'    => $data['titre_lecon'],
                'contenu_lecon'  => $data['contenu_lecon'] ?? null,
            ]
        );

        // 2. Présences / absences
        foreach ($data['eleves'] as $eleveId => $statut) {
            if ($statut !== 'present') {
                Absence::updateOrCreate(
                    [
                        'eleve_id'    => $eleveId,
                        'matiere_id'  => $data['matiere_id'],
                        'date_absence'=> $data['date_absence'],
                        'heure_debut' => $data['heure_debut'],
                    ],
                    [
                        'classe_id'        => $data['classe_id'],
                        'annee_scolaire_id'=> $annee?->id,
                        'enseignant_id'    => $enseignant?->id,
                        'type'             => $statut,
                        'heure_fin'        => $data['heure_fin'],
                        'justifie'         => false,
                        'cahier_texte_id'  => $cahier->id,
                    ]
                );
            } else {
                // Remettre présent = supprimer l'absence pour ce créneau
                Absence::where('eleve_id', $eleveId)
                    ->where('matiere_id', $data['matiere_id'])
                    ->where('date_absence', $data['date_absence'])
                    ->where('heure_debut', $data['heure_debut'])
                    ->delete();
            }
        }

        $nbAbsents = collect($data['eleves'])->filter(fn($s) => $s !== 'present')->count();

        return redirect()->route('professeur.dashboard')
            ->with('success', "Appel enregistré · {$nbAbsents} absent(s) · Cahier de textes sauvegardé ✓");
    }

    /* ===============================================================
     * ABSENCES — Historique par classe
     * =============================================================== */
    public function absencesHistorique(Request $request)
    {
        $enseignant = $this->enseignant();
        $cours      = $this->coursRows($enseignant);

        $classeIds  = $cours->pluck('classe_id')->unique();
        $classes    = Classe::whereIn('id', $classeIds)->where('active', true)->get();

        $classe_id  = $request->get('classe_id', $classeIds->first());
        $classe     = $classe_id ? Classe::find($classe_id) : null;

        $absences = collect();
        if ($classe) {
            $absences = Absence::where('classe_id', $classe_id)
                ->with(['eleve', 'matiere'])
                ->orderByDesc('date_absence')
                ->orderBy('heure_debut')
                ->take(100)
                ->get()
                ->groupBy('date_absence');
        }

        return view('professeur.absences_historique', compact(
            'classes', 'classe', 'absences', 'classe_id'
        ));
    }

    /* ===============================================================
     * MES CLASSES & ÉLÈVES
     * =============================================================== */
    public function classes()
    {
        $enseignant = $this->enseignant();
        $cours      = $this->coursRows($enseignant);
        $classeIds  = $cours->pluck('classe_id')->unique();
        $classes    = Classe::whereIn('id', $classeIds)->where('active', true)->with(['niveau', 'salle'])->withCount('eleves')->get();

        $pivotData = $cours->groupBy('classe_id');
        foreach ($classes as $classe) {
            $matiereIds = $pivotData->get($classe->id, collect())->pluck('matiere_id');
            $classe->matieres_enseignees = Matiere::whereIn('id', $matiereIds)->get();
        }

        return view('professeur.classes', compact('classes', 'enseignant'));
    }

    public function classeEleves($classeId)
    {
        $enseignant = $this->enseignant();
        $cours      = $this->coursRows($enseignant);
        $classeIds  = $cours->pluck('classe_id')->unique();

        if (!$classeIds->contains($classeId) && !auth()->user()->isAdmin()) {
            abort(403, "Vous n'avez pas accès à cette classe.");
        }

        $classe = Classe::with(['niveau', 'salle'])->findOrFail($classeId);
        $eleves = Eleve::where('classe_id', $classeId)->orderBy('nom')->orderBy('prenom')->get();

        return view('professeur.classe_eleves', compact('classe', 'eleves', 'enseignant'));
    }

    /* ===============================================================
     * PLANNING / EMPLOI DU TEMPS
     * =============================================================== */
    public function planning()
    {
        $enseignant = $this->enseignant();
        $annee      = AnneeScolaire::where('active', true)->first();

        $emploisQuery = EmploiDuTemps::with(['classe', 'matiere', 'salle'])
            ->when($annee, fn($q) => $q->where('annee_scolaire_id', $annee->id));

        if ($enseignant) {
            $emploisQuery->where('enseignant_id', $enseignant->id);
        }

        $emplois = $emploisQuery->orderBy('heure_debut')->get()->groupBy('jour');
        $jours   = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi'];

        return view('professeur.planning', compact('emplois', 'jours', 'enseignant'));
    }

    /* ===============================================================
     * CAHIER DE TEXTES
     * =============================================================== */
    public function cahierTextes(Request $request)
    {
        $enseignant = $this->enseignant();
        $cours      = $this->coursRows($enseignant);
        $classeIds  = $cours->pluck('classe_id')->unique();
        $classes    = Classe::whereIn('id', $classeIds)->where('active', true)->get();

        $classe_id = $request->get('classe_id');
        $cahiers = CahierTexte::with(['classe', 'matiere'])
            ->when($enseignant, fn($q) => $q->where('enseignant_id', $enseignant->id))
            ->when($classe_id, fn($q) => $q->where('classe_id', $classe_id))
            ->whereIn('classe_id', $classeIds)
            ->orderByDesc('date_cours')
            ->orderByDesc('heure_debut')
            ->paginate(15);

        // Matières de l'enseignant pour le formulaire
        $matieresIds = $cours->pluck('matiere_id')->unique();
        $matieres    = Matiere::whereIn('id', $matieresIds)->get();

        return view('professeur.cahier_textes', compact('cahiers', 'classes', 'matieres', 'classe_id', 'enseignant'));
    }

    public function storeCahierTexte(Request $request)
    {
        $enseignant = $this->enseignant();
        $data = $request->validate([
            'classe_id'     => 'required|exists:classes,id',
            'matiere_id'    => 'required|exists:matieres,id',
            'date_cours'    => 'required|date',
            'heure_debut'   => 'required',
            'heure_fin'     => 'required|after:heure_debut',
            'titre_lecon'   => 'required|string|max:255',
            'contenu_lecon' => 'nullable|string',
        ]);

        $annee = AnneeScolaire::where('active', true)->first();

        CahierTexte::create([
            'classe_id'        => $data['classe_id'],
            'matiere_id'       => $data['matiere_id'],
            'enseignant_id'    => $enseignant?->id,
            'date_cours'       => $data['date_cours'],
            'heure_debut'      => $data['heure_debut'],
            'heure_fin'        => $data['heure_fin'],
            'titre_lecon'      => $data['titre_lecon'],
            'contenu_lecon'    => $data['contenu_lecon'] ?? null,
            'annee_scolaire_id'=> $annee?->id,
        ]);

        return back()->with('success', 'Séance enregistrée dans le cahier de textes avec succès.');
    }
}
