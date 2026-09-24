@extends('layouts.app')
@section('page_title', isset($chauffeur) ? 'Modifier le Chauffeur' : 'Nouveau Chauffeur')

@section('content')
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h4 class="fw-bold mb-0">
            <i class='bx bxs-user-badge me-2 text-primary'></i>
            {{ isset($chauffeur) ? 'Modifier : ' . $chauffeur->nom : 'Nouveau Chauffeur' }}
        </h4>
        <p class="text-muted small mb-0">L'ajout d'un chauffeur crée automatiquement une fiche dans le personnel de l'école.</p>
    </div>
    <a href="{{ route('chauffeurs.index') }}" class="btn btn-outline-secondary">
        <i class='bx bx-arrow-back me-1'></i> Retour
    </a>
</div>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="card border-0 shadow-sm p-4">
            <form action="{{ isset($chauffeur) ? route('chauffeurs.update', $chauffeur) : route('chauffeurs.store') }}" method="POST">
                @csrf
                @if(isset($chauffeur)) @method('PUT') @endif

                @if($errors->any())
                    <div class="alert alert-danger border-0 rounded-4 mb-4">
                        <ul class="mb-0">@foreach($errors->all() as $e)<li>{{ $e }}</li>@endforeach</ul>
                    </div>
                @endif
                
                @php
                    $prenom = '';
                    $nom = '';
                    $email = '';
                    if(isset($chauffeur) && $chauffeur->personnel) {
                        $prenom = $chauffeur->personnel->prenom;
                        $nom = $chauffeur->personnel->nom;
                        $email = $chauffeur->personnel->email;
                    } elseif(isset($chauffeur)) {
                        // fallback if no personnel linked somehow
                        $parts = explode(' ', $chauffeur->nom, 2);
                        $prenom = $parts[0] ?? '';
                        $nom = $parts[1] ?? '';
                    }
                @endphp

                <div class="row g-3 mb-4">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Prénom <span class="text-danger">*</span></label>
                        <input type="text" name="prenom" class="form-control @error('prenom') is-invalid @enderror"
                            value="{{ old('prenom', $prenom) }}" required>
                        @error('prenom') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Nom <span class="text-danger">*</span></label>
                        <input type="text" name="nom" class="form-control @error('nom') is-invalid @enderror"
                            value="{{ old('nom', $nom) }}" required>
                        @error('nom') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                    
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Téléphone <span class="text-danger">*</span></label>
                        <input type="text" name="telephone" class="form-control @error('telephone') is-invalid @enderror"
                            value="{{ old('telephone', $chauffeur->telephone ?? '') }}" required>
                        @error('telephone') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Email</label>
                        <input type="email" name="email" class="form-control @error('email') is-invalid @enderror"
                            value="{{ old('email', $email) }}">
                        @error('email') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>

                    <div class="col-md-12 mt-4">
                        <h6 class="fw-bold mb-3 border-bottom pb-2"><i class='bx bxs-bus text-primary me-2'></i>Affectation au véhicule</h6>
                    </div>
                    
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Véhicule Assigné</label>
                        <select name="vehicule_id" class="form-select">
                            <option value="">-- Aucun --</option>
                            @foreach($vehicules as $v)
                                <option value="{{ $v->id }}"
                                    {{ old('vehicule_id', $chauffeur->vehicule_id ?? '') == $v->id ? 'selected' : '' }}>
                                    {{ $v->immatriculation }} {{ $v->marque ? '('.$v->marque.')' : '' }}
                                </option>
                            @endforeach
                        </select>
                    </div>
                    <div class="col-md-6">
                        <div class="form-check form-switch mt-4 pt-1">
                            <input class="form-check-input" type="checkbox" name="actif" id="actif" value="1"
                                {{ old('actif', $chauffeur->actif ?? true) ? 'checked' : '' }}>
                            <label class="form-check-label fw-semibold" for="actif">Chauffeur Actif</label>
                        </div>
                    </div>
                </div>

                <div class="d-flex gap-3 justify-content-end mt-4">
                    <a href="{{ route('chauffeurs.index') }}" class="btn btn-light">Annuler</a>
                    <button type="submit" class="btn btn-primary px-4 fw-semibold">
                        <i class='bx bx-check me-1'></i>
                        {{ isset($chauffeur) ? 'Mettre à jour' : 'Enregistrer' }}
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection
