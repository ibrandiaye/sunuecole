<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('enseignants', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->cascadeOnDelete();
            $table->string('matricule')->unique()->nullable();
            $table->string('specialite')->nullable();         // Matière principale
            $table->string('telephone')->nullable();
            $table->string('email_perso')->nullable();
            $table->string('adresse')->nullable();
            $table->string('sexe')->nullable();               // M | F
            $table->date('date_naissance')->nullable();
            $table->string('lieu_naissance')->nullable();
            $table->string('nationalite')->default('Sénégalaise');
            $table->string('diplome')->nullable();
            $table->string('statut')->nullable();              // vacataire | permanent
            $table->string('signature')->nullable();          // Chemin image signature
            $table->string('photo')->nullable();
            $table->integer('heure_service')->default(0);     // Heures/semaine
            $table->date('date_embauche')->nullable();
            $table->boolean('actif')->default(true);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('enseignants');
    }
};
