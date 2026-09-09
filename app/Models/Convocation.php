<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Convocation extends Model
{
    use HasFactory;

    protected $fillable = [
        'eleve_id', 'motif', 'description', 'date_convocation', 'parent_informe'
    ];

    protected $casts = [
        'date_convocation' => 'date',
        'parent_informe' => 'boolean'
    ];

    public function eleve()
    {
        return $this->belongsTo(Eleve::class);
    }
}
