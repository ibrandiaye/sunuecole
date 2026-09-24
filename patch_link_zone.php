<?php
$f = 'resources/views/logistique/transport/index.blade.php';
$c = file_get_contents($f);
$c = str_replace(
    "<button class=\"btn btn-outline-secondary px-3 me-2\" onclick=\"alert('Module de gestion des véhicules, zones et chauffeurs en développement.')\">\n                <i class='bx bx-map-alt'></i> Zones & Véhicules\n            </button>",
    "<a href=\"{{ route('zone_transports.index') }}\" class=\"btn btn-outline-secondary px-3 me-2\">\n                <i class='bx bx-map-alt'></i> Zones de Transport\n            </a>",
    $c
);
file_put_contents($f, $c);
