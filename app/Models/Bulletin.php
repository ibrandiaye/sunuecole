<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Bulletin extends Model
{
    protected $fillable = [
        'eleve_id', 'classe_id', 'annee_scolaire_id', 'trimestre',
        'moyenne_generale', 'rang', 'effectif_classe', 'moyenne_classe',
        'moyenne_max', 'moyenne_min', 'mention', 'appreciation_generale',
        'qr_code', 'pdf_path', 'token_verification', 'publie', 'date_publication'
    ];

    public function eleve()
    {
        return $this->belongsTo(Eleve::class);
    }

    public function anneeScolaire()
    {
        return $this->belongsTo(AnneeScolaire::class);
    }
}
