<?php
require __DIR__.'/vendor/autoload.php';
$app = require_once __DIR__.'/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$eleves = App\Models\Eleve::with('classe')->take(5)->get();
foreach($eleves as $e) {
    echo $e->nom . " - Classe: " . $e->classe->nom . "\n";
    echo "  Classe MENS: " . $e->classe->montant_mensualite . "\n";
    echo "  Classe CANT: " . $e->classe->montant_cantine . "\n";
    echo "  Classe TRANSP: " . $e->classe->montant_transport . "\n";
}
