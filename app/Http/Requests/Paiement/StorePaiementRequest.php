<?php

namespace App\Http\Requests\Paiement;

use Illuminate\Foundation\Http\FormRequest;

class StorePaiementRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'eleve_id' => 'required|exists:eleves,id',
            'type_paiement_id' => 'required|exists:types_paiements,id',
            'montant_paye' => 'required|numeric|min:0',
            'date_paiement' => 'required|date',
            'mode_paiement' => 'required|in:espèces,chèque,virement,mobile_money',
            'mois' => 'nullable|string', // Pour les mensualités
            'commentaire' => 'nullable|string|max:255',
        ];
    }
}
