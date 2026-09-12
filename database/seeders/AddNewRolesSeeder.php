<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;

/**
 * Seeder de migration : à exécuter sur une installation existante.
 * N'efface pas les permissions ou rôles existants.
 * 
 * Usage : php artisan db:seed --class=AddNewRolesSeeder
 */
class AddNewRolesSeeder extends Seeder
{
    public function run(): void
    {
        // Vider le cache des permissions
        app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions();

        // === NOUVELLES PERMISSIONS ===
        $newPermissions = [
            // Inscriptions
            'inscriptions.view', 'inscriptions.create',
            // Tuteurs
            'tuteurs.view', 'tuteurs.edit',
            // Dépenses
            'depenses.view', 'depenses.create', 'depenses.edit', 'depenses.delete',
            // Types de frais
            'types_paiements.view', 'types_paiements.edit',
            // Niveaux et tarifs
            'niveaux.view', 'niveaux.edit',
            // Rapport financier
            'rapports.view',
            // Convocations
            'convocations.view', 'convocations.create',
        ];

        foreach ($newPermissions as $perm) {
            Permission::firstOrCreate(['name' => $perm]);
        }

        // === super_admin : toutes les permissions ===
        $superAdmin = Role::firstOrCreate(['name' => 'super_admin']);
        $superAdmin->syncPermissions(Permission::all());

        // === directeur : toutes les permissions ===
        $directeur = Role::firstOrCreate(['name' => 'directeur']);
        $directeur->syncPermissions(Permission::all());

        // === COMPTABLE (enrichi) ===
        $comptable = Role::firstOrCreate(['name' => 'comptable']);
        $comptable->syncPermissions([
            // Finance — accès complet
            'paiements.view', 'paiements.encaisser', 'paiements.stats',
            'depenses.view', 'depenses.create', 'depenses.edit', 'depenses.delete',
            'types_paiements.view', 'types_paiements.edit',
            'niveaux.view', 'niveaux.edit',
            'rapports.view',
            // Vue contextuelle uniquement
            'eleves.view',
            'tuteurs.view',
            'inscriptions.view',
            'classes.view',
        ]);

        // === ADMINISTRATIF (nouveau) ===
        $administratif = Role::firstOrCreate(['name' => 'administratif']);
        $administratif->syncPermissions([
            // Élèves — complet
            'eleves.view', 'eleves.create', 'eleves.edit', 'eleves.delete',
            // Tuteurs
            'tuteurs.view', 'tuteurs.edit',
            // Inscriptions
            'inscriptions.view', 'inscriptions.create',
            // Classes
            'classes.view', 'classes.create', 'classes.edit',
            // Enseignants
            'enseignants.view', 'enseignants.create', 'enseignants.edit',
            // Notes
            'notes.view',
            // Bulletins
            'bulletins.view', 'bulletins.generer',
            // Absences
            'absences.view', 'absences.marquer', 'absences.justifier',
            // Convocations
            'convocations.view', 'convocations.create',
            // Emploi du temps
            'emplois.view', 'emplois.edit',
            // Niveaux (vue uniquement pour contexte classes)
            'niveaux.view',
            'parametres.view',
        ]);

        $this->command->info('Roles Comptable et Administratif crees/mis a jour avec succes !');
        $this->command->table(
            ['Role', 'Nb Permissions'],
            [
                ['super_admin',   $superAdmin->permissions->count()],
                ['directeur',     $directeur->permissions->count()],
                ['comptable',     $comptable->permissions->count()],
                ['administratif', $administratif->permissions->count()],
            ]
        );
    }
}
