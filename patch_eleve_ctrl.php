<?php
$f = 'app/Http/Controllers/Web/EleveController.php';
$c = file_get_contents($f);

$oldBlock = <<<'OLD'
            if ($data['avec_transport'] && $request->has('zone_transport_id')) {
                $abT = \App\Models\AbonnementTransport::where('eleve_id', $eleve->id)->where('actif', true)->first();
                if (!$abT) {
                    \App\Models\AbonnementTransport::create([
                        'eleve_id' => $eleve->id,
                        'zone_transport_id' => $request->zone_transport_id,
                        'date_debut' => now(),
                        'actif' => true,
                    ]);
                } elseif ($abT->zone_transport_id != $request->zone_transport_id) {
                    $abT->update(['zone_transport_id' => $request->zone_transport_id]);
                }
            } else {
OLD;

$newBlock = <<<'NEW'
            if ($data['avec_transport'] && $request->has('zone_transport_id')) {
                $abT = \App\Models\AbonnementTransport::where('eleve_id', $eleve->id)->where('actif', true)->first();
                if (!$abT) {
                    \App\Models\AbonnementTransport::create([
                        'eleve_id' => $eleve->id,
                        'zone_transport_id' => $request->zone_transport_id,
                        'vehicule_id' => $request->vehicule_id,
                        'date_debut' => now(),
                        'actif' => true,
                    ]);
                } elseif ($abT->zone_transport_id != $request->zone_transport_id || $abT->vehicule_id != $request->vehicule_id) {
                    $abT->update([
                        'zone_transport_id' => $request->zone_transport_id,
                        'vehicule_id' => $request->vehicule_id
                    ]);
                }
            } else {
NEW;

$c = str_replace($oldBlock, $newBlock, $c);
file_put_contents($f, $c);
echo "EleveController OK\n";
