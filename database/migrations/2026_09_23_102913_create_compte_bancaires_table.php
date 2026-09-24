<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void {
        Schema::create('compte_bancaires', function (Blueprint $table) {
            $table->id();
            $table->string('nom_banque');
            $table->string('numero_compte')->nullable();
            $table->decimal('solde_initial', 15, 2)->default(0);
            $table->boolean('actif')->default(true);
            $table->timestamps();
        });
    }
    public function down(): void { Schema::dropIfExists('compte_bancaires'); }
};