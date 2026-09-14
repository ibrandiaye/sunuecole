<?php
require __DIR__.'/vendor/autoload.php';
$app = require_once __DIR__.'/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$eleve = App\Models\Eleve::with('classe', 'inscriptionActuelle')->first();
if ($eleve && $eleve->classe) {
    echo "Eleve: " . $eleve->nom . "\n";
    echo "Classe INSCR: " . $eleve->classe->getEffectiveTarif('INSCR') . "\n";
    echo "Classe MENS: " . $eleve->classe->getEffectiveTarif('MENS') . "\n";
    echo "Classe CANT: " . $eleve->classe->getEffectiveTarif('CANT') . "\n";
    echo "Classe TRANSP: " . $eleve->classe->getEffectiveTarif('TRANSP') . "\n";
    
    echo "Remise MENS: " . $eleve->inscriptionActuelle->remise_mensualite . "\n";
} else {
    echo "No eleve or classe found\n";
}
