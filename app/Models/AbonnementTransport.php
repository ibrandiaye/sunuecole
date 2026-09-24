<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AbonnementTransport extends Model {
    use HasFactory;
    protected $fillable = ['eleve_id', 'zone_transport_id', 'vehicule_id', 'date_debut', 'date_fin', 'actif'];

    public function eleve() { return $this->belongsTo(Eleve::class); }
    public function zoneTransport() { return $this->belongsTo(ZoneTransport::class); }
    public function vehicule() { return $this->belongsTo(Vehicule::class); }
}