<?php
namespace App\Http\Controllers\Web;
use App\Http\Controllers\Controller;
use App\Models\CompteBancaire;
use App\Models\OperationBancaire;
use Illuminate\Http\Request;

class CompteBancaireController extends Controller {
    public function index() {
        $comptes = CompteBancaire::withCount('operations')->get();
        $totalSolde = $comptes->sum(function ($c) { return $c->solde_actuel; });
        return view('finance.banque.index', compact('comptes', 'totalSolde'));
    }

    public function store(Request $request) {
        $data = $request->validate([
            'nom_banque' => 'required|string|max:255',
            'numero_compte' => 'nullable|string|max:100',
            'solde_initial' => 'required|numeric|min:0'
        ]);
        CompteBancaire::create($data);
        return back()->with('success', 'Compte bancaire ajouté.');
    }

    public function update(Request $request, CompteBancaire $compte_bancaire) {
        $data = $request->validate([
            'nom_banque' => 'required|string|max:255',
            'numero_compte' => 'nullable|string|max:100',
        ]);
        $compte_bancaire->update($data);
        return back()->with('success', 'Compte bancaire modifié.');
    }

    public function show(CompteBancaire $compte_bancaire) {
        $operations = $compte_bancaire->operations()->latest('date_operation')->latest('id')->get();
        return view('finance.banque.show', compact('compte_bancaire', 'operations'));
    }
}