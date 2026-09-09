<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Serie extends Model
{
    use HasFactory;

    protected $fillable = ['nom', 'code', 'cycle', 'description'];

    public function classes()
    {
        return $this->hasMany(Classe::class);
    }
}
