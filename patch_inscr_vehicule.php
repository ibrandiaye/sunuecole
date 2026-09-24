<?php
$f = 'app/Http/Controllers/Web/InscriptionController.php';
$c = file_get_contents($f);

// 1. Update validation
$c = str_replace(
    "'zone_transport_id' => 'required_if:avec_transport,1|nullable|exists:zone_transports,id',",
    "'zone_transport_id' => 'required_if:avec_transport,1|nullable|exists:zone_transports,id',\n            'vehicule_id' => 'required_if:avec_transport,1|nullable|exists:vehicules,id',",
    $c
);

// 2. Update creation
$c = str_replace(
    "'zone_transport_id' => \$request->zone_transport_id,",
    "'zone_transport_id' => \$request->zone_transport_id,\n                'vehicule_id' => \$request->vehicule_id,",
    $c
);

file_put_contents($f, $c);
echo "InscriptionController OK\n";
