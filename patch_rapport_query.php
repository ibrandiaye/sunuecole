<?php
$f = 'app/Http/Controllers/Web/RapportController.php';
$c = file_get_contents($f);
$c = str_replace(
    "\App\Models\Eleve::where('actif', true)->count()",
    "\App\Models\Eleve::where('statut', 'actif')->count()",
    $c
);
file_put_contents($f, $c);
