<?php
$f = 'app/Services/EleveService.php';
$c = file_get_contents($f);

$oldBlock = <<<'OLD'
                if (!empty($data['avec_transport']) && !empty($data['zone_transport_id'])) {
                    \App\Models\AbonnementTransport::create([
                        'eleve_id' => $eleve->id,
                        'zone_transport_id' => $data['zone_transport_id'],
                        'date_debut' => now(),
                        'actif' => true,
                    ]);
                }
OLD;

$newBlock = <<<'NEW'
                if (!empty($data['avec_transport']) && !empty($data['zone_transport_id'])) {
                    \App\Models\AbonnementTransport::create([
                        'eleve_id' => $eleve->id,
                        'zone_transport_id' => $data['zone_transport_id'],
                        'vehicule_id' => $data['vehicule_id'] ?? null,
                        'date_debut' => now(),
                        'actif' => true,
                    ]);
                }
NEW;

$c = str_replace($oldBlock, $newBlock, $c);
file_put_contents($f, $c);
echo "EleveService OK\n";
