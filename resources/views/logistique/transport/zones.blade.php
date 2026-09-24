@extends('layouts.app')
@section('title', 'Gestion des Zones de Transport')
@section('content')
<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="h3 mb-0 text-gray-800"><i class='bx bx-map-alt text-primary me-2'></i> Zones & Tarifs de Transport</h2>
        <div>
            <a href="{{ route('abonnement_transports.index') }}" class="btn btn-outline-secondary px-3 me-2">
                <i class='bx bx-arrow-back'></i> Retour aux abonnements
            </a>
            <button class="btn btn-primary px-4" data-bs-toggle="modal" data-bs-target="#addZoneModal">
                <i class='bx bx-plus'></i> Ajouter une Zone
            </button>
        </div>
    </div>

    <div class="card shadow-sm border-0">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Nom de la Zone / Circuit</th>
                            <th>Tarif Mensuel (FCFA)</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($zones as $zone)
                        <tr>
                            <td class="fw-bold">{{ $zone->nom }}</td>
                            <td><span class="badge bg-success fs-6">{{ number_format($zone->tarif_mensuel, 0, ',', ' ') }} FCFA</span></td>
                            <td class="text-end">
                                <button class="btn btn-sm btn-light text-primary rounded-circle me-1" data-bs-toggle="modal" data-bs-target="#editZoneModal{{ $zone->id }}">
                                    <i class='bx bx-edit'></i>
                                </button>
                                <form action="{{ route('zone_transports.destroy', $zone) }}" method="POST" class="d-inline" onsubmit="return confirm('Êtes-vous sûr de vouloir supprimer cette zone ?');">
                                    @csrf @method('DELETE')
                                    <button type="submit" class="btn btn-sm btn-light text-danger rounded-circle"><i class='bx bx-trash'></i></button>
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

@foreach($zones as $zone)
<!-- Modal Edit Zone -->
<div class="modal fade" id="editZoneModal{{ $zone->id }}" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <form action="{{ route('zone_transports.update', $zone) }}" method="POST">
                @csrf @method('PUT')
                <div class="modal-header border-0 pb-0">
                    <h5 class="modal-title fw-bold">Modifier la Zone</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body py-4 text-start">
                    <div class="mb-3">
                        <label class="form-label">Nom de la Zone</label>
                        <input type="text" name="nom" class="form-control" required value="{{ $zone->nom }}">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Tarif Mensuel (FCFA)</label>
                        <input type="number" name="tarif_mensuel" class="form-control" required min="0" value="{{ $zone->tarif_mensuel }}">
                    </div>
                </div>
                <div class="modal-footer border-0 bg-light rounded-bottom-3">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-primary px-4 shadow-sm">Mettre à jour</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endforeach

<!-- Modal Add Zone -->
<div class="modal fade" id="addZoneModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <form action="{{ route('zone_transports.store') }}" method="POST">
                @csrf
                <div class="modal-header border-0 pb-0">
                    <h5 class="modal-title fw-bold">Ajouter une Zone</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body py-4">
                    <div class="mb-3">
                        <label class="form-label">Nom de la Zone / Circuit</label>
                        <input type="text" name="nom" class="form-control" required placeholder="ex: Parcelles Assainies, Plateau...">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Tarif Mensuel (FCFA)</label>
                        <input type="number" name="tarif_mensuel" class="form-control" required min="0" placeholder="ex: 15000">
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