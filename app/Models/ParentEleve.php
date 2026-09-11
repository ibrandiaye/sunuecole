<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ParentEleve extends Model
{
    protected $table = 'parents';

    protected $fillable = [
        'user_id', 'telephone', 'profession',
        'adresse', 'relation', 'nin', 'photo', 'actif',
    ];

    protected $casts = [
        'actif' => 'boolean',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function eleves()
    {
        return $this->hasMany(Eleve::class, 'parent_id');
    }

    public function scopeSearch($query, $search)
    {
        return $query->whereHas('user', fn($q) =>
            $q->where('name', 'like', "%{$search}%")
              ->orWhere('email', 'like', "%{$search}%")
              ->orWhere('telephone', 'like', "%{$search}%")
        )->orWhere('telephone', 'like', "%{$search}%");
    }
}
