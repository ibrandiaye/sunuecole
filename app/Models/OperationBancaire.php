<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OperationBancaire extends Model {
    use HasFactory;
    protected $fillable = ['compte_bancaire_id', 'type', 'montant', 'date_operation', 'motif', 'reference_piece', 'user_id'];
    
    public function compte() {
        return $this->belongsTo(CompteBancaire::class, 'compte_bancaire_id');
    }
    public function user() {
        return $this->belongsTo(User::class);
    }
}