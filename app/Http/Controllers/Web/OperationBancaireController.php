<?php
namespace App\Http\Controllers\Web;
use App\Http\Controllers\Controller;
use App\Models\OperationBancaire;
use App\Models\CompteBancaire;
use Illuminate\Http\Request;

class OperationBancaireController extends Controller {
    public function store(Request $request) {
        $data = $request->validate([
            'compte_bancaire_id' => 'required|exists:compte_bancaires,id',
            'type' => 'required|in:depot,retrait,frais',
            'montant' => 'required|numeric|min:1',
            'date_operation' => 'required|date',
            'motif' => 'required|string|max:255',
            'reference_piece' => 'nullable|string|max:100'
        ]);
        $data['user_id'] = auth()->id();
        
        OperationBancaire::create($data);
        return back()->with('success', 'Opération enregistrée avec succès.');
    }

    public function destroy(OperationBancaire $operation_bancaire) {
        $operation_bancaire->delete();
        return back()->with('success', 'Opération annulée/supprimée.');
    }
}