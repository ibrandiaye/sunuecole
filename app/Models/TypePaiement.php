<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TypePaiement extends Model
{
    use HasFactory;

    protected $table = 'types_paiements';

    protected $fillable = [
        'nom', 'code', 'montant_defaut', 'periodicite', 'active', 'description'
    ];

    public function tarifs()
    {
        return $this->hasMany(Tarif::class);
    }
    public function paiements()
    {
        return $this->hasMany(Paiement::class);
    }
}
