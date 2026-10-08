@extends('layouts.app')

@section('title', 'Évaluations — ' . $classe->nom)
@section('page_title', 'Évaluations : ' . $classe->nom)

@section('content')
<div class="container-fluid p-0">
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-2">
        <div>
            <a href="{{ route('professeur.notes.index') }}" class="btn btn-outline-secondary btn-sm rounded-3 mb-2">
                <i class='bx bx-arrow-back me-1'></i> Changer de cours
            </a>
            <h4 class="fw-bold mb-1">{{ $classe->nom }} &bull; {{ $matiere->nom }}</h4>
            <div class="d-flex flex-wrap gap-2 align-items-center text-muted small">
                <span class="badge bg-primary bg-opacity-10 text-primary">{{ $periode === 'Premier Semestre' ? '1er Semestre' : '2ème Semestre' }}</span>
                <span class="badge bg-secondary bg-opacity-10 text-secondary">Coefficient : {{ number_format($coefficient, 0) }}</span>
                <span>Total : <strong>{{ $totalEleves }} élève(s)</strong></span>
            </div>
        </div>
        <button type="button" class="btn btn-primary rounded-3 btn-sm fw-bold shadow-sm" data-bs-toggle="modal" data-bs-target="#createEvalModal">
            <i class='bx bx-plus-circle me-1'></i> Nouvelle Évaluation
        </button>
    </div>

    @if(session('success'))
        <div class="alert alert-success border-0 shadow-sm rounded-4 mb-4">
            <i class='bx bx-check-circle me-1'></i> {{ session('success') }}
        </div>
    @endif
    @if(session('warning'))
        <div class="alert alert-warning border-0 shadow-sm rounded-4 mb-4">
            <i class='bx bx-info-circle me-1'></i> {{ session('warning') }}
        </div>
    @endif

    <div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white">
        <div class="card-header bg-white py-3 px-4 border-0 d-flex justify-content-between align-items-center">
            <h5 class="fw-bold mb-0">Liste des Évaluations Programmées</h5>
            <span class="badge bg-light text-dark border">{{ $evaluations->count() }} évaluation(s)</span>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="bg-light">
                        <tr>
                            <th class="ps-4">Titre de l'évaluation</th>
                            <th>Type</th>
                            <th>Date</th>
                            <th>Progression de Saisie</th>
                            <th class="text-end pe-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($evaluations as $eval)
                            @php
                                $pct = $totalEleves > 0 ? min(100, round(($eval->notes_count / $totalEleves) * 100)) : 0;
                            @endphp
                            <tr>
                                <td class="ps-4">
                                    <strong class="text-dark">{{ $eval->titre }}</strong>
                                </td>
                                <td>
                                    <span class="badge {{ $eval->type_evaluation === 'composition' ? 'bg-warning text-dark' : 'bg-primary bg-opacity-10 text-primary' }} rounded-pill px-3 py-1">
                                        {{ ucfirst($eval->type_evaluation) }}
                                    </span>
                                </td>
                                <td>
                                    <span class="text-muted small">
                                        <i class='bx bx-calendar me-1'></i>{{ \Carbon\Carbon::parse($eval->date_evaluation)->format('d/m/Y') }}
                                    </span>
                                </td>
                                <td style="min-width: 200px;">
                                    <div class="d-flex justify-content-between small text-muted mb-1">
                                        <span>{{ $eval->notes_count }} / {{ $totalEleves }} notes</span>
                                        <strong>{{ $pct }}%</strong>
                                    </div>
                                    <div class="progress" style="height: 6px; border-radius: 10px;">
                                        <div class="progress-bar {{ $eval->type_evaluation === 'composition' ? 'bg-warning' : 'bg-primary' }}" 
                                             role="progressbar" style="width: {{ $pct }}%" aria-valuenow="{{ $pct }}" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                </td>
                                <td class="text-end pe-4">
                                    <a href="{{ route('professeur.notes.saisie', ['evaluation_id' => $eval->id]) }}" class="btn btn-outline-primary btn-sm rounded-3 fw-bold">
                                        <i class='bx bx-edit me-1'></i> Saisir les notes
                                    </a>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="5" class="text-center py-5 text-muted">
                                    <i class='bx bx-notepad fs-2 d-block mb-2 opacity-50'></i>
                                    Aucune évaluation trouvée pour cette classe et matière.<br>
                                    Cliquez sur <strong>"Nouvelle Évaluation"</strong> pour créer un devoir ou une composition.
                                </td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Modal Création Évaluation -->
<div class="modal fade" id="createEvalModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 border-0 shadow">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-bold"><i class='bx bx-plus-circle text-primary me-2'></i>Nouvelle Évaluation</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="{{ route('professeur.notes.evaluations.store') }}" method="POST">
                @csrf
                <input type="hidden" name="classe_id" value="{{ $classe->id }}">
                <input type="hidden" name="matiere_id" value="{{ $matiere->id }}">
                <input type="hidden" name="periode" value="{{ $periode }}">
                
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label small fw-bold">Titre de l'évaluation</label>
                        <input type="text" name="titre" class="form-control rounded-3" placeholder="ex: Devoir 1, Interrogation, Composition..." required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-bold">Type d'évaluation</label>
                        <select name="type_evaluation" class="form-select rounded-3" required>
                            <option value="devoir">Devoir surveillé</option>
                            <option value="composition">Composition</option>
                            <option value="examen">Examen blanc</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-bold">Date de l'évaluation</label>
                        <input type="date" name="date_evaluation" class="form-control rounded-3" value="{{ date('Y-m-d') }}" required>
                    </div>
                </div>
                <div class="modal-footer border-0 pt-0">
                    <button type="button" class="btn btn-light rounded-3" data-bs-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-primary rounded-3 px-4">Créer et continuer</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection