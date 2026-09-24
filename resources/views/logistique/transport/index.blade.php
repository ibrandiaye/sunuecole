@extends('layouts.app')
@section('title', 'Transport Scolaire')
@section('content')
<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="h3 mb-0 text-gray-800"><i class='bx bx-bus text-primary me-2'></i> Abonnements Transport</h2>
        <div>
            <a href="{{ route('zone_transports.index') }}" class="btn btn-outline-secondary px-3 me-2">
                <i class='bx bx-map-alt'></i> Zones de Transport
            </a>
            <button class="btn btn-primary px-4" data-bs-toggle="modal" data-bs-target="#addTransportModal">
                <i class='bx bx-plus'></i> Nouvel Abonnement
            </button>
        </div>
    </div>

    <div class="card shadow-sm border-0">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover align-middle datatable">
                    <thead class="table-light">
                        <tr>
                            <th>Élève</th>
                            <th>Classe</th>
                            <th>Zone / Circuit</th>
                            <th>Date de début</th>
                            <th>Statut</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($abonnements as $ab)
                        <tr>
                            <td class="fw-bold">{{ $ab->eleve->prenom }} {{ $ab->eleve->nom }}</td>
                            <td>{{ $ab->eleve->classe->nom ?? '-' }}</td>
                            <td>{{ $ab->zoneTransport->nom ?? 'Non défini' }}</td>
                            <td>{{ \Carbon\Carbon::parse($ab->date_debut)->format('d/m/Y') }}</td>
                            <td>
                                @if($ab->actif)
                                    <span class="badge bg-success">Actif</span>
                                @else
                                    <span class="badge bg-danger">Inactif</span>
                                @endif
                            </td>
                            <td class="text-end">
                                <form action="{{ route('abonnement_transports.destroy', $ab) }}" method="POST" onsubmit="return confirm('Supprimer cet abonnement ?');">
                                    @csrf @method('DELETE')
                                    <button type="submit" class="btn btn-sm btn-danger rounded-circle"><i class='bx bx-trash'></i></button>
                                </form>
                            </td>
                        </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="addTransportModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <form action="{{ route('abonnement_transports.store') }}" method="POST">
                @csrf
                <div class="modal-header border-0 pb-0">
                    <h5 class="modal-title fw-bold">Nouvel Abonnement Transport</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body py-4">
                    <div class="mb-3">
                        <label class="form-label">Élève</label>
                        <select name="eleve_id" class="form-select select2" required>
                            <option value="">Sélectionner un élève...</option>
                            @foreach($eleves as $eleve)
                                <option value="{{ $eleve->id }}">{{ $eleve->prenom }} {{ $eleve->nom }} ({{ $eleve->classe->nom ?? 'Sans classe' }})</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Zone de transport (Circuit)</label>
                        <select name="zone_transport_id" class="form-select" required>
                            @if($zones->isEmpty())
                                <option value="">Aucune zone configurée...</option>
                            @else
                                <option value="">Sélectionner une zone...</option>
                                @foreach($zones as $zone)
                                    <option value="{{ $zone->id }}">{{ $zone->nom }}</option>
                                @endforeach
                            @endif
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Date de début</label>
                        <input type="date" name="date_debut" class="form-control" required value="{{ date('Y-m-d') }}">
                    </div>
                    <div class="form-check form-switch mt-3">
                        <input class="form-check-input" type="checkbox" name="actif" value="1" checked>
                        <label class="form-check-label fw-bold text-success">Abonnement Actif</label>
                    </div>
                </div>
                <div class="modal-footer border-0 bg-light rounded-bottom-3">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-primary px-4 shadow-sm">Enregistrer</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection