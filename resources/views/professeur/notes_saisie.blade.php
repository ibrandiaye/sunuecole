@extends('layouts.app')

@section('title', 'Saisie des notes — ' . $evaluation->titre)
@section('page_title', 'Saisie des notes : ' . $evaluation->titre)

@section('content')
<div class="container-fluid p-0">
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-2">
        <div>
            <a href="{{ route('professeur.notes.devoirs', ['classe_id' => $classe->id, 'matiere_id' => $matiere->id, 'periode' => $evaluation->semestre]) }}" class="btn btn-outline-secondary btn-sm rounded-3 mb-2">
                <i class='bx bx-arrow-back me-1'></i> Retour aux évaluations
            </a>
            <h4 class="fw-bold mb-1">{{ $evaluation->titre }} &bull; {{ $classe->nom }}</h4>
            <div class="d-flex flex-wrap gap-2 align-items-center text-muted small">
                <span class="badge bg-primary bg-opacity-10 text-primary">{{ $matiere->nom }}</span>
                <span class="badge bg-secondary bg-opacity-10 text-secondary">{{ $evaluation->semestre === 'Premier Semestre' ? '1er Semestre' : '2ème Semestre' }}</span>
                <span class="badge bg-info bg-opacity-10 text-info">Coef. {{ number_format($coefficient, 0) }}</span>
                <span>Date : <strong>{{ \Carbon\Carbon::parse($evaluation->date_evaluation)->format('d/m/Y') }}</strong></span>
            </div>
        </div>
        <div>
            <button type="submit" form="notesForm" class="btn btn-primary rounded-3 px-4 py-2 fw-bold shadow-sm">
                <i class='bx bx-save me-1'></i> {{ $notesExistantes->count() > 0 ? 'Mettre à jour' : 'Enregistrer' }}
            </button>
        </div>
    </div>

    @if(session('success'))
        <div class="alert alert-success border-0 shadow-sm rounded-4 mb-4">
            <i class='bx bx-check-circle me-1'></i> {{ session('success') }}
        </div>
    @endif

    {{-- Erreurs de validation --}}
    @if ($errors->any())
        <div class="alert alert-danger border-0 shadow-sm rounded-4 mb-4">
            <ul class="mb-0">
                @foreach ($errors->all() as $error)
                    <li><i class='bx bx-error-circle me-1'></i>{{ $error }}</li>
                @endforeach
            </ul>
        </div>
    @endif

    <!-- Formulaire de saisie -->
    <form id="notesForm" action="{{ route('professeur.notes.store') }}" method="POST">
        @csrf
        <input type="hidden" name="evaluation_id" value="{{ $evaluation->id }}">

        <div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white mb-4">
            <div class="card-header bg-white py-3 px-4 border-0 d-flex justify-content-between align-items-center">
                <div>
                    <h5 class="fw-bold mb-0">Liste des Élèves ({{ count($eleves) }})</h5>
                    <small class="text-muted">{{ $notesExistantes->count() }} note(s) déjà renseignée(s)</small>
                </div>
                <div class="text-muted small">
                    <i class='bx bx-info-circle me-1'></i> Barème : note sur 20 (ex: 14.5)
                </div>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="bg-light">
                            <tr>
                                <th class="ps-4" style="width: 50px;">#</th>
                                <th>Élève</th>
                                <th>Matricule</th>
                                <th style="width: 140px;">Note (/20)</th>
                                <th>Commentaire / Appréciation</th>
                                <th class="text-end pe-4" style="width: 120px;">Statut</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($eleves as $index => $eleve)
                                @php
                                    $noteExistante = $notesExistantes->get($eleve->id);
                                    $valeur = $noteExistante ? floatval($noteExistante->valeur) : '';
                                    $commentaire = $noteExistante ? $noteExistante->commentaire : '';
                                    $oldVal = old('notes.'.$index.'.valeur', $valeur);
                                    $oldCom = old('notes.'.$index.'.commentaire', $commentaire);
                                @endphp
                                <tr>
                                    <td class="ps-4 text-muted small">{{ $index + 1 }}</td>
                                    <td>
                                        <div class="d-flex align-items-center gap-3">
                                            <div class="rounded-circle bg-primary bg-opacity-10 text-primary fw-bold d-flex align-items-center justify-content-center" style="width: 36px; height: 36px;">
                                                {{ strtoupper(substr($eleve->prenom, 0, 1)) }}{{ strtoupper(substr($eleve->nom, 0, 1)) }}
                                            </div>
                                            <div>
                                                <div class="fw-bold text-dark">{{ $eleve->nom }} {{ $eleve->prenom }}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="badge bg-light text-dark border font-monospace">{{ $eleve->matricule }}</span>
                                    </td>
                                    <td>
                                        <input type="hidden" name="notes[{{ $index }}][eleve_id]" value="{{ $eleve->id }}">
                                        <div class="input-group">
                                            <input type="number"
                                                   step="0.01" min="0" max="20"
                                                   name="notes[{{ $index }}][valeur]"
                                                   class="form-control rounded-3 text-center fw-bold fs-6 {{ $oldVal !== '' ? 'bg-primary bg-opacity-10 text-primary border-primary' : '' }}"
                                                   placeholder="--"
                                                   value="{{ $oldVal }}"
                                                   inputmode="decimal">
                                        </div>
                                    </td>
                                    <td>
                                        <input type="text"
                                               name="notes[{{ $index }}][commentaire]"
                                               class="form-control rounded-3 form-control-sm text-muted"
                                               placeholder="Appréciation facultative..."
                                               value="{{ $oldCom }}">
                                    </td>
                                    <td class="text-end pe-4">
                                        @if($oldVal !== '')
                                            <span class="badge {{ $oldVal >= 10 ? 'bg-success' : 'bg-danger' }} rounded-pill px-2 py-1">
                                                {{ $oldVal }}/20
                                            </span>
                                        @else
                                            <span class="badge bg-light text-muted border rounded-pill px-2 py-1">
                                                En attente
                                            </span>
                                        @endif
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="6" class="text-center py-5 text-muted">
                                        Aucun élève inscrit dans cette classe.
                                    </td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="card-footer bg-white border-0 py-3 px-4 d-flex justify-content-between align-items-center">
                <span class="text-muted small">Vérifiez vos notes avant d'enregistrer.</span>
                <button type="submit" class="btn btn-primary rounded-3 px-4 py-2 fw-bold shadow-sm">
                    <i class='bx bx-save me-1'></i> {{ $notesExistantes->count() > 0 ? 'Mettre à jour les notes' : 'Enregistrer les notes' }}
                </button>
            </div>
        </div>
    </form>
</div>
@endsection