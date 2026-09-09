<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('classes', function (Blueprint $table) {
            $table->foreignId('cycle_id')->nullable()->after('id')->constrained('cycles')->nullOnDelete();
        });

        Schema::table('users', function (Blueprint $table) {
            $table->foreignId('cycle_id')->nullable()->after('id')->constrained('cycles')->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::table('classes', function (Blueprint $table) {
            $table->dropConstrainedForeignId('cycle_id');
        });

        Schema::table('users', function (Blueprint $table) {
            $table->dropConstrainedForeignId('cycle_id');
        });
    }
};
