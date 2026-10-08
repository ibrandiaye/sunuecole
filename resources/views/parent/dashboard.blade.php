@extends('layouts.app')

@section('title', 'Tableau de bord Parent')
@section('page_title', 'Espace Parent')

@section('content')
<div class="container-fluid p-0">
    <!-- Header Welcome -->
    <div class="card border-0 shadow-sm rounded-4 mb-4 text-white p-4 overflow-hidden position-relative" style="background: linear-gradient(135deg, #10b981 0%, #059669 100%);">
        <div class="d-flex align-items-center gap-3 position-relative" style="z-index: 2;">
            <div class="rounded-circle bg-white bg-opacity-20 d-flex align-items-center justify-content-center text-white fw-bold fs-2" style="width: 60px; height: 60px;">
                {{ strtoupper(substr(auth()->user()->name, 0, 1)) }}
            </div>
            <div>
                <h4 class="fw-bold mb-1">Bienvenue, {{ auth()->user()->name }}</h4>
                <p class="mb-0 text-white-50 small">
                    Espace Famille &bull; {{ $enfants->count() }} enfant(s) inscrit(s)
                </p>
            </div>
        </div>
    </div>

    @if($enfants->isEmpty())
        <div class="card p-5 text-center border-0 shadow-sm rounded-4">
            <div class="mb-3">
                <i class='bx bx-user-x text-muted' style="font-size: 4rem;"></i>
            </div>
            <h5 class="fw-bold">Aucun enfant rattaché</h5>
            <p class="text-muted small">Aucun dossier élève n'est actuellement rattaché à votre compte parent.<br>Veuillez contacter le secrétariat de l'école pour mettre à jour votre fiche.</p>
        </div>
    @else
        <!-- Sélecteur d'enfant actif si plusieurs enfants -->
        @include('parent.components.enfant_selector')

        @if($enfantActif)
            <!-- Fiche synthétique de l'enfant actif -->
            <div class="card border-0 shadow-sm rounded-4 p-4 mb-4 bg-white">
                <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
                    <div class="d-flex align-items-center gap-3">
                        <div class="rounded-4 bg-primary bg-opacity-10 text-primary p-3 d-flex align-items-center justify-content-center fw-bold fs-3" style="width: 56px; height: 56px;">
                            {{ strtoupper(substr($enfantActif->prenom, 0, 1)) }}{{ strtoupper(substr($enfantActif->nom, 0, 1)) }}
                        </div>
                        <div>
                            <h4 class="fw-bold mb-0 text-dark">{{ $enfantActif->prenom }} {{ $enfantActif->nom }}</h4>
                            <div class="text-muted small d-flex flex-wrap gap-2 mt-1">
                                <span class="badge bg-light text-dark border font-monospace">Matricule: {{ $enfantActif->matricule }}</span>
                                <span class="badge bg-primary bg-opacity-10 text-primary">Classe: {{ $enfantActif->classe->nom ?? 'N/A' }}</span>
                                <span class="badge bg-secondary bg-opacity-10 text-secondary">{{ $enfantActif->classe->niveau->nom ?? 'N/A' }}</span>
                            </div>
                        </div>
                    </div>
                    <div class="d-flex gap-2">
                        <a href="{{ route('parent.notes', ['enfant_id' => $enfantActif->id]) }}" class="btn btn-outline-primary btn-sm rounded-3">
                            <i class='bx bx-award me-1'></i> Ses Notes
                        </a>
                        <a href="{{ route('parent.planning', ['enfant_id' => $enfantActif->id]) }}" class="btn btn-outline-success btn-sm rounded-3">
                            <i class='bx bx-calendar me-1'></i> Emploi du temps
                        </a>
                        <a href="{{ route('parent.paiements', ['enfant_id' => $enfantActif->id]) }}" class="btn btn-primary btn-sm rounded-3">
                            <i class='bx bx-credit-card me-1'></i> Suivi Scolarité
                        </a>
                    </div>
                </div>
            </div>

            <!-- Statistiques rapides -->
            <div class="row g-3 mb-4">
                <div class="col-6 col-md-3">
                    <div class="card border-0 shadow-sm rounded-4 p-3 text-center h-100">
                        <div class="text-warning fs-2 mb-1"><i class='bx bxs-award'></i></div>
                        <h3 class="fw-bold mb-0 text-dark">
                            {{ $stats['moyenne_generale'] ? number_format($stats['moyenne_generale'], 2) . '/20' : '—' }}
                        </h3>
                        <small class="text-muted fw-semibold">Moyenne générale</small>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="card border-0 shadow-sm rounded-4 p-3 text-center h-100">
                        <div class="text-danger fs-2 mb-1"><i class='bx bxs-user-x'></i></div>
                        <h3 class="fw-bold mb-0 text-danger">{{ $enfantActif->absences()->count() }}</h3>
                        <small class="text-muted fw-semibold">Absence(s) & Retard(s)</small>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="card border-0 shadow-sm rounded-4 p-3 text-center h-100">
                        <div class="text-info fs-2 mb-1"><i class='bx bxs-envelope'></i></div>
                        <h3 class="fw-bold mb-0 text-info">{{ $enfantActif->convocations()->count() }}</h3>
                        <small class="text-muted fw-semibold">Convocation(s)</small>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="card border-0 shadow-sm rounded-4 p-3 text-center h-100">
                        <div class="text-success fs-2 mb-1"><i class='bx bxs-credit-card'></i></div>
                        @php
                            $moisPayes = $stats['suivi_paiement']['mensualites']['mois_payes'] ?? 0;
                            $moisTotal = $stats['suivi_paiement']['mensualites']['mois_total'] ?? 9;
                        @endphp
                        <h3 class="fw-bold mb-0 text-success">{{ $moisPayes }}/{{ $moisTotal }}</h3>
                        <small class="text-muted fw-semibold">Mensualités réglées</small>
                    </div>
                </div>
            </div>

            <!-- Grille Notes récentes & Absences récentes -->
            <div class="row g-4 mb-4">
                <div class="col-lg-6">
                    <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="fw-bold mb-0"><i class='bx bx-award text-warning me-2'></i>Dernières Notes</h5>
                            <a href="{{ route('parent.notes', ['enfant_id' => $enfantActif->id]) }}" class="small fw-bold text-decoration-none">Toutes les notes</a>
                        </div>
                        <div class="list-group list-group-flush">
                            @forelse($stats['notes_recentes'] as $note)
                                <div class="list-group-item px-0 py-2 d-flex justify-content-between align-items-center border-bottom">
                                    <div>
                                        <div class="fw-bold text-dark">{{ $note->matiere->nom ?? 'Matière' }}</div>
                                        <small class="text-muted">
                                            {{ ucfirst($note->type_evaluation) }} &bull; {{ $note->date_evaluation ? \Carbon\Carbon::parse($note->date_evaluation)->format('d/m/Y') : '' }}
                                        </small>
                                    </div>
                                    <span class="badge {{ $note->valeur >= 10 ? 'bg-success' : 'bg-danger' }} fs-6 rounded-pill px-3 py-1 font-monospace">
                                        {{ number_format($note->valeur, 2) }}/20
                                    </span>
                                </div>
                            @empty
                                <div class="text-center py-4 text-muted small">
                                    Aucune note enregistrée récemment.
                                </div>
                            @endforelse
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="fw-bold mb-0"><i class='bx bx-time-five text-danger me-2'></i>Dernières Absences</h5>
                            <a href="{{ route('parent.absences', ['enfant_id' => $enfantActif->id]) }}" class="small fw-bold text-decoration-none">Tout voir</a>
                        </div>
                        <div class="list-group list-group-flush">
                            @forelse($stats['absences_recentes'] as $abs)
                                <div class="list-group-item px-0 py-2 d-flex justify-content-between align-items-center border-bottom">
                                    <div>
                                        <div class="fw-bold text-dark">{{ \Carbon\Carbon::parse($abs->date_absence)->format('d/m/Y') }}</div>
                                        <small class="text-muted">{{ $abs->matiere->nom ?? 'Cours' }} &bull; {{ $abs->motif ?? 'Non précisé' }}</small>
                                    </div>
                                    <span class="badge {{ $abs->justifie ? 'bg-success bg-opacity-10 text-success' : 'bg-danger bg-opacity-10 text-danger' }} rounded-pill px-3 py-1">
                                        {{ $abs->justifie ? 'Justifiée' : 'Non justifiée' }}
                                    </span>
                                </div>
                            @empty
                                <div class="text-center py-4 text-muted small">
                                    <i class='bx bx-check-circle fs-3 text-success d-block mb-1'></i>
                                    Aucune absence signalée récemment.
                                </div>
                            @endforelse
                        </div>
                    </div>
                </div>
            </div>

            <!-- Aperçu Situation Financière -->
            @if($stats['suivi_paiement'])
                <div class="card border-0 shadow-sm rounded-4 p-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold mb-0"><i class='bx bx-wallet text-success me-2'></i>Aperçu Scolarité & Règlement</h5>
                        <a href="{{ route('parent.paiements', ['enfant_id' => $enfantActif->id]) }}" class="small fw-bold text-decoration-none">Détail financier</a>
                    </div>
                    <div class="row g-3 align-items-center">
                        <div class="col-md-4">
                            <div class="p-3 rounded-3 bg-light">
                                <small class="text-muted d-block mb-1">Inscription :</small>
                                <span class="badge {{ $stats['suivi_paiement']['inscription']['statut'] === 'paye' ? 'bg-success' : 'bg-warning text-dark' }} px-3 py-2 rounded-pill">
                                    {{ ucfirst($stats['suivi_paiement']['inscription']['statut']) }}
                                </span>
                                <span class="ms-2 fw-bold">{{ number_format($stats['suivi_paiement']['inscription']['montant_paye'], 0, ',', ' ') }} FCFA</span>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="p-3 rounded-3 bg-light">
                                <small class="text-muted d-block mb-1">Mensualités ({{ $moisPayes }}/{{ $moisTotal }} réglées) :</small>
                                <strong class="text-success">{{ number_format($stats['suivi_paiement']['mensualites']['total_paye'], 0, ',', ' ') }} FCFA</strong> payés
                                <span class="text-muted small">/ {{ number_format($stats['suivi_paiement']['mensualites']['total_du'], 0, ',', ' ') }} FCFA</span>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="p-3 rounded-3 bg-light">
                                <small class="text-muted d-block mb-1">Reste total à solder :</small>
                                <strong class="{{ $stats['suivi_paiement']['mensualites']['reste_total'] > 0 ? 'text-danger' : 'text-success' }} fs-5">
                                    {{ number_format($stats['suivi_paiement']['mensualites']['reste_total'], 0, ',', ' ') }} FCFA
                                </strong>
                            </div>
                        </div>
                    </div>
                </div>
            @endif
        @endif
    @endif
</div>
@endsection
