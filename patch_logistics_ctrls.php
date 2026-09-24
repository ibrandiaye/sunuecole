<?php
$f = 'app/Http/Controllers/Web/AbonnementCantineController.php';
$c = <<<EOT
<?php
namespace App\Http\Controllers\Web;
use App\Http\Controllers\Controller;
use App\Models\AbonnementCantine;
use App\Models\Eleve;
use Illuminate\Http\Request;
class AbonnementCantineController extends Controller {
    public function index() {
        \$abonnements = AbonnementCantine::with('eleve.classe')->latest()->get();
        \$eleves = Eleve::all();
        return view('logistique.cantine.index', compact('abonnements', 'eleves'));
    }
    public function store(Request \$request) {
        \$data = \$request->validate(['eleve_id' => 'required', 'date_debut' => 'required|date', 'date_fin' => 'nullable|date', 'regime_alimentaire' => 'nullable|string', 'actif' => 'boolean']);
        \$data['actif'] = \$request->has('actif') ? 1 : 0;
        AbonnementCantine::create(\$data);
        return back()->with('success', 'Abonnement Cantine ajouté.');
    }
    public function destroy(AbonnementCantine \$abonnement_cantine) {
        \$abonnement_cantine->delete();
        return back()->with('success', 'Abonnement supprimé.');
    }
}
EOT;
file_put_contents($f, $c);

$f2 = 'app/Http/Controllers/Web/AbonnementTransportController.php';
$c2 = <<<EOT
<?php
namespace App\Http\Controllers\Web;
use App\Http\Controllers\Controller;
use App\Models\AbonnementTransport;
use App\Models\Eleve;
use App\Models\ZoneTransport;
use Illuminate\Http\Request;
class AbonnementTransportController extends Controller {
    public function index() {
        \$abonnements = AbonnementTransport::with(['eleve.classe', 'zoneTransport'])->latest()->get();
        \$eleves = Eleve::all();
        \$zones = ZoneTransport::all();
        return view('logistique.transport.index', compact('abonnements', 'eleves', 'zones'));
    }
    public function store(Request \$request) {
        \$data = \$request->validate(['eleve_id' => 'required', 'zone_transport_id' => 'required', 'date_debut' => 'required|date', 'date_fin' => 'nullable|date', 'actif' => 'boolean']);
        \$data['actif'] = \$request->has('actif') ? 1 : 0;
        AbonnementTransport::create(\$data);
        return back()->with('success', 'Abonnement Transport ajouté.');
    }
    public function destroy(AbonnementTransport \$abonnement_transport) {
        \$abonnement_transport->delete();
        return back()->with('success', 'Abonnement supprimé.');
    }
}
EOT;
file_put_contents($f2, $c2);
