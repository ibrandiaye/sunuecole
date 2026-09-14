@extends('layouts.app')

@section('title', 'Liste des Élèves')
@section('page_title', 'Gestion des Élèves')

@section('content')
<div class="row mb-4 animate__animated animate__fadeIn">
    <div class="col-md-8">
        <div class="card p-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h5 class="fw-bold mb-0"><i class='bx bx-list-ul me-2 text-primary'></i>Liste des inscrits</h5>
                <div>
                    <button type="button" class="btn btn-outline-success me-2" data-bs-toggle="modal" data-bs-target="#importModal">
                        <i class='bx bx-import me-1'></i> Importer
                    </button>
                    <a href="{{ route('eleves.create', isset($selected_classe_id) ? ['classe_id' => $selected_classe_id] : []) }}" class="btn btn-primary">
                        <i class='bx bx-plus-circle me-1'></i> Nouvel Élève
                    </a>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th class="border-0 rounded-start">Matricule</th>
                            <th class="border-0">Nom Complet</th>
                            <th class="border-0">Classe</th>
                            <th class="border-0">Sexe</th>
                            <th class="border-0">Statut</th>
                            <th class="border-0 rounded-end text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($eleves as $eleve)
                        <tr>
                            <td class="fw-bold text-primary">{{ $eleve->matricule }}</td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="flex-shrink-0">
                                        @if($eleve->photo)
                                            <img src="{{ asset('storage/' . $eleve->photo) }}" class="rounded-circle" width="35" height="35" alt="">
                                        @else
                                            <div class="rounded-circle bg-light d-flex align-items-center justify-content-center" style="width: 35px; height: 35px;">
                                                <i class='bx bxs-user text-muted'></i>
                                            </div>
                                        @endif
                                    </div>
                                    <div class="ms-3">
                                        <div class="fw-semibold">{{ $eleve->prenom }} {{ $eleve->nom }}</div>
                                    </div>
                                </div>
                            </td>
                            <td><span class="badge bg-light text-dark border">{{ $eleve->classe->nom ?? 'N/A' }}</span></td>
                            <td>{{ $eleve->sexe }}</td>
                            <td>
                                <span class="badge {{ $eleve->statut == 'actif' ? 'bg-success-subtle text-success' : 'bg-danger-subtle text-danger' }} px-3 py-2 rounded-pill">
                                    {{ ucfirst($eleve->statut) }}
                                </span>
                            </td>
                            <td class="text-center">
                                <div class="dropdown">
                                    <button class="btn btn-sm btn-light" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class='bx bx-dots-vertical-rounded'></i>
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end shadow-sm border-0">
                                        <li><a class="dropdown-item fw-bold text-primary" href="{{ route('eleves.show', $eleve) }}"><i class='bx bx-show me-2'></i> Dossier complet</a></li>
                                        <li><a class="dropdown-item" href="{{ route('paiements.index', ['eleve_id' => $eleve->id]) }}"><i class='bx bx-wallet me-2 text-success'></i> Voir les paiements</a></li>
                                        <li><a class="dropdown-item" href="{{ route('absences.index', ['classe_id' => $eleve->classe_id]) }}"><i class='bx bx-time-five me-2 text-warning'></i> Pointage absences</a></li>
                                        <li><a class="dropdown-item" href="{{ route('notes.index', ['classe_id' => $eleve->classe_id]) }}"><i class='bx bx-edit me-2 text-info'></i> Saisir notations</a></li>
                                        <li><a class="dropdown-item" href="{{ route('bulletins.index', ['classe_id' => $eleve->classe_id]) }}"><i class='bx bxs-file-pdf me-2 text-danger'></i> Imprimer bulletins</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="{{ route('eleves.edit', $eleve) }}"><i class='bx bx-edit-alt me-2'></i> Modifier</a></li>
                                        <li>
                                            <form action="{{ route('eleves.destroy', $eleve) }}" method="POST" class="d-inline">
                                                @csrf @method('DELETE')
                                                <button class="dropdown-item text-danger" onclick="return confirm('Confirmer la suppression ?')">
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
                            <td colspan="6" class="text-center py-5">
                                <i class='bx bx-user-x fs-1 text-muted d-block mb-3'></i>
                                <p class="text-muted">Aucun élève inscrit pour le moment.</p>
                                <a href="{{ route('eleves.create') }}" class="btn btn-outline-primary btn-sm">Inscrire le premier élève</a>
                            </td>
                        </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>

            <div class="mt-4">
                {{ $eleves->links() }}
            </div>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card p-4 mb-4 bg-primary text-white">
            <h6 class="mb-3">Résumé Rapide</h6>
            <div class="d-flex justify-content-between mb-3">
                <span>Total Élèves</span>
                <span class="fw-bold">{{ $eleves->total() }}</span>
            </div>
            <div class="d-flex justify-content-between mb-0">
                <span>Inscriptions ce mois</span>
                <span class="fw-bold">0</span>
            </div>
        </div>

        <div class="card p-4 shadow-sm border-0">
            <h6 class="fw-bold mb-3">Statut par Cycle</h6>
            <!-- Ici on pourrait mettre un petit chart ou des barres de progression -->
            <div class="mb-3">
                <small class="text-muted d-flex justify-content-between">Élémentaire <span>0%</span></small>
                <div class="progress mt-1" style="height: 6px;">
                    <div class="progress-bar bg-primary" style="width: 0%"></div>
                </div>
            </div>
            <div class="mb-3">
                <small class="text-muted d-flex justify-content-between">Moyen <span>0%</span></small>
                <div class="progress mt-1" style="height: 6px;">
                    <div class="progress-bar bg-success" style="width: 0%"></div>
                </div>
            </div>
            <div>
                <small class="text-muted d-flex justify-content-between">Secondaire <span>0%</span></small>
                <div class="progress mt-1" style="height: 6px;">
                    <div class="progress-bar bg-info" style="width: 0%"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal Import -->
<div class="modal fade" id="importModal" tabindex="-1" aria-labelledby="importModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form action="{{ route('eleves.import') }}" method="POST" enctype="multipart/form-data">
            @csrf
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="importModalLabel"><i class='bx bx-import me-2'></i>Importer des Élèves</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p class="text-muted small">
                        Téléchargez le modèle ci-dessous, remplissez-le sans modifier les en-têtes de colonnes, puis importez-le ici.
                    </p>
                    <div class="mb-3">
                        <a href="{{ route('eleves.import_template') }}" class="btn btn-sm btn-outline-primary">
                            <i class='bx bxs-download me-1'></i> Télécharger le modèle (Excel)
                        </a>
                    </div>
                    <div class="mb-3">
                        <label for="fichier_excel" class="form-label fw-bold">Fichier (Excel/CSV)</label>
                        <input class="form-control" type="file" id="fichier_excel" name="fichier_excel" accept=".xlsx, .xls, .csv" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-primary">Lancer l'importation</button>
                </div>
            </div>
        </form>
    </div>
</div>

@endsection
