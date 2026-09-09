<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Eleve extends Model
{
    protected $fillable = [
        'user_id', 'matricule', 'nom', 'prenom', 'date_naissance', 'lieu_naissance',
        'sexe', 'nationalite', 'photo', 'groupe_sanguin', 'allergies',
        'maladies_chroniques', 'medecin_traitant', 'parent_id', 'nom_tuteur',
        'tel_tuteur', 'email_tuteur', 'relation_tuteur', 'classe_id',
        'annee_scolaire_id', 'statut', 'date_inscription', 'date_sortie', 'motif_sortie'
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function parent()
    {
        return $this->belongsTo(ParentEleve::class, 'parent_id');
    }

    public function classe()
    {
        return $this->belongsTo(Classe::class);
    }

    public function anneeScolaire()
    {
        return $this->belongsTo(AnneeScolaire::class);
    }

    public function notes()
    {
        return $this->hasMany(Note::class);
    }

    public function absences()
    {
        return $this->hasMany(Absence::class);
    }

    public function convocations()
    {
        return $this->hasMany(Convocation::class);
    }

    public function bulletins()
    {
        return $this->hasMany(Bulletin::class);
    }

    public function paiements()
    {
        return $this->hasMany(Paiement::class);
    }

    public function inscriptions()
    {
        return $this->hasMany(Inscription::class);
    }

    public function inscriptionActuelle()
    {
        $activeYear = \App\Models\AnneeScolaire::where('active', true)->first();
        return $this->hasOne(Inscription::class)
                    ->where('annee_scolaire_id', $activeYear ? $activeYear->id : null);
    }

    /**
     * Scope pour limiter les élèves au cycle de l'utilisateur
     */
    public function scopeVisible($query)
    {
        if (auth()->check() && auth()->user()->cycle_id) {
            return $query->whereHas('classe', function($q) {
                $q->where('cycle_id', auth()->user()->cycle_id);
            });
        }
        return $query;
    }
}
