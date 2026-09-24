<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Vehicule;
use App\Models\Chauffeur;
use App\Models\ZoneTransport;
use Illuminate\Http\Request;

class VehiculeController extends Controller
{
    public function index()
    {
        $vehicules = Vehicule::with(['chauffeurPrincipal', 'zones'])
            ->withCount(['abonnements as places_occupees' => fn($q) => $q->where('actif', true)])
            ->get();

        return view('logistique.transport.vehicules', compact('vehicules'));
    }

    public function create()
    {
        $chauffeurs = Chauffeur::where('actif', true)->get();
        $zones = ZoneTransport::all();
        return view('logistique.transport.vehicule_form', compact('chauffeurs', 'zones'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'immatriculation' => 'required|string|max:20|unique:vehicules,immatriculation',
            'marque'          => 'nullable|string|max:100',
            'capacite'        => 'required|integer|min:1|max:100',
            'zones'           => 'nullable|array',
            'zones.*'         => 'exists:zone_transports,id',
        ]);

        $vehicule = Vehicule::create([
            'immatriculation' => $request->immatriculation,
            'marque'          => $request->marque,
            'capacite'        => $request->capacite,
            'actif'           => $request->boolean('actif', true),
        ]);

        if ($request->filled('zones')) {
            $vehicule->zones()->sync($request->zones);
        }

        if ($request->filled('chauffeur_id')) {
            Chauffeur::where('id', $request->chauffeur_id)->update(['vehicule_id' => $vehicule->id]);
        }

        return redirect()->route('vehicules.index')->with('success', "Véhicule {$vehicule->immatriculation} enregistré avec succès !");
    }

    public function edit(Vehicule $vehicule)
    {
        $vehicule->load('zones', 'chauffeurPrincipal');
        $chauffeurs = Chauffeur::where('actif', true)->get();
        $zones = ZoneTransport::all();
        $zonesActives = $vehicule->zones->pluck('id')->toArray();
        return view('logistique.transport.vehicule_form', compact('vehicule', 'chauffeurs', 'zones', 'zonesActives'));
    }

    public function update(Request $request, Vehicule $vehicule)
    {
        $request->validate([
            'immatriculation' => 'required|string|max:20|unique:vehicules,immatriculation,' . $vehicule->id,
            'marque'          => 'nullable|string|max:100',
            'capacite'        => 'required|integer|min:1|max:100',
            'zones'           => 'nullable|array',
            'zones.*'         => 'exists:zone_transports,id',
        ]);

        $vehicule->update([
            'immatriculation' => $request->immatriculation,
            'marque'          => $request->marque,
            'capacite'        => $request->capacite,
            'actif'           => $request->boolean('actif', true),
        ]);

        $vehicule->zones()->sync($request->zones ?? []);

        if ($request->filled('chauffeur_id')) {
            Chauffeur::where('vehicule_id', $vehicule->id)->update(['vehicule_id' => null]);
            Chauffeur::where('id', $request->chauffeur_id)->update(['vehicule_id' => $vehicule->id]);
        }

        return redirect()->route('vehicules.index')->with('success', "Véhicule {$vehicule->immatriculation} mis à jour !");
    }

    public function destroy(Vehicule $vehicule)
    {
        $vehicule->zones()->detach();
        $vehicule->delete();
        return redirect()->route('vehicules.index')->with('success', 'Véhicule supprimé.');
    }

    /**
     * AJAX : véhicules disponibles pour une zone donnée (avec places restantes)
     */
    public function parZone(ZoneTransport $zone)
    {
        $vehicules = $zone->vehicules()
            ->withCount(['abonnements as places_occupees' => fn($q) => $q->where('actif', true)])
            ->get()
            ->map(function ($v) {
                $dispo = max(0, $v->capacite - $v->places_occupees);
                return [
                    'id'              => $v->id,
                    'label'           => $v->immatriculation . ($v->marque ? ' — ' . $v->marque : ''),
                    'capacite'        => $v->capacite,
                    'places_occupees' => $v->places_occupees,
                    'places_dispo'    => $dispo,
                    'complet'         => $dispo <= 0,
                ];
            });

        return response()->json($vehicules);
    }
}
