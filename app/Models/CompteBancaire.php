<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CompteBancaire extends Model {
    use HasFactory;
    protected $fillable = ['nom_banque', 'numero_compte', 'solde_initial', 'actif'];
    
    public function operations() {
        return $this->hasMany(OperationBancaire::class);
    }

    public function getSoldeActuelAttribute() {
        $depots = $this->operations()->where('type', 'depot')->sum('montant');
        $retraits = $this->operations()->whereIn('type', ['retrait', 'frais'])->sum('montant');
        return $this->solde_initial + $depots - $retraits;
    }
}