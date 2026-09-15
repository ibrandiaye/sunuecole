<?php
namespace App\Services;

use App\Models\NotificationPush;
use App\Models\User;
use App\Models\Eleve;
use Illuminate\Support\Facades\Log;
use Google\Client;
use Illuminate\Support\Facades\Http;

class NotificationService
{
    /**
     * Envoie une notification à un utilisateur (Web + Mobile Push)
     */
    public function sendToUser(User $user, string $title, string $message, string $type = 'info', array $data = [])
    {
        $notification = NotificationPush::create([
            'user_id' => $user->id,
            'titre' => $title,
            'message' => $message,
            'type' => $type,
            'data' => $data,
        ]);

        if (!empty($user->fcm_token)) {
            $this->sendFcmPush($user->fcm_token, $title, $message, $data);
        }

        return $notification;
    }

    public function sendToEleveAndTuteur(Eleve $eleve, string $title, string $message, string $type = 'info', array $data = [])
    {
        if ($eleve->user_id) {
            $userEleve = User::find($eleve->user_id);
            if ($userEleve) $this->sendToUser($userEleve, $title, $message, $type, $data);
        }

        if ($eleve->parent_id) {
            $parent = $eleve->parent;
            if ($parent && $parent->user_id) {
                $userTuteur = User::find($parent->user_id);
                if ($userTuteur) $this->sendToUser($userTuteur, $title, $message, $type, $data);
            }
        }
    }

    protected function sendFcmPush($token, $title, $body, $data)
    {
        try {
            $credentialsPath = storage_path('app/firebase_credentials.json');

            if (!file_exists($credentialsPath)) {
                Log::warning("FCM Credentials not found at {$credentialsPath}");
                return;
            }

            $client = new Client();
            $client->setAuthConfig($credentialsPath);
            $client->addScope('https://www.googleapis.com/auth/firebase.messaging');
            $client->useApplicationDefaultCredentials();

            $tokenData = $client->fetchAccessTokenWithAssertion();
            if (!isset($tokenData['access_token'])) {
                Log::error("FCM Token generation failed", $tokenData);
                return;
            }
            $accessToken = $tokenData['access_token'];

            $projectId = json_decode(file_get_contents($credentialsPath))->project_id;

            $message = [
                'message' => [
                    'token' => $token,
                    'notification' => [
                        'title' => $title,
                        'body' => $body,
                    ],
                    'data' => empty($data) ? (object)[] : $data
                ]
            ];

            $response = Http::withToken($accessToken)
                ->post("https://fcm.googleapis.com/v1/projects/{$projectId}/messages:send", $message);

            if ($response->successful()) {
                Log::info("FCM Push sent successfully to token: {$token}");
            } else {
                Log::error("FCM Push failed: " . $response->body());
            }

        } catch (\Exception $e) {
            Log::error("Erreur FCM: " . $e->getMessage());
        }
    }
}
