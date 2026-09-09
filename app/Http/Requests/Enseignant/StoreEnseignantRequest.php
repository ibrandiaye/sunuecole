<?php

namespace App\Http\Requests\Enseignant;

use Illuminate\Foundation\Http\FormRequest;

class StoreEnseignantRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'name' => 'required|string|max:255',
            'email' => 'required|email|unique:users,email',
            'telephone' => 'required|string|unique:users,telephone',
            'specialite' => 'nullable|string|max:100',
            'statut' => 'required|in:permanent,vacataire',
            'date_embauche' => 'nullable|date',
            'photo' => 'nullable|image|max:2048',
            'matieres' => 'nullable|array',
            'matieres.*' => 'exists:matieres,id',
        ];
    }
}
