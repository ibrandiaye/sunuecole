<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\ValidationException;

use App\Models\User;
use App\Models\Enseignant;
use App\Models\ParentEleve;
use App\Models\Eleve;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function showLogin()
    {
        if (Auth::check()) {
            return redirect($this->redirectPathForUser(Auth::user()));
        }
        return view('auth.login');
    }

    public function login(Request $request)
    {
        $login = trim($request->input('login') ?? $request->input('email') ?? '');
        $password = $request->input('password');

        if (empty($login) || empty($password)) {
            throw ValidationException::withMessages([
                'login' => 'Veuillez saisir votre identifiant et votre mot de passe.',
            ]);
        }

        $cleanPhone = preg_replace('/[^0-9]/', '', $login);
        $user = null;
        $eleve = null;

        // 1. Recherche par Numéro de Téléphone (Professeurs, Parents, Utilisateurs)
        if (!empty($cleanPhone) && strlen($cleanPhone) >= 7) {
            $user = User::where(function($q) use ($login, $cleanPhone) {
                $q->where('telephone', $login)
                  ->orWhere('telephone', $cleanPhone)
                  ->orWhere('telephone', 'like', '%' . substr($cleanPhone, -9));
            })->first();

            if (!$user) {
                $ens = Enseignant::where(function($q) use ($login, $cleanPhone) {
                    $q->where('telephone', $login)
                      ->orWhere('telephone', $cleanPhone)
                      ->orWhere('telephone', 'like', '%' . substr($cleanPhone, -9));
                })->with('user')->first();

                if ($ens && $ens->user) {
                    $user = $ens->user;
                }
            }

            if (!$user) {
                $parent = ParentEleve::where(function($q) use ($login, $cleanPhone) {
                    $q->where('telephone', $login)
                      ->orWhere('telephone', $cleanPhone)
                      ->orWhere('telephone', 'like', '%' . substr($cleanPhone, -9));
                })->with('user')->first();

                if ($parent && $parent->user) {
                    $user = $parent->user;
                }
            }
        }

        // 2. Recherche par Matricule (Élèves)
        if (!$user) {
            $eleve = Eleve::where('matricule', $login)
                ->orWhere('matricule', strtoupper($login))
                ->with('user')
                ->first();

            if ($eleve) {
                if (!$eleve->user_id || !$eleve->user) {
                    $slug = strtolower(preg_replace('/[^a-zA-Z0-9]/', '', $eleve->matricule));
                    $userEleve = User::create([
                        'name' => $eleve->prenom . ' ' . $eleve->nom,
                        'email' => $slug . '@sunuecole.sn',
                        'password' => Hash::make('password'),
                        'actif' => true,
                    ]);
                    $userEleve->assignRole('eleve');
                    $eleve->update(['user_id' => $userEleve->id]);
                    $user = $userEleve;
                } else {
                    $user = $eleve->user;
                }
            }
        }

        // 3. Recherche par Numéro de téléphone tuteur pour les Élèves
        if (!$user && !empty($cleanPhone) && strlen($cleanPhone) >= 7) {
            $eleve = Eleve::where(function($q) use ($login, $cleanPhone) {
                $q->where('tel_tuteur', $login)
                  ->orWhere('tel_tuteur', $cleanPhone)
                  ->orWhere('tel_tuteur', 'like', '%' . substr($cleanPhone, -9));
            })->with('user')->first();

            if ($eleve && $eleve->user) {
                $user = $eleve->user;
            }
        }

        // 4. Recherche par Email (Fallback direct)
        if (!$user) {
            $user = User::where('email', $login)->first();
            if ($user && $user->hasRole('eleve')) {
                $eleve = Eleve::where('user_id', $user->id)->first();
            }
        }

        // Vérification de l'utilisateur
        if (!$user) {
            throw ValidationException::withMessages([
                'login' => 'Identifiant introuvable. Veuillez vérifier votre identifiant (email, téléphone ou matricule).',
            ]);
        }

        if (!$user->actif) {
            throw ValidationException::withMessages([
                'login' => 'Ce compte a été suspendu. Veuillez contacter la direction de l\'école.',
            ]);
        }

        // Vérification du mot de passe
        $validPassword = Hash::check($password, $user->password);

        // Fallback mot de passe pour les élèves (matricule ou "password")
        if (!$validPassword && $eleve) {
            if (strcasecmp($password, $eleve->matricule) === 0 || $password === 'password') {
                $validPassword = true;
            }
        }

        if (!$validPassword) {
            throw ValidationException::withMessages([
                'password' => 'Mot de passe incorrect.',
            ]);
        }

        Auth::login($user, $request->boolean('remember'));
        $request->session()->regenerate();

        return redirect()->intended($this->redirectPathForUser($user));
    }

    public function redirectPathForUser($user): string
    {
        if ($user->hasRole('enseignant')) {
            return route('professeur.dashboard');
        }
        if ($user->hasRole('parent')) {
            return route('parent.dashboard');
        }
        if ($user->hasRole('eleve')) {
            return route('eleve.dashboard');
        }

        return route('dashboard');
    }

    public function logout(Request $request)
    {
        Auth::logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return redirect()->route('login');
    }
}
