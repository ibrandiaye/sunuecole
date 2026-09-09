<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Matiere extends Model
{
    use HasFactory;

    protected $fillable = ['nom', 'code', 'cycle_id', 'type', 'coefficient'];

    public function cycle()
    {
        return $this->belongsTo(Cycle::class);
    }

    public function classes()
    {
        return $this->belongsToMany(Classe::class, 'classe_matiere')
                    ->withPivot('coefficient');
    }

    public function enseignants()
    {
        return $this->belongsToMany(Enseignant::class, 'enseignant_matiere');
    }
}
