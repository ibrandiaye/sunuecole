<?php
$f = 'routes/web.php';
$c = file_get_contents($f);

$replacement = <<<EOT
    // =========================================================
    // === ROUTES LOGISTIQUE (Cantine & Transport) : logistique | super_admin | directeur
    // =========================================================
    Route::middleware(['role:super_admin|directeur|logistique'])->group(function () {
        Route::resource('vehicules', \App\Http\Controllers\Web\VehiculeController::class);
        Route::resource('chauffeurs', \App\Http\Controllers\Web\ChauffeurController::class);
        Route::resource('zone_transports', \App\Http\Controllers\Web\ZoneTransportController::class);
        Route::resource('abonnement_transports', \App\Http\Controllers\Web\AbonnementTransportController::class);
        Route::resource('abonnement_cantines', \App\Http\Controllers\Web\AbonnementCantineController::class);
    });
EOT;

$c = str_replace('// ========================================================='."\n".'    // === ROUTES READ-ONLY', $replacement . "\n\n    // =========================================================\n    // === ROUTES READ-ONLY", $c);
file_put_contents($f, $c);
