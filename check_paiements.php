<?php
require 'vendor/autoload.php';
$app = require_once 'bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$paiements = App\Models\Paiement::orderBy('id', 'desc')->take(5)->get();
foreach($paiements as $p) {
    echo "Paiement ID: {$p->id}, EleveID: {$p->eleve_id}, Montant: {$p->montant_paye}\n";
    $e = $p->eleve;
    echo "  -> Eleve UserID: " . ($e->user_id ?? 'NULL') . ", ParentID: " . ($e->parent_id ?? 'NULL') . "\n";
}
