@extends('layouts.app')

@section('title', 'Gestion des Notes')
@section('page_title', 'Saisie & Modification des Résultats')

@section('content')
<div class="row">
    <!-- Filtres de sélection -->
    <div class="col-md-12 mb-4">
        <div class="card p-3 shadow-sm border-0">
            <form action="{{ route('notes.index') }}" method="GET" class="row g-3 align-items-end">
                <div class="col-md-3">
                    <label class="form-label fw-bold small text-muted">CLASSE</label>
                    <select name="classe_id" class="form-select border-0 bg-light" required id="classeSelect">
                        <option value="">-- Choisir --</option>
                        @foreach($classes as $classe)
                            <option value="{{ $classe->id }}" {{ $selected_classe_id == $classe->id ? 'selected' : '' }}>
                                {{ $classe->nom }}
                            </option>
                        @endforeach
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label fw-bold small text-muted">MATIÈRE</label>
                    <select name="matiere_id" class="form-select border-0 bg-light" required id="matiereSelect">
                        <option value="">-- Choisir --</option>
                        @foreach($matieres as $matiere)
                            <option value="{{ $matiere->id }}" {{ $selected_matiere_id == $matiere->id ? 'selected' : '' }}>
                                {{ $matiere->nom }}
                            </option>
                        @endforeach
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label fw-bold small text-muted">SEMESTRE</label>
                    <select name="periode" class="form-select border-0 bg-light">
                        <option value="Premier Semestre" {{ $selected_periode == 'Premier Semestre' ? 'selected' : '' }}>Premier Semestre</option>
                        <option value="Second Semestre" {{ $selected_periode == 'Second Semestre' ? 'selected' : '' }}>Second Semestre</option>
                    </select>
                </div>
                
                <div class="col-md-3">
                    <button type="submit" class="btn btn-primary w-100">
                        <i class='bx bx-search'></i> Chercher les évaluations
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Évaluations existantes (Raccourcis rapides) -->
    @if($selected_classe_id && $selected_matiere_id)
    <div class="col-md-12 mb-3">
        <div class="d-flex align-items-center gap-2 flex-wrap">
            <span class="text-muted small fw-bold me-2">Évaluations :</span>
            @forelse($evaluationsExistantes as $eval)
                <a href="{{ route('notes.index', ['classe_id' => $selected_classe_id, 'matiere_id' => $selected_matiere_id, 'periode' => $selected_periode, 'evaluation_id' => $eval->id]) }}"
                   class="btn btn-sm {{ $selected_evaluation_id == $eval->id ? 'btn-primary' : 'btn-outline-primary' }} rounded-pill px-3">
                    {{ $eval->titre }} ({{ ucfirst($eval->type_evaluation) }})
                </a>
            @empty
                <span class="text-muted small fst-italic">Aucune évaluation.</span>
            @endforelse
            
            <button type="button" class="btn btn-sm btn-outline-success rounded-pill px-3" data-bs-toggle="modal" data-bs-target="#createEvalModal">
                <i class='bx bx-plus me-1'></i>Nouvelle Évaluation
            </button>
        </div>
    </div>
    @endif

    <!-- Message de guidage -->
    @if(($selected_classe_id && !$selected_matiere_id) || ($selected_classe_id && $selected_matiere_id && !$selected_evaluation_id))
    <div class="col-md-12 mb-4">
        <div class="card p-5 border-0 shadow-sm text-center">
            <i class='bx bx-book-open fs-1 text-primary d-block mb-3'></i>
            <h5 class="fw-bold mb-2">Classe sélectionnée : {{ $classes->firstWhere('id', $selected_classe_id)?->nom }}</h5>
            <p class="text-muted mb-0">
                @if(!$selected_matiere_id)
                    Choisissez maintenant la <strong>matière</strong> et le <strong>semestre</strong> puis cliquez sur <i class='bx bx-search'></i>.
                @else
                    Sélectionnez une <strong>Évaluation</strong> ci-dessus ou créez-en une nouvelle pour saisir les notes.
                @endif
            </p>
        </div>
    </div>
    @endif

    <!-- Saisie / Modification des notes -->
    @if($selected_evaluation_id && $selectedEvaluation)
    <div class="col-md-12">
        <form action="{{ route('notes.store') }}" method="POST">
            @csrf
            <input type="hidden" name="evaluation_id" value="{{ $selectedEvaluation->id }}">
            
            <div class="card p-4 border-0 shadow-sm mb-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h5 class="fw-bold mb-1">
                            <i class='bx bx-edit-alt me-2 text-primary'></i>
                            {{ $selectedEvaluation->titre }}
                            — {{ $selectedEvaluation->semestre }}
                        </h5>
                        <p class="text-muted mb-0 small">
                            {{ $eleves->count() }} élèves • 
                            {{ $notesExistantes->count() }} notes déjà saisies
                            @if($notesExistantes->count() > 0)
                                <span class="badge bg-warning-subtle text-warning ms-2">Mode modification</span>
                            @else
                                <span class="badge bg-success-subtle text-success ms-2">Nouvelle saisie</span>
                            @endif
                        </p>
                    </div>
                    <div>
                        <label class="form-label fw-bold small text-muted d-block">Date d'évaluation</label>
                        <input type="date" class="form-control form-control-sm" 
                               value="{{ \Carbon\Carbon::parse($selectedEvaluation->date_evaluation)->format('Y-m-d') }}" readonly disabled>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th width="5%">#</th>
                                <th width="12%">Matricule</th>
                                <th width="28%">Nom de l'Élève</th>
                                <th width="15%">Note (/20)</th>
                                <th width="40%">Observations</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($eleves as $index => $eleve)
                            @php $noteExistante = $notesExistantes->get($eleve->id); @endphp
                            <tr class="{{ $noteExistante ? '' : 'table-light' }}">
                                <td class="text-muted small">{{ $index + 1 }}</td>
                                <td class="fw-bold text-primary">{{ $eleve->matricule }}</td>
                                <td>{{ $eleve->prenom }} {{ $eleve->nom }}</td>
                                <td>
                                    <input type="hidden" name="notes[{{ $index }}][eleve_id]" value="{{ $eleve->id }}">
                                    <input type="number" step="0.25" min="0" max="20" name="notes[{{ $index }}][valeur]" 
                                           class="form-control text-center fw-bold {{ $noteExistante ? 'border-primary' : '' }}" 
                                           placeholder="--" 
                                           value="{{ $noteExistante ? $noteExistante->valeur : old('notes.'.$index.'.valeur') }}"
                                           style="border-radius: 10px; background: {{ $noteExistante ? '#f0f4ff' : '#f8f9ff' }};">
                                </td>
                                <td>
                                    <input type="text" name="notes[{{ $index }}][commentaire]" class="form-control border-0 bg-light" 
                                           placeholder="Observations facultatives..."
                                           value="{{ $noteExistante ? $noteExistante->commentaire : old('notes.'.$index.'.commentaire') }}">
                                </td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>

                <div class="d-flex justify-content-between align-items-center mt-4">
                    <div class="text-muted small">
                        <i class='bx bx-info-circle me-1'></i> 
                        Les notes existantes seront mises à jour, les nouvelles seront créées.
                    </div>
                    <button type="submit" class="btn btn-success px-5 py-2 fw-bold rounded-pill shadow-sm">
                        <i class='bx bx-cloud-upload me-2'></i>
                        {{ $notesExistantes->count() > 0 ? 'Mettre à jour les notes' : 'Enregistrer les notes' }}
                    </button>
                </div>
            </div>
        </form>
    </div>
    @endif
</div>

<!-- Modal Création Évaluation (Desktop) -->
@if($selected_classe_id && $selected_matiere_id)
<div class="modal fade" id="createEvalModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content border-0 shadow" style="border-radius: 14px;">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-bold">Nouvelle Évaluation</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="{{ route('professeur.notes.evaluations.store') }}" method="POST">
                @csrf
                <input type="hidden" name="classe_id" value="{{ $selected_classe_id }}">
                <input type="hidden" name="matiere_id" value="{{ $selected_matiere_id }}">
                <input type="hidden" name="periode" value="{{ $selected_periode }}">
                
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label small fw-bold">Titre de l'évaluation</label>
                        <input type="text" name="titre" class="form-control" placeholder="ex: Devoir 1, Test surprise..." required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-bold">Type</label>
                        <select name="type_evaluation" class="form-select" required>
                            <option value="devoir">Devoir</option>
                            <option value="composition">Composition</option>
                            <option value="examen">Examen</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-bold">Date de l'évaluation</label>
                        <input type="date" name="date_evaluation" class="form-control" value="{{ date('Y-m-d') }}" required>
                    </div>
                </div>
                <div class="modal-footer border-0 pt-0">
                    <button type="submit" class="btn btn-primary w-100 rounded-pill py-2">Créer l'évaluation</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endif
@endsection

@section('scripts')
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Filtrage dynamique des matières par classe
    const classeSelect = document.getElementById('classeSelect');
    const matiereSelect = document.getElementById('matiereSelect');
    const classeMatieres = @json($classeMatieres);

    if (classeSelect && matiereSelect) {
        classeSelect.addEventListener('change', function() {
            const classeId = this.value;
            const currentMatiereId = matiereSelect.value;
            
            // Vider le dropdown matières
            matiereSelect.innerHTML = '<option value="">-- Choisir --</option>';
            
            if (classeId && classeMatieres[classeId]) {
                classeMatieres[classeId].forEach(function(m) {
                    const option = document.createElement('option');
                    option.value = m.id;
                    option.textContent = m.nom;
                    if (m.id == currentMatiereId) option.selected = true;
                    matiereSelect.appendChild(option);
                });
            }
        });
    }
});
</script>
@endsection
