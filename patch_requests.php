<?php
$f1 = 'app/Http/Requests/Eleve/StoreEleveRequest.php';
$c1 = file_get_contents($f1);
$c1 = str_replace(
    "'zone_transport_id' => 'required_if:avec_transport,1|nullable|exists:zone_transports,id',",
    "'zone_transport_id' => 'required_if:avec_transport,1|nullable|exists:zone_transports,id',\n            'vehicule_id' => 'required_if:avec_transport,1|nullable|exists:vehicules,id',",
    $c1
);
file_put_contents($f1, $c1);

$f2 = 'app/Http/Requests/Eleve/UpdateEleveRequest.php';
$c2 = file_get_contents($f2);
$c2 = str_replace(
    "'zone_transport_id' => 'required_if:avec_transport,1|nullable|exists:zone_transports,id',",
    "'zone_transport_id' => 'required_if:avec_transport,1|nullable|exists:zone_transports,id',\n            'vehicule_id' => 'required_if:avec_transport,1|nullable|exists:vehicules,id',",
    $c2
);
file_put_contents($f2, $c2);

echo "Requests OK\n";
