<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('abonnement_transports', function (Blueprint $table) {
            $table->foreignId('vehicule_id')->nullable()->after('zone_transport_id')->constrained('vehicules')->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::table('abonnement_transports', function (Blueprint $table) {
            $table->dropForeign(['vehicule_id']);
            $table->dropColumn('vehicule_id');
        });
    }
};
