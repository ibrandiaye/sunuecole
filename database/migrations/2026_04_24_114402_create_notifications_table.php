<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('notifications_push', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->nullable()->constrained('users')->nullOnDelete();
            $table->string('titre');
            $table->text('message');
            $table->string('type');                         // absence | note | paiement | bulletin
            $table->json('data')->nullable();               // Données supplémentaires
            $table->boolean('lu')->default(false);
            $table->timestamp('lu_at')->nullable();
            $table->timestamps();

            $table->index(['user_id', 'lu', 'created_at']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('notifications_push');
    }
};
