<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ZoneTransport extends Model {
    use HasFactory;
    protected $fillable = ['nom', 'tarif_mensuel'];

    /** Véhicules qui desservent cette zone */
    public function vehicules() {
        return $this->belongsToMany(Vehicule::class, 'vehicule_zone_transport')->where('actif', true);
    }

    /** Abonnements actifs dans cette zone */
    public function abonnements() {
        return $this->hasMany(AbonnementTransport::class);
    }
}