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
        Schema::create('depenses', function (Blueprint $table) {
            $table->id();
            $table->string('reference')->unique();          // DEP-2025-000001
            $table->string('libelle');                       // Achat matériel, salaire...
            $table->string('categorie')->default('autre');  // salaires | fournitures | infrastructure | entretien | autre
            $table->decimal('montant', 12, 2);
            $table->string('mode_paiement')->default('especes'); // especes | wave | OM | virement
            $table->date('date_depense');
            $table->foreignId('annee_scolaire_id')->constrained('annee_scolaires')->cascadeOnDelete();
            $table->foreignId('enregistre_par')->nullable()->constrained('users')->nullOnDelete();
            $table->text('notes')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('depenses');
    }
};
