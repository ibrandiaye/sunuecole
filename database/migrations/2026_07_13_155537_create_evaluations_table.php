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
        Schema::create('evaluations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('classe_id')->constrained('classes')->onDelete('cascade');
            $table->foreignId('matiere_id')->constrained('matieres')->onDelete('cascade');
            $table->foreignId('enseignant_id')->constrained('enseignants')->onDelete('cascade');
            $table->foreignId('annee_scolaire_id')->nullable()->constrained('annee_scolaires')->onDelete('set null');
            
            $table->string('titre'); // e.g. "Devoir 1", "Composition du 1er Semestre"
            $table->string('type_evaluation')->default('Devoir'); // Devoir, Composition
            $table->date('date_evaluation');
            $table->decimal('coefficient', 5, 2)->default(1.0);
            $table->integer('semestre')->default(1);
            
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('evaluations');
    }
};
