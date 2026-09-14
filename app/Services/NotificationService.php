<?php
namespace App\Services;

use App\Models\NotificationPush;
use App\Models\User;
use App\Models\Eleve;
use Illuminate\Support\Facades\Log;

class NotificationService
{
    /**
     * Envoie une notification à un utilisateur (Web + Mobile Push)
     */
    public function sendToUser(User $user, string $title, string $message, string $type = 'info', array $data = [])
    {
        // 1. Sauvegarder dans la base de données
        $notification = NotificationPush::create([
            'user_id' => $user->id,
            'titre' => $title,
            'message' => $message,
            'type' => $type,
            'data' => $data,
        ]);

        // 2. Envoyer par FCM si le token existe
        if (!empty($user->fcm_token)) {
            $this->sendFcmPush($user->fcm_token, $title, $message, $data);
        }

        return $notification;
    }

    /**
     * Envoie une notification concernant un élève à l'élève lui-même et à son tuteur
     */
    public function sendToEleveAndTuteur(Eleve $eleve, string $title, string $message, string $type = 'info', array $data = [])
    {
        // Notifier l'élève s'il a un compte
        if ($eleve->user_id) {
            $userEleve = User::find($eleve->user_id);
            if ($userEleve) {
                $this->sendToUser($userEleve, $title, $message, $type, $data);
            }
        }

        // Notifier le tuteur s'il a un compte
        if ($eleve->parent_id) {
            $parent = $eleve->parent;
            if ($parent && $parent->user_id) {
                $userTuteur = User::find($parent->user_id);
                if ($userTuteur) {
                    $this->sendToUser($userTuteur, $title, $message, $type, $data);
                }
            }
        }
    }

    /**
     * Envoie un push Firebase Cloud Messaging (FCM)
     */
    protected function sendFcmPush($token, $title, $body, $data)
    {
        // TODO: Pour envoyer la notification push vers le mobile,
        // vous devez configurer le SDK Firebase (ex: kreait/laravel-firebase)
        // ou utiliser cURL avec l'API v1 de Firebase (nécessite firebase_credentials.json).
        
        Log::info("FCM Push ready to be sent to token: {$token}", [
            'title' => $title,
            'body' => $body
        ]);
        
        /* Exemple avec kreait/laravel-firebase une fois installé :
        try {
            $messaging = app('firebase.messaging');
            $message = \Kreait\Firebase\Messaging\CloudMessage::withTarget('token', $token)
                ->withNotification(\Kreait\Firebase\Messaging\Notification::create($title, $body))
                ->withData($data);
            $messaging->send($message);
        } catch (\Exception $e) {
            Log::error("Erreur FCM: " . $e->getMessage());
        }
        */
    }
}
