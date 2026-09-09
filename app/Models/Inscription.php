<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Inscription extends Model
{
    use HasFactory;

    protected $fillable = [
        'eleve_id', 'classe_id', 'annee_scolaire_id', 
        'date_inscription', 'statut', 'notes',
        'remise_inscription', 'remise_mensualite',
        'avec_cantine', 'avec_transport'
    ];

    protected $casts = [
        'date_inscription' => 'date',
    ];

    public function eleve()
    {
        return $this->belongsTo(Eleve::class);
    }

    public function classe()
    {
        return $this->belongsTo(Classe::class);
    }

    public function anneeScolaire()
    {
        return $this->belongsTo(AnneeScolaire::class);
    }
}
