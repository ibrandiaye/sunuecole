<?php
require 'vendor/autoload.php';
$app = require_once 'bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$eleve = App\Models\Eleve::whereNotNull('user_id')->first();
$notifService = app(\App\Services\NotificationService::class);
$notifService->sendToEleveAndTuteur(
    $eleve,
    "Test Notification",
    "Ceci est un test depuis Tinker",
    "paiement"
);
echo "Done";
