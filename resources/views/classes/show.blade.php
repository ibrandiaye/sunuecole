@extends('layouts.app')

@section('title', 'Détails de la Classe')
@section('page_title', 'Gestion de la Classe')

@section('content')
<div class="row animate__animated animate__fadeIn">
    <!-- En-tête -->
    <div class="col-md-12 mb-4">
        <div class="card p-4 border-0 shadow-sm">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h4 class="fw-bold mb-1"><i class='bx bxs-school text-primary me-2'></i>{{ $classe->nom }}</h4>
                    <p class="text-muted mb-0">
                        <span class="badge bg-light text-dark border me-2">{{ $classe->niveau->nom ?? 'Niveau inconnu' }}</span>
                        <span class="badge bg-light text-dark border me-2">{{ $classe->serie->code ?? 'Général' }}</span>
                        <span class="badge {{ $classe->active ? 'bg-success-subtle text-success' : 'bg-secondary-subtle text-secondary' }}">{{ $classe->active ? 'Ouverte' : 'Fermée' }}</span>
                    </p>
                </div>
                <div>
                    <a href="{{ route('classes.index') }}" class="btn btn-outline-secondary me-2"><i class='bx bx-arrow-back me-1'></i>Retour</a>
                    <div class="btn-group me-2">
                        <button type="button" class="btn btn-outline-success dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class='bx bx-user-plus me-1'></i>Inscrire un élève
                        </button>
                        <ul class="dropdown-menu shadow-sm border-0">
                            <li><a class="dropdown-item" href="{{ route('eleves.create', ['classe_id' => $classe->id]) }}"><i class='bx bx-user-plus me-2 text-success'></i>Nouvel élève</a></li>
                            <li><a class="dropdown-item" href="{{ route('inscriptions.create', ['classe_id' => $classe->id]) }}"><i class='bx bx-user-check me-2 text-primary'></i>Élève déjà enregistré</a></li>
                        </ul>
                    </div>
                    <a href="{{ route('classes.edit', $classe) }}" class="btn btn-primary"><i class='bx bx-edit me-1'></i>Modifier</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Contenu Principal -->
    <div class="col-md-4">
        <!-- Ajout de matière -->
        <div class="card p-4 mb-4 border-0 shadow-sm">
            <h5 class="fw-bold mb-4 text-primary"><i class='bx bx-book-add me-2'></i>Associer une Matière</h5>
            
            <form action="{{ route('classes.matieres.attach', $classe) }}" method="POST">
                @csrf
                <div class="mb-3">
                    <label class="form-label fw-semibold">Discipline <span class="text-danger">*</span></label>
                    <select name="matiere_id" class="form-select @error('matiere_id') is-invalid @enderror" required>
                        <option value="">Sélectionner une matière...</option>
                        @foreach($matieres_disponibles as $m)
                            <option value="{{ $m->id }}">{{ $m->nom }} (Défaut: Coeff {{ $m->coefficient }})</option>
                        @endforeach
                    </select>
                    @error('matiere_id') <div class="invalid-feedback">{{ $message }}</div> @enderror
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Professeur (Optionnel)</label>
                    <select name="enseignant_id" class="form-select @error('enseignant_id') is-invalid @enderror">
                        <option value="">-- Non assigné --</option>
                        @foreach($enseignants_disponibles as $e)
                            <option value="{{ $e->id }}">{{ $e->user->name }}</option>
                        @endforeach
                    </select>
                    @error('enseignant_id') <div class="invalid-feedback">{{ $message }}</div> @enderror
                </div>

                <div class="row g-3 mb-4">
                    <div class="col-6">
                        <label class="form-label fw-semibold" title="Remplacer le coefficient par défaut">Coeff. Classe</label>
                        <input type="number" step="0.5" min="0.5" max="10" name="coefficient_override" class="form-control" placeholder="Défaut" value="{{ old('coefficient_override') }}">
                    </div>
                    <div class="col-6">
                        <label class="form-label fw-semibold">Heures / sem <span class="text-danger">*</span></label>
                        <input type="number" min="1" name="heures_semaine" class="form-control" required value="{{ old('heures_semaine', 2) }}">
                    </div>
                </div>

                <button type="submit" class="btn btn-primary w-100 fw-bold">Ajouter la matière</button>
            </form>
        </div>
    </div>

    <!-- Liste des Matières de la classe -->
    <div class="col-md-8">
        <div class="card p-4 border-0 shadow-sm">
            <h5 class="fw-bold mb-4">Programme Pédagogique de la Classe</h5>
            
            @if(session('success'))
                <div class="alert alert-success border-0 shadow-sm rounded-4 mb-4">
                    <i class='bx bx-check-circle me-1'></i> {{ session('success') }}
                </div>
            @endif

            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th class="border-0 rounded-start">Matière</th>
                            <th class="border-0">Type</th>
                            <th class="border-0">Professeur</th>
                            <th class="border-0 text-center">Coeff</th>
                            <th class="border-0 text-center">Heures</th>
                            <th class="border-0 rounded-end text-end">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($classe->matieres as $matiere)
                        <tr>
                            <td class="fw-bold">{{ $matiere->nom }}</td>
                            <td>
                                @if($matiere->type == 'obligatoire')
                                    <span class="badge bg-success-subtle text-success">Obligatoire</span>
                                @else
                                    <span class="badge bg-warning-subtle text-warning">Optionnel</span>
                                @endif
                            </td>
                            <td>
                                @if($matiere->pivot->enseignant_id)
                                    {{ \App\Models\Enseignant::find($matiere->pivot->enseignant_id)->user->name ?? 'Inconnu' }}
                                @else
                                    <span class="text-muted fst-italic">Non assigné</span>
                                @endif
                            </td>
                            <td class="text-center">
                                @if($matiere->pivot->coefficient_override)
                                    <span class="badge bg-primary">{{ $matiere->pivot->coefficient_override }}</span>
                                @else
                                    <span class="badge bg-light text-dark border">{{ $matiere->coefficient }}</span>
                                @endif
                            </td>
                            <td class="text-center">{{ $matiere->pivot->heures_semaine }}h</td>
                            <td class="text-end">
                                <form action="{{ route('classes.matieres.detach', [$classe, $matiere]) }}" method="POST" class="d-inline">
                                    @csrf @method('DELETE')
                                    <button class="btn btn-sm btn-light text-danger" title="Retirer de la classe" onclick="return confirm('Retirer cette matière de la classe ?')">
                                        <i class='bx bx-unlink'></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                        @empty
                        <tr>
                            <td colspan="6" class="text-center py-5 text-muted">
                                <i class='bx bx-book-open fs-1 d-block mb-3'></i>
                                Aucune matière n'a encore été attribuée à cette classe.
                            </td>
                        </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
@endsection
