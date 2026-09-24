@extends('layouts.app')
@section('title', 'Synthèse Globale')
@section('content')
<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="h3 mb-0 text-gray-800"><i class='bx bx-pie-chart-alt-2 text-primary me-2'></i> Tableau de Bord de Synthèse</h2>
        <button class="btn btn-outline-primary" onclick="window.print()">
            <i class='bx bx-printer'></i> Imprimer
        </button>
    </div>

    <!-- SCOLARITE -->
    <h5 class="fw-bold mb-3 text-secondary border-bottom pb-2">Scolarité & Pédagogie</h5>
    <div class="row mb-4">
        <div class="col-md-4 mb-3">
            <div class="card border-0 shadow-sm border-start border-primary border-4">
                <div class="card-body">
                    <div class="text-xs fw-bold text-primary text-uppercase mb-1">Élèves Inscrits</div>
                    <div class="h3 mb-0 fw-bold text-gray-800">{{ $statsScolarite['eleves_actifs'] }}</div>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card border-0 shadow-sm border-start border-info border-4">
                <div class="card-body">
                    <div class="text-xs fw-bold text-info text-uppercase mb-1">Inscriptions ({{ $anneeActive ? $anneeActive->nom : 'N/A' }})</div>
                    <div class="h3 mb-0 fw-bold text-gray-800">{{ $statsScolarite['inscriptions_annee'] }}</div>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card border-0 shadow-sm border-start border-success border-4">
                <div class="card-body">
                    <div class="text-xs fw-bold text-success text-uppercase mb-1">Classes</div>
                    <div class="h3 mb-0 fw-bold text-gray-800">{{ $statsScolarite['total_classes'] }}</div>
                </div>
            </div>
        </div>
    </div>

    <!-- RH & LOGISTIQUE -->
    <div class="row mb-4">
        <div class="col-md-6">
            <h5 class="fw-bold mb-3 text-secondary border-bottom pb-2">Ressources Humaines</h5>
            <div class="row">
                <div class="col-6 mb-3">
                    <div class="card bg-light border-0 shadow-sm text-center py-3">
                        <i class='bx bxs-graduation text-primary fs-1 mb-2'></i>
                        <h4 class="fw-bold mb-0">{{ $statsRH['total_enseignants'] }}</h4>
                        <span class="text-muted small">Enseignants</span>
                    </div>
                </div>
                <div class="col-6 mb-3">
                    <div class="card bg-light border-0 shadow-sm text-center py-3">
                        <i class='bx bxs-user-detail text-secondary fs-1 mb-2'></i>
                        <h4 class="fw-bold mb-0">{{ $statsRH['total_personnels'] }}</h4>
                        <span class="text-muted small">Personnel Administratif</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <h5 class="fw-bold mb-3 text-secondary border-bottom pb-2">Logistique (Cantine & Transport)</h5>
            <div class="row">
                <div class="col-6 mb-3">
                    <div class="card bg-light border-0 shadow-sm text-center py-3">
                        <i class='bx bx-restaurant text-warning fs-1 mb-2'></i>
                        <h4 class="fw-bold mb-0">{{ $statsLogistique['abonnes_cantine'] }}</h4>
                        <span class="text-muted small">Abonnés Cantine</span>
                    </div>
                </div>
                <div class="col-6 mb-3">
                    <div class="card bg-light border-0 shadow-sm text-center py-3">
                        <i class='bx bx-bus text-success fs-1 mb-2'></i>
                        <h4 class="fw-bold mb-0">{{ $statsLogistique['abonnes_transport'] }}</h4>
                        <span class="text-muted small">Abonnés Transport</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- FINANCES & TRESORERIE -->
    <h5 class="fw-bold mb-3 text-secondary border-bottom pb-2">Finances & Trésorerie</h5>
    <div class="row mb-4">
        <div class="col-md-4 mb-3">
            <div class="card border-0 shadow-sm bg-primary text-white h-100 py-2 rounded-4">
                <div class="card-body text-center">
                    <p class="text-uppercase small fw-bold mb-1 opacity-75">Encaissements Globaux</p>
                    <h3 class="fw-bold mb-0">{{ number_format($totalPaiements, 0, ',', ' ') }} <small class="fs-6">FCFA</small></h3>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card border-0 shadow-sm bg-success text-white h-100 py-2 rounded-4">
                <div class="card-body text-center">
                    <p class="text-uppercase small fw-bold mb-1 opacity-75">Solde Trésorerie (Tous Comptes)</p>
                    <h3 class="fw-bold mb-0">{{ number_format($statsBanque['solde_global'], 0, ',', ' ') }} <small class="fs-6">FCFA</small></h3>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-header bg-white border-0 pt-3 pb-0 fw-bold">Détail des soldes</div>
                <div class="card-body py-2">
                    <ul class="list-group list-group-flush">
                        @foreach($statsBanque['comptes'] as $c)
                        <li class="list-group-item d-flex justify-content-between align-items-center px-0 py-1 border-0">
                            <span class="small">{{ $c['nom'] }}</span>
                            <span class="fw-bold {{ $c['solde'] >= 0 ? 'text-success' : 'text-danger' }}">{{ number_format($c['solde'], 0, ',', ' ') }} F</span>
                        </li>
                        @endforeach
                        @if(empty($statsBanque['comptes']))
                        <li class="list-group-item px-0 py-1 border-0 text-muted small">Aucun compte bancaire.</li>
                        @endif
                    </ul>
                </div>
            </div>
        </div>
    </div>

</div>
@endsection