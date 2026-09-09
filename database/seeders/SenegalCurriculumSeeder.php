<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\AnneeScolaire;
use App\Models\Cycle;
use App\Models\Niveau;
use App\Models\Serie;
use App\Models\Classe;
use App\Models\Matiere;
use App\Models\Eleve;
use App\Models\Note;
use App\Models\Salle;
use App\Models\Enseignant;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class SenegalCurriculumSeeder extends Seeder
{
    public function run(): void
    {
        // 1. Année Scolaire
        $annee = AnneeScolaire::firstOrCreate(
            ['libelle' => '2023-2024'],
            [
                'date_debut' => '2023-10-05',
                'date_fin' => '2024-07-31',
                'active' => true
            ]
        );

        // 2. Cycles (Assurons-nous qu'ils existent)
        $cycleMoyen = Cycle::firstOrCreate(['code' => 'MOY'], ['nom' => 'Moyen', 'description' => 'Collège']);
        $cycleSecondaire = Cycle::firstOrCreate(['code' => 'SEC'], ['nom' => 'Secondaire', 'description' => 'Lycée']);

        // 3. Niveaux et Séries
        $niveau6e = Niveau::firstOrCreate(['code' => '6EME'], ['nom' => '6ème', 'cycle_id' => $cycleMoyen->id]);
        $niveau1ere = Niveau::firstOrCreate(['code' => '1ERE'], ['nom' => '1ère', 'cycle_id' => $cycleSecondaire->id]);
        $serieL2 = Serie::firstOrCreate(['code' => 'L2'], ['nom' => 'Littéraire L2', 'description' => 'Langues et Civilisations']);

        // 4. Création des Salles
        $salle6e = Salle::firstOrCreate(['nom' => 'Salle 101'], ['capacite' => 60, 'disponible' => true]);
        $salle1ere = Salle::firstOrCreate(['nom' => 'Salle 201'], ['capacite' => 50, 'disponible' => true]);

        // 5. Création des Classes
        $classe6e = Classe::firstOrCreate(
            ['nom' => '6ème A'],
            [
                'niveau_id' => $niveau6e->id,
                'annee_scolaire_id' => $annee->id,
                'salle_id' => $salle6e->id,
                'cycle_id' => $cycleMoyen->id,
                'effectif_max' => 60,
                'active' => true
            ]
        );

        $classe1ere = Classe::firstOrCreate(
            ['nom' => '1ère L2A'],
            [
                'niveau_id' => $niveau1ere->id,
                'serie_id' => $serieL2->id,
                'annee_scolaire_id' => $annee->id,
                'salle_id' => $salle1ere->id,
                'cycle_id' => $cycleSecondaire->id,
                'effectif_max' => 50,
                'active' => true
            ]
        );

        // 6. Création des Matières Sénégalaises (Moyen & Secondaire)
        // Matières 6ème
        $matieres6e = [
            ['nom' => 'Mathématiques', 'code' => 'MATH', 'coeff' => 3, 'type' => 'obligatoire'],
            ['nom' => 'Français', 'code' => 'FR', 'coeff' => 4, 'type' => 'obligatoire'],
            ['nom' => 'Histoire-Géographie', 'code' => 'HG', 'coeff' => 2, 'type' => 'obligatoire'],
            ['nom' => 'Anglais', 'code' => 'ANG', 'coeff' => 2, 'type' => 'obligatoire'],
            ['nom' => 'SVT', 'code' => 'SVT', 'coeff' => 2, 'type' => 'obligatoire'],
            ['nom' => 'Education Physique', 'code' => 'EPS', 'coeff' => 2, 'type' => 'obligatoire'],
            ['nom' => 'Arabe', 'code' => 'ARA', 'coeff' => 2, 'type' => 'optionnel'],
        ];

        // Matières 1ère L2
        $matieres1ereL2 = [
            ['nom' => 'Français', 'code' => 'FR_L2', 'coeff' => 4, 'type' => 'obligatoire'],
            ['nom' => 'Philosophie', 'code' => 'PHILO', 'coeff' => 2, 'type' => 'obligatoire'],
            ['nom' => 'Histoire-Géographie', 'code' => 'HG_L2', 'coeff' => 4, 'type' => 'obligatoire'],
            ['nom' => 'Anglais', 'code' => 'ANG_L2', 'coeff' => 3, 'type' => 'obligatoire'],
            ['nom' => 'Espagnol', 'code' => 'LV2_ESP', 'coeff' => 3, 'type' => 'obligatoire'],
            ['nom' => 'Mathématiques', 'code' => 'MATH_L2', 'coeff' => 2, 'type' => 'obligatoire'],
            ['nom' => 'Education Physique', 'code' => 'EPS_L2', 'coeff' => 2, 'type' => 'obligatoire'],
        ];

        $allMatieres6e = [];
        foreach ($matieres6e as $m) {
            $matiere = Matiere::firstOrCreate(
                ['code' => $m['code']],
                ['nom' => $m['nom'], 'cycle_id' => $cycleMoyen->id, 'type' => $m['type'], 'coefficient' => $m['coeff']]
            );
            $allMatieres6e[] = $matiere;
            $classe6e->matieres()->syncWithoutDetaching([$matiere->id => ['coefficient_override' => $m['coeff'], 'heures_semaine' => 4]]);
        }

        $allMatieres1ere = [];
        foreach ($matieres1ereL2 as $m) {
            $matiere = Matiere::firstOrCreate(
                ['code' => $m['code']],
                ['nom' => $m['nom'], 'cycle_id' => $cycleSecondaire->id, 'type' => $m['type'], 'coefficient' => $m['coeff']]
            );
            $allMatieres1ere[] = $matiere;
            $classe1ere->matieres()->syncWithoutDetaching([$matiere->id => ['coefficient_override' => $m['coeff'], 'heures_semaine' => 4]]);
        }

        // 7. Création des Élèves (50 par classe)
        $faker = \Faker\Factory::create('fr_FR'); // fallback à fr_FR si fr_SN n'est pas dispo
        
        $eleves6e = [];
        for ($i = 0; $i < 50; $i++) {
            $eleves6e[] = Eleve::create([
                'matricule' => '6E' . str_pad($i + 1, 3, '0', STR_PAD_LEFT) . 'A',
                'prenom' => $faker->firstName,
                'nom' => $faker->lastName,
                'date_naissance' => $faker->dateTimeBetween('-13 years', '-11 years')->format('Y-m-d'),
                'lieu_naissance' => $faker->city,
                'sexe' => $faker->randomElement(['M', 'F']),
                'classe_id' => $classe6e->id,
                'annee_scolaire_id' => $annee->id,
                'nom_tuteur' => $faker->name,
                'tel_tuteur' => $faker->phoneNumber,
                'statut' => 'actif'
            ]);
        }

        $eleves1ere = [];
        for ($i = 0; $i < 50; $i++) {
            $eleves1ere[] = Eleve::create([
                'matricule' => '1L2' . str_pad($i + 1, 3, '0', STR_PAD_LEFT) . 'A',
                'prenom' => $faker->firstName,
                'nom' => $faker->lastName,
                'date_naissance' => $faker->dateTimeBetween('-18 years', '-16 years')->format('Y-m-d'),
                'lieu_naissance' => $faker->city,
                'sexe' => $faker->randomElement(['M', 'F']),
                'classe_id' => $classe1ere->id,
                'annee_scolaire_id' => $annee->id,
                'nom_tuteur' => $faker->name,
                'tel_tuteur' => $faker->phoneNumber,
                'statut' => 'actif'
            ]);
        }

        // 8. Génération des Notes
        $periodes = ['Premier Semestre', 'Second Semestre'];

        // Pour la 6ème
        foreach ($eleves6e as $eleve) {
            foreach ($periodes as $periode) {
                foreach ($allMatieres6e as $matiere) {
                    // 2 devoirs
                    for ($d = 1; $d <= 2; $d++) {
                        Note::create([
                            'eleve_id' => $eleve->id,
                            'matiere_id' => $matiere->id,
                            'classe_id' => $classe6e->id,
                            'annee_scolaire_id' => $annee->id,
                            'type_evaluation' => 'devoir',
                            'numero_devoir' => $d,
                            'periode' => $periode,
                            'valeur' => $faker->randomFloat(2, 6, 19), 
                            'date_evaluation' => Carbon::now()->subMonths(rand(1, 6)),
                        ]);
                    }
                    // 1 composition
                    Note::create([
                        'eleve_id' => $eleve->id,
                        'matiere_id' => $matiere->id,
                        'classe_id' => $classe6e->id,
                        'annee_scolaire_id' => $annee->id,
                        'type_evaluation' => 'composition',
                        'periode' => $periode,
                        'valeur' => $faker->randomFloat(2, 7, 18),
                        'date_evaluation' => Carbon::now()->subMonths(rand(1, 6)),
                    ]);
                }
            }
        }

        // Pour la 1ère L2
        foreach ($eleves1ere as $eleve) {
            foreach ($periodes as $periode) {
                foreach ($allMatieres1ere as $matiere) {
                    // 2 devoirs
                    for ($d = 1; $d <= 2; $d++) {
                        Note::create([
                            'eleve_id' => $eleve->id,
                            'matiere_id' => $matiere->id,
                            'classe_id' => $classe1ere->id,
                            'annee_scolaire_id' => $annee->id,
                            'type_evaluation' => 'devoir',
                            'numero_devoir' => $d,
                            'periode' => $periode,
                            'valeur' => $faker->randomFloat(2, 5, 18), 
                            'date_evaluation' => Carbon::now()->subMonths(rand(1, 6)),
                        ]);
                    }
                    // 1 composition
                    Note::create([
                        'eleve_id' => $eleve->id,
                        'matiere_id' => $matiere->id,
                        'classe_id' => $classe1ere->id,
                        'annee_scolaire_id' => $annee->id,
                        'type_evaluation' => 'composition',
                        'periode' => $periode,
                        'valeur' => $faker->randomFloat(2, 6, 17),
                        'date_evaluation' => Carbon::now()->subMonths(rand(1, 6)),
                    ]);
                }
            }
        }
    }
}

