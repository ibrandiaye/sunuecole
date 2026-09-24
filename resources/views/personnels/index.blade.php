@extends('layouts.app')

@section('title', 'Liste des Personnels')
@section('page_title', 'Gestion du Corps Professoral')

@section('content')
<div class="row animate__animated animate__fadeIn">
    <div class="col-md-12">
        <div class="card p-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h5 class="fw-bold mb-0"><i class='bx bxs-group me-2 text-primary'></i>Personnels inscrits</h5>
                <a href="{{ route('personnels.create') }}" class="btn btn-primary">
                    <i class='bx bx-user-plus me-1'></i> Nouvel Personnel
                </a>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle datatable">
                    <thead class="table-light">
                        <tr>
                            <th class="border-0 rounded-start">Personnel</th>
                            <th class="border-0">Matières</th>
                            <th class="border-0">Statut</th>
                            <th class="border-0">Téléphone</th>
                            <th class="border-0">Affectations</th>
                            <th class="border-0 rounded-end text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($personnels as $personnel)
                        <tr>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="flex-shrink-0">
                                        @if($personnel->photo)
                                            <img src="{{ asset('storage/' . $personnel->photo) }}" class="rounded-circle" width="40" height="40" alt="">
                                        @else
                                            <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; font-weight: bold;">
                                                {{ $personnel->user ? substr($personnel->user->name, 0, 1) : substr($personnel->prenom, 0, 1) }}
                                            </div>
                                        @endif
                                    </div>
                                    <div class="ms-3">
                                        <div class="fw-bold">{{ $personnel->user ? $personnel->user->name : $personnel->prenom }}</div>
                                        <div class="text-muted small">{{ $personnel->email ?? "-" }}</div>
                                    </div>
                                </div>
                            </td>
                            <td>
                                @if($personnel->matieres)
                                @forelse($personnel->matieres as $matiere)
                                    <span class="badge bg-light text-primary border me-1 small">{{ $matiere->code }}</span>
                                @empty
                                    <span class="text-muted small">Aucune</span>
                                @endforelse
                                @else
                                    <span class="text-muted small">Aucune</span>
                                @endif
                            </td>
                            <td>
                                <span class="badge {{ $personnel->statut == 'permanent' ? 'bg-success-subtle text-success' : 'bg-warning-subtle text-warning' }} rounded-pill px-3">
                                    {{ ucfirst($personnel->statut) }}
                                </span>
                            </td>
                            <td>{{ $personnel->telephone ?? "-" }}</td>
                            <td>
                                <span class="badge bg-light text-muted border">{{ $personnel->classes ? $personnel->classes()->count() : "-" }} cours</span>
                            </td>
                            <td class="text-center">
                                <div class="d-flex justify-content-center gap-2">
                                    <a href="{{ route('personnels.show', $personnel) }}" class="btn btn-sm btn-light text-primary" title="Voir"><i class='bx bx-show'></i></a>
                                    <a href="{{ route('personnels.edit', $personnel) }}" class="btn btn-sm btn-light text-info" title="Modifier"><i class='bx bx-edit-alt'></i></a>
                                    <form action="{{ route('personnels.destroy', $personnel) }}" method="POST" class="d-inline">
                                        @csrf @method('DELETE')
                                        <button class="btn btn-sm btn-light text-danger" title="Supprimer" onclick="return confirm('Supprimer cet personnel et son compte ?')"><i class='bx bx-trash'></i></button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                        @empty
                        <tr>
                            <td colspan="6" class="text-center py-5">Aucun personnel enregistré.</td>
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
