<?php
$f = 'resources/views/layouts/app.blade.php';
$c = file_get_contents($f);

$c = str_replace(
    "<a href=\"{{ route('abonnement_transports.index') }}\" class=\"nav-link {{ request()->routeIs('abonnement_transports.*') ? 'active' : '' }}\"><i class='bx bx-bus'></i> Transport Scolaire</a>",
    "<a href=\"{{ route('abonnement_transports.index') }}\" class=\"nav-link {{ request()->routeIs('abonnement_transports.*') ? 'active' : '' }}\"><i class='bx bx-bus'></i> Transport Scolaire</a>\n                <a href=\"{{ route('vehicules.index') }}\" class=\"nav-link {{ request()->routeIs('vehicules.*') ? 'active' : '' }}\"><i class='bx bxs-car'></i> Véhicules</a>\n                <a href=\"{{ route('zone_transports.index') }}\" class=\"nav-link {{ request()->routeIs('zone_transports.*') ? 'active' : '' }}\"><i class='bx bx-map'></i> Zones Transport</a>",
    $c
);

file_put_contents($f, $c);
echo "sidebar OK\n";
