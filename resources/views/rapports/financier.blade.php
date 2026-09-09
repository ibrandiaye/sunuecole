@extends('layouts.app')

@section('title', 'Rapport Financier')
@section('page_title', 'Statistiques & Finances')

@section('content')
<div class="row">
    <!-- Filtre de période -->
    <div class="col-12 mb-4">
        <div class="card p-3 shadow-sm border-0">
            <form action="{{ route('rapports.financier') }}" method="GET" class="row g-3 align-items-end">
                <div class="col-md-3">
                    <label class="form-label fw-bold">Date Début</label>
                    <input type="date" name="date_debut" class="form-control" value="{{ $date_debut }}">
                </div>
                <div class="col-md-3">
                    <label class="form-label fw-bold">Date Fin</label>
                    <input type="date" name="date_fin" class="form-control" value="{{ $date_fin }}">
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary w-100">
                        <i class='bx bx-filter-alt me-1'></i> Filtrer
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- KPIs -->
    <div class="col-md-4 mb-4">
        <div class="card p-3 border-0 bg-primary text-white shadow">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h6 class="mb-1 opacity-75">Encaissements du Jour</h6>
                    <h3 class="fw-bold mb-0">{{ number_format($totalJournalier, 0, ',', ' ') }} FCFA</h3>
                </div>
                <div class="bg-white bg-opacity-25 p-3 rounded-circle">
                    <i class='bx bx-calendar-star fs-1'></i>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4 mb-4">
        <div class="card p-3 border-0 bg-success text-white shadow">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h6 class="mb-1 opacity-75">Total ce Mois</h6>
                    <h3 class="fw-bold mb-0">{{ number_format($totalMensuel, 0, ',', ' ') }} FCFA</h3>
                </div>
                <div class="bg-white bg-opacity-25 p-3 rounded-circle">
                    <i class='bx bx-trending-up fs-1'></i>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4 mb-4">
        <div class="card p-3 border-0 bg-dark text-white shadow">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h6 class="mb-1 opacity-75">Recue de l'Année (Active)</h6>
                    <h3 class="fw-bold mb-0">{{ number_format($totalAnnuel, 0, ',', ' ') }} FCFA</h3>
                </div>
                <div class="bg-white bg-opacity-25 p-3 rounded-circle">
                    <i class='bx bxs-bank fs-1'></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Graphiques -->
    <div class="col-md-8 mb-4">
        <div class="card p-4 shadow-sm border-0" style="height: 400px;">
            <h5 class="fw-bold mb-3"><i class='bx bx-line-chart me-2 text-primary'></i>Évolution des paiements (30j)</h5>
            <div style="flex-grow: 1; position: relative; height: 300px;">
                <canvas id="evolutionChart"></canvas>
            </div>
        </div>
    </div>
    <div class="col-md-4 mb-4">
        <div class="card p-4 shadow-sm border-0" style="height: 400px;">
            <h5 class="fw-bold mb-3"><i class='bx bx-pie-chart-alt-2 me-2 text-success'></i>Modes de Paiement</h5>
            <div style="flex-grow: 1; position: relative; height: 300px;">
                <canvas id="modeChart"></canvas>
            </div>
        </div>
    </div>

    <div class="col-md-6 mb-4">
        <div class="card p-4 shadow-sm border-0 h-100">
            <h5 class="fw-bold mb-4"><i class='bx bx-category me-2 text-warning'></i>Répartition par Rubrique</h5>
            <div class="table-responsive">
                <table class="table table-sm table-hover">
                    <thead>
                        <tr><th>Type de frais</th><th class="text-end">Montant Total</th></tr>
                    </thead>
                    <tbody>
                        @foreach($statsParType as $stat)
                        <tr>
                            <td>{{ $stat->nom }}</td>
                            <td class="text-end fw-bold">{{ number_format($stat->total, 0, ',', ' ') }} FCFA</td>
                        </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="col-md-6 mb-4">
        <div class="card p-4 shadow-sm border-0 h-100">
            <h5 class="fw-bold mb-4"><i class='bx bx-history me-2 text-primary'></i>Dernières Transactions</h5>
            <div class="table-responsive">
                <table class="table table-sm">
                    <thead>
                        <tr><th>Élève</th><th>Type</th><th class="text-end">Montant</th></tr>
                    </thead>
                    <tbody>
                        @foreach($derniersPaiements as $p)
                        <tr>
                            <td class="small">{{ $p->eleve->prenom }} {{ $p->eleve->nom }}</td>
                            <td><span class="badge bg-light text-dark border">{{ $p->typePaiement->nom }}</span></td>
                            <td class="text-end fw-bold">{{ number_format($p->montant_paye, 0, ',', ' ') }}</td>
                        </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
@endsection

@section('scripts')
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Données Evolution
    const evolutionLabels = {!! json_encode($evolutionPaiements->pluck('date')) !!};
    const evolutionData = {!! json_encode($evolutionPaiements->pluck('total')) !!};

    if (evolutionLabels.length > 0) {
        const evolutionCtx = document.getElementById('evolutionChart').getContext('2d');
        new Chart(evolutionCtx, {
            type: 'line',
            data: {
                labels: evolutionLabels,
                datasets: [{
                    label: 'Encaissements (FCFA)',
                    data: evolutionData,
                    borderColor: '#4361ee',
                    backgroundColor: 'rgba(67, 97, 238, 0.1)',
                    fill: true,
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: { legend: { display: false } },
                scales: { y: { beginAtZero: true } }
            }
        });
    }

    // Données Modes de Paiement
    const modeLabels = {!! json_encode($statsParMode->pluck('mode_paiement')) !!};
    const modeData = {!! json_encode($statsParMode->pluck('total')) !!};

    if (modeLabels.length > 0) {
        const modeCtx = document.getElementById('modeChart').getContext('2d');
        new Chart(modeCtx, {
            type: 'doughnut',
            data: {
                labels: modeLabels.map(m => m.charAt(0).toUpperCase() + m.slice(1)),
                datasets: [{
                    data: modeData,
                    backgroundColor: ['#4361ee', '#4cc9f0', '#4895ef', '#560bad', '#3f37c9']
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: { 
                    legend: { position: 'bottom' } 
                }
            }
        });
    } else {
        const modeCanvas = document.getElementById('modeChart');
        if (modeCanvas) {
            modeCanvas.parentElement.innerHTML = '<div class="text-center py-5 text-muted"><i class="bx bx-info-circle fs-1 d-block mb-2"></i>Aucune donnée</div>';
        }
    }
});
</script>
@endsection
