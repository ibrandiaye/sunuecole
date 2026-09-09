<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('types_paiements', function (Blueprint $table) {
            $table->id();
            $table->string('nom');                          // Inscription, Mensualité, Transport...
            $table->string('code')->unique();               // INSCR, MENS, TRANSP, CANT, TENUE
            $table->decimal('montant_defaut', 12, 2)->default(0);
            $table->string('periodicite')->default('unique'); // unique | mensuel | trimestriel
            $table->boolean('active')->default(true);
            $table->text('description')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('types_paiements');
    }
};
