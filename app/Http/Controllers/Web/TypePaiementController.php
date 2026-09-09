<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\TypePaiement;
use Illuminate\Http\Request;

class TypePaiementController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $types = TypePaiement::latest()->get();
        return view('types_paiements.index', compact('types'));
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'nom' => 'required|string|max:100',
            'code' => 'required|string|max:20|unique:types_paiements,code',
            'periodicite' => 'required|string',
            'montant_defaut' => 'nullable|numeric|min:0',
        ]);

        TypePaiement::create($data);

        return redirect()->route('types_paiements.index')->with('success', 'Type de frais ajouté.');
    }

    public function update(Request $request, TypePaiement $typePaiement)
    {
        $data = $request->validate([
            'nom' => 'required|string|max:100',
            'code' => 'required|string|max:20|unique:types_paiements,code,' . $typePaiement->id,
            'periodicite' => 'required|string',
            'montant_defaut' => 'nullable|numeric|min:0',
        ]);

        $typePaiement->update($data);

        return redirect()->route('types_paiements.index')->with('success', 'Type de frais mis à jour.');
    }

    public function destroy(TypePaiement $typePaiement)
    {
        if ($typePaiement->paiements()->count() > 0) {
            return back()->with('error', 'Impossible de supprimer un type de frais déjà utilisé dans des transactions.');
        }
        $typePaiement->delete();
        return redirect()->route('types_paiements.index')->with('success', 'Type de frais supprimé.');
    }
}
