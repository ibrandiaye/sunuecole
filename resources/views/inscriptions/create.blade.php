@extends('layouts.app')

@section('title', 'Nouvelle Inscription')
@section('page_title', 'Inscrire un Élève')

@section('content')
<div class="row justify-content-center animate__animated animate__fadeIn">
    <div class="col-md-8">
        <div class="card p-4">
            <form action="{{ route('inscriptions.store') }}" method="POST">
                @csrf
                
                <div class="mb-3">
                    <label class="form-label fw-bold">Élève</label>
                    <select name="eleve_id" class="form-select @error('eleve_id') is-invalid @enderror" required>
                        <option value="">Sélectionner un élève...</option>
                        @foreach($eleves as $eleve)
                            <option value="{{ $eleve->id }}" {{ (isset($selected_eleve) && $selected_eleve == $eleve->id) ? 'selected' : '' }}>
                                {{ $eleve->matricule }} - {{ $eleve->nom }} {{ $eleve->prenom }}
                            </option>
                        @endforeach
                    </select>
                    @error('eleve_id') <div class="invalid-feedback">{{ $message }}</div> @enderror
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Année Scolaire</label>
                        <select name="annee_scolaire_id" class="form-select @error('annee_scolaire_id') is-invalid @enderror" required>
                            @foreach($annees as $annee)
                                <option value="{{ $annee->id }}" {{ $annee->active ? 'selected' : '' }}>
                                    {{ $annee->libelle }} {{ $annee->active ? '(Active)' : '' }}
                                </option>
                            @endforeach
                        </select>
                        @error('annee_scolaire_id') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Classe</label>
                        <select name="classe_id" class="form-select @error('classe_id') is-invalid @enderror" required>
                            <option value="">Sélectionner la classe...</option>
                            @foreach($classes as $classe)
                                <option value="{{ $classe->id }}">{{ $classe->nom }}</option>
                            @endforeach
                        </select>
                        @error('classe_id') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-bold">Date de l'inscription</label>
                    <input type="date" name="date_inscription" class="form-control" value="{{ date('Y-m-d') }}" required>
                </div>

                <div class="card bg-light border-0 mb-4 p-3 rounded-3">
                    <h6 class="fw-bold text-secondary mb-3"><i class='bx bx-category me-2'></i>Services Optionnels</h6>
                    <div class="form-check form-switch mb-2">
                        <input class="form-check-input" type="checkbox" role="switch" name="avec_cantine" id="avec_cantine" value="1">
                        <label class="form-check-label" for="avec_cantine">Souscrire à la Cantine Scolaire</label>
                    </div>
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" role="switch" name="avec_transport" id="avec_transport" value="1">
                        <label class="form-check-label" for="avec_transport">Souscrire au Transport Scolaire</label>
                    </div>
                </div>

                <div class="d-flex justify-content-between">
                    <a href="{{ route('inscriptions.index') }}" class="btn btn-light">Annuler</a>
                    <button type="submit" class="btn btn-primary px-5">Valider l'Inscription</button>
                </div>
            </form>
        </div>

        <div class="alert alert-info mt-4 border-0 rounded-4">
            <i class='bx bx-info-circle me-1'></i>
            L'inscription d'un élève dans l'année scolaire <strong>Active</strong> mettra automatiquement à jour sa classe actuelle affichée dans sa fiche de profil.
        </div>
    </div>
</div>
@endsection
