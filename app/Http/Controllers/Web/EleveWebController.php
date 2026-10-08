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
use App\Traits\SuiviPaiementTrait;
use Illuminate\Http\Request;

class EleveWebController extends Controller
{
    use SuiviPaiementTrait;

    /**
     * Récupérer l'élève lié à l'utilisateur connecté (ou le premier élève si admin en test).
     */
    private function getEleve(): ?Eleve
    {
        $user = auth()->user();
        $eleve = Eleve::where('user_id', $user->id)
            ->with(['classe.niveau', 'classe.salle', 'inscriptionActuelle'])
            ->first();

        // En mode démo / admin sans compte élève propre
        if (!$eleve && ($user->isAdmin() || $user->hasRole('super_admin'))) {
            $eleve = Eleve::with(['classe.niveau', 'classe.salle', 'inscriptionActuelle'])->first();
        }

        return $eleve;
    }

    /* ===============================================================
     * TABLEAU DE BORD ÉLÈVE
     * =============================================================== */
    public function dashboard()
    {
        $eleve = $this->getEleve();
        $annee = AnneeScolaire::where('active', true)->first();

        if (!$eleve) {
            return view('eleve.dashboard', [
                'eleve' => null,
                'notesRecentes' => collect(),
                'absencesRecentes' => collect(),
                'coursAujourdhui' => collect(),
                'moyenneGenerale' => null,
                'suiviPaiement' => null,
            ]);
        }

        $notesRecentes = Note::where('eleve_id', $eleve->id)
            ->with('matiere')
            ->latest('date_evaluation')
            ->take(5)
            ->get();

        $absencesRecentes = Absence::where('eleve_id', $eleve->id)
            ->with('matiere')
            ->latest('date_absence')
            ->take(5)
            ->get();

        $notes = Note::where('eleve_id', $eleve->id)->get();
        $moyenneGenerale = $notes->isNotEmpty() ? round($notes->avg('valeur'), 2) : null;

        // Cours du jour selon le jour actuel de la semaine
        $joursSemaine = [
            1 => 'Lundi', 2 => 'Mardi', 3 => 'Mercredi',
            4 => 'Jeudi', 5 => 'Vendredi', 6 => 'Samedi', 7 => 'Dimanche'
        ];
        $nomJour = $joursSemaine[now()->dayOfWeekIso] ?? 'Lundi';

        $coursAujourdhui = collect();
        if ($eleve->classe_id) {
            $coursAujourdhui = EmploiDuTemps::where('classe_id', $eleve->classe_id)
                ->where('jour', $nomJour)
                ->with(['matiere', 'enseignant.user', 'salle'])
                ->orderBy('heure_debut')
                ->get();
        }

        $suiviPaiement = null;
        if ($annee) {
            $suiviPaiement = $this->buildSuiviPaiements($eleve, $annee);
        }

        return view('eleve.dashboard', compact(
            'eleve', 'notesRecentes', 'absencesRecentes',
            'coursAujourdhui', 'moyenneGenerale', 'suiviPaiement', 'nomJour'
        ));
    }

    /* ===============================================================
     * EMPLOI DU TEMPS ÉLÈVE
     * =============================================================== */
    public function planning()
    {
        $eleve = $this->getEleve();
        $emplois = collect();
        $jours = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi'];

        if ($eleve && $eleve->classe_id) {
            $emplois = EmploiDuTemps::where('classe_id', $eleve->classe_id)
                ->with(['matiere', 'enseignant.user', 'salle'])
                ->orderBy('heure_debut')
                ->get()
                ->groupBy('jour');
        }

        return view('eleve.planning', compact('eleve', 'emplois', 'jours'));
    }

    /* ===============================================================
     * NOTES & BULLETINS ÉLÈVE
     * =============================================================== */
    public function notes()
    {
        $eleve = $this->getEleve();
        $notes = collect();
        $bulletins = collect();
        $moyenneGenerale = null;

        if ($eleve) {
            $notes = Note::where('eleve_id', $eleve->id)
                ->with('matiere')
                ->orderByDesc('date_evaluation')
                ->get();

            $moyenneGenerale = $notes->isNotEmpty() ? round($notes->avg('valeur'), 2) : null;

            $bulletins = Bulletin::where('eleve_id', $eleve->id)
                ->with('anneeScolaire')
                ->latest()
                ->get();
        }

        return view('eleve.notes', compact('eleve', 'notes', 'bulletins', 'moyenneGenerale'));
    }

    /* ===============================================================
     * ABSENCES & RETARDS ÉLÈVE
     * =============================================================== */
    public function absences()
    {
        $eleve = $this->getEleve();
        $absences = collect();

        if ($eleve) {
            $absences = Absence::where('eleve_id', $eleve->id)
                ->with('matiere')
                ->orderByDesc('date_absence')
                ->orderByDesc('heure_debut')
                ->get();
        }

        return view('eleve.absences', compact('eleve', 'absences'));
    }

    /* ===============================================================
     * CONVOCATIONS ÉLÈVE
     * =============================================================== */
    public function convocations()
    {
        $eleve = $this->getEleve();
        $convocations = collect();

        if ($eleve) {
            $convocations = Convocation::where('eleve_id', $eleve->id)
                ->orderByDesc('date_convocation')
                ->get();
        }

        return view('eleve.convocations', compact('eleve', 'convocations'));
    }

    /* ===============================================================
     * MA SCOLARITÉ & PAIEMENTS
     * =============================================================== */
    public function paiements()
    {
        $eleve = $this->getEleve();
        $annee = AnneeScolaire::where('active', true)->first();

        $suivi = null;
        if ($eleve && $annee) {
            $suivi = $this->buildSuiviPaiements($eleve, $annee);
        }

        return view('eleve.paiements', compact('eleve', 'suivi', 'annee'));
    }
}
