@extends('layouts.app')

@section('title', 'Gestion des Séries')
@section('page_title', 'Configuration des Filières')

@section('content')
<div class="row animate__animated animate__fadeIn">
    <div class="col-md-4">
        <div class="card p-4 shadow-sm border-0">
            <h5 class="fw-bold mb-4 text-primary"><i class='bx bx-plus-circle me-2'></i>Nouvelle Série</h5>
            <form action="{{ route('series.store') }}" method="POST">
                @csrf
                <div class="mb-3">
                    <label class="form-label fw-bold">Nom complet</label>
                    <input type="text" name="nom" class="form-control" placeholder="Ex: Terminale S1" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-bold">Code / Abréviation</label>
                    <input type="text" name="code" class="form-control" placeholder="Ex: S1, L2, S-TEC" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-bold">Cycle</label>
                    <select name="cycle" class="form-select">
                        <option value="elementaire">Élémentaire</option>
                        <option value="moyen">Moyen</option>
                        <option value="secondaire" selected>Secondaire</option>
                    </select>
                </div>
                <div class="mb-4">
                    <label class="form-label fw-bold">Description (Optionnelle)</label>
                    <textarea name="description" class="form-control" rows="2"></textarea>
                </div>
                <button type="submit" class="btn btn-primary w-100 py-2 fw-bold">Ajouter la série</button>
            </form>
        </div>
    </div>

    <div class="col-md-8">
        <div class="card p-4 shadow-sm border-0">
            <h5 class="fw-bold mb-4">Filières disponibles</h5>
            <div class="table-responsive">
                <table class="table table-hover align-middle datatable">
                    <thead class="table-light">
                        <tr>
                            <th class="border-0 rounded-start">Code</th>
                            <th class="border-0">Désignation</th>
                            <th class="border-0">Cycle</th>
                            <th class="border-0">Classes liées</th>
                            <th class="border-0 rounded-end text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($series as $serie)
                        <tr>
                            <td><span class="badge bg-primary-subtle text-primary fw-bold">{{ $serie->code }}</span></td>
                            <td class="fw-semibold">{{ $serie->nom }}</td>
                            <td><span class="badge bg-light text-dark border">{{ ucfirst($serie->cycle) }}</span></td>
                            <td>
                                <span class="badge bg-light text-muted border px-2">{{ $serie->classes()->count() }} classes</span>
                            </td>
                            <td class="text-end">
                                <form action="{{ route('series.destroy', $serie) }}" method="POST" class="d-inline">
                                    @csrf @method('DELETE')
                                    <button class="btn btn-sm btn-light text-danger" onclick="return confirm('Supprimer cette série ?')">
                                        <i class='bx bx-trash'></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
@endsection
