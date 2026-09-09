<?php

namespace App\Http\Requests\Matiere;

use Illuminate\Foundation\Http\FormRequest;

class StoreMatiereRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'nom' => 'required|string|max:100|unique:matieres,nom',
            'code' => 'required|string|max:10|unique:matieres,code',
            'cycle_id' => 'required|exists:cycles,id',
            'type' => 'required|in:obligatoire,optionnel',
            'coefficient' => 'required|numeric|min:1|max:10',
        ];
    }
}
