<?php
namespace App\Http\Controllers\Web;
use App\Http\Controllers\Controller;
use App\Models\AbonnementCantine;
use App\Models\Eleve;
use Illuminate\Http\Request;
class AbonnementCantineController extends Controller {
    public function index() {
        $abonnements = AbonnementCantine::with('eleve.classe')->latest()->get();
        $eleves = Eleve::all();
        return view('logistique.cantine.index', compact('abonnements', 'eleves'));
    }
    public function store(Request $request) {
        $data = $request->validate(['eleve_id' => 'required', 'date_debut' => 'required|date', 'date_fin' => 'nullable|date', 'regime_alimentaire' => 'nullable|string', 'actif' => 'boolean']);
        $data['actif'] = $request->has('actif') ? 1 : 0;
        AbonnementCantine::create($data);
        return back()->with('success', 'Abonnement Cantine ajouté.');
    }
    public function destroy(AbonnementCantine $abonnement_cantine) {
        $abonnement_cantine->delete();
        return back()->with('success', 'Abonnement supprimé.');
    }
}