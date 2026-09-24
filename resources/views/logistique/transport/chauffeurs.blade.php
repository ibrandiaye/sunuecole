@extends('layouts.app')
@section('page_title', 'Gestion des Chauffeurs')

@section('content')
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h4 class="fw-bold mb-0"><i class='bx bxs-user-badge me-2 text-primary'></i>Chauffeurs</h4>
        <p class="text-muted small mb-0">Gérez les chauffeurs et leur affectation aux véhicules</p>
    </div>
    <a href="{{ route('chauffeurs.create') }}" class="btn btn-primary">
        <i class='bx bx-plus me-1'></i> Nouveau Chauffeur
    </a>
</div>

@if(session('success'))
    <div class="alert alert-success border-0 shadow-sm rounded-4 mb-4">
        <i class='bx bx-check-circle me-1'></i> {{ session('success') }}
    </div>
@endif

<div class="row g-4">
    @forelse($chauffeurs as $c)
    <div class="col-md-6 col-xl-4">
        <div class="card border-0 shadow-sm h-100">
            <div class="card-body p-4">
                <div class="d-flex justify-content-between align-items-start mb-3">
                    <div class="d-flex align-items-center">
                        <div class="bg-primary-subtle text-primary rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 48px; height: 48px;">
                            <i class='bx bxs-user fs-4'></i>
                        </div>
                        <div>
                            <h5 class="fw-bold mb-0">{{ $c->nom }}</h5>
                            <small class="text-muted"><i class='bx bx-phone me-1'></i>{{ $c->telephone }}</small>
                        </div>
                    </div>
                    @if($c->actif)
                        <span class="badge bg-success-subtle text-success border border-success-subtle">Actif</span>
                    @else
                        <span class="badge bg-danger-subtle text-danger border border-danger-subtle">Inactif</span>
                    @endif
                </div>

                <div class="mb-3 p-3 bg-light rounded-3">
                    <div class="small text-muted mb-1"><i class='bx bxs-bus me-1'></i>Véhicule Assigné</div>
                    @if($c->vehicule)
                        <div class="fw-semibold">{{ $c->vehicule->immatriculation }}</div>
                        <div class="small text-muted">{{ $c->vehicule->marque ?? 'Marque non renseignée' }}</div>
                    @else
                        <div class="fst-italic text-warning small"><i class='bx bx-error-circle me-1'></i>Aucun véhicule</div>
                    @endif
                </div>
                
                @if($c->personnel_id)
                <div class="mb-3">
                    <span class="badge bg-info-subtle text-dark border"><i class='bx bx-id-card me-1'></i>Lié au personnel (ID: {{ $c->personnel_id }})</span>
                </div>
                @endif

                <div class="d-flex gap-2 pt-2 border-top">
                    <a href="{{ route('chauffeurs.edit', $c) }}" class="btn btn-sm btn-outline-primary flex-fill">
                        <i class='bx bx-edit me-1'></i>Modifier
                    </a>
                    <form action="{{ route('chauffeurs.destroy', $c) }}" method="POST" class="flex-fill">
                        @csrf @method('DELETE')
                        <button class="btn btn-sm btn-outline-danger w-100" onclick="return confirm('Supprimer ce chauffeur ? (Cela supprimera également son enregistrement dans le personnel)')">
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
            <i class='bx bxs-user-badge fs-1 d-block mb-3 text-secondary'></i>
            <p class="mb-2">Aucun chauffeur enregistré.</p>
            <a href="{{ route('chauffeurs.create') }}" class="btn btn-primary">
                <i class='bx bx-plus me-1'></i> Ajouter un chauffeur
            </a>
        </div>
    </div>
    @endforelse
</div>
@endsection
