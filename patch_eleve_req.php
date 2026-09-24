<?php
$f = 'app/Http/Requests/Eleve/StoreEleveRequest.php';
$c = file_get_contents($f);

$c = str_replace(
    "'avec_transport' => 'nullable|boolean',",
    "'avec_transport' => 'nullable|boolean',\n            'zone_transport_id' => 'required_if:avec_transport,1|nullable|exists:zone_transports,id',",
    $c
);
file_put_contents($f, $c);

$f2 = 'app/Http/Requests/Eleve/UpdateEleveRequest.php';
$c2 = file_get_contents($f2);
$c2 = str_replace(
    "'avec_transport' => 'nullable|boolean',",
    "'avec_transport' => 'nullable|boolean',\n            'zone_transport_id' => 'required_if:avec_transport,1|nullable|exists:zone_transports,id',",
    $c2
);
file_put_contents($f2, $c2);
