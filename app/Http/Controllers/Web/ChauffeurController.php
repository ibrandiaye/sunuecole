<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Chauffeur;
use App\Models\Personnel;
use App\Models\Vehicule;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ChauffeurController extends Controller
{
    public function index()
    {
        $chauffeurs = Chauffeur::with(['vehicule', 'personnel'])->get();
        return view('logistique.transport.chauffeurs', compact('chauffeurs'));
    }

    public function create()
    {
        $vehicules = Vehicule::where('actif', true)->get();
        return view('logistique.transport.chauffeur_form', compact('vehicules'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'prenom' => 'required|string|max:100',
            'nom' => 'required|string|max:100',
            'telephone' => 'required|string|max:20',
            'email' => 'nullable|email|max:150',
            'vehicule_id' => 'nullable|exists:vehicules,id',
            'actif' => 'nullable|boolean',
        ]);

        DB::transaction(function () use ($request) {
            $actif = $request->boolean('actif', true);
            
            // 1. Create Personnel
            $personnel = Personnel::create([
                'prenom' => $request->prenom,
                'nom' => $request->nom,
                'telephone' => $request->telephone,
                'email' => $request->email,
                'fonction' => 'Chauffeur',
                'date_embauche' => now(),
                'actif' => $actif,
            ]);

            // 2. Create Chauffeur
            Chauffeur::create([
                'personnel_id' => $personnel->id,
                'nom' => $request->prenom . ' ' . $request->nom,
                'telephone' => $request->telephone,
                'vehicule_id' => $request->vehicule_id,
                'actif' => $actif,
            ]);
        });

        return redirect()->route('chauffeurs.index')->with('success', 'Chauffeur (et personnel) créé avec succès.');
    }

    public function edit(Chauffeur $chauffeur)
    {
        $vehicules = Vehicule::where('actif', true)->get();
        return view('logistique.transport.chauffeur_form', compact('chauffeur', 'vehicules'));
    }

    public function update(Request $request, Chauffeur $chauffeur)
    {
        $request->validate([
            'prenom' => 'required|string|max:100',
            'nom' => 'required|string|max:100',
            'telephone' => 'required|string|max:20',
            'email' => 'nullable|email|max:150',
            'vehicule_id' => 'nullable|exists:vehicules,id',
            'actif' => 'nullable|boolean',
        ]);

        DB::transaction(function () use ($request, $chauffeur) {
            $actif = $request->boolean('actif', true);

            // Update Personnel if exists
            if ($chauffeur->personnel_id) {
                Personnel::where('id', $chauffeur->personnel_id)->update([
                    'prenom' => $request->prenom,
                    'nom' => $request->nom,
                    'telephone' => $request->telephone,
                    'email' => $request->email,
                    'actif' => $actif,
                ]);
            }

            // Update Chauffeur
            $chauffeur->update([
                'nom' => $request->prenom . ' ' . $request->nom,
                'telephone' => $request->telephone,
                'vehicule_id' => $request->vehicule_id,
                'actif' => $actif,
            ]);
        });

        return redirect()->route('chauffeurs.index')->with('success', 'Chauffeur mis à jour avec succès.');
    }

    public function destroy(Chauffeur $chauffeur)
    {
        DB::transaction(function () use ($chauffeur) {
            if ($chauffeur->personnel_id) {
                Personnel::where('id', $chauffeur->personnel_id)->delete();
            }
            $chauffeur->delete();
        });

        return redirect()->route('chauffeurs.index')->with('success', 'Chauffeur (et personnel) supprimé.');
    }
}
