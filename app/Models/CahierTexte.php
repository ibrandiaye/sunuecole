<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CahierTexte extends Model
{
    use HasFactory;

    protected $fillable = [
        'classe_id', 'matiere_id', 'enseignant_id', 'annee_scolaire_id',
        'date_cours', 'heure_debut', 'heure_fin', 'periode', 'titre_lecon', 'contenu_lecon'
    ];

    public function classe()
    {
        return $this->belongsTo(Classe::class);
    }

    public function matiere()
    {
        return $this->belongsTo(Matiere::class);
    }

    public function enseignant()
    {
        return $this->belongsTo(Enseignant::class);
    }

    public function anneeScolaire()
    {
        return $this->belongsTo(AnneeScolaire::class);
    }

    public function absences()
    {
        return $this->hasMany(Absence::class);
    }
}
