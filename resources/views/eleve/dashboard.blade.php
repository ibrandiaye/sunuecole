@extends('layouts.app')

@section('title', 'Espace Élève')
@section('page_title', 'Mon Espace Élève')

@section('content')
<div class="container-fluid p-0">
    @if(!$eleve)
        <div class="card p-5 text-center border-0 shadow-sm rounded-4">
            <h5 class="fw-bold">Profil élève non trouvé</h5>
            <p class="text-muted small">Aucun dossier d'élève n'est rattaché à votre compte utilisateur.</p>
        </div>
    @else
        <!-- Bannière Carte Étudiant -->
        <div class="card border-0 shadow-sm rounded-4 mb-4 text-white p-4 overflow-hidden position-relative" style="background: linear-gradient(135deg, #4361ee 0%, #3a0ca3 100%);">
            <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 position-relative" style="z-index: 2;">
                <div class="d-flex align-items-center gap-3">
                    <div class="rounded-circle bg-white bg-opacity-20 d-flex align-items-center justify-content-center text-white fw-bold fs-2" style="width: 64px; height: 64px;">
                        {{ strtoupper(substr($eleve->prenom, 0, 1)) }}{{ strtoupper(substr($eleve->nom, 0, 1)) }}
                    </div>
                    <div>
                        <h4 class="fw-bold mb-1">{{ $eleve->prenom }} {{ $eleve->nom }}</h4>
                        <div class="d-flex flex-wrap gap-2 text-white-50 small mt-1">
                            <span class="badge bg-white bg-opacity-20 text-white font-monospace">Matricule: {{ $eleve->matricule }}</span>
                            <span class="badge bg-white bg-opacity-20 text-white">Classe: {{ $eleve->classe->nom ?? 'N/A' }}</span>
                            <span class="badge bg-white bg-opacity-20 text-white">{{ $eleve->classe->niveau->nom ?? 'Niveau' }}</span>
                        </div>
                    </div>
                </div>
                <div>
                    <span class="badge bg-success bg-opacity-25 text-white border border-success px-3 py-2 rounded-pill">
                        <i class='bx bx-check-circle me-1'></i> Année Active
                    </span>
                </div>
            </div>
        </div>

        <!-- Statistiques rapides -->
        <div class="row g-3 mb-4">
            <div class="col-6 col-md-3">
                <div class="card border-0 shadow-sm rounded-4 p-3 text-center h-100">
                    <div class="text-warning fs-2 mb-1"><i class='bx bxs-award'></i></div>
                    <h3 class="fw-bold mb-0 text-dark">
                        {{ $moyenneGenerale ? number_format($moyenneGenerale, 2) . '/20' : '—' }}
                    </h3>
                    <small class="text-muted fw-semibold">Ma Moyenne générale</small>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="card border-0 shadow-sm rounded-4 p-3 text-center h-100">
                    <div class="text-danger fs-2 mb-1"><i class='bx bxs-user-x'></i></div>
                    <h3 class="fw-bold mb-0 text-danger">{{ $eleve->absences()->count() }}</h3>
                    <small class="text-muted fw-semibold">Absence(s) & Retard(s)</small>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="card border-0 shadow-sm rounded-4 p-3 text-center h-100">
                    <div class="text-info fs-2 mb-1"><i class='bx bxs-envelope'></i></div>
                    <h3 class="fw-bold mb-0 text-info">{{ $eleve->convocations()->count() }}</h3>
                    <small class="text-muted fw-semibold">Convocation(s)</small>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="card border-0 shadow-sm rounded-4 p-3 text-center h-100">
                    <div class="text-success fs-2 mb-1"><i class='bx bxs-calendar-check'></i></div>
                    <h3 class="fw-bold mb-0 text-success">{{ $coursAujourdhui->count() }}</h3>
                    <small class="text-muted fw-semibold">Cours aujourd'hui ({{ $nomJour }})</small>
                </div>
            </div>
        </div>

        <!-- Actions Rapides -->
        <h6 class="fw-bold text-muted text-uppercase small mb-3">Accès Rapide</h6>
        <div class="row g-3 mb-4">
            <div class="col-6 col-md-3">
                <a href="{{ route('eleve.notes') }}" class="card border-0 shadow-sm rounded-4 p-3 text-center text-decoration-none text-dark h-100">
                    <div class="text-warning fs-1 mb-2"><i class='bx bxs-award'></i></div>
                    <span class="fw-bold small d-block">Mes Notes</span>
                    <small class="text-muted" style="font-size: 0.75rem;">Devoirs & Bulletins</small>
                </a>
            </div>
            <div class="col-6 col-md-3">
                <a href="{{ route('eleve.planning') }}" class="card border-0 shadow-sm rounded-4 p-3 text-center text-decoration-none text-dark h-100">
                    <div class="text-info fs-1 mb-2"><i class='bx bxs-calendar'></i></div>
                    <span class="fw-bold small d-block">Mon Emploi du Temps</span>
                    <small class="text-muted" style="font-size: 0.75rem;">Grille de la semaine</small>
                </a>
            </div>
            <div class="col-6 col-md-3">
                <a href="{{ route('eleve.absences') }}" class="card border-0 shadow-sm rounded-4 p-3 text-center text-decoration-none text-dark h-100">
                    <div class="text-danger fs-1 mb-2"><i class='bx bxs-time-five'></i></div>
                    <span class="fw-bold small d-block">Mes Absences</span>
                    <small class="text-muted" style="font-size: 0.75rem;">Assiduité & Retards</small>
                </a>
            </div>
            <div class="col-6 col-md-3">
                <a href="{{ route('eleve.paiements') }}" class="card border-0 shadow-sm rounded-4 p-3 text-center text-decoration-none text-dark h-100">
                    <div class="text-success fs-1 mb-2"><i class='bx bxs-credit-card'></i></div>
                    <span class="fw-bold small d-block">Ma Scolarité</span>
                    <small class="text-muted" style="font-size: 0.75rem;">État des règlements</small>
                </a>
            </div>
        </div>

        <!-- Cours du Jour & Dernières Notes -->
        <div class="row g-4">
            <div class="col-lg-6">
                <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold mb-0"><i class='bx bx-calendar text-info me-2'></i>Mes Cours Aujourd'hui ({{ $nomJour }})</h5>
                        <a href="{{ route('eleve.planning') }}" class="small fw-bold text-decoration-none">Semaine complète</a>
                    </div>
                    @forelse($coursAujourdhui as $cours)
                        <div class="p-3 mb-2 rounded-3 bg-light d-flex align-items-center gap-3 border-start border-4 border-info">
                            <div class="text-center font-monospace" style="min-width: 60px;">
                                <strong class="text-info">{{ \Carbon\Carbon::parse($cours->heure_debut)->format('H:i') }}</strong><br>
                                <small class="text-muted">{{ \Carbon\Carbon::parse($cours->heure_fin)->format('H:i') }}</small>
                            </div>
                            <div class="border-start ps-3 flex-grow-1">
                                <div class="fw-bold text-dark">{{ $cours->matiere->nom ?? 'Matière' }}</div>
                                <div class="text-muted small">
                                    Prof. : {{ $cours->enseignant?->user?->name ?? 'Enseignant' }}
                                    @if($cours->salle) &bull; Salle : {{ $cours->salle->nom }} @endif
                                </div>
                            </div>
                        </div>
                    @empty
                        <div class="text-center py-4 text-muted small">
                            <i class='bx bx-coffee fs-2 d-block mb-2 text-secondary opacity-50'></i>
                            Aucun cours prévu aujourd'hui.
                        </div>
                    @endforelse
                </div>
            </div>

            <div class="col-lg-6">
                <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold mb-0"><i class='bx bx-award text-warning me-2'></i>Dernières Notes Reçues</h5>
                        <a href="{{ route('eleve.notes') }}" class="small fw-bold text-decoration-none">Toutes mes notes</a>
                    </div>
                    <div class="list-group list-group-flush">
                        @forelse($notesRecentes as $note)
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
        </div>
    @endif
</div>
@endsection
