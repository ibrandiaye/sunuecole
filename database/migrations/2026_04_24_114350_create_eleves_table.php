<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('eleves', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->nullable()->constrained('users')->nullOnDelete();
            $table->string('matricule')->unique();         // SEN-2025-00001
            $table->string('nom');
            $table->string('prenom');
            $table->date('date_naissance');
            $table->string('lieu_naissance')->nullable();
            $table->string('sexe');                        // M | F
            $table->string('nationalite')->default('Sénégalaise');
            $table->string('photo')->nullable();

            // Dossier médical
            $table->string('groupe_sanguin')->nullable();  // A+, B-, O+...
            $table->text('allergies')->nullable();
            $table->text('maladies_chroniques')->nullable();
            $table->string('medecin_traitant')->nullable();

            // Tuteur / Parent
            $table->foreignId('parent_id')->nullable()->constrained('parents')->nullOnDelete();
            $table->string('nom_tuteur')->nullable();
            $table->string('tel_tuteur')->nullable();
            $table->string('email_tuteur')->nullable();
            $table->string('relation_tuteur')->nullable(); // père | mère | tuteur

            // Scolarité
            $table->foreignId('classe_id')->nullable()->constrained('classes')->nullOnDelete();
            $table->foreignId('annee_scolaire_id')->nullable()->constrained('annee_scolaires')->nullOnDelete();

            // Statut
            $table->string('statut')->default('actif');    // actif | archivé | transféré | exclu
            $table->date('date_inscription')->nullable();
            $table->date('date_sortie')->nullable();
            $table->text('motif_sortie')->nullable();

            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('eleves');
    }
};
