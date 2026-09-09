@extends('layouts.app')

@section('title', 'Informations Établissement')
@section('page_title', 'Paramètres de l\'École')

@section('content')
<div class="card p-4 animate__animated animate__fadeIn">
    @if(!$etablissement)
        <div class="alert alert-warning">
            Aucun établissement configuré. Veuillez contacter l'administrateur.
        </div>
    @else
        <form action="{{ route('etablissements.update', $etablissement) }}" method="POST" enctype="multipart/form-data">
            @csrf
            @method('PUT')
            
            <div class="row g-4">
                <div class="col-md-3 text-center border-end">
                    <div class="mb-3">
                        <label class="form-label d-block fw-bold">Logo</label>
                        @if($etablissement->logo)
                            <img src="{{ asset('storage/' . $etablissement->logo) }}" class="rounded mb-3 shadow-sm" width="150" alt="Logo">
                        @else
                            <div class="bg-light rounded d-flex align-items-center justify-content-center mx-auto mb-3 shadow-sm" style="width: 150px; height: 150px;">
                                <i class='bx bxs-school fs-1 text-muted'></i>
                            </div>
                        @endif
                        <input type="file" name="logo" class="form-control form-control-sm">
                        <small class="text-muted">Format recommandé: PNG/JPG (carré)</small>
                    </div>
                </div>

                <div class="col-md-9">
                    <div class="row g-3">
                        <div class="col-md-8">
                            <label class="form-label fw-bold">Nom de l'Établissement</label>
                            <input type="text" name="nom" class="form-control" value="{{ old('nom', $etablissement->nom) }}" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-bold">Code / Matricule École</label>
                            <input type="text" name="code" class="form-control" value="{{ old('code', $etablissement->code) }}" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-bold">Type</label>
                            <select name="type" class="form-select">
                                <option value="prive" {{ $etablissement->type == 'prive' ? 'selected' : '' }}>Privé</option>
                                <option value="public" {{ $etablissement->type == 'public' ? 'selected' : '' }}>Public</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Cycle</label>
                            <select name="cycle" class="form-select">
                                <option value="elementaire" {{ $etablissement->cycle == 'elementaire' ? 'selected' : '' }}>Élémentaire</option>
                                <option value="moyen" {{ $etablissement->cycle == 'moyen' ? 'selected' : '' }}>Moyen</option>
                                <option value="secondaire" {{ $etablissement->cycle == 'secondaire' ? 'selected' : '' }}>Secondaire</option>
                                <option value="mixte" {{ $etablissement->cycle == 'mixte' ? 'selected' : '' }}>Mixte (Tous)</option>
                            </select>
                        </div>

                        <div class="col-md-12 mt-3">
                            <h6 class="fw-bold border-bottom pb-2">Paramètres Pédagogiques</h6>
                        </div>

                        <div class="col-md-12 mb-3">
                            <label class="form-label fw-bold">Formule de Calcul des Bulletins</label>
                            <select name="formule_bulletin" class="form-select">
                                <option value="(M+C)/2" {{ $etablissement->formule_bulletin == '(M+C)/2' ? 'selected' : '' }}>Standard : (Moyenne Classe + Composition) / 2</option>
                                <option value="(M+2C)/3" {{ $etablissement->formule_bulletin == '(M+2C)/3' ? 'selected' : '' }}>Pondération Composition : (Moyenne Classe + (Composition × 2)) / 3</option>
                            </select>
                            <small class="text-muted d-block mt-1">Cette formule s'appliquera lors de la génération de tous les bulletins de l'école.</small>
                        </div>

                        <div class="col-md-12">
                            <label class="form-label fw-bold">Adresse Physique</label>
                            <input type="text" name="adresse" class="form-control" value="{{ old('adresse', $etablissement->adresse) }}">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-bold">Téléphone</label>
                            <input type="text" name="telephone" class="form-control" value="{{ old('telephone', $etablissement->telephone) }}">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">E-mail de contact</label>
                            <input type="email" name="email" class="form-control" value="{{ old('email', $etablissement->email) }}">
                        </div>

                        <div class="col-md-12 mt-4">
                            <h6 class="fw-bold border-bottom pb-2">Tutelle & Direction</h6>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-bold">Nom du Directeur / Chef d'Établissement</label>
                            <input type="text" name="directeur_nom" class="form-control" value="{{ old('directeur_nom', $etablissement->directeur_nom) }}">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label fw-bold">Académie</label>
                            <input type="text" name="academie" class="form-control" value="{{ old('academie', $etablissement->academie) }}">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label fw-bold">Inspection (IEF)</label>
                            <input type="text" name="inspection" class="form-control" value="{{ old('inspection', $etablissement->inspection) }}">
                        </div>
                    </div>

                    <div class="mt-5 text-end">
                        <button type="submit" class="btn btn-primary px-5 fw-bold">
                            <i class='bx bx-save me-2'></i> Enregistrer les modifications
                        </button>
                    </div>
                </div>
            </div>
        </form>
    @endif
</div>
@endsection
