<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('classes', function (Blueprint $table) {
            $table->decimal('montant_inscription', 12, 2)->nullable()->after('effectif_max');
            $table->decimal('montant_mensualite', 12, 2)->nullable()->after('montant_inscription');
            $table->decimal('montant_cantine', 12, 2)->nullable()->after('montant_mensualite');
            $table->decimal('montant_transport', 12, 2)->nullable()->after('montant_cantine');
        });

        Schema::table('inscriptions', function (Blueprint $table) {
            $table->boolean('avec_cantine')->default(false)->after('statut');
            $table->boolean('avec_transport')->default(false)->after('avec_cantine');
        });
    }

    public function down(): void
    {
        Schema::table('classes', function (Blueprint $table) {
            $table->dropColumn(['montant_inscription', 'montant_mensualite', 'montant_cantine', 'montant_transport']);
        });

        Schema::table('inscriptions', function (Blueprint $table) {
            $table->dropColumn(['avec_cantine', 'avec_transport']);
        });
    }
};
