<?php
$f = 'app/Http/Controllers/Web/CompteBancaireController.php';
$c = <<<EOT
<?php
namespace App\Http\Controllers\Web;
use App\Http\Controllers\Controller;
use App\Models\CompteBancaire;
use App\Models\OperationBancaire;
use Illuminate\Http\Request;

class CompteBancaireController extends Controller {
    public function index() {
        \$comptes = CompteBancaire::withCount('operations')->get();
        \$totalSolde = \$comptes->sum(function (\$c) { return \$c->solde_actuel; });
        return view('finance.banque.index', compact('comptes', 'totalSolde'));
    }

    public function store(Request \$request) {
        \$data = \$request->validate([
            'nom_banque' => 'required|string|max:255',
            'numero_compte' => 'nullable|string|max:100',
            'solde_initial' => 'required|numeric|min:0'
        ]);
        CompteBancaire::create(\$data);
        return back()->with('success', 'Compte bancaire ajouté.');
    }

    public function update(Request \$request, CompteBancaire \$compte_bancaire) {
        \$data = \$request->validate([
            'nom_banque' => 'required|string|max:255',
            'numero_compte' => 'nullable|string|max:100',
        ]);
        \$compte_bancaire->update(\$data);
        return back()->with('success', 'Compte bancaire modifié.');
    }

    public function show(CompteBancaire \$compte_bancaire) {
        \$operations = \$compte_bancaire->operations()->latest('date_operation')->latest('id')->get();
        return view('finance.banque.show', compact('compte_bancaire', 'operations'));
    }
}
EOT;
file_put_contents($f, $c);

$f2 = 'app/Http/Controllers/Web/OperationBancaireController.php';
$c2 = <<<EOT
<?php
namespace App\Http\Controllers\Web;
use App\Http\Controllers\Controller;
use App\Models\OperationBancaire;
use App\Models\CompteBancaire;
use Illuminate\Http\Request;

class OperationBancaireController extends Controller {
    public function store(Request \$request) {
        \$data = \$request->validate([
            'compte_bancaire_id' => 'required|exists:compte_bancaires,id',
            'type' => 'required|in:depot,retrait,frais',
            'montant' => 'required|numeric|min:1',
            'date_operation' => 'required|date',
            'motif' => 'required|string|max:255',
            'reference_piece' => 'nullable|string|max:100'
        ]);
        \$data['user_id'] = auth()->id();
        
        OperationBancaire::create(\$data);
        return back()->with('success', 'Opération enregistrée avec succès.');
    }

    public function destroy(OperationBancaire \$operation_bancaire) {
        \$operation_bancaire->delete();
        return back()->with('success', 'Opération annulée/supprimée.');
    }
}
EOT;
file_put_contents($f2, $c2);
