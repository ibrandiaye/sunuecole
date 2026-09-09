<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('recus', function (Blueprint $table) {
            $table->id();
            $table->string('numero')->unique();              // RECU-2025-000001
            $table->foreignId('paiement_id')->constrained('paiements')->cascadeOnDelete();
            $table->foreignId('emis_par')->nullable()->constrained('users')->nullOnDelete();
            $table->string('pdf_path')->nullable();
            $table->string('qr_code')->nullable();
            $table->boolean('envoye_email')->default(false);
            $table->timestamp('date_emission');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('recus');
    }
};
