<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;

class RolesAndPermissionsSeeder extends Seeder
{
    public function run(): void
    {
        // Reset cached roles and permissions
        app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions();

        // Liste des permissions granulaires
        $permissions = [
            // Élèves
            'eleves.view', 'eleves.create', 'eleves.edit', 'eleves.delete',
            // Enseignants
            'enseignants.view', 'enseignants.create', 'enseignants.edit', 'enseignants.delete',
            // Classes
            'classes.view', 'classes.create', 'classes.edit', 'classes.delete',
            // Notes
            'notes.view', 'notes.saisir', 'notes.valider',
            // Bulletins
            'bulletins.view', 'bulletins.generer', 'bulletins.publier',
            // Absences
            'absences.view', 'absences.marquer', 'absences.justifier',
            // Paiements
            'paiements.view', 'paiements.encaisser', 'paiements.stats',
            // Paramètres
            'parametres.view', 'parametres.edit',
            // Emploi du temps
            'emplois.view', 'emplois.edit',
        ];

        foreach ($permissions as $permission) {
            Permission::firstOrCreate(['name' => $permission]);
        }

        // Création des rôles et assignation des permissions
        
        // Super Admin : a toutes les permissions
        $role = Role::firstOrCreate(['name' => 'super_admin']);
        $role->givePermissionTo(Permission::all());

        // Directeur
        $directeur = Role::firstOrCreate(['name' => 'directeur']);
        $directeur->givePermissionTo(Permission::all()); // On donne presque tout au directeur pour l'instant

        // Comptable
        $comptable = Role::firstOrCreate(['name' => 'comptable']);
        
        // Secrétaire
        $secretaire = Role::firstOrCreate(['name' => 'secretaire']);

        // RH (Ressources Humaines)
        $rh = Role::firstOrCreate(['name' => 'rh']);

        // Logistique (Cantine & Transport)
        $logistique = Role::firstOrCreate(['name' => 'logistique']);

        // Administratif (Générique)
        $administratif = Role::firstOrCreate(['name' => 'administratif']);

        // Surveillant
        $surveillant = Role::firstOrCreate(['name' => 'surveillant']);

        // Enseignant
        $enseignant = Role::firstOrCreate(['name' => 'enseignant']);

        // Parent
        $parent = Role::firstOrCreate(['name' => 'parent']);

        // Élève
        $eleve = Role::firstOrCreate(['name' => 'eleve']);
    }
}