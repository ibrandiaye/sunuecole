@extends('layouts.app')

@section('title', 'Mes Convocations')
@section('page_title', 'Mes Convocations & Avis')

@section('content')
<div class="container-fluid p-0">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h4 class="fw-bold mb-1">Avis & Convocations de l'établissement</h4>
            <p class="text-muted small mb-0">Consultez les convocations ou notifications administratives.</p>
        </div>
    </div>

    @if($convocations->isEmpty())
        <div class="card border-0 shadow-sm rounded-4 p-5 text-center">
            <div class="mb-3">
                <i class='bx bx-check-double text-success' style="font-size: 4rem;"></i>
            </div>
            <h5 class="fw-bold text-dark">Aucune convocation</h5>
            <p class="text-muted small">Vous n'avez fait l'objet d'aucune convocation ou mesure disciplinaire.</p>
        </div>
    @else
        <div class="row g-4">
            @foreach($convocations as $conv)
                <div class="col-md-6">
                    <div class="card border-0 shadow-sm rounded-4 p-4 h-100 border-start border-4 border-warning">
                        <div class="d-flex justify-content-between align-items-start mb-2">
                            <span class="badge bg-warning text-dark px-3 py-2 rounded-pill">
                                <i class='bx bx-calendar me-1'></i>
                                {{ \Carbon\Carbon::parse($conv->date_convocation)->format('d/m/Y') }}
                                @if($conv->heure_convocation)
                                    à {{ \Carbon\Carbon::parse($conv->heure_convocation)->format('H:i') }}
                                @endif
                            </span>
                            <span class="badge {{ $conv->statut == 'resolu' ? 'bg-success' : 'bg-secondary' }}">
                                {{ ucfirst($conv->statut ?? 'en attente') }}
                            </span>
                        </div>
                        <h5 class="fw-bold text-dark mt-2 mb-2">{{ $conv->motif ?? 'Convocation' }}</h5>
                        <p class="text-muted small mb-3">
                            {{ $conv->description ?? 'Veuillez vous présenter à la vie scolaire ou à l\'administration.' }}
                        </p>
                        @if($conv->personne_a_rencontrer)
                            <div class="p-2 rounded-3 bg-light text-muted small">
                                <i class='bx bx-user me-1'></i>À rencontrer : <strong>{{ $conv->personne_a_rencontrer }}</strong>
                            </div>
                        @endif
                    </div>
                </div>
            @endforeach
        </div>
    @endif
</div>
@endsection
