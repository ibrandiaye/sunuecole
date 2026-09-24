<?php
$f = 'routes/web.php';
$c = file_get_contents($f);

// 1. Finance (comptable)
// already correct: role:super_admin|directeur|comptable

// 2. Administrative Writing (eleves, classes, inscriptions, enseignants)
$c = str_replace(
    "role:super_admin|directeur|administratif", 
    "role:super_admin|directeur|administratif|secretaire|rh", 
    $c
);

// 3. Read-only global
$c = str_replace(
    "role:super_admin|directeur|comptable|administratif", 
    "role:super_admin|directeur|comptable|administratif|secretaire|rh", 
    $c
);

file_put_contents($f, $c);
