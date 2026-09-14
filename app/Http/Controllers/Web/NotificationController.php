<?php
namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use App\Services\NotificationService;
use App\Models\NotificationPush;

class NotificationController extends Controller
{
    public function index()
    {
        $notifications = NotificationPush::with('user')->orderBy('created_at', 'desc')->paginate(20);
        return view('notifications.index', compact('notifications'));
    }

    public function create()
    {
        // Users for the dropdown
        $users = User::orderBy('name')->get();
        return view('notifications.create', compact('users'));
    }

    public function store(Request $request, NotificationService $notifService)
    {
        $data = $request->validate([
            'titre' => 'required|string|max:255',
            'message' => 'required|string',
            'user_id' => 'nullable|exists:users,id',
            'type' => 'required|string|in:info,alerte'
        ]);

        if ($data['user_id']) {
            // Envoyer à un utilisateur spécifique
            $user = User::find($data['user_id']);
            $notifService->sendToUser($user, $data['titre'], $data['message'], $data['type']);
            $msg = "Notification envoyée à {$user->name}.";
        } else {
            // Envoyer à TOUS les utilisateurs
            $users = User::all();
            foreach ($users as $u) {
                $notifService->sendToUser($u, $data['titre'], $data['message'], $data['type']);
            }
            $msg = "Notification envoyée à tous les utilisateurs.";
        }

        return redirect()->route('notifications.index')->with('success', $msg);
    }
}
