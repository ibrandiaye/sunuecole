<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
class Chauffeur extends Model {
    use HasFactory;
    protected $fillable = ['personnel_id', 'nom', 'telephone', 'vehicule_id', 'actif'];
    
    public function vehicule() { return $this->belongsTo(Vehicule::class); }
    public function personnel() { return $this->belongsTo(Personnel::class); }
}