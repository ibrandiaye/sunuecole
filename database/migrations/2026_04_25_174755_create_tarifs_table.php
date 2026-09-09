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
        Schema::create('tarifs', function (Blueprint $table) {
            $table->id();
            $table->foreignId('annee_scolaire_id')->constrained('annee_scolaires')->cascadeOnDelete();
            $table->foreignId('niveau_id')->constrained('niveaux')->cascadeOnDelete();
            $table->foreignId('type_paiement_id')->constrained('types_paiements')->cascadeOnDelete();
            $table->decimal('montant', 10, 2);
            $table->timestamps();

            // Un seul tarif par type, niveau et année scolaire
            $table->unique(['annee_scolaire_id', 'niveau_id', 'type_paiement_id'], 'unique_tarif_annee_niveau_type');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('tarifs');
    }
};
