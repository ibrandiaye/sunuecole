<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // Table pivot classe ↔ matière ↔ enseignant
        Schema::create('classe_matiere', function (Blueprint $table) {
            $table->id();
            $table->foreignId('classe_id')->constrained('classes')->cascadeOnDelete();
            $table->foreignId('matiere_id')->constrained('matieres')->cascadeOnDelete();
            $table->foreignId('enseignant_id')->nullable()->constrained('enseignants')->nullOnDelete();
            $table->decimal('coefficient_override', 4, 1)->nullable(); // Override coeff classe
            $table->integer('heures_semaine')->default(2);
            $table->timestamps();

            $table->unique(['classe_id', 'matiere_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('classe_matiere');
    }
};
