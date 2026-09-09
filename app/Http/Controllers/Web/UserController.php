<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\User;
use Spatie\Permission\Models\Role;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules;

class UserController extends Controller
{
    public function index()
    {
        $users = User::with('roles')->latest()->get();
        return view('users.index', compact('users'));
    }

    public function create()
    {
        $roles = Role::all();
        $cycles = \App\Models\Cycle::all();
        return view('users.create', compact('roles', 'cycles'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'lowercase', 'email', 'max:255', 'unique:'.User::class],
            'password' => ['required', 'confirmed', Rules\Password::defaults()],
            'role' => ['required', 'exists:roles,name'],
            'cycle_id' => ['nullable', 'exists:cycles,id'],
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'cycle_id' => $request->cycle_id,
        ]);

        $user->assignRole($request->role);

        return redirect()->route('users.index')
            ->with('success', 'Utilisateur créé avec succès.');
    }

    public function edit(User $user)
    {
        $roles = Role::all();
        $cycles = \App\Models\Cycle::all();
        $userRole = $user->roles->first()?->name;
        return view('users.edit', compact('user', 'roles', 'userRole', 'cycles'));
    }

    public function update(Request $request, User $user)
    {
        $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'lowercase', 'email', 'max:255', 'unique:users,email,'.$user->id],
            'password' => ['nullable', 'confirmed', Rules\Password::defaults()],
            'role' => ['required', 'exists:roles,name'],
            'cycle_id' => ['nullable', 'exists:cycles,id'],
            'active' => ['boolean']
        ]);

        $user->name = $request->name;
        $user->email = $request->email;
        $user->cycle_id = $request->cycle_id;
        
        if ($request->filled('password')) {
            $user->password = Hash::make($request->password);
        }

        $user->save();
        $user->syncRoles([$request->role]);

        return redirect()->route('users.index')
            ->with('success', 'Utilisateur mis à jour avec succès.');
    }

    public function destroy(User $user)
    {
        if ($user->id === auth()->id()) {
            return back()->with('error', 'Vous ne pouvez pas supprimer votre propre compte.');
        }

        $user->delete();
        return redirect()->route('users.index')
            ->with('success', 'Utilisateur supprimé.');
    }

    public function toggleStatus(User $user)
    {
        // Supposons une colonne 'active' ou gestion via permissions
        // Pour l'instant on simule si la colonne n'existe pas ou on l'ajoute plus tard
        return back()->with('info', 'Fonctionnalité de blocage en cours de déploiement.');
    }
}
