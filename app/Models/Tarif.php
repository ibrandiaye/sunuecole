<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tarif extends Model
{
    use HasFactory;

    protected $fillable = [
        'annee_scolaire_id',
        'niveau_id',
        'type_paiement_id',
        'montant'
    ];

    public function anneeScolaire()
    {
        return $this->belongsTo(AnneeScolaire::class);
    }

    public function niveau()
    {
        return $this->belongsTo(Niveau::class);
    }

    public function typePaiement()
    {
        return $this->belongsTo(TypePaiement::class);
    }
}
