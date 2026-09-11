@extends('layouts.app')

@section('title', 'Liste des Classes')
@section('page_title', 'Configuration des Classes')

@section('content')
<div class="row animate__animated animate__fadeIn">
    <div class="col-md-12">
        <div class="card p-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h5 class="fw-bold mb-0"><i class='bx bxs-school me-2 text-primary'></i>Classes Ouvertes</h5>
                <a href="{{ route('classes.create') }}" class="btn btn-primary">
                    <i class='bx bx-plus-circle me-1'></i> Créer une Classe
                </a>
            </div>

            @if(session('error'))
                <div class="alert alert-danger border-0 shadow-sm rounded-4 mb-4">
                    {{ session('error') }}
                </div>
            @endif

            <div class="table-responsive">
                <table class="table table-hover align-middle datatable">
                    <thead class="table-light">
                        <tr>
                            <th class="border-0 rounded-start">Nom de la Classe</th>
                            <th class="border-0">Niveau</th>
                            <th class="border-0">Série</th>
                            <th class="border-0">Effectif Actuel</th>
                            <th class="border-0">Capacité Max</th>
                            <th class="border-0">Statut</th>
                            <th class="border-0 rounded-end text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($classes as $classe)
                        <tr>
                            <td class="fw-bold">
                                <a href="{{ route('classes.show', $classe) }}" class="text-decoration-none text-dark">{{ $classe->nom }}</a>
                            </td>
                            <td><span class="badge bg-primary-subtle text-primary">{{ $classe->niveau->nom ?? 'N/A' }}</span></td>
                            <td>{{ $classe->serie->code ?? 'Général' }}</td>
                            <td>
                                <div class="d-flex align-items-center gap-2">
                                    <span class="fw-semibold">{{ $classe->eleves_count ?? $classe->eleves()->count() }}</span>
                                    <div class="progress flex-grow-1" style="height: 5px; width: 60px;">
                                        @php 
                                            $percent = ($classe->effectif_max > 0) ? ($classe->eleves()->count() / $classe->effectif_max) * 100 : 0;
                                        @endphp
                                        <div class="progress-bar {{ $percent > 90 ? 'bg-danger' : 'bg-success' }}" style="width: {{ $percent }}%"></div>
                                    </div>
                                </div>
                            </td>
                            <td>{{ $classe->effectif_max }}</td>
                            <td>
                                @if($classe->active)
                                    <span class="badge bg-success-subtle text-success rounded-pill px-3">Ouverte</span>
                                @else
                                    <span class="badge bg-secondary-subtle text-secondary rounded-pill px-3">Fermée</span>
                                @endif
                            </td>
                            <td class="text-center">
                                <div class="dropdown">
                                    <button class="btn btn-sm btn-light" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class='bx bx-dots-vertical-rounded'></i>
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end shadow-sm border-0">
                                        <li><a class="dropdown-item" href="{{ route('classes.show', $classe) }}"><i class='bx bx-book-open me-2 text-primary'></i> Programme & Matières</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="{{ route('eleves.index', ['classe_id' => $classe->id]) }}"><i class='bx bx-group me-2 text-primary'></i> Voir les élèves</a></li>
                                        <li><a class="dropdown-item" href="{{ route('eleves.create', ['classe_id' => $classe->id]) }}"><i class='bx bx-user-plus me-2 text-success'></i> Inscrire un nouvel élève</a></li>
                                        <li>
                                            <button type="button" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#modalInscrireEleve"
                                                data-classe-id="{{ $classe->id }}"
                                                data-classe-nom="{{ $classe->nom }}"
                                                data-cantine="{{ $classe->montant_cantine ?? 0 }}"
                                                data-transport="{{ $classe->montant_transport ?? 0 }}">
                                                <i class='bx bx-user-check me-2 text-primary'></i> Inscrire un élève existant
                                            </button>
                                        </li>
                                        <li><a class="dropdown-item" href="{{ route('emplois.index', ['classe_id' => $classe->id]) }}"><i class='bx bx-calendar-event me-2 text-warning'></i> Voir le planning</a></li>
                                        <li><a class="dropdown-item" href="{{ route('notes.index', ['classe_id' => $classe->id]) }}"><i class='bx bx-edit me-2 text-info'></i> Saisir les notes</a></li>
                                        <li><a class="dropdown-item" href="{{ route('bulletins.index', ['classe_id' => $classe->id]) }}"><i class='bx bxs-file-pdf me-2 text-danger'></i> Bulletins</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="{{ route('classes.edit', $classe) }}"><i class='bx bx-edit-alt me-2 text-info'></i> Modifier</a></li>
                                        <li>
                                            <form action="{{ route('classes.destroy', $classe) }}" method="POST" class="d-inline">
                                                @csrf @method('DELETE')
                                                <button class="dropdown-item text-danger" title="Supprimer" onclick="return confirm('Voulez-vous vraiment supprimer cette classe ?')">
                                                    <i class='bx bx-trash me-2'></i> Supprimer
                                                </button>
                                            </form>
                                        </li>
                                    </ul>
                                </div>
                            </td>
                        </tr>
                        @empty
                        <tr>
                            <td colspan="7" class="text-center py-5 text-muted">
                                <i class='bx bx-info-circle fs-1 d-block mb-3'></i>
                                Aucune classe n'est encore configurée.
                            </td>
                        </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>

            <div class="mt-4">
                {{-- Pagination DataTables gérée côté client --}}
            </div>
        </div>
    </div>
</div>

{{-- MODAL INSCRIPTION ÉLÈVE EXISTANT --}}
<div class="modal fade" id="modalInscrireEleve" tabindex="-1" aria-labelledby="modalInscrireEleveLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <form action="{{ route('inscriptions.store') }}" method="POST" class="modal-content border-0 rounded-4 shadow">
            @csrf
            <input type="hidden" name="redirect_to_classes" value="1">
            <input type="hidden" name="classe_id" id="modal_classe_id" value="">
            @if($anneeActive)
                <input type="hidden" name="annee_scolaire_id" value="{{ $anneeActive->id }}">
            @endif

            <div class="modal-header bg-primary text-white border-0 py-3 rounded-top-4">
                <div>
                    <h5 class="modal-title fw-bold mb-0" id="modalInscrireEleveLabel">
                        <i class='bx bx-user-plus me-1'></i> Inscrire un élève existant
                    </h5>
                    <small class="text-white-50">Classe de destination : <span id="modal_classe_nom" class="fw-bold text-white"></span></small>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body p-4">
                {{-- ÉLÈVE NON INSCRIT --}}
                <div class="mb-3">
                    <div class="d-flex justify-content-between align-items-center mb-1">
                        <label class="form-label fw-bold mb-0">Choisir l'élève <span class="text-danger">*</span></label>
                        <span class="badge bg-primary-subtle text-primary border border-primary-subtle rounded-pill px-2 py-1 small">
                            {{ $elevesNonInscrits->count() }} sans inscription
                        </span>
                    </div>
                    <select name="eleve_id" id="modal_eleve_id" class="form-select select2" data-placeholder="Rechercher un élève par nom ou matricule..." required>
                        @if($elevesNonInscrits->isEmpty())
                            <option value="">-- Aucun élève disponible (tous sont déjà inscrits cette année) --</option>
                        @else
                            <option value=""></option>
                            @foreach($elevesNonInscrits as $el)
                                <option value="{{ $el->id }}">
                                    {{ $el->nom }} {{ $el->prenom }} &bull; {{ $el->matricule }}
                                </option>
                            @endforeach
                        @endif
                    </select>
                    <small class="text-muted d-block mt-1">
                        <i class='bx bx-info-circle me-1 text-primary'></i> Seuls les élèves sans inscription pour l'année scolaire active ({{ $anneeActive?->libelle ?? 'en cours' }}) sont affichés.
                    </small>
                </div>

                {{-- DATE D'INSCRIPTION --}}
                <div class="mb-3">
                    <label class="form-label fw-bold">Date d'inscription <span class="text-danger">*</span></label>
                    <input type="date" name="date_inscription" class="form-control" value="{{ date('Y-m-d') }}" required>
                </div>

                {{-- OPTIONS CANTINE & TRANSPORT --}}
                <div class="card bg-light border-0 p-3 rounded-3 mb-3">
                    <h6 class="fw-bold text-secondary mb-3"><i class='bx bx-check-shield me-1 text-primary'></i>Services Optionnels</h6>
                    <div class="row g-2">
                        <div class="col-12">
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" role="switch" name="avec_cantine" id="modal_avec_cantine" value="1">
                                <label class="form-check-label fw-semibold" for="modal_avec_cantine">
                                    <i class='bx bx-restaurant text-warning me-1'></i> Cantine Scolaire
                                    <span id="modal_cantine_tarif" class="badge bg-warning-subtle text-dark border ms-1 d-none"></span>
                                </label>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" role="switch" name="avec_transport" id="modal_avec_transport" value="1">
                                <label class="form-check-label fw-semibold" for="modal_avec_transport">
                                    <i class='bx bx-bus text-info me-1'></i> Transport Scolaire
                                    <span id="modal_transport_tarif" class="badge bg-info-subtle text-dark border ms-1 d-none"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>

                {{-- REMISES OPTIONNELLES --}}
                <div>
                    <a class="text-decoration-none small text-muted d-inline-flex align-items-center" data-bs-toggle="collapse" href="#modalCollapseRemises" role="button">
                        <i class='bx bx-purchase-tag-alt me-1 text-primary'></i> Accorder une remise (facultatif) <i class='bx bx-chevron-down ms-1'></i>
                    </a>
                    <div class="collapse mt-2" id="modalCollapseRemises">
                        <div class="row g-2 p-3 bg-light rounded-3 border">
                            <div class="col-6">
                                <label class="form-label small fw-semibold mb-1">Remise inscription</label>
                                <input type="number" name="remise_inscription" class="form-control form-control-sm" value="0" min="0" step="500">
                            </div>
                            <div class="col-6">
                                <label class="form-label small fw-semibold mb-1">Remise mensualité</label>
                                <input type="number" name="remise_mensualite" class="form-control form-control-sm" value="0" min="0" step="500">
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal-footer border-0 pt-0">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Annuler</button>
                <button type="submit" class="btn btn-primary px-4 fw-semibold" {{ $elevesNonInscrits->isEmpty() ? 'disabled' : '' }}>
                    <i class='bx bx-check me-1'></i> Valider l'inscription
                </button>
            </div>
        </form>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const modalInscrireEleve = document.getElementById('modalInscrireEleve');
    if (modalInscrireEleve) {
        modalInscrireEleve.addEventListener('show.bs.modal', function(event) {
            const button = event.relatedTarget;
            if (!button) return;

            const classeId = button.getAttribute('data-classe-id');
            const classeNom = button.getAttribute('data-classe-nom');
            const cantine = parseFloat(button.getAttribute('data-cantine')) || 0;
            const transport = parseFloat(button.getAttribute('data-transport')) || 0;

            document.getElementById('modal_classe_id').value = classeId;
            document.getElementById('modal_classe_nom').textContent = classeNom;

            const cantineBadge = document.getElementById('modal_cantine_tarif');
            if (cantine > 0) {
                cantineBadge.textContent = new Intl.NumberFormat('fr-FR').format(cantine) + ' FCFA/mois';
                cantineBadge.classList.remove('d-none');
            } else {
                cantineBadge.classList.add('d-none');
            }

            const transportBadge = document.getElementById('modal_transport_tarif');
            if (transport > 0) {
                transportBadge.textContent = new Intl.NumberFormat('fr-FR').format(transport) + ' FCFA/mois';
                transportBadge.classList.remove('d-none');
            } else {
                transportBadge.classList.add('d-none');
            }
        });
    }
});
</script>
@endsection
