@extends('layouts.app')
@section('page_title', 'Gestion des Véhicules')

@section('content')
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h4 class="fw-bold mb-0"><i class='bx bxs-bus me-2 text-primary'></i>Véhicules de Transport</h4>
        <p class="text-muted small mb-0">Gérez vos véhicules, chauffeurs et zones desservies</p>
    </div>
    <a href="{{ route('vehicules.create') }}" class="btn btn-primary">
        <i class='bx bx-plus me-1'></i> Nouveau Véhicule
    </a>
</div>

@if(session('success'))
    <div class="alert alert-success border-0 shadow-sm rounded-4 mb-4">
        <i class='bx bx-check-circle me-1'></i> {{ session('success') }}
    </div>
@endif

<div class="row g-4">
    @forelse($vehicules as $v)
    @php
        $occupees = $v->places_occupees ?? 0;
        $dispo    = max(0, $v->capacite - $occupees);
        $pct      = $v->capacite > 0 ? round(($occupees / $v->capacite) * 100) : 0;
        $barColor = $pct >= 100 ? 'danger' : ($pct >= 75 ? 'warning' : 'success');
    @endphp
    <div class="col-md-6 col-xl-4">
        <div class="card border-0 shadow-sm h-100">
            <div class="card-body p-4">
                {{-- Header --}}
                <div class="d-flex justify-content-between align-items-start mb-3">
                    <div>
                        <h5 class="fw-bold mb-0">{{ $v->immatriculation }}</h5>
                        <small class="text-muted">{{ $v->marque ?? 'Marque non renseignée' }}</small>
                    </div>
                    @if($v->actif)
                        <span class="badge bg-success-subtle text-success border border-success-subtle">Actif</span>
                    @else
                        <span class="badge bg-danger-subtle text-danger border border-danger-subtle">Inactif</span>
                    @endif
                </div>

                {{-- Chauffeur --}}
                <div class="d-flex align-items-center mb-3 p-2 bg-light rounded-3">
                    <i class='bx bxs-user-circle text-primary me-2 fs-5'></i>
                    <div>
                        <div class="small text-muted">Chauffeur</div>
                        <div class="fw-semibold small">{{ $v->chauffeurPrincipal?->nom ?? 'Non assigné' }}</div>
                        @if($v->chauffeurPrincipal?->telephone)
                            <div class="text-muted" style="font-size:.75rem;">{{ $v->chauffeurPrincipal->telephone }}</div>
                        @endif
                    </div>
                </div>

                {{-- Places --}}
                <div class="mb-3">
                    <div class="d-flex justify-content-between mb-1">
                        <small class="fw-semibold">Occupation des places</small>
                        <small class="{{ $pct >= 100 ? 'text-danger fw-bold' : 'text-muted' }}">
                            {{ $occupees }}/{{ $v->capacite }}
                            @if($pct >= 100) <span class="badge bg-danger ms-1">COMPLET</span>@endif
                        </small>
                    </div>
                    <div class="progress" style="height:8px;">
                        <div class="progress-bar bg-{{ $barColor }}" style="width:{{ $pct }}%"></div>
                    </div>
                    <div class="d-flex justify-content-between mt-1">
                        <small class="text-muted">{{ $occupees }} occupées</small>
                        <small class="text-{{ $barColor }} fw-semibold">{{ $dispo }} dispo</small>
                    </div>
                </div>

                {{-- Zones --}}
                <div class="mb-3">
                    <small class="text-muted fw-semibold d-block mb-1">Zones desservies :</small>
                    @forelse($v->zones as $zone)
                        <span class="badge bg-info-subtle text-dark border me-1 mb-1">
                            <i class='bx bx-map-pin me-1'></i>{{ $zone->nom }}
                        </span>
                    @empty
                        <span class="text-muted fst-italic small">Aucune zone assignée</span>
                    @endforelse
                </div>

                {{-- Actions --}}
                <div class="d-flex gap-2 pt-2 border-top">
                    <a href="{{ route('vehicules.edit', $v) }}" class="btn btn-sm btn-outline-primary flex-fill">
                        <i class='bx bx-edit me-1'></i>Modifier
                    </a>
                    <form action="{{ route('vehicules.destroy', $v) }}" method="POST" class="flex-fill">
                        @csrf @method('DELETE')
                        <button class="btn btn-sm btn-outline-danger w-100" onclick="return confirm('Supprimer ce véhicule ?')">
                            <i class='bx bx-trash me-1'></i>Supprimer
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    @empty
    <div class="col-12">
        <div class="text-center py-5 text-muted">
            <i class='bx bxs-bus fs-1 d-block mb-3 text-secondary'></i>
            <p class="mb-2">Aucun véhicule enregistré.</p>
            <a href="{{ route('vehicules.create') }}" class="btn btn-primary">
                <i class='bx bx-plus me-1'></i> Ajouter un véhicule
            </a>
        </div>
    </div>
    @endforelse
</div>
@endsection
