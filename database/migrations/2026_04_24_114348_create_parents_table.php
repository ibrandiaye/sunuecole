<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('parents', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->cascadeOnDelete();
            $table->string('telephone')->nullable();
            $table->string('profession')->nullable();
            $table->string('adresse')->nullable();
            $table->string('relation')->default('parent');    // parent | tuteur | gardien
            $table->string('nin')->nullable();                // Numéro Identité National
            $table->string('photo')->nullable();
            $table->boolean('actif')->default(true);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('parents');
    }
};
