<?php
$f = 'app/Http/Controllers/Web/PaiementController.php';
$c = file_get_contents($f);

$oldCode = <<<EOT
            } elseif (\$code === 'CANT') {
                \$tarifBase = (\$eleve->inscriptionActuelle && \$eleve->inscriptionActuelle->avec_cantine) 
                    ? \$montantCantine 
                    : 0;
            }
EOT;

$newCode = <<<EOT
            } elseif (\$code === 'CANT') {
                // Vérifier si l'élève a un abonnement cantine actif
                \$abonnementCantine = \App\Models\AbonnementCantine::where('eleve_id', \$eleve->id)
                    ->where('actif', true)
                    ->first();
                \$tarifBase = \$abonnementCantine ? (\$montantCantine > 0 ? \$montantCantine : \$type->montant_defaut) : 0;
            }
EOT;

$c = str_replace($oldCode, $newCode, $c);
file_put_contents($f, $c);
