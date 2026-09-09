<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class AdminSeeder extends Seeder
{
    public function run(): void
    {
        $admin = User::create([
            'name' => 'Admin SunuEcole',
            'email' => 'admin@sunuecole.sn',
            'password' => Hash::make('password'), // Change me in production
            'telephone' => '770000000',
            'actif' => true,
        ]);

        $admin->assignRole('super_admin');
    }
}
