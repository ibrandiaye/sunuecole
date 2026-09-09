<?php

namespace App\Http\Requests\Note;

use Illuminate\Foundation\Http\FormRequest;

class StoreNoteRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'classe_id' => 'required|exists:classes,id',
            'matiere_id' => 'required|exists:matieres,id',
            'type_evaluation' => 'required|in:devoir,composition,examen',
            'periode' => 'required|string',
            'numero_devoir' => 'nullable|integer|min:1|max:10',
            'date_evaluation' => 'nullable|date',
            'notes' => 'required|array',
            'notes.*.eleve_id' => 'required|exists:eleves,id',
            'notes.*.valeur' => 'nullable|numeric|min:0|max:20',
            'notes.*.commentaire' => 'nullable|string|max:255',
        ];
    }
}
