<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Classe extends Model
{
    protected $fillable = [
        'nom', 'niveau_id', 'serie_id', 'annee_scolaire_id', 'salle_id',
        'professeur_principal_id', 'effectif_max', 'active', 'cycle_id',
        'montant_inscription', 'montant_mensualite', 'montant_cantine', 'montant_transport'
    ];

    public function cycle()
    {
        return $this->belongsTo(Cycle::class);
    }

    /**
     * Scope pour limiter les classes au cycle de l'utilisateur
     */
    public function scopeVisible($query)
    {
        if (auth()->check() && auth()->user()->cycle_id) {
            return $query->where('cycle_id', auth()->user()->cycle_id);
        }
        return $query;
    }

    public function niveau()
    {
        return $this->belongsTo(Niveau::class);
    }

    public function serie()
    {
        return $this->belongsTo(Serie::class);
    }

    public function anneeScolaire()
    {
        return $this->belongsTo(AnneeScolaire::class);
    }

    public function salle()
    {
        return $this->belongsTo(Salle::class);
    }

    public function professeurPrincipal()
    {
        return $this->belongsTo(User::class, 'professeur_principal_id');
    }

    public function eleves()
    {
        return $this->hasMany(Eleve::class);
    }

    public function matieres()
    {
        return $this->belongsToMany(Matiere::class, 'classe_matiere')
                    ->withPivot('enseignant_id', 'coefficient_override', 'heures_semaine')
                    ->withTimestamps();
    }

    public function emploisDuTemps()
    {
        return $this->hasMany(EmploiDuTemps::class);
    }

    /**
     * Récupère le tarif effectif pour un type de paiement donné (INSCR, MENS, CANT, TRANSP).
     * Priorité 1: Montant spécifique à la classe
     * Priorité 2: Tarif configuré pour le niveau (année scolaire active)
     */
    public function getEffectiveTarif(string $code): ?float
    {
        $field = match($code) {
            'INSCR'  => 'montant_inscription',
            'MENS'   => 'montant_mensualite',
            'CANT'   => 'montant_cantine',
            'TRANSP' => 'montant_transport',
            default  => null,
        };

        if ($field && $this->$field !== null) {
            return (float) $this->$field;
        }

        $activeYear = \App\Models\AnneeScolaire::where('active', true)->first();
        if ($this->niveau_id && $activeYear) {
            $type = \App\Models\TypePaiement::where('code', $code)->first();
            if ($type) {
                $tarif = \App\Models\Tarif::where('annee_scolaire_id', $activeYear->id)
                    ->where('niveau_id', $this->niveau_id)
                    ->where('type_paiement_id', $type->id)
                    ->first();
                if ($tarif) {
                    return (float) $tarif->montant;
                }
            }
        }

        return null;
    }
}
