<?php
$f='app/Http/Controllers/Web/PaiementController.php';
$c=file_get_contents($f);

// Restore file from git
exec('git checkout app/Http/Controllers/Web/PaiementController.php');
$c=file_get_contents($f);

$oldCode = '        $annee = AnneeScolaire::where(\'active\', true)->first();
        $baseData = $request->validated();
        
        // Recalculer le montant dû selon les tarifs et remises';

$newCode = '        $annee = AnneeScolaire::where(\'active\', true)->first();
        $baseData = $request->validated();
        
        // Vérifier si un paiement existe déjà pour cet élève, ce type et ce mois
        $query = \App\Models\Paiement::where(\'eleve_id\', $baseData[\'eleve_id\'])
            ->where(\'type_paiement_id\', $baseData[\'type_paiement_id\'])
            ->where(\'annee_scolaire_id\', $annee ? $annee->id : null);
            
        if (!empty($baseData[\'mois\'])) {
            $query->where(\'mois\', $baseData[\'mois\']);
        } else {
            $query->whereNull(\'mois\');
        }
        
        $existing = $query->first();
        if ($existing) {
            return back()->with(\'error\', \'Attention : Un paiement a déjà été enregistré pour cet élève pour cette rubrique et ce mois.\');
        }

        // Recalculer le montant dû selon les tarifs et remises';

$c = str_replace($oldCode, $newCode, $c);
file_put_contents($f, $c);
