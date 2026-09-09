<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('etablissements', function (Blueprint $table) {
            $table->id();
            $table->string('nom');
            $table->string('code')->unique();             // Code unique établissement
            $table->string('type')->default('prive');     // prive / public
            $table->string('cycle')->default('mixte');    // elementaire / moyen / secondaire
            $table->string('adresse')->nullable();
            $table->string('ville')->default('Dakar');
            $table->string('telephone')->nullable();
            $table->string('email')->nullable();
            $table->string('logo')->nullable();
            $table->string('directeur_nom')->nullable();
            $table->string('academie')->nullable();
            $table->string('inspection')->nullable();
            $table->text('description')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('etablissements');
    }
};
