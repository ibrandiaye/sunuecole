<?php

namespace Database\Seeders;

use App\Models\AnneeScolaire;
use App\Models\TypePaiement;
use App\Models\Salle;
use App\Models\Serie;
use Illuminate\Database\Seeder;

class InitialDataSeeder extends Seeder
{
    public function run(): void
    {
        // Année scolaire active
        AnneeScolaire::create([
            'libelle' => '2025-2026',
            'date_debut' => '2025-10-01',
            'date_fin' => '2026-07-31',
            'active' => true,
        ]);

        // Types de paiements
        $types = [
            ['nom' => 'Inscription', 'code' => 'INSCR', 'montant_defaut' => 25000, 'periodicite' => 'unique'],
            ['nom' => 'Mensualité', 'code' => 'MENS', 'montant_defaut' => 15000, 'periodicite' => 'mensuel'],
            ['nom' => 'Cantine', 'code' => 'CANT', 'montant_defaut' => 10000, 'periodicite' => 'mensuel'],
            ['nom' => 'Transport', 'code' => 'TRANSP', 'montant_defaut' => 12000, 'periodicite' => 'mensuel'],
        ];

        foreach ($types as $type) {
            TypePaiement::create($type);
        }

        // Salles
        Salle::create(['nom' => 'Salle 101', 'capacite' => 45, 'type' => 'classe']);
        Salle::create(['nom' => 'Salle 102', 'capacite' => 45, 'type' => 'classe']);
        Salle::create(['nom' => 'Labo SVT', 'capacite' => 30, 'type' => 'laboratoire']);

        // Séries
        Serie::create(['nom' => 'S1', 'code' => 'S1']);
        Serie::create(['nom' => 'S2', 'code' => 'S2']);
        Serie::create(['nom' => 'L1', 'code' => 'L1']);
    }
}
