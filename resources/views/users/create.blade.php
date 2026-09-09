@extends('layouts.app')

@section('title', 'Nouvel Utilisateur')

@section('content')
<div class="row justify-content-center">
    <div class="col-md-6">
        <div class="card p-4 shadow-sm border-0 animate__animated animate__fadeInUp">
            <div class="d-flex align-items-center mb-4">
                <a href="{{ route('users.index') }}" class="btn btn-light btn-sm me-3"><i class='bx bx-arrow-back'></i></a>
                <h5 class="fw-bold mb-0">Créer un nouveau compte</h5>
            </div>

            <form action="{{ route('users.store') }}" method="POST">
                @csrf
                <div class="mb-3">
                    <label class="form-label fw-bold small">NOM COMPLET</label>
                    <input type="text" name="name" class="form-control" value="{{ old('name') }}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold small">ADRESSE EMAIL</label>
                    <input type="email" name="email" class="form-control" value="{{ old('email') }}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold small">RÔLE / ACCÈS</label>
                    <select name="role" class="form-select" required>
                        <option value="">Sélectionnez un rôle</option>
                        @foreach($roles as $role)
                            <option value="{{ $role->name }}">{{ ucfirst(str_replace('_', ' ', $role->name)) }}</option>
                        @endforeach
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold small">RESTRICTION DE CYCLE (OPTIONNEL)</label>
                    <select name="cycle_id" class="form-select">
                        <option value="">Tous les cycles (Accès complet)</option>
                        @foreach($cycles as $cycle)
                            <option value="{{ $cycle->id }}">{{ $cycle->nom }}</option>
                        @endforeach
                    </select>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold small">MOT DE PASSE</label>
                        <input type="password" name="password" class="form-control" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold small">CONFIRMATION</label>
                        <input type="password" name="password_confirmation" class="form-control" required>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary w-100 fw-bold py-2 mt-3">Créer l'utilisateur</button>
            </form>
        </div>
    </div>
</div>
@endsection
