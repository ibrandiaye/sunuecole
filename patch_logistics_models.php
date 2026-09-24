<?php
$f_veh = 'app/Models/Vehicule.php';
$c_veh = <<<EOT
<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
class Vehicule extends Model {
    use HasFactory;
    protected \$fillable = ['immatriculation', 'marque', 'capacite', 'actif'];
    public function chauffeurs() { return \$this->hasMany(Chauffeur::class); }
}
EOT;
file_put_contents($f_veh, $c_veh);

$f_chau = 'app/Models/Chauffeur.php';
$c_chau = <<<EOT
<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
class Chauffeur extends Model {
    use HasFactory;
    protected \$fillable = ['nom', 'telephone', 'vehicule_id', 'actif'];
    public function vehicule() { return \$this->belongsTo(Vehicule::class); }
}
EOT;
file_put_contents($f_chau, $c_chau);

$f_zone = 'app/Models/ZoneTransport.php';
$c_zone = <<<EOT
<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
class ZoneTransport extends Model {
    use HasFactory;
    protected \$fillable = ['nom', 'tarif_mensuel'];
}
EOT;
file_put_contents($f_zone, $c_zone);

$f_abt = 'app/Models/AbonnementTransport.php';
$c_abt = <<<EOT
<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
class AbonnementTransport extends Model {
    use HasFactory;
    protected \$fillable = ['eleve_id', 'zone_transport_id', 'date_debut', 'date_fin', 'actif'];
    public function eleve() { return \$this->belongsTo(Eleve::class); }
    public function zoneTransport() { return \$this->belongsTo(ZoneTransport::class); }
}
EOT;
file_put_contents($f_abt, $c_abt);

$f_abc = 'app/Models/AbonnementCantine.php';
$c_abc = <<<EOT
<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
class AbonnementCantine extends Model {
    use HasFactory;
    protected \$fillable = ['eleve_id', 'date_debut', 'date_fin', 'regime_alimentaire', 'actif'];
    public function eleve() { return \$this->belongsTo(Eleve::class); }
}
EOT;
file_put_contents($f_abc, $c_abc);

