@extends('layouts.app')

@section('title', 'Cahier de Textes')
@section('page_title', 'Cahier de Textes')

@section('content')
<div class="container-fluid p-0">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h4 class="fw-bold mb-1">Cahier de Textes & Séances</h4>
            <p class="text-muted small mb-0">Consultez et enregistrez les leçons dispensées par classe.</p>
        </div>
        <button type="button" class="btn btn-primary rounded-3 btn-sm" data-bs-toggle="modal" data-bs-target="#modalNouvelleSeance">
            <i class='bx bx-plus-circle me-1'></i> Enregistrer une Séance
        </button>
    </div>

    <!-- Filtre par classe -->
    <div class="card border-0 shadow-sm rounded-4 p-3 mb-4">
        <form method="GET" action="{{ route('professeur.cahier_textes') }}" class="row g-2 align-items-center">
            <div class="col-md-5">
                <select name="classe_id" class="form-select rounded-3" onchange="this.form.submit()">
                    <option value="">-- Toutes mes classes --</option>
                    @foreach($classes as $c)
                        <option value="{{ $c->id }}" {{ $classe_id == $c->id ? 'selected' : '' }}>
                            {{ $c->nom }}
                        </option>
                    @endforeach
                </select>
            </div>
            <div class="col-md-3">
                @if($classe_id)
                    <a href="{{ route('professeur.cahier_textes') }}" class="btn btn-light rounded-3 btn-sm text-muted">
                        <i class='bx bx-reset me-1'></i> Réinitialiser
                    </a>
                @endif
            </div>
        </form>
    </div>

    <!-- Liste des séances enregistrées -->
    <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="bg-light">
                        <tr>
                            <th class="ps-4">Date & Horaire</th>
                            <th>Classe</th>
                            <th>Matière</th>
                            <th>Titre de la Leçon</th>
                            <th>Contenu / Résumé</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($cahiers as $cahier)
                            <tr>
                                <td class="ps-4">
                                    <div class="fw-bold">{{ \Carbon\Carbon::parse($cahier->date_cours)->format('d/m/Y') }}</div>
                                    <small class="text-muted font-monospace">
                                        {{ \Carbon\Carbon::parse($cahier->heure_debut)->format('H:i') }} - {{ \Carbon\Carbon::parse($cahier->heure_fin)->format('H:i') }}
                                    </small>
                                </td>
                                <td>
                                    <span class="badge bg-light text-dark border">{{ $cahier->classe->nom ?? '—' }}</span>
                                </td>
                                <td>
                                    <span class="badge bg-primary bg-opacity-10 text-primary">{{ $cahier->matiere->nom ?? '—' }}</span>
                                </td>
                                <td>
                                    <strong class="text-dark">{{ $cahier->titre_lecon }}</strong>
                                </td>
                                <td>
                                    <span class="text-muted small">
                                        {{ Str::limit($cahier->contenu_lecon ?? 'Aucun détail renseigné.', 80) }}
                                    </span>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="5" class="text-center py-5 text-muted">
                                    <i class='bx bx-book-open fs-2 d-block mb-2 opacity-50'></i>
                                    Aucune séance enregistrée pour le moment.
                                </td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
        @if($cahiers->hasPages())
            <div class="card-footer bg-white border-0 py-3">
                {{ $cahiers->links() }}
            </div>
        @endif
    </div>
</div>

<!-- Modal Nouvelle Séance -->
<div class="modal fade" id="modalNouvelleSeance" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 border-0 shadow">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-bold"><i class='bx bx-book-add text-primary me-2'></i>Ajouter une séance</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="{{ route('professeur.cahier_textes.store') }}" method="POST">
                @csrf
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label small fw-bold">Classe</label>
                        <select name="classe_id" class="form-select rounded-3" required>
                            <option value="">Sélectionner une classe</option>
                            @foreach($classes as $c)
                                <option value="{{ $c->id }}" {{ $classe_id == $c->id ? 'selected' : '' }}>{{ $c->nom }}</option>
                            @endforeach
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-bold">Matière</label>
                        <select name="matiere_id" class="form-select rounded-3" required>
                            <option value="">Sélectionner la matière</option>
                            @foreach($matieres as $m)
                                <option value="{{ $m->id }}">{{ $m->nom }}</option>
                            @endforeach
                        </select>
                    </div>

                    <div class="row g-2 mb-3">
                        <div class="col-6">
                            <label class="form-label small fw-bold">Date</label>
                            <input type="date" name="date_cours" class="form-control rounded-3" value="{{ date('Y-m-d') }}" required>
                        </div>
                        <div class="col-3">
                            <label class="form-label small fw-bold">Début</label>
                            <input type="time" name="heure_debut" class="form-control rounded-3" value="08:00" required>
                        </div>
                        <div class="col-3">
                            <label class="form-label small fw-bold">Fin</label>
                            <input type="time" name="heure_fin" class="form-control rounded-3" value="10:00" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-bold">Titre de la leçon / Chapitre</label>
                        <input type="text" name="titre_lecon" class="form-control rounded-3" placeholder="Ex: Théorème de Pythagore" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-bold">Résumé & Devoirs à faire</label>
                        <textarea name="contenu_lecon" rows="4" class="form-control rounded-3" placeholder="Contenu abordé, exercices donnés à la maison..."></textarea>
                    </div>
                </div>
                <div class="modal-footer border-0 pt-0">
                    <button type="button" class="btn btn-light rounded-3" data-bs-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-primary rounded-3 px-4">Enregistrer</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection
