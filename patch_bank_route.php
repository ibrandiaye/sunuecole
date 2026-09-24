<?php
$f = 'routes/web.php';
$c = file_get_contents($f);
$replacement = <<<EOT
        Route::get('rapport-financier', [\App\Http\Controllers\Web\RapportController::class, 'financier'])->name('rapports.financier');

        // Trésorerie & Banque
        Route::resource('compte_bancaires', \App\Http\Controllers\Web\CompteBancaireController::class)->except(['create', 'edit', 'destroy']);
        Route::resource('operation_bancaires', \App\Http\Controllers\Web\OperationBancaireController::class)->only(['store', 'destroy']);
EOT;
$c = str_replace("Route::get('rapport-financier', [\App\Http\Controllers\Web\RapportController::class, 'financier'])->name('rapports.financier');", $replacement, $c);
file_put_contents($f, $c);
