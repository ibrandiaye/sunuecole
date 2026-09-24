<?php
$f_cpt = 'app/Models/CompteBancaire.php';
$c_cpt = <<<EOT
<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CompteBancaire extends Model {
    use HasFactory;
    protected \$fillable = ['nom_banque', 'numero_compte', 'solde_initial', 'actif'];
    
    public function operations() {
        return \$this->hasMany(OperationBancaire::class);
    }

    public function getSoldeActuelAttribute() {
        \$depots = \$this->operations()->where('type', 'depot')->sum('montant');
        \$retraits = \$this->operations()->whereIn('type', ['retrait', 'frais'])->sum('montant');
        return \$this->solde_initial + \$depots - \$retraits;
    }
}
EOT;
file_put_contents($f_cpt, $c_cpt);

$f_op = 'app/Models/OperationBancaire.php';
$c_op = <<<EOT
<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OperationBancaire extends Model {
    use HasFactory;
    protected \$fillable = ['compte_bancaire_id', 'type', 'montant', 'date_operation', 'motif', 'reference_piece', 'user_id'];
    
    public function compte() {
        return \$this->belongsTo(CompteBancaire::class, 'compte_bancaire_id');
    }
    public function user() {
        return \$this->belongsTo(User::class);
    }
}
EOT;
file_put_contents($f_op, $c_op);
