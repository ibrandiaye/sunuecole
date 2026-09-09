<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class EleveApiController extends Controller
{
    /**
     * Récupérer le profil complet de l'élève (infos, classe, moyennes).
     */
    public function getProfil()
    {
        $user = Auth::user();
        
        // On cherche l'élève lié par user_id
        $eleve = \App\Models\Eleve::where('user_id', $user->id)->with(['classe.salle', 'classe.niveau'])->first();

        if (!$eleve) {
            return response()->json(['message' => 'Élève non trouvé'], 404);
        }

        return response()->json([
            'status' => 'success',
            'data' => [
                'identite' => [
                    'nom' => $eleve->nom,
                    'prenom' => $eleve->prenom,
                    'matricule' => $eleve->matricule,
                    'photo' => $eleve->photo_url,
                ],
                'scolarité' => [
                    'classe' => $eleve->classe->nom ?? 'N/A',
                    'niveau' => $eleve->classe->niveau->nom ?? 'N/A',
                ],
                'statistiques' => [
                    'moyenne_generale' => $this->calculerMoyenne($eleve),
                    'absences_compte' => $eleve->absences()->count(),
                ]
            ]
        ]);
    }

    /**
     * Récupérer l'emploi du temps de la classe de l'élève.
     */
    public function getEmploiDuTemps()
    {
        $user = Auth::user();
        $eleve = \App\Models\Eleve::where('user_id', $user->id)->first();

        if (!$eleve || !$eleve->classe_id) {
            return response()->json(['message' => 'Classe non trouvée'], 404);
        }

        $emplois = \App\Models\EmploiDuTemps::where('classe_id', $eleve->classe_id)
            ->with(['matiere', 'enseignant.user'])
            ->get()
            ->groupBy('jour');

        return response()->json([
            'status' => 'success',
            'data' => $emplois
        ]);
    }

    private function calculerMoyenne($eleve)
    {
        // Logique simplifiée pour l'API
        return $eleve->notes()->avg('valeur') ?? 0;
    }

    /**
     * Récupérer les notes de l'élève connecté.
     */
    public function getNotes()
    {
        $user = Auth::user();
        $eleve = \App\Models\Eleve::where('user_id', $user->id)->first();

        if (!$eleve) {
            return response()->json(['message' => 'Élève non trouvé'], 404);
        }

        $notes = \App\Models\Note::where('eleve_id', $eleve->id)->with('matiere')->get();

        return response()->json([
            'status' => 'success',
            'data' => $notes
        ]);
    }

    /**
     * Récupérer les absences de l'élève connecté.
     */
    public function getAbsences()
    {
        $user = Auth::user();
        $eleve = \App\Models\Eleve::where('user_id', $user->id)->first();

        if (!$eleve) {
            return response()->json(['message' => 'Élève non trouvé'], 404);
        }

        $absences = \App\Models\Absence::where('eleve_id', $eleve->id)->get();

        return response()->json([
            'status' => 'success',
            'data' => $absences
        ]);
    }

    /**
     * Récupérer les convocations et sanctions de l'élève connecté.
     */
    public function getConvocations()
    {
        $user = Auth::user();
        $eleve = \App\Models\Eleve::where('user_id', $user->id)->first();

        if (!$eleve) {
            return response()->json(['message' => 'Elève non trouvé'], 404);
        }

        $convocations = \App\Models\Convocation::where('eleve_id', $eleve->id)
                            ->orderBy('date_convocation', 'desc')
                            ->get();

        return response()->json([
            'status' => 'success',
            'data' => $convocations
        ]);
    }
}
