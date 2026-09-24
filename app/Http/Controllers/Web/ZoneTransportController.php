<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\ZoneTransport;
use Illuminate\Http\Request;

class ZoneTransportController extends Controller
{
    public function index()
    {
        $zones = ZoneTransport::all();
        return view('logistique.transport.zones', compact('zones'));
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'nom' => 'required|string|max:255',
            'tarif_mensuel' => 'required|numeric|min:0'
        ]);

        ZoneTransport::create($data);
        return back()->with('success', 'Zone ajoutée avec succès.');
    }

    public function update(Request $request, ZoneTransport $zone_transport)
    {
        $data = $request->validate([
            'nom' => 'required|string|max:255',
            'tarif_mensuel' => 'required|numeric|min:0'
        ]);

        $zone_transport->update($data);
        return back()->with('success', 'Zone modifiée avec succès.');
    }

    public function destroy(ZoneTransport $zone_transport)
    {
        // Prevent deletion if subscriptions exist?
        // Let's just delete for now (cascade handled if we added it, but it throws SQL error if restricted)
        try {
            $zone_transport->delete();
            return back()->with('success', 'Zone supprimée.');
        } catch (\Exception $e) {
            return back()->with('error', 'Impossible de supprimer cette zone car elle est utilisée par des abonnements.');
        }
    }
}