@extends('layouts.app')

@section('title', 'Historique des Absences')
@section('page_title', 'Historique des Présences & Absences')

@section('content')
<div class="container-fluid p-0">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h4 class="fw-bold mb-1">Historique des Absences & Retards</h4>
            <p class="text-muted small mb-0">Consultez l'historique d'assiduité enregistré pour vos classes.</p>
        </div>
        <div class="d-flex gap-2">
            <a href="{{ route('professeur.absences.index') }}" class="btn btn-success btn-sm rounded-3">
                <i class='bx bx-user-check me-1'></i> Faire l'appel
            </a>
            <a href="{{ route('professeur.dashboard') }}" class="btn btn-outline-secondary btn-sm rounded-3">
                <i class='bx bx-arrow-back me-1'></i> Tableau de bord
            </a>
        </div>
    </div>

    <!-- Filtre par classe -->
    <div class="card border-0 shadow-sm rounded-4 p-3 mb-4 bg-white">
        <form action="{{ route('professeur.absences.historique') }}" method="GET" class="row g-2 align-items-center">
            <div class="col-md-5">
                <select name="classe_id" class="form-select rounded-3 py-2" onchange="this.form.submit()">
                    @foreach($classes as $c)
                        <option value="{{ $c->id }}" {{ $c->id == $classe_id ? 'selected' : '' }}>
                            {{ $c->nom }}
                        </option>
                    @endforeach
                </select>
            </div>
            @if($classe)
                <div class="col-md-7 text-md-end text-muted small">
                    Classe sélectionnée : <strong>{{ $classe->nom }}</strong> &bull; Total séances avec incidents : <strong>{{ $absences->count() }}</strong>
                </div>
            @endif
        </form>
    </div>

    @if(!$classe)
        <div class="card border-0 shadow-sm rounded-4 p-5 text-center bg-white">
            <p class="text-muted mb-0">Veuillez sélectionner une classe pour afficher son historique.</p>
        </div>
    @elseif($absences->isEmpty())
        <div class="card border-0 shadow-sm rounded-4 p-5 text-center bg-white">
            <div class="mb-3">
                <i class='bx bx-check-shield text-success' style="font-size: 3.5rem;"></i>
            </div>
            <h5 class="fw-bold text-dark">Aucune absence enregistrée</h5>
            <p class="text-muted small mb-0">Tous les élèves de la classe {{ $classe->nom }} ont été pointés présents lors des cours récents.</p>
        </div>
    @else
        <div class="row g-4">
            @foreach($absences as $date => $absencesDuJour)
                <div class="col-12">
                    <div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white">
                        <div class="card-header bg-light py-3 px-4 border-0 d-flex justify-content-between align-items-center">
                            <h6 class="fw-bold mb-0 text-dark">
                                <i class='bx bx-calendar me-2 text-primary'></i>{{ \Carbon\Carbon::parse($date)->format('d/m/Y') }}
                            </h6>
                            <span class="badge bg-white text-dark border rounded-pill px-3 py-1">
                                {{ $absencesDuJour->count() }} incident(s)
                            </span>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle mb-0">
                                    <thead class="bg-white">
                                        <tr class="text-muted small">
                                            <th class="ps-4">Élève</th>
                                            <th>Matière</th>
                                            <th>Créneau</th>
                                            <th>Type</th>
                                            <th class="text-end pe-4">Statut</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @foreach($absencesDuJour as $abs)
                                            <tr>
                                                <td class="ps-4">
                                                    <div class="d-flex align-items-center gap-3">
                                                        <div class="rounded-circle bg-secondary bg-opacity-10 text-secondary fw-bold d-flex align-items-center justify-content-center" style="width: 34px; height: 34px;">
                                                            {{ strtoupper(substr($abs->eleve->prenom, 0, 1)) }}
                                                        </div>
                                                        <strong class="text-dark">{{ $abs->eleve->nom }} {{ $abs->eleve->prenom }}</strong>
                                                    </div>
                                                </td>
                                                <td>{{ $abs->matiere->nom ?? '—' }}</td>
                                                <td>
                                                    <span class="badge bg-light text-dark border font-monospace">
                                                        {{ \Carbon\Carbon::parse($abs->heure_debut)->format('H:i') }} - {{ \Carbon\Carbon::parse($abs->heure_fin)->format('H:i') }}
                                                    </span>
                                                </td>
                                                <td>
                                                    <span class="badge {{ $abs->type === 'retard' ? 'bg-warning text-dark' : 'bg-danger' }} rounded-pill px-3 py-1">
                                                        {{ ucfirst($abs->type) }}
                                                    </span>
                                                </td>
                                                <td class="text-end pe-4">
                                                    <span class="badge {{ $abs->justifie ? 'bg-success bg-opacity-10 text-success' : 'bg-danger bg-opacity-10 text-danger' }} rounded-pill px-3 py-1">
                                                        {{ $abs->justifie ? 'Justifiée' : 'Non justifiée' }}
                                                    </span>
                                                </td>
                                            </tr>
                                        @endforeach
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            @endforeach
        </div>
    @endif
</div>
@endsection
