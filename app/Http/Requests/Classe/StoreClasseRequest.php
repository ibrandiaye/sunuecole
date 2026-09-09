<?php

namespace App\Http\Requests\Classe;

use Illuminate\Foundation\Http\FormRequest;

class StoreClasseRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'nom' => 'required|string|max:100',
            'niveau_id' => 'required|exists:niveaux,id',
            'serie_id' => 'nullable|exists:series,id',
            'salle_id' => 'nullable|exists:salles,id',
            'effectif_max' => 'required|integer|min:1|max:100',
            'active' => 'boolean',
            'montant_inscription' => 'nullable|numeric|min:0',
            'montant_mensualite' => 'nullable|numeric|min:0',
            'montant_cantine' => 'nullable|numeric|min:0',
            'montant_transport' => 'nullable|numeric|min:0',
        ];
    }
}
