<?php
$f = 'routes/web.php';
$c = file_get_contents($f);

$c = str_replace(
    "Route::get('/', [DashboardController::class, 'index'])->name('dashboard');",
    "Route::get('/', [DashboardController::class, 'index'])->name('dashboard');\n    Route::get('vehicules-par-zone/{zone}', [\App\Http\Controllers\Web\VehiculeController::class, 'parZone'])->name('vehicules.par_zone');",
    $c
);

file_put_contents($f, $c);
echo "route updated correctly\n";
