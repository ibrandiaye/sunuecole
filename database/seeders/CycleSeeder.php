<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Cycle;

class CycleSeeder extends Seeder
{
    public function run(): void
    {
        $cycles = [
            ['nom' => 'Elémentaire', 'code' => 'ELEM', 'description' => 'Cycle primaire du CI au CM2'],
            ['nom' => 'Moyen', 'code' => 'MOY', 'description' => 'Cycle collège de la 6ème à la 3ème'],
            ['nom' => 'Secondaire', 'code' => 'SEC', 'description' => 'Cycle lycée de la seconde à la terminale'],
        ];

        foreach ($cycles as $cycle) {
            Cycle::updateOrCreate(['code' => $cycle['code']], $cycle);
        }
    }
}
