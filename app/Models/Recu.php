<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Recu extends Model
{
    protected $fillable = [
        'numero', 'paiement_id', 'emis_par', 'pdf_path',
        'qr_code', 'envoye_email', 'date_emission'
    ];

    protected $casts = [
        'date_emission' => 'datetime',
        'envoye_email' => 'boolean'
    ];

    public function paiement()
    {
        return $this->belongsTo(Paiement::class);
    }

    public function emetteur()
    {
        return $this->belongsTo(User::class, 'emis_par');
    }
}
