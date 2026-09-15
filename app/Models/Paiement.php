<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Paiement extends Model
{
    use HasFactory;

    protected $fillable = [
        'reference', 'eleve_id', 'type_paiement_id', 'encaisse_par', 
        'annee_scolaire_id', 'montant_du', 'montant_paye', 'reste_a_payer', 
        'mois', 'mode_paiement', 'statut', 'notes', 'date_paiement'
    ];

    protected $casts = [
        'date_paiement' => 'datetime',
        'montant_du' => 'decimal:2',
        'montant_paye' => 'decimal:2',
        'reste_a_payer' => 'decimal:2',
    ];

    public function eleve()
    {
        return $this->belongsTo(Eleve::class);
    }

    public function typePaiement()
    {
        return $this->belongsTo(TypePaiement::class, 'type_paiement_id');
    }

    public function anneeScolaire()
    {
        return $this->belongsTo(AnneeScolaire::class);
    }

    public function caissier()
    {
        return $this->belongsTo(User::class, 'encaisse_par');
    }

    public function recu()
    {
        return $this->hasOne(Recu::class);
    }
}
