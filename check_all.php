<?php
require __DIR__.'/vendor/autoload.php';
$app = require_once __DIR__.'/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$eleves = App\Models\Eleve::with('classe.niveau')->get();
foreach($eleves as $e) {
    echo $e->nom . " - Classe: " . $e->classe->nom . " - Niveau: " . $e->classe->niveau->nom . "\n";
    echo "  Classe MENS: " . $e->classe->montant_mensualite . "\n";
    $annee = App\Models\AnneeScolaire::where('active', true)->first();
    $tarif = App\Models\Tarif::where('niveau_id', $e->classe->niveau_id)->where('annee_scolaire_id', $annee->id)->with('typePaiement')->get();
    foreach($tarif as $t) {
        echo "  Niveau " . $t->typePaiement->code . ": " . $t->montant . "\n";
    }
}
