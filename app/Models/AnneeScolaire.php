<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AnneeScolaire extends Model
{
    use HasFactory;

    protected $fillable = ['libelle', 'date_debut', 'date_fin', 'active'];

    protected $casts = [
        'active' => 'boolean',
        'date_debut' => 'date',
        'date_fin' => 'date',
    ];

    protected static function booted(): void
    {
        static::saving(function ($annee) {
            if ($annee->active) {
                // Dès qu'une année devient active, toutes les autres passent obligatoirement à active = false
                static::where('id', '!=', $annee->id)->update(['active' => false]);
            }
        });
    }

    public function scopeActive($query)
    {
        return $query->where('active', true);
    }

    /**
     * Retourne les 9 mois scolaires officiels (Octobre à Juin)
     * Format : ['10/2025' => 'Octobre', ..., '06/2026' => 'Juin']
     */
    public static function getMoisScolaires(?self $annee = null): array
    {
        $annee = $annee ?? static::where('active', true)->first();

        $startYear = (int) date('Y');
        $endYear = $startYear + 1;

        if ($annee) {
            $parts = explode('-', $annee->libelle);
            if (count($parts) == 2 && is_numeric(trim($parts[0])) && is_numeric(trim($parts[1]))) {
                $startYear = (int) trim($parts[0]);
                $endYear = (int) trim($parts[1]);
            } elseif ($annee->date_debut && $annee->date_fin) {
                $startYear = (int) \Carbon\Carbon::parse($annee->date_debut)->format('Y');
                $endYear = (int) \Carbon\Carbon::parse($annee->date_fin)->format('Y');
            }
        }

        return [
            sprintf('10/%04d', $startYear) => 'Octobre',
            sprintf('11/%04d', $startYear) => 'Novembre',
            sprintf('12/%04d', $startYear) => 'Décembre',
            sprintf('01/%04d', $endYear)   => 'Janvier',
            sprintf('02/%04d', $endYear)   => 'Février',
            sprintf('03/%04d', $endYear)   => 'Mars',
            sprintf('04/%04d', $endYear)   => 'Avril',
            sprintf('05/%04d', $endYear)   => 'Mai',
            sprintf('06/%04d', $endYear)   => 'Juin',
        ];
    }
}
