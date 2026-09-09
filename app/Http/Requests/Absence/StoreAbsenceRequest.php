<?php

namespace App\Http\Requests\Absence;

use Illuminate\Foundation\Http\FormRequest;

class StoreAbsenceRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'classe_id' => 'required|exists:classes,id',
            'date_absence' => 'required|date',
            'periode' => 'required|in:matin,apres-midi,journée',
            'absences' => 'required|array',
            'absences.*.eleve_id' => 'required|exists:eleves,id',
            'absences.*.statut' => 'required|in:present,absent,retard',
        ];
    }
}
