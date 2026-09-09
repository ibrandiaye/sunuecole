<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Niveau;
use App\Models\Matiere;
use App\Models\Classe;
use App\Models\Eleve;
use App\Models\Enseignant;
use App\Models\ParentEleve;
use App\Models\Paiement;
use App\Models\TypePaiement;
use App\Models\Note;
use App\Models\EmploiDuTemps;
use App\Models\AnneeScolaire;
use App\Models\Salle;
use App\Models\Inscription;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class TestDataSeeder extends Seeder
{
    public function run(): void
    {
        $anneeActive = AnneeScolaire::where('active', true)->first();
        if (!$anneeActive) {
             $anneeActive = AnneeScolaire::create([
                'libelle' => '2025-2026',
                'date_debut' => '2025-10-01',
                'date_fin' => '2026-07-31',
                'active' => true,
            ]);
        }

        // 0. Récupération des Cycles
        $cycleElem = \App\Models\Cycle::where('code', 'ELEM')->first();
        $cycleMoy = \App\Models\Cycle::where('code', 'MOY')->first();
        $cycleSec = \App\Models\Cycle::where('code', 'SEC')->first();

        // 1. Création des Niveaux
        $niveauxData = [
            ['nom' => 'Sixième', 'code' => '6EME', 'cycle_id' => $cycleMoy->id],
            ['nom' => 'Troisième', 'code' => '3EME', 'cycle_id' => $cycleMoy->id],
            ['nom' => 'Seconde S', 'code' => '2S', 'cycle_id' => $cycleSec->id],
            ['nom' => 'Terminale S2', 'code' => 'TS2', 'cycle_id' => $cycleSec->id],
        ];

        $niveaux = [];
        foreach ($niveauxData as $nd) {
            $niveaux[] = Niveau::create($nd);
        }

        // 2. Création des Matières
        $matieresData = [
            ['nom' => 'Mathématiques', 'code' => 'MATH', 'cycle_id' => $cycleMoy->id],
            ['nom' => 'Français', 'code' => 'FR', 'cycle_id' => $cycleMoy->id],
            ['nom' => 'SVT', 'code' => 'SVT', 'cycle_id' => $cycleMoy->id],
            ['nom' => 'Physique-Chimie', 'code' => 'PC', 'cycle_id' => $cycleSec->id],
            ['nom' => 'Philosophie', 'code' => 'PHILO', 'cycle_id' => $cycleSec->id],
        ];

        foreach ($matieresData as $md) {
            Matiere::create($md);
        }

        // 3. Création des Enseignants
        $enseignants = [];
        for ($i = 1; $i <= 3; $i++) {
            $user = User::create([
                'name' => "Professeur $i",
                'email' => "prof$i@sunuecole.sn",
                'password' => Hash::make('password'),
                'telephone' => '77000000' . $i,
                'actif' => true
            ]);
            $user->assignRole('enseignant');

            $enseignants[] = Enseignant::create([
                'user_id' => $user->id,
                'matricule' => 'PF-2026-' . str_pad($i, 3, '0', STR_PAD_LEFT),
                'specialite' => ($i % 2 == 0) ? 'Mathématiques' : 'Français'
            ]);
        }

        // 4. Création des Classes
        $salles = Salle::all();
        if ($salles->isEmpty()) {
            $salles[] = Salle::create(['nom' => 'Salle A1', 'capacite' => 40]);
            $salles[] = Salle::create(['nom' => 'Salle B2', 'capacite' => 45]);
        }

        $classes = [];
        foreach ($niveaux as $index => $nv) {
            $classes[] = Classe::create([
                'nom' => $nv->nom . ' A',
                'niveau_id' => $nv->id,
                'salle_id' => $salles[$index % count($salles)]->id,
                'annee_scolaire_id' => $anneeActive->id,
                'cycle_id' => $nv->cycle_id,
            ]);
        }

        // 5. Création des Élèves et Parents
        $typeInscription = TypePaiement::where('code', 'INSCR')->first();
        $typeMensualite = TypePaiement::where('code', 'MENS')->first();

        foreach ($classes as $classe) {
            for ($j = 1; $j <= 5; $j++) {
                $uniqueId = $classe->id . $j;
                
                // Créer un parent
                $userParent = User::create([
                    'name' => "Parent Eleve $uniqueId",
                    'email' => "parent$uniqueId@gmail.com",
                    'password' => Hash::make('password'),
                    'actif' => true
                ]);
                $userParent->assignRole('parent');
                $parent = ParentEleve::create(['user_id' => $userParent->id, 'telephone' => '7800000' . $uniqueId]);

                // Créer l'utilisateur pour l'élève (indispensable pour l'API)
                $userEleve = User::create([
                    'name' => "Prenom-$uniqueId NOM-$uniqueId",
                    'email' => "eleve$uniqueId@sunuecole.sn",
                    'password' => Hash::make('password'),
                    'actif' => true
                ]);
                $userEleve->assignRole('eleve');

                // Créer l'élève
                $eleve = Eleve::create([
                    'user_id' => $userEleve->id,
                    'nom' => "NOM-$uniqueId",
                    'prenom' => "Prenom-$uniqueId",
                    'matricule' => "MAT-" . date('Y') . "-$uniqueId",
                    'date_naissance' => '2010-05-15',
                    'sexe' => ($j % 2 == 0) ? 'M' : 'F',
                    'classe_id' => $classe->id,
                    'parent_id' => $parent->id,
                    'annee_scolaire_id' => $anneeActive->id,
                ]);

                // Créer l'inscription historique
                Inscription::create([
                    'eleve_id' => $eleve->id,
                    'classe_id' => $classe->id,
                    'annee_scolaire_id' => $anneeActive->id,
                    'date_inscription' => now(),
                    'statut' => 'actif'
                ]);

                // Créer un paiement d'inscription
                if ($typeInscription) {
                    Paiement::create([
                        'reference' => 'PAY-' . time() . '-' . $uniqueId,
                        'eleve_id' => $eleve->id,
                        'type_paiement_id' => $typeInscription->id,
                        'annee_scolaire_id' => $anneeActive->id,
                        'montant_du' => $typeInscription->montant_defaut,
                        'montant_paye' => $typeInscription->montant_defaut,
                        'reste_a_payer' => 0,
                        'date_paiement' => now(),
                        'mode_paiement' => 'especes',
                        'statut' => 'paye'
                    ]);
                }

                // Créer quelques notes
                $matiere = Matiere::first();
                if ($matiere) {
                    Note::create([
                        'eleve_id' => $eleve->id,
                        'matiere_id' => $matiere->id,
                        'classe_id' => $classe->id,
                        'annee_scolaire_id' => $anneeActive->id,
                        'periode' => 'Premier Semestre',
                        'type_evaluation' => 'devoir',
                        'valeur' => rand(10, 18),
                        'coefficient' => 1,
                        'date_evaluation' => date('Y-m-d')
                    ]);
                }
            }
        }

        // 6. Quelques Emplois du temps
        foreach ($classes as $cl) {
            EmploiDuTemps::create([
                'classe_id' => $cl->id,
                'matiere_id' => Matiere::first()->id,
                'enseignant_id' => $enseignants[0]->id,
                'annee_scolaire_id' => $anneeActive->id,
                'jour' => 1, // Lundi
                'heure_debut' => '08:00',
                'heure_fin' => '10:00',
                'salle_id' => $cl->salle_id
            ]);
        }
    }
}
