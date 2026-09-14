<?php
require __DIR__.'/vendor/autoload.php';
$app = require_once __DIR__.'/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$eleve = App\Models\Eleve::where('classe_id', 5)->first();
echo $eleve->nom . "\n";
$classe = $eleve->classe;
echo "MENS: " . $classe->getEffectiveTarif('MENS') . "\n";
echo "CANT: " . $classe->getEffectiveTarif('CANT') . "\n";
echo "TRANSP: " . $classe->getEffectiveTarif('TRANSP') . "\n";
