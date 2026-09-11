<?php

namespace App\Http\Requests\Eleve;

use Illuminate\Foundation\Http\FormRequest;

class UpdateEleveRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
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
            'classe_id' => 'nullable|exists:classes,id',
            'parent_id' => 'nullable|exists:parents,id',
            'tel_tuteur' => 'nullable|string|max:20',
            'nom_tuteur' => 'nullable|string|max:255',
            'email_tuteur' => 'nullable|email|max:255',
            'relation_tuteur' => 'nullable|string|max:50',
            'photo' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
            'statut' => 'required|in:actif,archivé,transféré,exclu',
            'remise_inscription' => 'nullable|numeric|min:0',
            'remise_mensualite' => 'nullable|numeric|min:0',
            'avec_cantine' => 'nullable|boolean',
            'avec_transport' => 'nullable|boolean',
        ];
    }
}
