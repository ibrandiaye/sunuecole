@extends('layouts.app')

@section('title', 'Mon Emploi du Temps')
@section('page_title', 'Mon Emploi du Temps')

@section('content')
<div class="container-fluid p-0">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h4 class="fw-bold mb-1">Emploi du temps de la classe</h4>
            <p class="text-muted small mb-0">
                Classe : <strong>{{ $eleve->classe->nom ?? 'N/A' }}</strong> &bull; Année scolaire en cours
            </p>
        </div>
        <button class="btn btn-outline-secondary btn-sm rounded-3" onclick="window.print();">
            <i class='bx bx-printer me-1'></i> Imprimer
        </button>
    </div>

    <div class="row g-4">
        @foreach($jours as $jour)
            @php
                $coursDuJour = $emplois->get($jour, collect());
            @endphp
            <div class="col-md-6 col-xl-4">
                <div class="card h-100 shadow-sm border-0 rounded-4 overflow-hidden">
                    <div class="card-header bg-primary bg-opacity-10 py-3 px-4 border-0 d-flex justify-content-between align-items-center">
                        <h6 class="fw-bold mb-0 text-primary">
                            <i class='bx bx-calendar-event me-2'></i>{{ $jour }}
                        </h6>
                        <span class="badge bg-white text-primary border rounded-pill px-2">
                            {{ $coursDuJour->count() }} cours
                        </span>
                    </div>
                    <div class="card-body p-3">
                        @forelse($coursDuJour as $item)
                            <div class="p-3 mb-2 rounded-3 bg-light border-start border-4 border-primary">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <span class="badge bg-primary text-white font-monospace small">
                                        {{ \Carbon\Carbon::parse($item->heure_debut)->format('H:i') }} - {{ \Carbon\Carbon::parse($item->heure_fin)->format('H:i') }}
                                    </span>
                                    @if($item->salle)
                                        <small class="text-muted"><i class='bx bx-door-open me-1'></i>{{ $item->salle->nom }}</small>
                                    @endif
                                </div>
                                <div class="fw-bold text-dark mt-2">{{ $item->matiere->nom ?? 'Matière' }}</div>
                                <div class="text-muted small">
                                    <i class='bx bx-user me-1'></i>Prof. : {{ $item->enseignant?->user?->name ?? 'Enseignant' }}
                                </div>
                            </div>
                        @empty
                            <div class="text-center py-4 text-muted small">
                                <i class='bx bx-coffee fs-3 d-block mb-1 text-secondary opacity-50'></i>
                                Aucun cours prévu ce jour.
                            </div>
                        @endforelse
                    </div>
                </div>
            </div>
        @endforeach
    </div>
</div>
@endsection
