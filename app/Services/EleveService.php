<?php

namespace App\Services;

use App\Models\Eleve;
use App\Models\AnneeScolaire;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\DB;

class EleveService
{
    /**
     * Génère un matricule unique type SEN-2026-00001
     */
    public function generateMatricule(): string
    {
        $year = date('Y');
        $prefix = "SEN-" . $year . "-";
        
        $lastEleve = Eleve::where('matricule', 'LIKE', $prefix . '%')
            ->orderBy('matricule', 'desc')
            ->first();

        if (!$lastEleve) {
            $number = 1;
        } else {
            $lastNumber = (int) Str::afterLast($lastEleve->matricule, '-');
            $number = $lastNumber + 1;
        }

        return $prefix . str_pad($number, 5, '0', STR_PAD_LEFT);
    }

    /**
     * Enregistre un nouvel élève
     */
    public function register(array $data): Eleve
    {
        return DB::transaction(function () use ($data) {
            $data['matricule'] = $this->generateMatricule();
            $data['statut'] = 'actif';
            $data['date_inscription'] = $data['date_inscription'] ?? now();
            
            // 1. Gestion du tuteur / parent
            if (!empty($data['parent_id'])) {
                $parent = \App\Models\ParentEleve::with('user')->find($data['parent_id']);
                if ($parent) {
                    $data['nom_tuteur'] = $parent->user->name ?? $data['nom_tuteur'] ?? null;
                    $data['tel_tuteur'] = $parent->telephone ?? $parent->user->telephone ?? $data['tel_tuteur'] ?? null;
                    $data['email_tuteur'] = $parent->user->email ?? $data['email_tuteur'] ?? null;
                    $data['relation_tuteur'] = $parent->relation ?? $data['relation_tuteur'] ?? 'parent';
                }
            } elseif (!empty($data['nom_tuteur']) || !empty($data['tel_tuteur'])) {
                // Vérifier si un parent existe déjà avec ce numéro ou cet email
                $existingParent = null;
                if (!empty($data['tel_tuteur'])) {
                    $existingParent = \App\Models\ParentEleve::where('telephone', $data['tel_tuteur'])
                        ->orWhereHas('user', function($q) use ($data) {
                            $q->where('telephone', $data['tel_tuteur']);
                        })->first();
                }
                if (!$existingParent && !empty($data['email_tuteur'])) {
                    $existingParent = \App\Models\ParentEleve::whereHas('user', function($q) use ($data) {
                        $q->where('email', $data['email_tuteur']);
                    })->first();
                }

                if ($existingParent) {
                    $data['parent_id'] = $existingParent->id;
                } else {
                    // Créer un utilisateur User et un profil ParentEleve
                    $email = !empty($data['email_tuteur']) ? $data['email_tuteur'] : 'parent_' . time() . rand(100, 999) . '@ecole.sn';
                    $user = \App\Models\User::create([
                        'name' => $data['nom_tuteur'] ?? 'Parent',
                        'email' => $email,
                        'telephone' => $data['tel_tuteur'] ?? null,
                        'password' => bcrypt('parent123'),
                        'actif' => true,
                    ]);

                    if (method_exists($user, 'assignRole')) {
                        try {
                            $user->assignRole('parent');
                        } catch (\Exception $e) {
                            // Ignorer si le rôle n'est pas encore initialisé
                        }
                    }

                    $newParent = \App\Models\ParentEleve::create([
                        'user_id' => $user->id,
                        'telephone' => $data['tel_tuteur'] ?? null,
                        'relation' => $data['relation_tuteur'] ?? 'parent',
                        'actif' => true,
                    ]);
                    $data['parent_id'] = $newParent->id;
                }
            }

            // Si pas d'année scolaire précisée, prendre l'active
            if (!isset($data['annee_scolaire_id'])) {
                $activeYear = AnneeScolaire::where('active', true)->first();
                $data['annee_scolaire_id'] = $activeYear?->id;
            }

            $eleve = Eleve::create($data);

            // Inscription automatique dans une classe UNIQUEMENT si classe_id est fournie
            if (!empty($data['classe_id']) && !empty($data['annee_scolaire_id'])) {
                \App\Models\Inscription::create([
                    'eleve_id' => $eleve->id,
                    'classe_id' => $data['classe_id'],
                    'annee_scolaire_id' => $data['annee_scolaire_id'],
                    'date_inscription' => $data['date_inscription'],
                    'statut' => 'actif',
                    'remise_inscription' => $data['remise_inscription'] ?? 0,
                    'remise_mensualite' => $data['remise_mensualite'] ?? 0,
                ]);
            }

            return $eleve;
        });
    }
}
