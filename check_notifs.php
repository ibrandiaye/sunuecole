<?php
require 'vendor/autoload.php';
$app = require_once 'bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$notifs = App\Models\NotificationPush::orderBy('id', 'desc')->take(10)->get();
foreach($notifs as $n) {
    echo "ID: {$n->id}, UserID: {$n->user_id}, Type: {$n->type}, Titre: {$n->titre}\n";
}
