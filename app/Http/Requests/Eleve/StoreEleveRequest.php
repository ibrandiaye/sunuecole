<?php

namespace App\Http\Requests\Eleve;

use Illuminate\Foundation\Http\FormRequest;

class StoreEleveRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true; // Géré par les politiques de rôles plus tard
    }

    public function rules(): array
    {
        return [
            'nom' => 'required|string|max:100',
            'prenom' => 'required|string|max:150',
            'date_naissance' => 'required|date|before:today',
            'lieu_naissance' => 'nullable|string|max:100',
            'sexe' => 'required|in:M,F',
            'nationalite' => 'required|string|max:100',
            'photo' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
            'tuteur_mode' => 'nullable|in:existant,nouveau',
            'parent_id' => 'nullable|exists:parents,id',
            'nom_tuteur' => 'nullable|string|max:255',
            'tel_tuteur' => 'nullable|string|max:20',
            'email_tuteur' => 'nullable|email|max:255',
            'relation_tuteur' => 'nullable|string|max:50',
            'classe_id' => 'nullable|exists:classes,id',
            'remise_inscription' => 'nullable|numeric|min:0',
            'remise_mensualite' => 'nullable|numeric|min:0',
        ];
    }

    public function messages(): array
    {
        return [
            'nom.required' => 'Le nom de famille est obligatoire.',
            'prenom.required' => 'Le prénom est obligatoire.',
            'date_naissance.required' => 'La date de naissance est requise.',
            'sexe.required' => 'Veuillez sélectionner le sexe.',
        ];
    }
}
