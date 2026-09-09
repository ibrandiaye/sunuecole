<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Niveau extends Model
{
    use HasFactory;

    protected $fillable = ['nom', 'code', 'cycle_id', 'ordre'];

    public function cycle()
    {
        return $this->belongsTo(Cycle::class);
    }

    public function classes()
    {
        return $this->hasMany(Classe::class);
    }

    public function tarifs()
    {
        return $this->hasMany(Tarif::class);
    }
}
