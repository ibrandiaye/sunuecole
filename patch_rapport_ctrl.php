<?php
$f = 'app/Http/Controllers/Web/RapportController.php';
$c = file_get_contents($f);

// Add synthese method
$method = <<<EOT
    public function synthese()
    {
        \$anneeActive = AnneeScolaire::where('active', true)->first();

        // Scolarité
        \$statsScolarite = [
            'eleves_actifs' => \App\Models\Eleve::where('actif', true)->count(),
            'total_classes' => \App\Models\Classe::count(),
            'inscriptions_annee' => \$anneeActive ? \App\Models\Inscription::where('annee_scolaire_id', \$anneeActive->id)->count() : 0,
        ];

        // Ressources Humaines
        \$statsRH = [
            'total_enseignants' => \App\Models\Enseignant::count(),
            'total_personnels' => class_exists('\App\Models\Personnel') ? \App\Models\Personnel::where('actif', true)->count() : 0,
        ];

        // Logistique
        \$statsLogistique = [
            'abonnes_cantine' => class_exists('\App\Models\AbonnementCantine') ? \App\Models\AbonnementCantine::where('actif', true)->count() : 0,
            'abonnes_transport' => class_exists('\App\Models\AbonnementTransport') ? \App\Models\AbonnementTransport::where('actif', true)->count() : 0,
        ];

        // Trésorerie & Banque
        \$statsBanque = [
            'solde_global' => 0,
            'comptes' => [],
        ];
        if (class_exists('\App\Models\CompteBancaire')) {
            \$comptes = \App\Models\CompteBancaire::all();
            foreach (\$comptes as \$compte) {
                \$statsBanque['solde_global'] += \$compte->solde_actuel;
                \$statsBanque['comptes'][] = [
                    'nom' => \$compte->nom_banque,
                    'solde' => \$compte->solde_actuel
                ];
            }
        }

        // Encaissements globaux
        \$totalPaiements = \App\Models\Paiement::sum('montant_paye');
        
        return view('rapports.synthese', compact(
            'statsScolarite', 'statsRH', 'statsLogistique', 'statsBanque', 'totalPaiements', 'anneeActive'
        ));
    }
EOT;

$c = str_replace("public function financier(Request \$request)", $method . "\n\n    public function financier(Request \$request)", $c);
file_put_contents($f, $c);
