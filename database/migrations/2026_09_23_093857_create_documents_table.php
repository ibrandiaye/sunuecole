<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('documents', function (Blueprint $table) {
            $table->id();
            $table->string('nom'); // ex: "Contrat de travail"
            $table->string('type_document')->nullable(); // ex: "contrat", "cv", "diplome"
            $table->string('fichier_path');
            $table->morphs('documentable'); // Creates documentable_id and documentable_type
            $table->foreignId('uploaded_by')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('documents');
    }
};