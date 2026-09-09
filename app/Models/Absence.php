<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Absence extends Model
{
    use HasFactory;

    protected $fillable = [
        'eleve_id', 'classe_id', 'annee_scolaire_id', 'enseignant_id', 'matiere_id', 'cahier_texte_id',
        'date_absence', 'heure_debut', 'heure_fin', 'periode', 'type', 'justifie', 'commentaire'
    ];

    public function eleve()
    {
        return $this->belongsTo(Eleve::class);
    }

    public function cahierTexte()
    {
        return $this->belongsTo(CahierTexte::class);
    }

    public function matiere()
    {
        return $this->belongsTo(Matiere::class);
    }
}
