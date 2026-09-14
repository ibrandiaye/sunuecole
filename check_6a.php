<?php
require __DIR__.'/vendor/autoload.php';
$app = require_once __DIR__.'/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$c = App\Models\Classe::where('nom', '6ème A')->first();
echo "6ème A:\n";
echo "MENS: " . $c->montant_mensualite . "\n";
echo "CANT: " . $c->montant_cantine . "\n";
echo "TRANSP: " . $c->montant_transport . "\n";
