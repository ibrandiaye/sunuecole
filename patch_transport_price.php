<?php
$f = 'app/Http/Controllers/Web/PaiementController.php';
$c = file_get_contents($f);

$oldCode = <<<EOT
            } elseif (\$code === 'TRANSP') {
                \$tarifBase = (\$eleve->inscriptionActuelle && \$eleve->inscriptionActuelle->avec_transport) 
                    ? \$montantTransport 
                    : 0;
            }
EOT;

$newCode = <<<EOT
            } elseif (\$code === 'TRANSP') {
                \$abonnement = \App\Models\AbonnementTransport::where('eleve_id', \$eleve->id)
                    ->where('actif', true)
                    ->with('zoneTransport')
                    ->first();
                \$tarifBase = \$abonnement && \$abonnement->zoneTransport ? \$abonnement->zoneTransport->tarif_mensuel : 0;
            }
EOT;

$c = str_replace($oldCode, $newCode, $c);
file_put_contents($f, $c);
