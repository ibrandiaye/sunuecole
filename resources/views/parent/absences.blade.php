@extends('layouts.app')

@section('title', 'Absences & Retards')
@section('page_title', 'Absences & Retards')

@section('content')
<div class="container-fluid p-0">
    @include('parent.components.enfant_selector')

    @if(!$enfantActif)
        <div class="card p-5 text-center border-0 shadow-sm rounded-4">
            <h5 class="fw-bold">Aucun enfant sélectionné</h5>
        </div>
    @else
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h4 class="fw-bold mb-1">Historique des Absences &bull; {{ $enfantActif->prenom }} {{ $enfantActif->nom }}</h4>
                <p class="text-muted small mb-0">Total : <strong>{{ $absences->count() }} enregistrement(s)</strong></p>
            </div>
        </div>

        <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0 datatable">
                        <thead class="bg-light">
                            <tr>
                                <th class="ps-4">Date</th>
                                <th>Créneau Horaires</th>
                                <th>Matière</th>
                                <th>Type</th>
                                <th>Motif</th>
                                <th class="text-end pe-4">Statut</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($absences as $abs)
                                <tr>
                                    <td class="ps-4">
                                        <strong>{{ \Carbon\Carbon::parse($abs->date_absence)->format('d/m/Y') }}</strong>
                                    </td>
                                    <td>
                                        @if($abs->heure_debut)
                                            <span class="badge bg-light text-dark border font-monospace">
                                                {{ \Carbon\Carbon::parse($abs->heure_debut)->format('H:i') }} - {{ \Carbon\Carbon::parse($abs->heure_fin)->format('H:i') }}
                                            </span>
                                        @else
                                            <span class="text-muted small">Journée entière</span>
                                        @endif
                                    </td>
                                    <td>{{ $abs->matiere->nom ?? '—' }}</td>
                                    <td>
                                        <span class="badge {{ $abs->type == 'retard' ? 'bg-warning text-dark' : 'bg-danger' }}">
                                            {{ ucfirst($abs->type ?? 'absence') }}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="text-muted small">{{ $abs->motif ?? 'Aucun motif renseigné' }}</span>
                                    </td>
                                    <td class="text-end pe-4">
                                        <span class="badge {{ $abs->justifie ? 'bg-success bg-opacity-10 text-success' : 'bg-danger bg-opacity-10 text-danger' }} rounded-pill px-3 py-1">
                                            {{ $abs->justifie ? 'Justifiée' : 'Non justifiée' }}
                                        </span>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="6" class="text-center py-5 text-muted">
                                        <i class='bx bx-check-shield fs-2 d-block mb-2 text-success opacity-75'></i>
                                        Félicitations ! Aucune absence ni retard enregistré.
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
