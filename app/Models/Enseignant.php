<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Enseignant extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id', 'matricule', 'specialite', 'telephone', 'email_perso',
        'adresse', 'sexe', 'date_naissance', 'lieu_naissance', 'nationalite',
        'diplome', 'statut', 'signature', 'photo', 'heure_service',
        'date_embauche', 'actif'
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function classes()
    {
        return $this->belongsToMany(Classe::class, 'classe_matiere')
                    ->withPivot('matiere_id', 'coefficient_override');
    }

    public function matieres()
    {
        return $this->belongsToMany(Matiere::class, 'enseignant_matiere');
    }

    public function cours()
    {
        return $this->hasMany(ClasseMatiere::class);
    }
}
