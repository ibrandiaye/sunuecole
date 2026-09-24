<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void {
        Schema::create('operation_bancaires', function (Blueprint $table) {
            $table->id();
            $table->foreignId('compte_bancaire_id')->constrained('compte_bancaires')->cascadeOnDelete();
            $table->string('type'); // depot, retrait, frais
            $table->decimal('montant', 15, 2);
            $table->date('date_operation');
            $table->string('motif')->nullable();
            $table->string('reference_piece')->nullable();
            $table->foreignId('user_id')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamps();
        });
    }
    public function down(): void { Schema::dropIfExists('operation_bancaires'); }
};