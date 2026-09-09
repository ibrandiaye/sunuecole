<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Depense extends Model
{
    protected $fillable = [
        'reference', 'libelle', 'categorie', 'montant',
        'mode_paiement', 'date_depense', 'annee_scolaire_id',
        'enregistre_par', 'notes'
    ];

    protected $casts = [
        'date_depense' => 'date',
        'montant' => 'decimal:2',
    ];

    public function anneeScolaire()
    {
        return $this->belongsTo(AnneeScolaire::class);
    }

    public function enregistrePar()
    {
        return $this->belongsTo(User::class, 'enregistre_par');
    }

    public static function categorieLabel(string $code): string
    {
        return match($code) {
            'salaires'       => 'Salaires & Charges',
            'fournitures'    => 'Fournitures Scolaires',
            'infrastructure' => 'Infrastructure & Loyer',
            'entretien'      => 'Entretien & Maintenance',
            'autre'          => 'Autre',
            default          => ucfirst($code),
        };
    }
}
