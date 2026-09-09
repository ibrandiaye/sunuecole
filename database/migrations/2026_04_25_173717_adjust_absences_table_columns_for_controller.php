<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('absences', function (Blueprint $table) {
            $table->renameColumn('date', 'date_absence');
            $table->renameColumn('justifiee', 'justifie');
            $table->renameColumn('motif', 'commentaire');
            $table->string('periode')->nullable()->after('heure_fin');
            $table->foreignId('matiere_id')->nullable()->after('enseignant_id')->constrained('matieres')->nullOnDelete();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('absences', function (Blueprint $table) {
            $table->renameColumn('date_absence', 'date');
            $table->renameColumn('justifie', 'justifiee');
            $table->renameColumn('commentaire', 'motif');
            $table->dropColumn('periode');
            $table->dropConstrainedForeignId('matiere_id');
        });
    }
};
