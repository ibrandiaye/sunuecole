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
                                        <li><a class="dropdown-item" href="{{ route('eleves.create', ['classe_id' => $classe->id]) }}"><i class='bx bx-user-plus me-2 text-success'></i> Inscrire un élève</a></li>
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
@endsection
