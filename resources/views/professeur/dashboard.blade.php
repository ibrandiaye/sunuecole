@extends('layouts.app')

@section('title', 'Tableau de bord Enseignant')
@section('page_title', 'Espace Enseignant')

@section('content')
<div class="container-fluid p-0">
    <!-- Header Welcome -->
    <div class="card border-0 shadow-sm rounded-4 mb-4 bg-primary text-white p-4 overflow-hidden position-relative" style="background: linear-gradient(135deg, #4361ee 0%, #3f37c9 100%);">
        <div class="d-flex align-items-center gap-3 position-relative" style="z-index: 2;">
            <div class="rounded-circle bg-white bg-opacity-20 d-flex align-items-center justify-content-center text-white fw-bold fs-2" style="width: 60px; height: 60px;">
                {{ strtoupper(substr(auth()->user()->name, 0, 1)) }}
            </div>
            <div>
                <h4 class="fw-bold mb-1">Bonjour, {{ auth()->user()->name }}</h4>
                <p class="mb-0 text-white-50 small">
                    {{ $enseignant->specialite ?? 'Professeur' }} &bull; {{ $classes->count() }} classe(s) attribuée(s)
                </p>
            </div>
        </div>
    </div>

    <!-- Statistiques rapides -->
    <div class="row g-3 mb-4">
        <div class="col-6 col-md-3">
            <div class="card border-0 shadow-sm rounded-4 p-3 text-center h-100">
                <div class="text-primary fs-2 mb-1"><i class='bx bxs-user-badge'></i></div>
                <h3 class="fw-bold mb-0 text-dark">{{ $totalEleves }}</h3>
                <small class="text-muted fw-semibold">Élèves au total</small>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card border-0 shadow-sm rounded-4 p-3 text-center h-100">
                <div class="text-danger fs-2 mb-1"><i class='bx bxs-user-x'></i></div>
                <h3 class="fw-bold mb-0 text-danger">{{ $absencesAujourdhui }}</h3>
                <small class="text-muted fw-semibold">Absences (Aujourd'hui)</small>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card border-0 shadow-sm rounded-4 p-3 text-center h-100">
                <div class="text-success fs-2 mb-1"><i class='bx bxs-edit'></i></div>
                <h3 class="fw-bold mb-0 text-success">{{ $notesMois }}</h3>
                <small class="text-muted fw-semibold">Notes saisies (Mois)</small>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card border-0 shadow-sm rounded-4 p-3 text-center h-100">
                <div class="text-info fs-2 mb-1"><i class='bx bxs-school'></i></div>
                <h3 class="fw-bold mb-0 text-info">{{ $classes->count() }}</h3>
                <small class="text-muted fw-semibold">Mes Classes</small>
            </div>
        </div>
    </div>

    <!-- Actions Rapides -->
    <h6 class="fw-bold text-muted text-uppercase small mb-3">Actions Rapides</h6>
    <div class="row g-3 mb-4">
        <div class="col-6 col-md-3">
            <a href="{{ route('professeur.notes.index') }}" class="card border-0 shadow-sm rounded-4 p-3 text-center text-decoration-none text-dark h-100 hover-card">
                <div class="text-primary fs-1 mb-2"><i class='bx bxs-edit-alt'></i></div>
                <span class="fw-bold small d-block">Saisie des Notes</span>
                <small class="text-muted" style="font-size: 0.75rem;">Devoirs & Compositions</small>
            </a>
        </div>
        <div class="col-6 col-md-3">
            <a href="{{ route('professeur.absences.index') }}" class="card border-0 shadow-sm rounded-4 p-3 text-center text-decoration-none text-dark h-100 hover-card">
                <div class="text-success fs-1 mb-2"><i class='bx bxs-user-check'></i></div>
                <span class="fw-bold small d-block">Faire l'Appel</span>
                <small class="text-muted" style="font-size: 0.75rem;">Présences par créneau</small>
            </a>
        </div>
        <div class="col-6 col-md-3">
            <a href="{{ route('professeur.planning') }}" class="card border-0 shadow-sm rounded-4 p-3 text-center text-decoration-none text-dark h-100 hover-card">
                <div class="text-info fs-1 mb-2"><i class='bx bxs-calendar'></i></div>
                <span class="fw-bold small d-block">Mon Emploi du Temps</span>
                <small class="text-muted" style="font-size: 0.75rem;">Planning de la semaine</small>
            </a>
        </div>
        <div class="col-6 col-md-3">
            <a href="{{ route('professeur.cahier_textes') }}" class="card border-0 shadow-sm rounded-4 p-3 text-center text-decoration-none text-dark h-100 hover-card">
                <div class="text-warning fs-1 mb-2"><i class='bx bxs-book-content'></i></div>
                <span class="fw-bold small d-block">Cahier de Textes</span>
                <small class="text-muted" style="font-size: 0.75rem;">Séances & devoirs</small>
            </a>
        </div>
    </div>

    <!-- Cours du jour & Classes -->
    <div class="row g-4">
        <div class="col-lg-6">
            <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold mb-0">Cahier de textes du jour ({{ \Carbon\Carbon::parse($today)->format('d/m/Y') }})</h5>
                    <a href="{{ route('professeur.cahier_textes') }}" class="small fw-bold text-decoration-none">Tout voir</a>
                </div>

                @forelse($coursDuJour as $cours)
                    <div class="p-3 mb-2 rounded-3 bg-light d-flex align-items-center gap-3">
                        <div class="text-center font-monospace" style="min-width: 60px;">
                            <strong class="text-primary">{{ \Carbon\Carbon::parse($cours->heure_debut)->format('H:i') }}</strong><br>
                            <small class="text-muted">{{ \Carbon\Carbon::parse($cours->heure_fin)->format('H:i') }}</small>
                        </div>
                        <div class="border-start ps-3 flex-grow-1">
                            <div class="fw-bold text-dark">{{ $cours->classe->nom }} &bull; {{ $cours->matiere->nom }}</div>
                            <div class="text-muted small text-truncate" style="max-width: 300px;">
                                {{ $cours->titre_lecon }}
                            </div>
                        </div>
                    </div>
                @empty
                    <div class="text-center py-4 text-muted small">
                        <i class='bx bx-notepad fs-2 d-block mb-2 text-secondary opacity-50'></i>
                        Aucune séance enregistrée pour aujourd'hui.
                    </div>
                @endforelse
            </div>
        </div>

        <div class="col-lg-6">
            <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold mb-0">Mes Classes</h5>
                    <a href="{{ route('professeur.classes') }}" class="small fw-bold text-decoration-none">Détails</a>
                </div>

                <div class="list-group list-group-flush">
                    @forelse($classes as $c)
                        <div class="list-group-item px-0 py-3 d-flex justify-content-between align-items-center border-bottom">
                            <div>
                                <h6 class="fw-bold mb-0">{{ $c->nom }}</h6>
                                <small class="text-muted">{{ $c->niveau->nom ?? 'Niveau' }}</small>
                            </div>
                            <div class="d-flex align-items-center gap-2">
                                <a href="{{ route('professeur.classes.eleves', $c->id) }}" class="btn btn-outline-primary btn-sm rounded-3">
                                    <i class='bx bx-group me-1'></i> Élèves
                                </a>
                            </div>
                        </div>
                    @empty
                        <div class="text-center py-4 text-muted small">
                            Aucune classe assignée.
                        </div>
                    @endforelse
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
