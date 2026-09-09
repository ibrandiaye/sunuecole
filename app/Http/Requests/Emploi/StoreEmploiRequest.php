<?php

namespace App\Http\Requests\Emploi;

use Illuminate\Foundation\Http\FormRequest;

class StoreEmploiRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'classe_id' => 'required|exists:classes,id',
            'enseignant_id' => 'required|exists:enseignants,id',
            'matiere_id' => 'required|exists:matieres,id',
            'salle_id' => 'nullable|exists:salles,id',
            'jour' => 'required|in:Lundi,Mardi,Mercredi,Jeudi,Vendredi,Samedi',
            'heure_debut' => 'required',
            'heure_fin' => 'required|after:heure_debut',
        ];
    }
}
