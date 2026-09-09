<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ParentApiController extends Controller
{
    /**
     * Récupérer le profil complet du parent et la liste de ses enfants.
     */
    public function getProfil()
    {
        $user = Auth::user();
        
        $parent = \App\Models\ParentEleve::where('user_id', $user->id)
            ->with(['eleves.classe.niveau', 'eleves.classe.salle'])
            ->first();

        if (!$parent) {
            return response()->json(['message' => 'Parent non trouvé'], 404);
        }

        return response()->json([
            'status' => 'success',
            'data' => [
                'identite' => [
                    'nom' => $parent->nom,
                    'prenom' => $parent->prenom,
                    'telephone' => $parent->telephone,
                ],
                'enfants' => $parent->eleves->map(function($eleve) {
                    return [
                        'id' => $eleve->id,
                        'nom' => $eleve->nom,
                        'prenom' => $eleve->prenom,
                        'matricule' => $eleve->matricule,
                        'classe' => $eleve->classe->nom ?? 'N/A',
                        'niveau' => $eleve->classe->niveau->nom ?? 'N/A',
                    ];
                })
            ]
        ]);
    }

    /**
     * Récupérer les notes d'un enfant spécifique
     */
    public function getNotesEnfant($enfantId)
    {
        $user = Auth::user();
        $parent = \App\Models\ParentEleve::where('user_id', $user->id)->first();
        
        if (!$parent) return response()->json(['message' => 'Non autorisé'], 403);
        
        $eleve = \App\Models\Eleve::where('id', $enfantId)->where('parent_id', $parent->id)->first();
        
        if (!$eleve) return response()->json(['message' => 'Enfant non trouvé'], 404);

        $notes = \App\Models\Note::where('eleve_id', $eleve->id)->with('matiere')->get();

        return response()->json([
            'status' => 'success',
            'data' => $notes
        ]);
    }
    
    /**
     * Récupérer les absences d'un enfant spécifique
     */
    public function getAbsencesEnfant($enfantId)
    {
        $user = Auth::user();
        $parent = \App\Models\ParentEleve::where('user_id', $user->id)->first();
        
        if (!$parent) return response()->json(['message' => 'Non autorisé'], 403);
        
        $eleve = \App\Models\Eleve::where('id', $enfantId)->where('parent_id', $parent->id)->first();
        
        if (!$eleve) return response()->json(['message' => 'Enfant non trouvé'], 404);

        $absences = \App\Models\Absence::where('eleve_id', $eleve->id)->get();

        return response()->json([
            'status' => 'success',
            'data' => $absences
        ]);
    }

    /**
     * Récupérer l'emploi du temps d'un enfant spécifique
     */
    public function getEmploiDuTempsEnfant($enfantId)
    {
        $user = Auth::user();
        $parent = \App\Models\ParentEleve::where('user_id', $user->id)->first();
        
        if (!$parent) return response()->json(['message' => 'Non autorisé'], 403);
        
        $eleve = \App\Models\Eleve::where('id', $enfantId)->where('parent_id', $parent->id)->first();
        
        if (!$eleve || !$eleve->classe_id) {
            return response()->json(['message' => 'Classe non trouvée pour cet enfant'], 404);
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

    /**
     * Récupérer les convocations d'un enfant spécifique
     */
    public function getConvocationsEnfant($enfantId)
    {
        $user = Auth::user();
        $parent = \App\Models\ParentEleve::where('user_id', $user->id)->first();
        
        if (!$parent) return response()->json(['message' => 'Non autorisé'], 403);
        
        $eleve = \App\Models\Eleve::where('id', $enfantId)->where('parent_id', $parent->id)->first();
        
        if (!$eleve) return response()->json(['message' => 'Enfant non trouvé'], 404);

        $convocations = \App\Models\Convocation::where('eleve_id', $eleve->id)
            ->orderBy('date_convocation', 'desc')
            ->get();

        return response()->json([
            'status' => 'success',
            'data' => $convocations
        ]);
    }
}
