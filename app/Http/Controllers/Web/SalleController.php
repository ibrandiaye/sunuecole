<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Salle;
use Illuminate\Http\Request;

class SalleController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $salles = Salle::latest()->get();
        return view('salles.index', compact('salles'));
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'nom' => 'required|string|max:100',
            'capacite' => 'required|integer|min:1',
            'type' => 'required|string',
        ]);

        Salle::create($data);

        return redirect()->route('salles.index')->with('success', 'Salle ajoutée.');
    }

    public function update(Request $request, Salle $salle)
    {
        $data = $request->validate([
            'nom' => 'required|string|max:100',
            'capacite' => 'required|integer|min:1',
            'type' => 'required|string',
            'disponible' => 'boolean',
        ]);

        $salle->update($data);

        return redirect()->route('salles.index')->with('success', 'Salle mise à jour.');
    }

    public function destroy(Salle $salle)
    {
        if ($salle->classes()->count() > 0) {
            return back()->with('error', 'Impossible de supprimer une salle occupée par des classes.');
        }
        $salle->delete();
        return redirect()->route('salles.index')->with('success', 'Salle supprimée.');
    }
}
