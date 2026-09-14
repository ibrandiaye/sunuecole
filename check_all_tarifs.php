<?php
require __DIR__.'/vendor/autoload.php';
$app = require_once __DIR__.'/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$tarifs = App\Models\Tarif::with(['niveau', 'typePaiement'])->get();
foreach($tarifs as $t) {
    echo $t->niveau->nom . " - " . $t->typePaiement->code . ": " . $t->montant . "\n";
}
