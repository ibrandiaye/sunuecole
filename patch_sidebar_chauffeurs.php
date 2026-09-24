<?php
$f = 'resources/views/layouts/app.blade.php';
$c = file_get_contents($f);

$c = str_replace(
    "<a href=\"{{ route('vehicules.index') }}\" class=\"nav-link {{ request()->routeIs('vehicules.*') ? 'active' : '' }}\"><i class='bx bxs-car'></i> Véhicules</a>",
    "<a href=\"{{ route('vehicules.index') }}\" class=\"nav-link {{ request()->routeIs('vehicules.*') ? 'active' : '' }}\"><i class='bx bxs-car'></i> Véhicules</a>\n                <a href=\"{{ route('chauffeurs.index') }}\" class=\"nav-link {{ request()->routeIs('chauffeurs.*') ? 'active' : '' }}\"><i class='bx bxs-user-badge'></i> Chauffeurs</a>",
    $c
);

file_put_contents($f, $c);
echo "sidebar chauffeurs OK\n";
