<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
class AbonnementCantine extends Model {
    use HasFactory;
    protected $fillable = ['eleve_id', 'date_debut', 'date_fin', 'regime_alimentaire', 'actif'];
    public function eleve() { return $this->belongsTo(Eleve::class); }
}