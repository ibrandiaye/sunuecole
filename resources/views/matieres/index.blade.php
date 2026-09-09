@extends('layouts.app')

@section('title', 'Gestion des Matières')
@section('page_title', 'Configuration des Disciplines')

@section('content')
<div class="row animate__animated animate__fadeIn">
    <!-- Formulaire d'ajout -->
    <div class="col-md-4">
        <div class="card p-4">
            <h5 class="fw-bold mb-4 text-primary"><i class='bx bx-plus-circle me-2'></i>Nouvelle Matière</h5>
            <form action="{{ route('matieres.store') }}" method="POST">
                @csrf
                <div class="mb-3">
                    <label class="form-label fw-semibold">Nom de la matière <span class="text-danger">*</span></label>
                    <input type="text" name="nom" class="form-control @error('nom') is-invalid @enderror" value="{{ old('nom') }}" placeholder="Ex: Mathématiques">
                    @error('nom') <div class="invalid-feedback">{{ $message }}</div> @enderror
                </div>
                
                <div class="mb-4">
                    <label class="form-label fw-semibold">Code / Abréviation <span class="text-danger">*</span></label>
                    <input type="text" name="code" class="form-control @error('code') is-invalid @enderror" value="{{ old('code') }}" placeholder="Ex: MATH">
                    @error('code') <div class="invalid-feedback">{{ $message }}</div> @enderror
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold">Cycle <span class="text-danger">*</span></label>
                    <select name="cycle_id" class="form-select @error('cycle_id') is-invalid @enderror">
                        @foreach($cycles as $cycle)
                            <option value="{{ $cycle->id }}">{{ $cycle->nom }}</option>
                        @endforeach
                    </select>
                    @error('cycle_id') <div class="invalid-feedback">{{ $message }}</div> @enderror
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold">Type de matière <span class="text-danger">*</span></label>
                    <select name="type" class="form-select @error('type') is-invalid @enderror">
                        <option value="obligatoire">Obligatoire</option>
                        <option value="optionnel">Optionnel (Facultatif)</option>
                    </select>
                    @error('type') <div class="invalid-feedback">{{ $message }}</div> @enderror
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold">Coefficient par défaut <span class="text-danger">*</span></label>
                    <input type="number" name="coefficient" class="form-control @error('coefficient') is-invalid @enderror" value="{{ old('coefficient', 1) }}" min="1" max="10">
                    @error('coefficient') <div class="invalid-feedback">{{ $message }}</div> @enderror
                </div>

                <div class="alert alert-light border rounded-4 small mb-4">
                    <i class='bx bx-info-circle me-1'></i> Ces matières seront ensuite liées aux classes et aux coefficients.
                </div>

                <button type="submit" class="btn btn-primary w-100 py-2 fw-bold">Enregistrer la Matière</button>
            </form>
        </div>
    </div>

    <!-- Liste des matières -->
    <div class="col-md-8">
        <div class="card p-4">
            <h5 class="fw-bold mb-4">Disciplines enregistrées</h5>
            <div class="table-responsive">
                <table class="table table-hover align-middle datatable">
                    <thead class="table-light">
                        <tr>
                            <th class="border-0 rounded-start">Code</th>
                            <th class="border-0">Nom de la Discipline</th>
                            <th class="border-0">Cycle</th>
                            <th class="border-0">Type & Coeff</th>
                            <th class="border-0">Enseignants liés</th>
                            <th class="border-0 rounded-end text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($matieres as $matiere)
                        <tr>
                            <td><span class="badge bg-primary-subtle text-primary fw-bold">{{ $matiere->code }}</span></td>
                            <td class="fw-semibold">{{ $matiere->nom }}</td>
                            <td><span class="badge bg-secondary-subtle text-secondary">{{ ucfirst($matiere->cycle->nom) }}</span></td>
                            <td>
                                @if($matiere->type == 'obligatoire')
                                    <span class="badge bg-success-subtle text-success">Obligatoire</span>
                                @else
                                    <span class="badge bg-warning-subtle text-warning">Optionnel</span>
                                @endif
                                <span class="badge bg-dark-subtle text-dark ms-1">Coeff {{ $matiere->coefficient }}</span>
                            </td>
                            <td>
                                <span class="badge bg-light text-muted border">{{ $matiere->enseignants()->count() }} profs</span>
                            </td>
                            <td class="text-end">
                                <form action="{{ route('matieres.destroy', $matiere) }}" method="POST" class="d-inline">
                                    @csrf @method('DELETE')
                                    <button class="btn btn-sm btn-light text-danger" onclick="return confirm('Supprimer cette matière ?')" title="Supprimer">
                                        <i class='bx bx-trash'></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                        @empty
                        <tr>
                            <td colspan="4" class="text-center py-5 text-muted">Aucune matière configurée.</td>
                        </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
            <div class="mt-3">
                {{-- Pagination DataTables gérée côté client --}}
            </div>
        </div>
    </div>
</div>
@endsection
