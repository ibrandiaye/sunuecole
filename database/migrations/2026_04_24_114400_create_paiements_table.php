<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('paiements', function (Blueprint $table) {
            $table->id();
            $table->string('reference')->unique();          // PAY-2025-000001
            $table->foreignId('eleve_id')->constrained('eleves')->cascadeOnDelete();
            $table->foreignId('type_paiement_id')->constrained('types_paiements')->cascadeOnDelete();
            $table->foreignId('encaisse_par')->nullable()->constrained('users')->nullOnDelete();
            $table->foreignId('annee_scolaire_id')->constrained('annee_scolaires')->cascadeOnDelete();
            $table->decimal('montant_du', 12, 2);
            $table->decimal('montant_paye', 12, 2);
            $table->decimal('reste_a_payer', 12, 2)->default(0);
            $table->string('mois')->nullable();             // 09/2025 pour mensualité
            $table->string('mode_paiement')->default('especes'); // especes | wave | OM | virement
            $table->string('statut')->default('partiel');   // paye | partiel | impaye
            $table->text('notes')->nullable();
            $table->timestamp('date_paiement');
            $table->timestamps();

            // Index performance
            $table->index(['eleve_id', 'type_paiement_id', 'statut']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('paiements');
    }
};
