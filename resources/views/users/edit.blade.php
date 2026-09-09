@extends('layouts.app')

@section('title', 'Modifier l\'Utilisateur')

@section('content')
<div class="row justify-content-center">
    <div class="col-md-6">
        <div class="card p-4 shadow-sm border-0 animate__animated animate__fadeInUp">
            <div class="d-flex align-items-center mb-4">
                <a href="{{ route('users.index') }}" class="btn btn-light btn-sm me-3"><i class='bx bx-arrow-back'></i></a>
                <h5 class="fw-bold mb-0">Modifier profil utilisateur</h5>
            </div>

            <form action="{{ route('users.update', $user) }}" method="POST">
                @csrf @method('PUT')
                <div class="mb-3">
                    <label class="form-label fw-bold small">NOM COMPLET</label>
                    <input type="text" name="name" class="form-control" value="{{ old('name', $user->name) }}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold small">ADRESSE EMAIL</label>
                    <input type="email" name="email" class="form-control" value="{{ old('email', $user->email) }}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold small">RÔLE / ACCÈS</label>
                    <select name="role" class="form-select" required>
                        @foreach($roles as $role)
                            <option value="{{ $role->name }}" {{ $userRole == $role->name ? 'selected' : '' }}>
                                {{ ucfirst(str_replace('_', ' ', $role->name)) }}
                            </option>
                        @endforeach
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold small">RESTRICTION DE CYCLE (OPTIONNEL)</label>
                    <select name="cycle_id" class="form-select">
                        <option value="">Tous les cycles (Accès complet)</option>
                        @foreach($cycles as $cycle)
                            <option value="{{ $cycle->id }}" {{ $user->cycle_id == $cycle->id ? 'selected' : '' }}>
                                {{ $cycle->nom }}
                            </option>
                        @endforeach
                    </select>
                </div>

                <div class="alert alert-info border-0 small mb-4">
                    <i class='bx bx-info-circle me-1'></i> Laissez les champs mot de passe vides si vous ne souhaitez pas les modifier.
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold small">NOUVEAU MOT DE PASSE</label>
                        <input type="password" name="password" class="form-control">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold small">CONFIRMATION</label>
                        <input type="password" name="password_confirmation" class="form-control">
                    </div>
                </div>

                <button type="submit" class="btn btn-primary w-100 fw-bold py-2 mt-3">Enregistrer les modifications</button>
            </form>
        </div>
    </div>
</div>
@endsection
