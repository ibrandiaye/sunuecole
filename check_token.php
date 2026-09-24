<?php
require 'vendor/autoload.php';
$app = require_once 'bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$users = App\Models\User::whereNotNull('fcm_token')->get();
foreach($users as $u) {
    echo "ID: {$u->id}, Name: {$u->name}, Role: {$u->roles->pluck('name')->implode(',')}\n";
}
