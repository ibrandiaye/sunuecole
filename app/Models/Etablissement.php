<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Etablissement extends Model
{
    protected $fillable = [
        'nom',
        'code',
        'type',
        'cycle',
        'formule_bulletin',
        'adresse',
        'ville',
        'telephone',
        'email',
        'logo',
        'directeur_nom',
        'academie',
        'inspection',
        'description',
    ];
}
