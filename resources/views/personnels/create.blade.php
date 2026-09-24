@extends('layouts.app')
@section('title', 'Ajouter un Membre du Personnel')
@section('content')
<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="h3 mb-0 text-gray-800">Ajouter un Membre du Personnel</h2>
        <a href="{{ route('personnels.index') }}" class="btn btn-outline-secondary">
            <i class='bx bx-arrow-back'></i> Retour
        </a>
    </div>

    <div class="card shadow-sm border-0">
        <div class="card-body p-4">
            <form action="{{ route('personnels.store') }}" method="POST">
                @csrf
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Prénom <span class="text-danger">*</span></label>
                        <input type="text" name="prenom" class="form-control" required value="{{ old('prenom') }}">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Nom <span class="text-danger">*</span></label>
                        <input type="text" name="nom" class="form-control" required value="{{ old('nom') }}">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Téléphone <span class="text-danger">*</span></label>
                        <input type="text" name="telephone" class="form-control" required value="{{ old('telephone') }}">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Email (Optionnel)</label>
                        <input type="email" name="email" class="form-control" value="{{ old('email') }}">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Fonction <span class="text-danger">*</span></label>
                        <input type="text" name="fonction" class="form-control" placeholder="ex: Gardien, Secrétaire..." required value="{{ old('fonction') }}">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Date d'embauche</label>
                        <input type="date" name="date_embauche" class="form-control" value="{{ old('date_embauche') }}">
                    </div>
                    <div class="col-md-12 mb-4">
                        <div class="form-check form-switch mt-3">
                            <input class="form-check-input" type="checkbox" id="create_user" name="create_user" value="1" checked>
                            <label class="form-check-label fw-bold" for="create_user">Créer un compte d'accès à la plateforme</label>
                            <small class="d-block text-muted">Si coché, un compte sera créé avec le mot de passe "password". Il sera assigné au rôle Administratif.</small>
                        </div>
                    </div>
                </div>
                <div class="text-end">
                    <button type="submit" class="btn btn-primary px-4"><i class='bx bx-save'></i> Enregistrer</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection