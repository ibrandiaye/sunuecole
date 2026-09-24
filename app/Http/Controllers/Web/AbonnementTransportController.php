<?php
namespace App\Http\Controllers\Web;
use App\Http\Controllers\Controller;
use App\Models\AbonnementTransport;
use App\Models\Eleve;
use App\Models\ZoneTransport;
use Illuminate\Http\Request;
class AbonnementTransportController extends Controller {
    public function index() {
        $abonnements = AbonnementTransport::with(['eleve.classe', 'zoneTransport'])->latest()->get();
        $eleves = Eleve::all();
        $zones = ZoneTransport::all();
        return view('logistique.transport.index', compact('abonnements', 'eleves', 'zones'));
    }
    public function store(Request $request) {
        $data = $request->validate(['eleve_id' => 'required', 'zone_transport_id' => 'required', 'date_debut' => 'required|date', 'date_fin' => 'nullable|date', 'actif' => 'boolean']);
        $data['actif'] = $request->has('actif') ? 1 : 0;
        AbonnementTransport::create($data);
        return back()->with('success', 'Abonnement Transport ajouté.');
    }
    public function destroy(AbonnementTransport $abonnement_transport) {
        $abonnement_transport->delete();
        return back()->with('success', 'Abonnement supprimé.');
    }
}