<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('niveaux', function (Blueprint $table) {
            $table->id();
            $table->string('nom');         // ex: CI, CP, CE1, 6e, 5e, 2nde, 1ere, Tle
            $table->string('code');        // ex: CI, CP, 6E, 5E, 2ND
            $table->string('cycle');       // elementaire | moyen | secondaire
            $table->integer('ordre')->default(1); // pour trier
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('niveaux');
    }
};
