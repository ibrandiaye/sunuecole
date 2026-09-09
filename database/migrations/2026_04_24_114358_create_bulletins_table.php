<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('bulletins', function (Blueprint $table) {
            $table->id();
            $table->foreignId('eleve_id')->constrained('eleves')->cascadeOnDelete();
            $table->foreignId('classe_id')->constrained('classes')->cascadeOnDelete();
            $table->foreignId('annee_scolaire_id')->constrained('annee_scolaires')->cascadeOnDelete();
            $table->tinyInteger('trimestre');                           // 1 | 2 | 3
            $table->decimal('moyenne_generale', 5, 2)->nullable();
            $table->integer('rang')->nullable();
            $table->integer('effectif_classe')->nullable();
            $table->decimal('moyenne_classe', 5, 2)->nullable();
            $table->decimal('moyenne_max', 5, 2)->nullable();
            $table->decimal('moyenne_min', 5, 2)->nullable();
            $table->string('mention')->nullable();                      // Très Bien, Bien...
            $table->text('appreciation_generale')->nullable();
            $table->string('qr_code')->nullable();                     // Chemin QR Code
            $table->string('pdf_path')->nullable();                    // Chemin PDF
            $table->string('token_verification')->nullable()->unique(); // Pour QR Code URL
            $table->boolean('publie')->default(false);
            $table->timestamp('date_publication')->nullable();
            $table->timestamps();

            $table->unique(['eleve_id', 'trimestre', 'annee_scolaire_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('bulletins');
    }
};
