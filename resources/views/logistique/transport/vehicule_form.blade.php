@extends('layouts.app')
@section('page_title', isset($vehicule) ? 'Modifier le Véhicule' : 'Nouveau Véhicule')

@section('content')
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h4 class="fw-bold mb-0">
            <i class='bx bxs-bus me-2 text-primary'></i>
            {{ isset($vehicule) ? 'Modifier : ' . $vehicule->immatriculation : 'Nouveau Véhicule' }}
        </h4>
    </div>
    <a href="{{ route('vehicules.index') }}" class="btn btn-outline-secondary">
        <i class='bx bx-arrow-back me-1'></i> Retour
    </a>
</div>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="card border-0 shadow-sm p-4">
            <form action="{{ isset($vehicule) ? route('vehicules.update', $vehicule) : route('vehicules.store') }}" method="POST">
                @csrf
                @if(isset($vehicule)) @method('PUT') @endif

                @if($errors->any())
                    <div class="alert alert-danger border-0 rounded-4 mb-4">
                        <ul class="mb-0">@foreach($errors->all() as $e)<li>{{ $e }}</li>@endforeach</ul>
                    </div>
                @endif

                <div class="row g-3 mb-4">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Immatriculation <span class="text-danger">*</span></label>
                        <input type="text" name="immatriculation" class="form-control @error('immatriculation') is-invalid @enderror"
                            value="{{ old('immatriculation', $vehicule->immatriculation ?? '') }}" placeholder="ex: DK-1234-AA" required>
                        @error('immatriculation') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Marque / Modèle</label>
                        <input type="text" name="marque" class="form-control"
                            value="{{ old('marque', $vehicule->marque ?? '') }}" placeholder="ex: Toyota Hiace">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Capacité (places) <span class="text-danger">*</span></label>
                        <input type="number" name="capacite" class="form-control @error('capacite') is-invalid @enderror"
                            value="{{ old('capacite', $vehicule->capacite ?? '') }}" min="1" max="100" required>
                        @error('capacite') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Chauffeur Principal</label>
                        <select name="chauffeur_id" class="form-select">
                            <option value="">-- Aucun --</option>
                            @foreach($chauffeurs as $c)
                                <option value="{{ $c->id }}"
                                    {{ old('chauffeur_id', $vehicule->chauffeurPrincipal?->id ?? '') == $c->id ? 'selected' : '' }}>
                                    {{ $c->nom }} {{ $c->telephone ? '(' . $c->telephone . ')' : '' }}
                                </option>
                            @endforeach
                        </select>
                    </div>
                    <div class="col-md-6">
                        <div class="form-check form-switch mt-3">
                            <input class="form-check-input" type="checkbox" name="actif" id="actif" value="1"
                                {{ old('actif', $vehicule->actif ?? true) ? 'checked' : '' }}>
                            <label class="form-check-label fw-semibold" for="actif">Véhicule Actif</label>
                        </div>
                    </div>
                </div>

                {{-- Zones desservies --}}
                <div class="mb-4">
                    <label class="form-label fw-semibold"><i class='bx bx-map-pin me-1 text-primary'></i>Zones desservies</label>
                    <div class="row g-2 p-3 bg-light rounded-3 border">
                        @forelse($zones as $zone)
                        <div class="col-md-4 col-6">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="zones[]"
                                    value="{{ $zone->id }}" id="zone_{{ $zone->id }}"
                                    {{ in_array($zone->id, old('zones', $zonesActives ?? [])) ? 'checked' : '' }}>
                                <label class="form-check-label" for="zone_{{ $zone->id }}">
                                    {{ $zone->nom }}
                                    <span class="text-muted small">({{ number_format($zone->tarif_mensuel, 0, ',', ' ') }} F)</span>
                                </label>
                            </div>
                        </div>
                        @empty
                        <p class="text-muted mb-0 small">
                            Aucune zone définie.
                            <a href="{{ route('zone_transports.create') }}">Créer une zone</a>
                        </p>
                        @endforelse
                    </div>
                </div>

                <div class="d-flex gap-3 justify-content-end">
                    <a href="{{ route('vehicules.index') }}" class="btn btn-light">Annuler</a>
                    <button type="submit" class="btn btn-primary px-4 fw-semibold">
                        <i class='bx bx-check me-1'></i>
                        {{ isset($vehicule) ? 'Mettre à jour' : 'Enregistrer' }}
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection
