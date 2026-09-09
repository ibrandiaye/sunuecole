<?php

namespace App\Models;

use Database\Factories\UserFactory;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Spatie\Permission\Traits\HasRoles;
use Tymon\JWTAuth\Contracts\JWTSubject;

class User extends Authenticatable implements JWTSubject
{
    /** @use HasFactory<UserFactory> */
    use HasFactory, Notifiable, HasRoles;

    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'telephone',
        'photo',
        'actif',
        'fcm_token',
        'cycle_id',
    ];

    public function cycle()
    {
        return $this->belongsTo(Cycle::class);
    }

    public function isRestrictedToCycle()
    {
        return !empty($this->cycle_id);
    }

    /**
     * The attributes that should be hidden for serialization.
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password'          => 'hashed',
            'actif'             => 'boolean',
        ];
    }

    // === Implémentation JWT ===

    public function getJWTIdentifier(): mixed
    {
        return $this->getKey();
    }

    public function getJWTCustomClaims(): array
    {
        return [
            'role'  => $this->getRoleNames()->first(),
            'email' => $this->email,
        ];
    }

    // === Relations ===

    public function enseignant()
    {
        return $this->hasOne(Enseignant::class);
    }

    public function parent()
    {
        return $this->hasOne(ParentEleve::class, 'user_id');
    }

    public function notifications()
    {
        return $this->hasMany(NotificationPush::class);
    }

    public function auditLogs()
    {
        return $this->hasMany(AuditLog::class);
    }

    // === Scopes ===

    public function scopeActifs($query)
    {
        return $query->where('actif', true);
    }

    // === Helpers ===

    public function isAdmin(): bool
    {
        return $this->hasAnyRole(['super_admin', 'directeur']);
    }
}
