@extends('layouts.app')

@section('title', 'Mes Classes')
@section('page_title', 'Mes Classes & Élèves')

@section('content')
<div class="container-fluid p-0">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h4 class="fw-bold mb-1">Classes assignées</h4>
            <p class="text-muted small mb-0">Consultez vos classes et la liste des élèves pour cette année scolaire.</p>
        </div>
    </div>

    @if($classes->isEmpty())
        <div class="card p-5 text-center">
            <div class="mb-3">
                <i class='bx bx-book-open text-muted' style="font-size: 4rem;"></i>
            </div>
            <h5 class="fw-bold">Aucune classe assignée</h5>
            <p class="text-muted small">Vous n'avez pas encore de classe ou matière assignée pour cette année scolaire.<br>Veuillez contacter l'administration de l'établissement.</p>
        </div>
    @else
        <div class="row g-4">
            @foreach($classes as $classe)
                <div class="col-md-6 col-xl-4">
                    <div class="card h-100 shadow-sm border-0 rounded-4 overflow-hidden">
                        <div class="card-body p-4 d-flex flex-column justify-content-between">
                            <div>
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <div class="d-flex align-items-center gap-3">
                                        <div class="rounded-3 bg-primary bg-opacity-10 text-primary p-3 d-flex align-items-center justify-content-center" style="width: 54px; height: 54px;">
                                            <i class='bx bxs-school fs-2'></i>
                                        </div>
                                        <div>
                                            <h5 class="fw-bold mb-0">{{ $classe->nom }}</h5>
                                            <span class="badge bg-light text-dark border">{{ $classe->niveau->nom ?? 'Niveau' }}</span>
                                        </div>
                                    </div>
                                    <span class="badge bg-primary rounded-pill px-3 py-2">
                                        <i class='bx bx-user me-1'></i> {{ $classe->eleves_count }} élève(s)
                                    </span>
                                </div>

                                <div class="mb-3 pt-2">
                                    <small class="text-muted fw-bold d-block mb-1">Matières enseignées :</small>
                                    <div class="d-flex flex-wrap gap-1">
                                        @forelse($classe->matieres_enseignees as $mat)
                                            <span class="badge bg-secondary bg-opacity-10 text-secondary border">
                                                {{ $mat->nom }}
                                            </span>
                                        @empty
                                            <span class="text-muted small fst-italic">Non spécifiée</span>
                                        @endforelse
                                    </div>
                                </div>

                                @if($classe->salle)
                                    <p class="text-muted small mb-3">
                                        <i class='bx bx-door-open me-1'></i> Salle : <strong>{{ $classe->salle->nom }}</strong>
                                    </p>
                                @endif
                            </div>

                            <div class="pt-3 border-top d-flex gap-2">
                                <a href="{{ route('professeur.classes.eleves', $classe->id) }}" class="btn btn-outline-primary btn-sm flex-grow-1 rounded-3 fw-bold">
                                    <i class='bx bx-group me-1'></i> Liste des Élèves
                                </a>
                                <a href="{{ route('professeur.notes.index') }}" class="btn btn-light btn-sm rounded-3" title="Saisir des notes">
                                    <i class='bx bx-edit text-primary'></i>
                                </a>
                                <a href="{{ route('professeur.absences.index') }}" class="btn btn-light btn-sm rounded-3" title="Faire l'appel">
                                    <i class='bx bx-user-check text-success'></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            @endforeach
        </div>
    @endif
</div>
@endsection
