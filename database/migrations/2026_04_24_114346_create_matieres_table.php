<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('matieres', function (Blueprint $table) {
            $table->id();
            $table->string('nom');
            $table->string('code')->unique();               // ex: MATH, FR, PC
            $table->decimal('coefficient', 4, 1)->default(1);
            $table->string('cycle');                        // elementaire | moyen | secondaire
            $table->foreignId('niveau_id')->nullable()->constrained('niveaux')->nullOnDelete();
            $table->foreignId('serie_id')->nullable()->constrained('series')->nullOnDelete();
            $table->string('type')->default('obligatoire'); // obligatoire | optionnel
            $table->string('groupe')->nullable();           // Sc. Exactes | Lettres | Sport...
            $table->boolean('active')->default(true);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('matieres');
    }
};
