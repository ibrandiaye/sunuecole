@extends('layouts.app')

@section('title', 'Convocations & Discipline')
@section('page_title', 'Convocations & Discipline')

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
                <h4 class="fw-bold mb-1">Convocations & Avis &bull; {{ $enfantActif->prenom }} {{ $enfantActif->nom }}</h4>
                <p class="text-muted small mb-0">Courriers administratifs et convocations émis par l'établissement.</p>
            </div>
        </div>

        @if($convocations->isEmpty())
            <div class="card border-0 shadow-sm rounded-4 p-5 text-center">
                <div class="mb-3">
                    <i class='bx bx-check-double text-success' style="font-size: 4rem;"></i>
                </div>
                <h5 class="fw-bold text-dark">Aucune convocation</h5>
                <p class="text-muted small">Votre enfant n'a fait l'objet d'aucune convocation ou mesure disciplinaire.</p>
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
                            <h5 class="fw-bold text-dark mt-2 mb-2">{{ $conv->motif ?? 'Convocation administrative' }}</h5>
                            <p class="text-muted small mb-3">
                                {{ $conv->description ?? 'Veuillez vous présenter à la vie scolaire ou à la direction de l\'établissement.' }}
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
    @endif
</div>
@endsection
