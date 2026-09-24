<?php
$f = 'resources/views/layouts/app.blade.php';
$c = file_get_contents($f);
$c = str_replace(
    "<a href=\"{{ route('enseignants.index') }}\" class=\"nav-link {{ request()->routeIs('enseignants.*') ? 'active' : '' }}\"><i class='bx bxs-group'></i> Enseignants</a>",
    "<a href=\"{{ route('enseignants.index') }}\" class=\"nav-link {{ request()->routeIs('enseignants.*') ? 'active' : '' }}\"><i class='bx bxs-group'></i> Enseignants</a>\n                <a href=\"{{ route('personnels.index') }}\" class=\"nav-link {{ request()->routeIs('personnels.*') ? 'active' : '' }}\"><i class='bx bxs-user-detail'></i> Personnel Admin.</a>",
    $c
);
file_put_contents($f, $c);
