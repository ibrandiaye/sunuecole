<?php
$f = 'resources/views/eleves/create.blade.php';
$c = file_get_contents($f);
$c = str_replace(
    "<select name=\"zone_transport_id\" class=\"form-select form-select-sm\">",
    "<select name=\"zone_transport_id\" class=\"form-select form-select-sm @error('zone_transport_id') is-invalid @enderror\">\n                                        @error('zone_transport_id') <div class=\"invalid-feedback\">Veuillez sélectionner une zone si le transport est coché.</div> @enderror",
    $c
);
file_put_contents($f, $c);

$f2 = 'resources/views/eleves/edit.blade.php';
$c2 = file_get_contents($f2);
$c2 = str_replace(
    "<select name=\"zone_transport_id\" class=\"form-select form-select-sm\">",
    "<select name=\"zone_transport_id\" class=\"form-select form-select-sm @error('zone_transport_id') is-invalid @enderror\">\n                                            @error('zone_transport_id') <div class=\"invalid-feedback\">Veuillez sélectionner une zone si le transport est coché.</div> @enderror",
    $c2
);
file_put_contents($f2, $c2);
