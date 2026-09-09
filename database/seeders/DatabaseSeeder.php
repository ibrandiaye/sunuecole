<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $this->call([
            EtablissementSeeder::class,
            CycleSeeder::class,
            RolesAndPermissionsSeeder::class,
            AdminSeeder::class,
            InitialDataSeeder::class,
            TestDataSeeder::class,
        ]);
    }
}
