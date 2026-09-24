<?php
$f_veh = glob('database/migrations/*_create_vehicules_table.php')[0];
$c_veh = <<<EOT
<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
return new class extends Migration {
    public function up(): void {
        Schema::create('vehicules', function (Blueprint \$table) {
            \$table->id();
            \$table->string('immatriculation')->unique();
            \$table->string('marque')->nullable();
            \$table->integer('capacite')->default(0);
            \$table->boolean('actif')->default(true);
            \$table->timestamps();
        });
    }
    public function down(): void { Schema::dropIfExists('vehicules'); }
};
EOT;
file_put_contents($f_veh, $c_veh);

$f_chau = glob('database/migrations/*_create_chauffeurs_table.php')[0];
$c_chau = <<<EOT
<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
return new class extends Migration {
    public function up(): void {
        Schema::create('chauffeurs', function (Blueprint \$table) {
            \$table->id();
            \$table->string('nom');
            \$table->string('telephone')->nullable();
            \$table->foreignId('vehicule_id')->nullable()->constrained('vehicules')->nullOnDelete();
            \$table->boolean('actif')->default(true);
            \$table->timestamps();
        });
    }
    public function down(): void { Schema::dropIfExists('chauffeurs'); }
};
EOT;
file_put_contents($f_chau, $c_chau);

$f_zone = glob('database/migrations/*_create_zone_transports_table.php')[0];
$c_zone = <<<EOT
<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
return new class extends Migration {
    public function up(): void {
        Schema::create('zone_transports', function (Blueprint \$table) {
            \$table->id();
            \$table->string('nom'); // ex: Zone A, Zone B, Plateau, Parcelles...
            \$table->decimal('tarif_mensuel', 10, 2)->default(0);
            \$table->timestamps();
        });
    }
    public function down(): void { Schema::dropIfExists('zone_transports'); }
};
EOT;
file_put_contents($f_zone, $c_zone);

$f_ab_tr = glob('database/migrations/*_create_abonnement_transports_table.php')[0];
$c_ab_tr = <<<EOT
<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
return new class extends Migration {
    public function up(): void {
        Schema::create('abonnement_transports', function (Blueprint \$table) {
            \$table->id();
            \$table->foreignId('eleve_id')->constrained('eleves')->cascadeOnDelete();
            \$table->foreignId('zone_transport_id')->constrained('zone_transports');
            \$table->date('date_debut');
            \$table->date('date_fin')->nullable();
            \$table->boolean('actif')->default(true);
            \$table->timestamps();
        });
    }
    public function down(): void { Schema::dropIfExists('abonnement_transports'); }
};
EOT;
file_put_contents($f_ab_tr, $c_ab_tr);

$f_ab_cant = glob('database/migrations/*_create_abonnement_cantines_table.php')[0];
$c_ab_cant = <<<EOT
<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
return new class extends Migration {
    public function up(): void {
        Schema::create('abonnement_cantines', function (Blueprint \$table) {
            \$table->id();
            \$table->foreignId('eleve_id')->constrained('eleves')->cascadeOnDelete();
            \$table->date('date_debut');
            \$table->date('date_fin')->nullable();
            \$table->string('regime_alimentaire')->nullable(); // ex: sans_sel, vegetarien
            \$table->boolean('actif')->default(true);
            \$table->timestamps();
        });
    }
    public function down(): void { Schema::dropIfExists('abonnement_cantines'); }
};
EOT;
file_put_contents($f_ab_cant, $c_ab_cant);
