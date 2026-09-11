<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\ParentEleve;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;

class TuteurController extends Controller
{
    /**
     * Liste des tuteurs avec filtre.
     */
    public function index(Request $request)
    {
        $search   = $request->get('search');
        $relation = $request->get('relation');
        $statut   = $request->get('statut', 'tous');

        $query = ParentEleve::with(['user', 'eleves.classe'])->latest();

        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->whereHas('user', fn($uq) =>
                    $uq->where('name', 'like', "%{$search}%")
                       ->orWhere('email', 'like', "%{$search}%")
                       ->orWhere('telephone', 'like', "%{$search}%")
                )->orWhere('telephone', 'like', "%{$search}%")
                 ->orWhere('nin', 'like', "%{$search}%");
            });
        }

        if ($relation) {
            $query->where('relation', $relation);
        }

        if ($statut === 'actif') {
            $query->where('actif', true);
        } elseif ($statut === 'inactif') {
            $query->where('actif', false);
        }

        $tuteurs = $query->get();

        return view('tuteurs.index', compact('tuteurs', 'search', 'relation', 'statut'));
    }

    /**
     * Formulaire d'édition d'un tuteur.
     */
    public function edit(ParentEleve $tuteur)
    {
        $tuteur->load(['user', 'eleves.classe']);
        return view('tuteurs.edit', compact('tuteur'));
    }

    /**
     * Mise à jour des informations d'un tuteur.
     */
    public function update(Request $request, ParentEleve $tuteur)
    {
        $request->validate([
            'name'       => 'required|string|max:255',
            'email'      => 'required|email|unique:users,email,' . $tuteur->user_id,
            'telephone'  => 'nullable|string|max:20',
            'profession' => 'nullable|string|max:255',
            'adresse'    => 'nullable|string|max:500',
            'relation'   => 'required|in:parent,tuteur,gardien',
            'nin'        => 'nullable|string|max:50',
            'actif'      => 'boolean',
            'photo'      => 'nullable|image|max:2048',
            'password'   => 'nullable|min:6|confirmed',
        ]);

        // Mise à jour du compte utilisateur
        $user = $tuteur->user;
        $user->name      = $request->name;
        $user->email     = $request->email;
        $user->telephone = $request->telephone;
        if ($request->filled('password')) {
            $user->password = Hash::make($request->password);
        }
        $user->actif = $request->boolean('actif', true);
        $user->save();

        // Mise à jour du profil tuteur
        $tuteur->telephone  = $request->telephone;
        $tuteur->profession = $request->profession;
        $tuteur->adresse    = $request->adresse;
        $tuteur->relation   = $request->relation;
        $tuteur->nin        = $request->nin;
        $tuteur->actif      = $request->boolean('actif', true);

        if ($request->hasFile('photo')) {
            if ($tuteur->photo) {
                Storage::disk('public')->delete($tuteur->photo);
            }
            $tuteur->photo = $request->file('photo')->store('tuteurs/photos', 'public');
        }

        $tuteur->save();

        return redirect()->route('tuteurs.index')
            ->with('success', "Tuteur {$user->name} mis à jour avec succès !");
    }

    /**
     * Activer / désactiver un tuteur.
     */
    public function toggleStatus(ParentEleve $tuteur)
    {
        $tuteur->actif = !$tuteur->actif;
        $tuteur->save();
        $tuteur->user->update(['actif' => $tuteur->actif]);

        $msg = $tuteur->actif ? 'activé' : 'désactivé';
        return back()->with('success', "Tuteur {$tuteur->user->name} {$msg} avec succès.");
    }
}
