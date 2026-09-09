<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Http\Requests\Enseignant\StoreEnseignantRequest;
use App\Models\Enseignant;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Request;

class EnseignantController extends Controller
{
    public function index()
    {
        $enseignants = Enseignant::with('user')->latest()->get();
        return view('enseignants.index', compact('enseignants'));
    }

    public function create()
    {
        $matieres = \App\Models\Matiere::orderBy('nom')->get();
        return view('enseignants.create', compact('matieres'));
    }

    public function store(StoreEnseignantRequest $request)
    {
        $data = $request->validated();

        DB::transaction(function () use ($data, $request) {
            // 1. Créer le compte utilisateur
            $user = User::create([
                'name' => $data['name'],
                'email' => $data['email'],
                'telephone' => $data['telephone'],
                'password' => Hash::make('password'), // Par défaut, à changer à la première connexion
            ]);

            $user->assignRole('enseignant');

            // 2. Créer le profil enseignant
            $enseignant = new Enseignant();
            $enseignant->user_id = $user->id;
            $enseignant->specialite = $data['specialite'];
            $enseignant->statut = $data['statut'];
            $enseignant->date_embauche = $data['date_embauche'] ?? now();
            
            if ($request->hasFile('photo')) {
                $enseignant->photo = $request->file('photo')->store('enseignants/photos', 'public');
            }

            $enseignant->save();

            // 3. Associer les matières
            if (isset($data['matieres'])) {
                $enseignant->matieres()->sync($data['matieres']);
            }
        });

        return redirect()->route('enseignants.index')
            ->with('success', 'Enseignant ajouté et compte utilisateur créé !');
    }

    public function edit(Enseignant $enseignant)
    {
        $enseignant->load(['user', 'matieres']);
        $matieres = \App\Models\Matiere::orderBy('nom')->get();
        return view('enseignants.edit', compact('enseignant', 'matieres'));
    }

    public function update(Request $request, Enseignant $enseignant)
    {
        $data = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|unique:users,email,' . $enseignant->user_id,
            'telephone' => 'required|string|unique:users,telephone,' . $enseignant->user_id,
            'specialite' => 'nullable|string|max:100',
            'statut' => 'required|in:permanent,vacataire',
            'matieres' => 'nullable|array',
            'matieres.*' => 'exists:matieres,id',
        ]);

        DB::transaction(function () use ($enseignant, $data) {
            $enseignant->user->update([
                'name' => $data['name'],
                'email' => $data['email'],
                'telephone' => $data['telephone'],
            ]);

            $enseignant->update([
                'specialite' => $data['specialite'],
                'statut' => $data['statut'],
            ]);

            if (isset($data['matieres'])) {
                $enseignant->matieres()->sync($data['matieres']);
            }
        });

        return redirect()->route('enseignants.index')->with('success', 'Profil enseignant mis à jour.');
    }

    public function show(Enseignant $enseignant)
    {
        $enseignant->load(['user', 'classes', 'matieres']);
        return view('enseignants.show', compact('enseignant'));
    }

    public function destroy(Enseignant $enseignant)
    {
        DB::transaction(function () use ($enseignant) {
            $user = $enseignant->user;
            $enseignant->delete();
            $user?->delete();
        });

        return redirect()->route('enseignants.index')
            ->with('success', 'Enseignant et son compte utilisateur supprimés.');
    }
}
