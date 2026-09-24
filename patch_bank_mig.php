<?php
$f_cpt = glob('database/migrations/*_create_compte_bancaires_table.php')[0];
$c_cpt = <<<EOT
<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void {
        Schema::create('compte_bancaires', function (Blueprint \$table) {
            \$table->id();
            \$table->string('nom_banque');
            \$table->string('numero_compte')->nullable();
            \$table->decimal('solde_initial', 15, 2)->default(0);
            \$table->boolean('actif')->default(true);
            \$table->timestamps();
        });
    }
    public function down(): void { Schema::dropIfExists('compte_bancaires'); }
};
EOT;
file_put_contents($f_cpt, $c_cpt);

$f_op = glob('database/migrations/*_create_operation_bancaires_table.php')[0];
$c_op = <<<EOT
<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void {
        Schema::create('operation_bancaires', function (Blueprint \$table) {
            \$table->id();
            \$table->foreignId('compte_bancaire_id')->constrained('compte_bancaires')->cascadeOnDelete();
            \$table->string('type'); // depot, retrait, frais
            \$table->decimal('montant', 15, 2);
            \$table->date('date_operation');
            \$table->string('motif')->nullable();
            \$table->string('reference_piece')->nullable();
            \$table->foreignId('user_id')->nullable()->constrained('users')->nullOnDelete();
            \$table->timestamps();
        });
    }
    public function down(): void { Schema::dropIfExists('operation_bancaires'); }
};
EOT;
file_put_contents($f_op, $c_op);
