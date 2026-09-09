<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('notes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('eleve_id')->constrained('eleves')->cascadeOnDelete();
            $table->foreignId('matiere_id')->constrained('matieres')->cascadeOnDelete();
            $table->foreignId('classe_id')->constrained('classes')->cascadeOnDelete();
            $table->foreignId('annee_scolaire_id')->nullable()->constrained('annee_scolaires')->cascadeOnDelete();
            $table->foreignId('enseignant_id')->nullable()->constrained('enseignants')->nullOnDelete();

            // Type évaluation
            $table->string('type_evaluation');             // devoir | composition | examen
            $table->string('periode');                      // Premier Semestre, etc.
            $table->decimal('valeur', 5, 2);                // sur 20
            $table->decimal('coefficient', 4, 1)->default(1);
            $table->date('date_evaluation');
            $table->text('commentaire')->nullable();
            $table->boolean('verrouille')->default(false);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('notes');
    }
};
