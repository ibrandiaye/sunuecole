<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('inscriptions', function (Blueprint $table) {
            $table->decimal('remise_inscription', 10, 2)->default(0)->after('statut');
            $table->decimal('remise_mensualite', 10, 2)->default(0)->after('remise_inscription');
        });
    }

    public function down(): void
    {
        Schema::table('inscriptions', function (Blueprint $table) {
            $table->dropColumn(['remise_inscription', 'remise_mensualite']);
        });
    }
};
