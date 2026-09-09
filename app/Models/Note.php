<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Note extends Model
{
    use HasFactory;

    protected $fillable = [
        'eleve_id', 'matiere_id', 'classe_id', 'annee_scolaire_id', 'evaluation_id',
        'enseignant_id', 'type_evaluation', 'numero_devoir', 'periode', 'valeur',
        'coefficient', 'date_evaluation', 'commentaire', 'verrouille'
    ];

    public function eleve()
    {
        return $this->belongsTo(Eleve::class);
    }

    public function matiere()
    {
        return $this->belongsTo(Matiere::class);
    }

    public function evaluation()
    {
        return $this->belongsTo(Evaluation::class);
    }
}
