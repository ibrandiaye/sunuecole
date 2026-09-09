<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class NotificationPush extends Model
{
    protected $table = 'notifications_push';

    protected $fillable = [
        'user_id',
        'titre',
        'message',
        'type',
        'data',
        'lu',
        'lu_at'
    ];

    protected $casts = [
        'data' => 'array',
        'lu' => 'boolean',
        'lu_at' => 'datetime'
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
