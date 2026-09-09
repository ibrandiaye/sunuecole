<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Etablissement;
use Illuminate\Http\Request;

class EtablissementController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $etablissement = Etablissement::first();
        return view('etablissements.index', compact('etablissement'));
    }

    public function update(Request $request, Etablissement $etablissement)
    {
        $data = $request->validate([
            'nom' => 'required|string|max:255',
            'code' => 'required|string|max:50|unique:etablissements,code,' . $etablissement->id,
            'type' => 'required|string',
            'cycle' => 'required|string',
            'formule_bulletin' => 'required|in:(M+C)/2,(M+2C)/3',
            'adresse' => 'nullable|string',
            'telephone' => 'nullable|string',
            'email' => 'nullable|email',
            'directeur_nom' => 'nullable|string',
            'academie' => 'nullable|string',
            'inspection' => 'nullable|string',
        ]);

        if ($request->hasFile('logo')) {
            $data['logo'] = $request->file('logo')->store('logos', 'public');
        }

        $etablissement->update($data);

        return redirect()->route('etablissements.index')->with('success', 'Informations de l\'établissement mises à jour.');
    }
}
