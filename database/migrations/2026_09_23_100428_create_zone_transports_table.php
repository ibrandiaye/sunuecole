<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
return new class extends Migration {
    public function up(): void {
        Schema::create('zone_transports', function (Blueprint $table) {
            $table->id();
            $table->string('nom'); // ex: Zone A, Zone B, Plateau, Parcelles...
            $table->decimal('tarif_mensuel', 10, 2)->default(0);
            $table->timestamps();
        });
    }
    public function down(): void { Schema::dropIfExists('zone_transports'); }
};