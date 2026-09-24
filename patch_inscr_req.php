<?php
$f = 'app/Http/Controllers/Web/InscriptionController.php';
$c = file_get_contents($f);
$c = str_replace(
    "'remise_mensualite' => 'nullable|numeric|min:0',",
    "'remise_mensualite' => 'nullable|numeric|min:0',\n            'avec_transport' => 'nullable|boolean',\n            'zone_transport_id' => 'required_if:avec_transport,1|nullable|exists:zone_transports,id',",
    $c
);
file_put_contents($f, $c);
