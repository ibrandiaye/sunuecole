<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Enseignant;
use App\Models\ParentEleve;
use App\Models\Eleve;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class AuthController extends Controller
{
    /**
     * Authentification multi-critères mobile :
     * - Professeurs & Parents : Numéro de téléphone (ou email)
     * - Élèves : Matricule OU Numéro de téléphone (ou email)
     */
    public function login(Request $request)
    {
        $login = trim($request->input('login') ?? $request->input('email') ?? $request->input('telephone') ?? $request->input('matricule') ?? '');
        $password = $request->input('password');

        if (empty($login) || empty($password)) {
            return response()->json([
                'status' => 'error',
                'message' => 'Veuillez saisir votre identifiant (téléphone, matricule ou email) et mot de passe.'
            ], 422);
        }

        // Nettoyage des caractères non numériques pour la recherche téléphonique
        $cleanPhone = preg_replace('/[^0-9]/', '', $login);

        $user = null;
        $eleve = null;

        // 1. Recherche par Numéro de Téléphone (Professeurs, Parents, Utilisateurs)
        if (!empty($cleanPhone) && strlen($cleanPhone) >= 7) {
            // Dans la table users
            $user = User::where(function($q) use ($login, $cleanPhone) {
                $q->where('telephone', $login)
                  ->orWhere('telephone', $cleanPhone)
                  ->orWhere('telephone', 'like', '%' . substr($cleanPhone, -9));
            })->first();

            // Dans la table enseignants
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

            // Dans la table parents
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

        // 3. Recherche par Numéro de téléphone pour les Élèves (tel_tuteur ou téléphone)
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

        // Si aucun utilisateur trouvé
        if (!$user) {
            return response()->json([
                'status' => 'error',
                'message' => 'Identifiant introuvable. Veuillez vérifier votre numéro de téléphone ou matricule.'
            ], 401);
        }

        // Vérification de l'état du compte
        if (!$user->actif) {
            return response()->json([
                'status' => 'error',
                'message' => 'Ce compte a été suspendu. Veuillez contacter la direction de l\'école.'
            ], 403);
        }

        // Vérification du mot de passe
        $validPassword = Hash::check($password, $user->password);

        // Pour les élèves : autoriser aussi la connexion si le mot de passe correspond à leur matricule ou "password"
        if (!$validPassword && $eleve) {
            if (strcasecmp($password, $eleve->matricule) === 0 || $password === 'password') {
                $validPassword = true;
            }
        }

        if (!$validPassword) {
            return response()->json([
                'status' => 'error',
                'message' => 'Mot de passe incorrect.'
            ], 401);
        }

        // Génération du token JWT
        $token = Auth::guard('api')->login($user);

        return $this->respondWithToken($token);
    }

    /**
     * Récupérer les informations de l'utilisateur connecté.
     */
    public function me()
    {
        return response()->json([
            'status' => 'success',
            'user' => Auth::guard('api')->user(),
            'role' => Auth::guard('api')->user()->getRoleNames()->first()
        ]);
    }

    /**
     * Déconnexion.
     */
    public function logout()
    {
        Auth::guard('api')->logout();

        return response()->json([
            'status' => 'success',
            'message' => 'Déconnexion réussie'
        ]);
    }

    /**
     * Rafraîchir le token.
     */
    public function refresh()
    {
        return $this->respondWithToken(Auth::guard('api')->refresh());
    }

    /**
     * Structure de la réponse avec le token.
     */
    protected function respondWithToken($token)
    {
        return response()->json([
            'status' => 'success',
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => Auth::guard('api')->factory()->getTTL() * 60,
            'user' => Auth::guard('api')->user()
        ]);
    }
}
