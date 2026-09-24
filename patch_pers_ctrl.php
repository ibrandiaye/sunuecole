<?php
$f = 'app/Http/Controllers/Web/PersonnelController.php';
$c = <<<EOT
<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Personnel;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class PersonnelController extends Controller
{
    public function index()
    {
        \$personnels = Personnel::with('user')->latest()->get();
        return view('personnels.index', compact('personnels'));
    }

    public function create()
    {
        return view('personnels.create');
    }

    public function store(Request \$request)
    {
        \$data = \$request->validate([
            'prenom' => 'required|string|max:100',
            'nom' => 'required|string|max:100',
            'telephone' => 'required|string|max:20|unique:users,telephone',
            'email' => 'nullable|email|unique:users,email',
            'fonction' => 'required|string|max:150',
            'date_embauche' => 'nullable|date',
            'create_user' => 'nullable|boolean'
        ]);

        DB::transaction(function () use (\$data, \$request) {
            \$userId = null;
            if (!empty(\$data['create_user'])) {
                \$user = User::create([
                    'name' => \$data['prenom'] . ' ' . \$data['nom'],
                    'email' => \$data['email'] ?? strtolower(\$data['prenom'].\$data['nom']).rand(10,99).'@sunuecole.sn',
                    'telephone' => \$data['telephone'],
                    'password' => Hash::make('password'),
                ]);
                \$user->assignRole('administratif');
                \$userId = \$user->id;
            }

            Personnel::create([
                'prenom' => \$data['prenom'],
                'nom' => \$data['nom'],
                'telephone' => \$data['telephone'],
                'email' => \$data['email'],
                'fonction' => \$data['fonction'],
                'date_embauche' => \$data['date_embauche'],
                'user_id' => \$userId,
                'actif' => true
            ]);
        });

        return redirect()->route('personnels.index')->with('success', 'Personnel ajouté avec succès.');
    }

    public function edit(Personnel \$personnel)
    {
        return view('personnels.edit', compact('personnel'));
    }

    public function update(Request \$request, Personnel \$personnel)
    {
        \$data = \$request->validate([
            'prenom' => 'required|string|max:100',
            'nom' => 'required|string|max:100',
            'telephone' => 'required|string|max:20',
            'email' => 'nullable|email',
            'fonction' => 'required|string|max:150',
            'date_embauche' => 'nullable|date',
            'actif' => 'boolean'
        ]);

        DB::transaction(function () use (\$personnel, \$data, \$request) {
            if (\$personnel->user_id) {
                // Check uniqueness excluding current user
                \$request->validate([
                    'telephone' => 'unique:users,telephone,' . \$personnel->user_id,
                    'email' => \$data['email'] ? 'unique:users,email,' . \$personnel->user_id : 'nullable',
                ]);
                
                \$personnel->user->update([
                    'name' => \$data['prenom'] . ' ' . \$data['nom'],
                    'email' => \$data['email'] ?? \$personnel->user->email,
                    'telephone' => \$data['telephone'],
                ]);
            }
            
            \$data['actif'] = \$request->has('actif') ? 1 : 0;
            \$personnel->update(\$data);
        });

        return redirect()->route('personnels.index')->with('success', 'Personnel mis à jour avec succès.');
    }

    public function show(Personnel \$personnel)
    {
        \$personnel->load(['user', 'documents']);
        return view('personnels.show', compact('personnel'));
    }

    public function destroy(Personnel \$personnel)
    {
        DB::transaction(function () use (\$personnel) {
            \$user = \$personnel->user;
            // Supprimer les documents liés
            foreach(\$personnel->documents as \$doc) {
                if (\Illuminate\Support\Facades\Storage::disk('public')->exists(\$doc->fichier_path)) {
                    \Illuminate\Support\Facades\Storage::disk('public')->delete(\$doc->fichier_path);
                }
                \$doc->delete();
            }
            \$personnel->delete();
            \$user?->delete();
        });

        return redirect()->route('personnels.index')->with('success', 'Personnel supprimé avec succès.');
    }
}
EOT;
file_put_contents($f, $c);
