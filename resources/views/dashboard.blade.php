@extends('layouts.app')

@section('title', 'Tableau de Bord')
@section('page_title', 'Vue d\'ensemble')

@section('content')
<!-- KPIs Section -->
<div class="row g-4 mb-4 animate__animated animate__fadeIn">
    <div class="col-md-3">
        <div class="card p-3 border-0 bg-primary text-white">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h6 class="text-white-50 small mb-1 uppercase fw-bold">Total Élèves</h6>
                    <h3 class="fw-bold mb-0">{{ $stats['total_eleves'] }}</h3>
                </div>
                <div class="fs-1 opacity-50"><i class='bx bxs-user-badge'></i></div>
            </div>
            <div class="mt-3 small text-white-50">Taux de croissance : <span class="text-white fw-bold">+0%</span></div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card p-3 border-0 bg-success text-white">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h6 class="text-white-50 small mb-1 uppercase fw-bold">Classes Actives</h6>
                    <h3 class="fw-bold mb-0">{{ $stats['total_classes'] }}</h3>
                </div>
                <div class="fs-1 opacity-50"><i class='bx bxs-school'></i></div>
            </div>
            <div class="mt-3 small text-white-50">Année : <span class="text-white fw-bold">{{ $activeYear->libelle ?? 'N/A' }}</span></div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card p-3 border-0 bg-info text-white">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h6 class="text-white-50 small mb-1 uppercase fw-bold">Enseignants</h6>
                    <h3 class="fw-bold mb-0">{{ $stats['total_enseignants'] }}</h3>
                </div>
                <div class="fs-1 opacity-50"><i class='bx bxs-group'></i></div>
            </div>
            <div class="mt-3 small text-white-50">Taux d'encadrement : <span class="text-white fw-bold">1/--</span></div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card p-3 border-0 bg-warning text-white">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h6 class="text-white-50 small mb-1 uppercase fw-bold">Recettes du Mois</h6>
                    <h3 class="fw-bold mb-0">{{ number_format($stats['recettes_mois'], 0, ',', ' ') }} <small class="fs-6">FCFA</small></h3>
                </div>
                <div class="fs-1 opacity-50"><i class='bx bxs-wallet'></i></div>
            </div>
            <div class="mt-3 small text-white-50 text-end fw-bold">Détails financiers →</div>
        </div>
    </div>
</div>

<div class="row g-4">
    <!-- Middle: Distribution -->
    <div class="col-md-7">
        <div class="card p-4 h-100">
            <h5 class="fw-bold mb-4">Répartition des Élèves par Cycle</h5>
            
            @php
                $bgColors = ['bg-primary', 'bg-success', 'bg-info', 'bg-warning', 'bg-danger'];
            @endphp
            @foreach($cyclesData as $index => $cycle)
                @php
                    $percentage = $stats['total_eleves'] > 0 ? ($cycle->eleves_count / $stats['total_eleves']) * 100 : 0;
                    $bgColor = $bgColors[$index % count($bgColors)];
                @endphp
                <div class="mb-4">
                    <div class="d-flex justify-content-between mb-2">
                        <span class="fw-medium">{{ ucfirst($cycle->nom) }}</span>
                        <span class="text-muted">{{ $cycle->eleves_count }} élèves</span>
                    </div>
                    <div class="progress" style="height: 10px; border-radius: 5px;">
                        <div class="progress-bar {{ $bgColor }}" role="progressbar" style="width: {{ $percentage }}%"></div>
                    </div>
                </div>
            @endforeach
            
            <hr class="my-4 opacity-50">
            
            <h6 class="fw-bold mb-3">Statut Global de Fréquentation</h6>
            <div class="p-3 bg-light rounded-4 border-dashed border-2 d-flex align-items-center gap-3">
                <div class="bg-white p-2 rounded-3 shadow-sm text-primary fs-4"><i class='bx bxs-check-shield'></i></div>
                <div>
                    <p class="mb-0 small text-muted">Système à jour</p>
                    <p class="mb-0 fw-bold small">Toutes les données sont synchronisées au {{ date('d/m/Y H:i') }}</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Right: Recent Activity -->
    <div class="col-md-5">
        <div class="card p-4 h-100">
            <h5 class="fw-bold mb-4">Inscriptions Récentes</h5>
            
            <div class="timeline">
                @forelse($recent_inscriptions as $eleve)
                <div class="d-flex gap-3 mb-4 last-child-mb-0">
                    <div class="bg-primary-subtle text-primary rounded-circle d-flex align-items-center justify-content-center flex-shrink-0" style="width: 40px; height: 40px;">
                        <i class='bx bxs-user-plus'></i>
                    </div>
                    <div>
                        <p class="mb-0 fw-bold">{{ $eleve->prenom }} {{ $eleve->nom }}</p>
                        <p class="mb-0 text-muted small">Affecté à : <strong>{{ $eleve->classe->nom ?? 'N/A' }}</strong></p>
                        <small class="text-muted opacity-75">{{ $eleve->created_at->diffForHumans() }}</small>
                    </div>
                </div>
                @empty
                <div class="text-center py-5">
                    <p class="text-muted small">Aucune inscription récente</p>
                </div>
                @endforelse
            </div>
            
            <div class="mt-auto">
                <a href="{{ route('eleves.create') }}" class="btn btn-outline-primary w-100 btn-sm">Nouvelle Inscription</a>
            </div>
        </div>
    </div>
</div>
@endsection
