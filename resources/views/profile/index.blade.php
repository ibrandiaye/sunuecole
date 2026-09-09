@extends('layouts.app')

@section('title', 'Mon Profil')
@section('page_title', 'Paramètres du compte')

@section('content')
<div class="row animate__animated animate__fadeIn">
    <div class="col-md-6 mb-4">
        <div class="card p-4 h-100 shadow-sm border-0">
            <h5 class="fw-bold mb-4 text-primary"><i class='bx bx-user-circle me-2'></i>Informations Personnelles</h5>
            <form action="{{ route('profile.update') }}" method="POST">
                @csrf @method('PATCH')
                <div class="mb-3">
                    <label class="form-label small fw-bold">NOM COMPLET</label>
                    <input type="text" name="name" class="form-control" value="{{ $user->name }}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-bold">ADRESSE EMAIL</label>
                    <input type="email" name="email" class="form-control" value="{{ $user->email }}" required>
                </div>
                <button type="submit" class="btn btn-primary fw-bold px-4">Mettre à jour</button>
            </form>
        </div>
    </div>

    <div class="col-md-6 mb-4">
        <div class="card p-4 h-100 shadow-sm border-0">
            <h5 class="fw-bold mb-4 text-danger"><i class='bx bx-lock-alt me-2'></i>Sécurité</h5>
            <form action="{{ route('profile.password') }}" method="POST">
                @csrf @method('PUT')
                <div class="mb-3">
                    <label class="form-label small fw-bold">MOT DE PASSE ACTUEL</label>
                    <input type="password" name="current_password" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-bold">NOUVEAU MOT DE PASSE</label>
                    <input type="password" name="password" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-bold">CONFIRMATION</label>
                    <input type="password" name="password_confirmation" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-danger fw-bold px-4">Changer le mot de passe</button>
            </form>
        </div>
    </div>
</div>
@endsection
