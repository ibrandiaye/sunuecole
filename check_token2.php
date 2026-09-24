<?php
require 'vendor/autoload.php';
$app = require_once 'bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$users = App\Models\User::whereNotNull('fcm_token')->orWhere('fcm_token', '!=', '')->get();
echo "Count: " . $users->count() . "\n";
foreach($users as $u) {
    echo "ID: {$u->id}, Name: {$u->name}, Token: {$u->fcm_token}\n";
}
