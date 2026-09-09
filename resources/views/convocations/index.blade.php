@extends('layouts.app')

@section('title', 'Gestion des Convocations et Sanctions')
@section('page_title', 'Convocations & Sanctions')

@section('content')
<div class="row animate__animated animate__fadeIn">
    <!-- Sélection Classe -->
    <div class="col-md-12 mb-4">
        <div class="card p-3 shadow-sm border-0">
            <form action="{{ route('convocations.index') }}" method="GET" class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label fw-bold small text-muted">CLASSE</label>
                    <select name="classe_id" class="form-select border-0 bg-light" required onchange="this.form.submit()">
                        <option value="">-- Sélectionner la classe --</option>
                        @foreach($classes as $classe)
                            <option value="{{ $classe->id }}" {{ $selected_classe_id == $classe->id ? 'selected' : '' }}>
                                {{ $classe->nom }}
                            </option>
                        @endforeach
                    </select>
                </div>
                <div class="col-md-8 text-end">
                    @if($selected_classe_id)
                        <button type="button" class="btn btn-primary shadow" data-bs-toggle="modal" data-bs-target="#createModal">
                            <i class='bx bx-plus-circle me-1'></i> Ajouter une Convocation
                        </button>
                    @endif
                </div>
            </form>
        </div>
    </div>

    @if(session('success'))
        <div class="col-md-12 mb-3">
            <div class="alert alert-success border-0 shadow-sm">
                {{ session('success') }}
            </div>
        </div>
    @endif

    <!-- Liste des convocations -->
    @if($selected_classe_id)
    <div class="col-md-12">
        <div class="card p-4 border-0 shadow-sm">
            <h5 class="fw-bold mb-4 text-primary"><i class='bx bx-list-ul me-2'></i>Historique de la classe</h5>
            
            @if($convocations->count() > 0)
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Date</th>
                            <th>Élève</th>
                            <th>Motif / Titre</th>
                            <th>Description</th>
                            <th>Parent Informé</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($convocations as $conv)
                        <tr>
                            <td class="fw-bold text-nowrap">{{ $conv->date_convocation->format('d/m/Y') }}</td>
                            <td>{{ $conv->eleve->prenom }} {{ $conv->eleve->nom }} ({{ $conv->eleve->matricule }})</td>
                            <td><span class="badge bg-danger">{{ $conv->motif }}</span></td>
                            <td class="text-muted small">{{ \Str::limit($conv->description, 50) }}</td>
                            <td>
                                @if($conv->parent_informe)
                                    <span class="badge bg-success"><i class='bx bx-check'></i> Oui</span>
                                @else
                                    <span class="badge bg-secondary">Non</span>
                                @endif
                            </td>
                            <td class="text-end text-nowrap">
                                <form action="{{ route('convocations.destroy', $conv->id) }}" method="POST" class="d-inline" onsubmit="return confirm('Êtes-vous sûr de vouloir supprimer ceci ?');">
                                    @csrf
                                    @method('DELETE')
                                    <button type="submit" class="btn btn-sm btn-light text-danger">
                                        <i class='bx bx-trash'></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
            @else
            <div class="alert alert-light text-center border-0 text-muted">
                Aucune convocation ou sanction enregistrée pour cette classe.
            </div>
            @endif
        </div>
    </div>
    @endif
</div>

<!-- Modal Ajout Convocation -->
@if($selected_classe_id)
<div class="modal fade" id="createModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content border-0 shadow">
            <div class="modal-header bg-primary text-white border-0">
                <h5 class="modal-title fw-bold">Nouvelle Convocation / Sanction</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="{{ route('convocations.store') }}" method="POST">
                @csrf
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-bold text-muted small">Élève concerné <span class="text-danger">*</span></label>
                            <select name="eleve_id" class="form-select bg-light border-0" required>
                                <option value="">-- Sélectionner l'élève --</option>
                                @foreach($eleves as $eleve)
                                    <option value="{{ $eleve->id }}">{{ $eleve->matricule }} - {{ $eleve->prenom }} {{ $eleve->nom }}</option>
                                @endforeach
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold text-muted small">Date <span class="text-danger">*</span></label>
                            <input type="date" name="date_convocation" class="form-control bg-light border-0" value="{{ date('Y-m-d') }}" required>
                        </div>
                        <div class="col-md-12">
                            <label class="form-label fw-bold text-muted small">Motif principal <span class="text-danger">*</span></label>
                            <input type="text" name="motif" class="form-control bg-light border-0" placeholder="Ex: Absence non justifiée, Indiscipline..." required>
                        </div>
                        <div class="col-md-12">
                            <label class="form-label fw-bold text-muted small">Description détaillée (Optionnel)</label>
                            <textarea name="description" class="form-control bg-light border-0" rows="3" placeholder="Circonstances, détails de la sanction..."></textarea>
                        </div>
                        <div class="col-md-12 mt-4">
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" name="parent_informe" id="parent_informe" value="1">
                                <label class="form-check-label fw-bold text-muted" for="parent_informe">Parent informé</label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-primary px-4 fw-bold">Enregistrer</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endif
@endsection