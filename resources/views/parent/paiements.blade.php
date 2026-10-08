@extends('layouts.app')

@section('title', 'Scolarité & Paiements')
@section('page_title', 'Suivi de la Scolarité')

@section('content')
<div class="container-fluid p-0">
    @include('parent.components.enfant_selector')

    @if(!$enfantActif || !$suivi)
        <div class="card p-5 text-center border-0 shadow-sm rounded-4">
            <h5 class="fw-bold">Aucune information financière disponible</h5>
            <p class="text-muted small">Vérifiez que l'enfant est bien inscrit pour l'année scolaire active.</p>
        </div>
    @else
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h4 class="fw-bold mb-1">Scolarité & Frais &bull; {{ $enfantActif->prenom }} {{ $enfantActif->nom }}</h4>
                <p class="text-muted small mb-0">
                    Année : <strong>{{ $suivi['annee_scolaire'] }}</strong> &bull; Classe : <strong>{{ $enfantActif->classe->nom ?? 'N/A' }}</strong>
                </p>
            </div>
            <button class="btn btn-outline-secondary btn-sm rounded-3" onclick="window.print();">
                <i class='bx bx-printer me-1'></i> Imprimer
            </button>
        </div>

        <!-- Cartes Totaux Synthétiques -->
        <div class="row g-3 mb-4">
            <div class="col-md-4">
                <div class="card border-0 shadow-sm rounded-4 p-3 bg-white h-100 border-start border-4 border-primary">
                    <small class="text-muted fw-bold text-uppercase">Total Scolarité Dû</small>
                    <h3 class="fw-bold mb-0 text-primary">{{ number_format($suivi['total_general_du'], 0, ',', ' ') }} FCFA</h3>
                    <small class="text-muted">Inscription + 9 mensualités + options</small>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm rounded-4 p-3 bg-white h-100 border-start border-4 border-success">
                    <small class="text-muted fw-bold text-uppercase">Total Déjà Réglé</small>
                    <h3 class="fw-bold mb-0 text-success">{{ number_format($suivi['total_general_paye'], 0, ',', ' ') }} FCFA</h3>
                    <small class="text-muted">{{ $suivi['mensualites']['mois_payes'] }} mensualité(s) soldée(s)</small>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm rounded-4 p-3 bg-white h-100 border-start border-4 {{ ($suivi['total_general_du'] - $suivi['total_general_paye']) > 0 ? 'border-danger' : 'border-success' }}">
                    <small class="text-muted fw-bold text-uppercase">Reste à Solder</small>
                    <h3 class="fw-bold mb-0 {{ ($suivi['total_general_du'] - $suivi['total_general_paye']) > 0 ? 'text-danger' : 'text-success' }}">
                        {{ number_format(max(0, $suivi['total_general_du'] - $suivi['total_general_paye']), 0, ',', ' ') }} FCFA
                    </h3>
                    <small class="text-muted">Solde restant à régler</small>
                </div>
            </div>
        </div>

        <!-- 1. Frais d'Inscription -->
        <div class="card border-0 shadow-sm rounded-4 p-4 mb-4 bg-white">
            <div class="d-flex justify-content-between align-items-center mb-2">
                <h5 class="fw-bold mb-0"><i class='bx bx-id-card text-primary me-2'></i>Frais d'Inscription</h5>
                @php $inscr = $suivi['inscription']; @endphp
                <span class="badge {{ $inscr['statut'] === 'paye' ? 'bg-success' : ($inscr['statut'] === 'partiel' ? 'bg-warning text-dark' : 'bg-danger') }} rounded-pill px-3 py-2">
                    {{ strtoupper($inscr['statut']) }}
                </span>
            </div>
            <div class="row g-3 pt-2">
                <div class="col-6 col-md-3">
                    <small class="text-muted d-block">Montant Dû</small>
                    <strong class="fs-6">{{ number_format($inscr['montant_du'], 0, ',', ' ') }} FCFA</strong>
                </div>
                <div class="col-6 col-md-3">
                    <small class="text-muted d-block">Montant Payé</small>
                    <strong class="text-success fs-6">{{ number_format($inscr['montant_paye'], 0, ',', ' ') }} FCFA</strong>
                </div>
                <div class="col-6 col-md-3">
                    <small class="text-muted d-block">Reste</small>
                    <strong class="{{ $inscr['reste'] > 0 ? 'text-danger' : 'text-success' }} fs-6">{{ number_format($inscr['reste'], 0, ',', ' ') }} FCFA</strong>
                </div>
                <div class="col-6 col-md-3">
                    <small class="text-muted d-block">Date & Réf.</small>
                    <span class="small">{{ $inscr['date_paiement'] ?? '—' }} ({{ $inscr['reference'] ?? '—' }})</span>
                </div>
            </div>
        </div>

        <!-- 2. Suivi des 9 Mensualités -->
        <div class="card border-0 shadow-sm rounded-4 overflow-hidden mb-4">
            <div class="card-header bg-white py-3 px-4 border-0 d-flex justify-content-between align-items-center">
                <h5 class="fw-bold mb-0"><i class='bx bx-calendar text-success me-2'></i>Mensualités Scolaires (9 Mois)</h5>
                <span class="badge bg-success bg-opacity-10 text-success rounded-pill px-3 py-1">
                    {{ $suivi['mensualites']['mois_payes'] }} / {{ $suivi['mensualites']['mois_total'] }} mois réglés
                </span>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="bg-light">
                            <tr>
                                <th class="ps-4">Mois</th>
                                <th>Montant Dû</th>
                                <th>Montant Payé</th>
                                <th>Reste</th>
                                <th>Date Règlement</th>
                                <th>Référence</th>
                                <th class="text-end pe-4">Statut</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($suivi['mensualites']['detail'] as $m)
                                <tr>
                                    <td class="ps-4">
                                        <strong>{{ $m['mois_label'] }}</strong>
                                    </td>
                                    <td>{{ number_format($m['montant_du'], 0, ',', ' ') }} FCFA</td>
                                    <td class="text-success fw-bold">{{ number_format($m['montant_paye'], 0, ',', ' ') }} FCFA</td>
                                    <td class="{{ $m['reste'] > 0 ? 'text-danger' : 'text-muted' }} fw-bold">
                                        {{ number_format($m['reste'], 0, ',', ' ') }} FCFA
                                    </td>
                                    <td>{{ $m['date_paiement'] ?? '—' }}</td>
                                    <td class="font-monospace small">{{ $m['reference'] ?? '—' }}</td>
                                    <td class="text-end pe-4">
                                        @if($m['statut'] === 'paye')
                                            <span class="badge bg-success rounded-pill px-3 py-1"><i class='bx bx-check me-1'></i>Payé</span>
                                        @elseif($m['statut'] === 'partiel')
                                            <span class="badge bg-warning text-dark rounded-pill px-3 py-1">Partiel</span>
                                        @else
                                            <span class="badge bg-danger bg-opacity-10 text-danger rounded-pill px-3 py-1">Impayé</span>
                                        @endif
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- 3. Cantine & Transport si souscrits -->
        @if($suivi['cantine'] || $suivi['transport'])
            <div class="row g-4 mb-4">
                @if($suivi['cantine'])
                    <div class="col-md-6">
                        <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                            <h5 class="fw-bold mb-3"><i class='bx bx-restaurant text-warning me-2'></i>Abonnement Cantine</h5>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Tarif mensuel :</span>
                                <strong>{{ number_format($suivi['cantine']['tarif_mensuel'], 0, ',', ' ') }} FCFA</strong>
                            </div>
                            <div class="d-flex justify-content-between mb-3">
                                <span class="text-muted">Mois réglés :</span>
                                <span class="badge bg-success px-3 py-1 rounded-pill">{{ $suivi['cantine']['mois_payes'] }} / {{ $suivi['cantine']['mois_total'] }} mois</span>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-sm align-middle">
                                    <tbody>
                                        @foreach($suivi['cantine']['detail'] as $c)
                                            <tr>
                                                <td>{{ $c['mois_label'] }}</td>
                                                <td class="text-end">
                                                    <span class="badge {{ $c['statut'] === 'paye' ? 'bg-success' : 'bg-light text-muted border' }}">
                                                        {{ ucfirst($c['statut']) }}
                                                    </span>
                                                </td>
                                            </tr>
                                        @endforeach
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                @endif

                @if($suivi['transport'])
                    <div class="col-md-6">
                        <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                            <h5 class="fw-bold mb-3"><i class='bx bx-bus text-info me-2'></i>Abonnement Transport</h5>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Tarif mensuel :</span>
                                <strong>{{ number_format($suivi['transport']['tarif_mensuel'], 0, ',', ' ') }} FCFA</strong>
                            </div>
                            <div class="d-flex justify-content-between mb-3">
                                <span class="text-muted">Mois réglés :</span>
                                <span class="badge bg-success px-3 py-1 rounded-pill">{{ $suivi['transport']['mois_payes'] }} / {{ $suivi['transport']['mois_total'] }} mois</span>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-sm align-middle">
                                    <tbody>
                                        @foreach($suivi['transport']['detail'] as $t)
                                            <tr>
                                                <td>{{ $t['mois_label'] }}</td>
                                                <td class="text-end">
                                                    <span class="badge {{ $t['statut'] === 'paye' ? 'bg-success' : 'bg-light text-muted border' }}">
                                                        {{ ucfirst($t['statut']) }}
                                                    </span>
                                                </td>
                                            </tr>
                                        @endforeach
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                @endif
            </div>
        @endif

        <!-- 4. Historique des Reçus de Paiement -->
        <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
            <div class="card-header bg-white py-3 px-4 border-0">
                <h5 class="fw-bold mb-0"><i class='bx bx-receipt text-primary me-2'></i>Historique des Règlements & Reçus</h5>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="bg-light">
                            <tr>
                                <th class="ps-4">Référence</th>
                                <th>Date</th>
                                <th>Type de Frais</th>
                                <th>Montant Payé</th>
                                <th>Mode de Règlement</th>
                                <th class="text-end pe-4">Reçu</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($suivi['historique_paiements'] as $paiement)
                                <tr>
                                    <td class="ps-4 font-monospace fw-bold">{{ $paiement->reference }}</td>
                                    <td>{{ $paiement->date_paiement ? \Carbon\Carbon::parse($paiement->date_paiement)->format('d/m/Y') : '—' }}</td>
                                    <td>
                                        <span class="badge bg-secondary bg-opacity-10 text-secondary border">
                                            {{ $paiement->typePaiement->nom ?? ($paiement->type ?? 'Frais scolaire') }}
                                        </span>
                                    </td>
                                    <td class="text-success fw-bold">{{ number_format($paiement->montant_paye, 0, ',', ' ') }} FCFA</td>
                                    <td>{{ ucfirst($paiement->mode_paiement ?? 'Espèces') }}</td>
                                    <td class="text-end pe-4">
                                        <a href="{{ route('paiements.receipt', $paiement->id) }}" target="_blank" class="btn btn-outline-primary btn-sm rounded-3">
                                            <i class='bx bx-printer me-1'></i> Reçu
                                        </a>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="6" class="text-center py-4 text-muted">
                                        Aucun reçu enregistré pour le moment.
                                    </td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    @endif
</div>
@endsection
