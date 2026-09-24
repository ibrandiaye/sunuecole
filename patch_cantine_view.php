<?php
$f = 'resources/views/logistique/cantine/index.blade.php';
$c = <<<EOT
@extends('layouts.app')
@section('title', 'Cantine Scolaire')
@section('content')
<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="h3 mb-0 text-gray-800"><i class='bx bx-restaurant text-primary me-2'></i> Abonnements Cantine</h2>
        <button class="btn btn-primary px-4" data-bs-toggle="modal" data-bs-target="#addCantineModal">
            <i class='bx bx-plus'></i> Nouvel Abonnement
        </button>
    </div>

    <div class="card shadow-sm border-0">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover align-middle datatable">
                    <thead class="table-light">
                        <tr>
                            <th>Élève</th>
                            <th>Classe</th>
                            <th>Date de début</th>
                            <th>Date de fin</th>
                            <th>Régime Alimentaire</th>
                            <th>Statut</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach(\$abonnements as \$ab)
                        <tr>
                            <td class="fw-bold">{{ \$ab->eleve->prenom }} {{ \$ab->eleve->nom }}</td>
                            <td>{{ \$ab->eleve->classe->nom ?? '-' }}</td>
                            <td>{{ \Carbon\Carbon::parse(\$ab->date_debut)->format('d/m/Y') }}</td>
                            <td>{{ \$ab->date_fin ? \Carbon\Carbon::parse(\$ab->date_fin)->format('d/m/Y') : '-' }}</td>
                            <td>{{ \$ab->regime_alimentaire ?? 'Normal' }}</td>
                            <td>
                                @if(\$ab->actif)
                                    <span class="badge bg-success">Actif</span>
                                @else
                                    <span class="badge bg-danger">Inactif</span>
                                @endif
                            </td>
                            <td class="text-end">
                                <form action="{{ route('abonnement_cantines.destroy', \$ab) }}" method="POST" onsubmit="return confirm('Supprimer cet abonnement ?');">
                                    @csrf @method('DELETE')
                                    <button type="submit" class="btn btn-sm btn-danger rounded-circle"><i class='bx bx-trash'></i></button>
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

<div class="modal fade" id="addCantineModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <form action="{{ route('abonnement_cantines.store') }}" method="POST">
                @csrf
                <div class="modal-header border-0 pb-0">
                    <h5 class="modal-title fw-bold">Nouvel Abonnement Cantine</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body py-4">
                    <div class="mb-3">
                        <label class="form-label">Élève</label>
                        <select name="eleve_id" class="form-select select2" required>
                            <option value="">Sélectionner un élève...</option>
                            @foreach(\$eleves as \$eleve)
                                <option value="{{ \$eleve->id }}">{{ \$eleve->prenom }} {{ \$eleve->nom }} ({{ \$eleve->classe->nom ?? 'Sans classe' }})</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Date de début</label>
                        <input type="date" name="date_debut" class="form-control" required value="{{ date('Y-m-d') }}">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Date de fin (Optionnel)</label>
                        <input type="date" name="date_fin" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Régime Alimentaire</label>
                        <input type="text" name="regime_alimentaire" class="form-control" placeholder="ex: Sans sel, Végétarien...">
                    </div>
                    <div class="form-check form-switch mt-3">
                        <input class="form-check-input" type="checkbox" name="actif" value="1" checked>
                        <label class="form-check-label fw-bold text-success">Abonnement Actif</label>
                    </div>
                </div>
                <div class="modal-footer border-0 bg-light rounded-bottom-3">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-primary px-4 shadow-sm">Enregistrer</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection
EOT;
file_put_contents($f, $c);
