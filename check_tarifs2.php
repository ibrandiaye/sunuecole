<?php
require __DIR__.'/vendor/autoload.php';
$app = require_once __DIR__.'/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$classe = App\Models\Classe::find(1);
echo "Classe 1 specific MENS: " . $classe->montant_mensualite . "\n";
echo "Classe 1 specific CANT: " . $classe->montant_cantine . "\n";
echo "Classe 1 specific TRANSP: " . $classe->montant_transport . "\n";

$niveau_id = $classe->niveau_id;
$annee = App\Models\AnneeScolaire::where('active', true)->first();
$tarifs = App\Models\Tarif::where('niveau_id', $niveau_id)->where('annee_scolaire_id', $annee->id)->with('typePaiement')->get();

foreach($tarifs as $tarif) {
    echo "Niveau Tarif " . $tarif->typePaiement->code . ": " . $tarif->montant . "\n";
}
