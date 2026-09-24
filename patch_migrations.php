<?php
$f = glob('database/migrations/*_create_personnels_table.php')[0];
$c = <<<EOT
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('personnels', function (Blueprint \$table) {
            \$table->id();
            \$table->string('prenom');
            \$table->string('nom');
            \$table->string('telephone')->nullable();
            \$table->string('email')->nullable();
            \$table->string('fonction'); // ex: Gardien, Secrétaire, Agent d'entretien
            \$table->date('date_embauche')->nullable();
            \$table->foreignId('user_id')->nullable()->constrained('users')->nullOnDelete();
            \$table->boolean('actif')->default(true);
            \$table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('personnels');
    }
};
EOT;
file_put_contents($f, $c);

$f2 = glob('database/migrations/*_create_documents_table.php')[0];
$c2 = <<<EOT
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('documents', function (Blueprint \$table) {
            \$table->id();
            \$table->string('nom'); // ex: "Contrat de travail"
            \$table->string('type_document')->nullable(); // ex: "contrat", "cv", "diplome"
            \$table->string('fichier_path');
            \$table->morphs('documentable'); // Creates documentable_id and documentable_type
            \$table->foreignId('uploaded_by')->nullable()->constrained('users')->nullOnDelete();
            \$table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('documents');
    }
};
EOT;
file_put_contents($f2, $c2);
