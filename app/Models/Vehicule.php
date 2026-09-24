<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Vehicule extends Model {
    use HasFactory;

    protected $fillable = ['immatriculation', 'marque', 'capacite', 'actif'];

    /** Chauffeur(s) affecté(s) à ce véhicule */
    public function chauffeurs() {
        return $this->hasMany(Chauffeur::class);
    }

    /** Chauffeur principal (le premier actif) */
    public function chauffeurPrincipal() {
        return $this->hasOne(Chauffeur::class)->where('actif', true);
    }

    /** Zones desservies par ce véhicule */
    public function zones() {
        return $this->belongsToMany(ZoneTransport::class, 'vehicule_zone_transport');
    }

    /** Abonnements actifs sur ce véhicule */
    public function abonnements() {
        return $this->hasMany(AbonnementTransport::class);
    }

    /** Nombre de places occupées (abonnements actifs) */
    public function placesOccupees(): int {
        return $this->abonnements()->where('actif', true)->count();
    }

    /** Nombre de places disponibles */
    public function placesDisponibles(): int {
        return max(0, $this->capacite - $this->placesOccupees());
    }

    /** Est-ce que le véhicule est complet ? */
    public function estComplet(): bool {
        return $this->placesDisponibles() <= 0;
    }
}