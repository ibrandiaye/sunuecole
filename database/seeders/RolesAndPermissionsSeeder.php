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
            Permission::create(['name' => $permission]);
        }

        // Création des rôles et assignation des permissions
        
        // Super Admin : a toutes les permissions
        $role = Role::create(['name' => 'super_admin']);
        $role->givePermissionTo(Permission::all());

        // Directeur
        $directeur = Role::create(['name' => 'directeur']);
        $directeur->givePermissionTo([
            'eleves.view', 'eleves.create', 'eleves.edit',
            'enseignants.view', 'enseignants.create', 'enseignants.edit',
            'classes.view', 'classes.create', 'classes.edit',
            'notes.view', 'bulletins.view', 'bulletins.publier',
            'absences.view', 'paiements.stats', 'emplois.view',
        ]);

        // Comptable
        $comptable = Role::create(['name' => 'comptable']);
        $comptable->givePermissionTo(['paiements.view', 'paiements.encaisser', 'paiements.stats', 'eleves.view']);

        // Surveillant
        $surveillant = Role::create(['name' => 'surveillant']);
        $surveillant->givePermissionTo(['absences.view', 'absences.marquer', 'absences.justifier', 'eleves.view', 'emplois.view']);

        // Enseignant
        $enseignant = Role::create(['name' => 'enseignant']);
        $enseignant->givePermissionTo(['notes.view', 'notes.saisir', 'absences.marquer', 'emplois.view', 'eleves.view']);

        // Parent
        $parent = Role::create(['name' => 'parent']);
        $parent->givePermissionTo(['notes.view', 'absences.view', 'bulletins.view', 'paiements.view', 'emplois.view']);

        // Élève
        $eleve = Role::create(['name' => 'eleve']);
        $eleve->givePermissionTo(['notes.view', 'absences.view', 'bulletins.view', 'emplois.view']);
    }
}
