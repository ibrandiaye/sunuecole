<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Absence;
use App\Models\AnneeScolaire;
use App\Models\Bulletin;
use App\Models\Convocation;
use App\Models\Eleve;
use App\Models\EmploiDuTemps;
use App\Models\Note;
use App\Models\ParentEleve;
use App\Traits\SuiviPaiementTrait;
use Illuminate\Http\Request;

class ParentWebController extends Controller
{
    use SuiviPaiementTrait;

    /**
     * Récupérer le parent connecté ou le premier parent si admin en prévisualisation.
     */
    private function getParent(): ?ParentEleve
    {
        $user = auth()->user();
        $parent = ParentEleve::where('user_id', $user->id)->first();

        // En mode démo / admin sans profil parent propre
        if (!$parent && ($user->isAdmin() || $user->hasRole('super_admin'))) {
            $parent = ParentEleve::first();
        }

        return $parent;
    }

    /**
     * Helper : Récupérer les enfants du parent et l'enfant actif sélectionné.
     */
    private function getEnfantsEtActif(Request $request): array
    {
        $parent = $this->getParent();
        $enfants = $parent 
            ? $parent->eleves()->with(['classe.niveau', 'classe.salle', 'inscriptionActuelle'])->get() 
            : collect();

        $enfantId = $request->get('enfant_id');
        $enfantActif = $enfants->firstWhere('id', $enfantId) ?? $enfants->first();

        return [$parent, $enfants, $enfantActif];
    }

    /* ===============================================================
     * TABLEAU DE BORD PARENT
     * =============================================================== */
    public function dashboard(Request $request)
    {
        [$parent, $enfants, $enfantActif] = $this->getEnfantsEtActif($request);
        $annee = AnneeScolaire::where('active', true)->first();

        $stats = [
            'notes_recentes'       => collect(),
            'absences_recentes'    => collect(),
            'convocations_recentes'=> collect(),
            'suivi_paiement'       => null,
            'moyenne_generale'     => null,
        ];

        if ($enfantActif) {
            $stats['notes_recentes'] = Note::where('eleve_id', $enfantActif->id)
                ->with('matiere')
                ->latest('date_evaluation')
                ->take(5)
                ->get();

            $stats['absences_recentes'] = Absence::where('eleve_id', $enfantActif->id)
                ->with('matiere')
                ->latest('date_absence')
                ->take(5)
                ->get();

            $stats['convocations_recentes'] = Convocation::where('eleve_id', $enfantActif->id)
                ->latest('date_convocation')
                ->take(3)
                ->get();

            $notes = Note::where('eleve_id', $enfantActif->id)->get();
            $stats['moyenne_generale'] = $notes->isNotEmpty() ? round($notes->avg('valeur'), 2) : null;

            if ($annee) {
                $stats['suivi_paiement'] = $this->buildSuiviPaiements($enfantActif, $annee);
            }
        }

        return view('parent.dashboard', compact('parent', 'enfants', 'enfantActif', 'stats', 'annee'));
    }

    /* ===============================================================
     * MES ENFANTS & PROFILS
     * =============================================================== */
    public function enfants(Request $request)
    {
        [$parent, $enfants, $enfantActif] = $this->getEnfantsEtActif($request);

        return view('parent.enfants', compact('parent', 'enfants', 'enfantActif'));
    }

    /* ===============================================================
     * NOTES & BULLETINS DE L'ENFANT
     * =============================================================== */
    public function notes(Request $request)
    {
        [$parent, $enfants, $enfantActif] = $this->getEnfantsEtActif($request);

        $notes = collect();
        $notesParMatiere = collect();
        $bulletins = collect();
        $moyenneGenerale = null;

        if ($enfantActif) {
            $notes = Note::where('eleve_id', $enfantActif->id)
                ->with('matiere')
                ->orderByDesc('date_evaluation')
                ->get();

            $notesParMatiere = $notes->groupBy('matiere_id');
            $moyenneGenerale = $notes->isNotEmpty() ? round($notes->avg('valeur'), 2) : null;

            $bulletins = Bulletin::where('eleve_id', $enfantActif->id)
                ->with('anneeScolaire')
                ->latest()
                ->get();
        }

        return view('parent.notes', compact('parent', 'enfants', 'enfantActif', 'notes', 'notesParMatiere', 'bulletins', 'moyenneGenerale'));
    }

    /* ===============================================================
     * EMPLOI DU TEMPS DE L'ENFANT
     * =============================================================== */
    public function planning(Request $request)
    {
        [$parent, $enfants, $enfantActif] = $this->getEnfantsEtActif($request);

        $emplois = collect();
        $jours = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi'];

        if ($enfantActif && $enfantActif->classe_id) {
            $emplois = EmploiDuTemps::where('classe_id', $enfantActif->classe_id)
                ->with(['matiere', 'enseignant.user', 'salle'])
                ->orderBy('heure_debut')
                ->get()
                ->groupBy('jour');
        }

        return view('parent.planning', compact('parent', 'enfants', 'enfantActif', 'emplois', 'jours'));
    }

    /* ===============================================================
     * ABSENCES & RETARDS DE L'ENFANT
     * =============================================================== */
    public function absences(Request $request)
    {
        [$parent, $enfants, $enfantActif] = $this->getEnfantsEtActif($request);

        $absences = collect();
        if ($enfantActif) {
            $absences = Absence::where('eleve_id', $enfantActif->id)
                ->with('matiere')
                ->orderByDesc('date_absence')
                ->orderByDesc('heure_debut')
                ->get();
        }

        return view('parent.absences', compact('parent', 'enfants', 'enfantActif', 'absences'));
    }

    /* ===============================================================
     * CONVOCATIONS DE L'ENFANT
     * =============================================================== */
    public function convocations(Request $request)
    {
        [$parent, $enfants, $enfantActif] = $this->getEnfantsEtActif($request);

        $convocations = collect();
        if ($enfantActif) {
            $convocations = Convocation::where('eleve_id', $enfantActif->id)
                ->orderByDesc('date_convocation')
                ->get();
        }

        return view('parent.convocations', compact('parent', 'enfants', 'enfantActif', 'convocations'));
    }

    /* ===============================================================
     * SUIVI DES PAIEMENTS & SCOLARITÉ
     * =============================================================== */
    public function paiements(Request $request)
    {
        [$parent, $enfants, $enfantActif] = $this->getEnfantsEtActif($request);
        $annee = AnneeScolaire::where('active', true)->first();

        $suivi = null;
        if ($enfantActif && $annee) {
            $suivi = $this->buildSuiviPaiements($enfantActif, $annee);
        }

        return view('parent.paiements', compact('parent', 'enfants', 'enfantActif', 'suivi', 'annee'));
    }
}
