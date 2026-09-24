<?php
$f = 'routes/web.php';
$c = file_get_contents($f);

// Replace "Route::resource('enseignants', EnseignantController::class)->parameters(['enseignants' => 'enseignant']);"
// with Enseignants, Personnels, and Documents
$replacement = <<<EOT
        // Enseignants & Personnel & Documents (RH)
        Route::resource('enseignants', EnseignantController::class)->parameters(['enseignants' => 'enseignant']);
        Route::resource('personnels', \App\Http\Controllers\Web\PersonnelController::class);
        Route::post('documents', [\App\Http\Controllers\Web\DocumentController::class, 'store'])->name('documents.store');
        Route::delete('documents/{document}', [\App\Http\Controllers\Web\DocumentController::class, 'destroy'])->name('documents.destroy');
EOT;
$c = preg_replace("/\/\/ Enseignants.*?Route::resource\('enseignants'.*?;/s", $replacement, $c);

file_put_contents($f, $c);
