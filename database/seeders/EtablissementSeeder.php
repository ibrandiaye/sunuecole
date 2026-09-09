<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class EtablissementSeeder extends Seeder
{
    public function run(): void
    {
        \App\Models\Etablissement::firstOrCreate([
            'code' => 'SE-2026',
        ], [
            'nom' => 'SunuEcole Digital Academy',
            'type' => 'prive',
            'cycle' => 'mixte',
            'adresse' => 'Dakar, Plateau',
            'ville' => 'Dakar',
            'telephone' => '+221 33 000 00 00',
            'email' => 'contact@sunuecole.sn',
            'directeur_nom' => 'Ibrahima Diallo',
            'description' => 'Établissement d\'excellence pour la formation numérique.',
        ]);
    }
}
