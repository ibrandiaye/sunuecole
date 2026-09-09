<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('niveaux', function (Blueprint $table) {
            $table->foreignId('cycle_id')->nullable()->after('id')->constrained('cycles')->nullOnDelete();
            // Optionnel: supprimer l'ancienne colonne si elle existe
            if (Schema::hasColumn('niveaux', 'cycle')) {
                $table->dropColumn('cycle');
            }
        });

        Schema::table('matieres', function (Blueprint $table) {
            $table->foreignId('cycle_id')->nullable()->after('id')->constrained('cycles')->nullOnDelete();
            if (Schema::hasColumn('matieres', 'cycle')) {
                $table->dropColumn('cycle');
            }
        });
    }

    public function down(): void
    {
        Schema::table('niveaux', function (Blueprint $table) {
            $table->string('cycle')->nullable();
            $table->dropConstrainedForeignId('cycle_id');
        });

        Schema::table('matieres', function (Blueprint $table) {
            $table->string('cycle')->nullable();
            $table->dropConstrainedForeignId('cycle_id');
        });
    }
};
