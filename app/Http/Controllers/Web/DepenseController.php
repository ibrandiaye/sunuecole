<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Depense;
use App\Models\AnneeScolaire;
use App\Models\Paiement;
use Illuminate\Http\Request;

class DepenseController extends Controller
{
    private array $categories = [
        'salaires'       => 'Salaires & Charges',
        'fournitures'    => 'Fournitures Scolaires',
        'infrastructure' => 'Infrastructure & Loyer',
        'entretien'      => 'Entretien & Maintenance',
        'autre'          => 'Autre',
    ];

    public function index(Request $request)
    {
        $annees  = AnneeScolaire::orderBy('libelle', 'desc')->get();
        $annee   = AnneeScolaire::where('active', true)->first();
        $selected_annee_id = $request->get('annee_id', $annee?->id);

        $query = Depense::with('enregistrePar')
            ->where('annee_scolaire_id', $selected_annee_id);

        if ($request->filled('categorie')) {
            $query->where('categorie', $request->categorie);
        }

        $depenses = $query->orderBy('date_depense', 'desc')->get();
        $totalDepenses = $depenses->sum('montant');

        // ── Recettes (paiements encaissés de l'année sélectionnée) ──
        $totalRecettes = Paiement::where('annee_scolaire_id', $selected_annee_id)
            ->where('statut', '!=', 'impaye')
            ->sum('montant_paye');

        $benefice = $totalRecettes - $totalDepenses;

        // Dépenses par catégorie (pour graphe)
        $parCategorie = $depenses->groupBy('categorie')->map->sum('montant');

        return view('depenses.index', compact(
            'depenses', 'annees', 'selected_annee_id',
            'totalDepenses', 'totalRecettes', 'benefice',
            'parCategorie'
        ) + ['categories' => $this->categories]);
    }

    public function create()
    {
        $annee = AnneeScolaire::where('active', true)->first();
        return view('depenses.create', [
            'categories' => $this->categories,
            'annee'      => $annee,
        ]);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'libelle'          => 'required|string|max:255',
            'categorie'        => 'required|in:salaires,fournitures,infrastructure,entretien,autre',
            'montant'          => 'required|numeric|min:0',
            'mode_paiement'    => 'required|in:especes,wave,OM,virement',
            'date_depense'     => 'required|date',
            'annee_scolaire_id' => 'required|exists:annee_scolaires,id',
            'notes'            => 'nullable|string',
        ]);

        $data['reference']     = 'DEP-' . strtoupper(uniqid());
        $data['enregistre_par'] = auth()->id();

        Depense::create($data);

        return redirect()->route('depenses.index')
            ->with('success', 'Dépense enregistrée avec succès !');
    }

    public function edit(Depense $depense)
    {
        return view('depenses.edit', [
            'depense'    => $depense,
            'categories' => $this->categories,
        ]);
    }

    public function update(Request $request, Depense $depense)
    {
        $data = $request->validate([
            'libelle'       => 'required|string|max:255',
            'categorie'     => 'required|in:salaires,fournitures,infrastructure,entretien,autre',
            'montant'       => 'required|numeric|min:0',
            'mode_paiement' => 'required|in:especes,wave,OM,virement',
            'date_depense'  => 'required|date',
            'notes'         => 'nullable|string',
        ]);

        $depense->update($data);

        return redirect()->route('depenses.index')
            ->with('success', 'Dépense mise à jour !');
    }

    public function destroy(Depense $depense)
    {
        $depense->delete();
        return redirect()->route('depenses.index')
            ->with('success', 'Dépense supprimée.');
    }
}
