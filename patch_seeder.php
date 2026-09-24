<?php
$f = 'database/seeders/RolesAndPermissionsSeeder.php';
$c = file_get_contents($f);

// Replace the role creation part
$start = strpos($c, '// Super Admin');
$newRoles = <<<EOT
// Super Admin : a toutes les permissions
        \$role = Role::firstOrCreate(['name' => 'super_admin']);
        \$role->givePermissionTo(Permission::all());

        // Directeur
        \$directeur = Role::firstOrCreate(['name' => 'directeur']);
        \$directeur->givePermissionTo(Permission::all()); // On donne presque tout au directeur pour l'instant

        // Comptable
        \$comptable = Role::firstOrCreate(['name' => 'comptable']);
        
        // Secrétaire
        \$secretaire = Role::firstOrCreate(['name' => 'secretaire']);

        // RH (Ressources Humaines)
        \$rh = Role::firstOrCreate(['name' => 'rh']);

        // Logistique (Cantine & Transport)
        \$logistique = Role::firstOrCreate(['name' => 'logistique']);

        // Administratif (Générique)
        \$administratif = Role::firstOrCreate(['name' => 'administratif']);

        // Surveillant
        \$surveillant = Role::firstOrCreate(['name' => 'surveillant']);

        // Enseignant
        \$enseignant = Role::firstOrCreate(['name' => 'enseignant']);

        // Parent
        \$parent = Role::firstOrCreate(['name' => 'parent']);

        // Élève
        \$eleve = Role::firstOrCreate(['name' => 'eleve']);
    }
}
EOT;

$c = substr($c, 0, $start) . $newRoles;

// Fix Permission::create to firstOrCreate
$c = str_replace("Permission::create(['name' => \$permission]);", "Permission::firstOrCreate(['name' => \$permission]);", $c);

file_put_contents($f, $c);
