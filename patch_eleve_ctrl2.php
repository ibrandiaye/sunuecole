<?php
$f = 'app/Http/Controllers/Web/EleveController.php';
$c = file_get_contents($f);

// Let me just manually edit EleveController instead of complex regexes
$c = preg_replace(
    "/if \(\\\$request->has\('classe_id'\) && \\\$request->classe_id\).*?Inscription::updateOrCreate.*?\);/s",
    "$0\n\n                // Gestion Cantine\n                if (\$data['avec_cantine']) {\n                    \App\Models\AbonnementCantine::firstOrCreate([\n                        'eleve_id' => \$eleve->id,\n                        'date_debut' => now(),\n                        'actif' => true,\n                    ]);\n                } else {\n                    \App\Models\AbonnementCantine::where('eleve_id', \$eleve->id)->update(['actif' => false]);\n                }\n                \n                // Gestion Transport\n                if (\$data['avec_transport'] && \$request->has('zone_transport_id')) {\n                    \$abT = \App\Models\AbonnementTransport::where('eleve_id', \$eleve->id)->where('actif', true)->first();\n                    if (!\$abT) {\n                        \App\Models\AbonnementTransport::create([\n                            'eleve_id' => \$eleve->id,\n                            'zone_transport_id' => \$request->zone_transport_id,\n                            'date_debut' => now(),\n                            'actif' => true,\n                        ]);\n                    } elseif (\$abT->zone_transport_id != \$request->zone_transport_id) {\n                        \$abT->update(['zone_transport_id' => \$request->zone_transport_id]);\n                    }\n                } else {\n                    \App\Models\AbonnementTransport::where('eleve_id', \$eleve->id)->update(['actif' => false]);\n                }",
    $c
);

file_put_contents($f, $c);
