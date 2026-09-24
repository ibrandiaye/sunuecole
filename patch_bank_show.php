<?php
$f = 'resources/views/finance/banque/show.blade.php';
$c = <<<EOT
@extends('layouts.app')
@section('title', 'Détails du compte ' . \$compte_bancaire->nom_banque)
@section('content')
<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="h3 mb-0 text-gray-800">
            <a href="{{ route('compte_bancaires.index') }}" class="text-muted text-decoration-none"><i class='bx bx-arrow-back'></i></a>
            {{ \$compte_bancaire->nom_banque }}
        </h2>
        <div>
            <button class="btn btn-danger px-3 me-2" data-bs-toggle="modal" data-bs-target="#addOperationModal" data-type="retrait">
                <i class='bx bx-minus-circle'></i> Retrait / Dépense
            </button>
            <button class="btn btn-success px-4" data-bs-toggle="modal" data-bs-target="#addOperationModal" data-type="depot">
                <i class='bx bx-plus-circle'></i> Dépôt / Recette
            </button>
        </div>
    </div>

    <div class="row">
        <div class="col-md-4 mb-4">
            <div class="card bg-primary text-white border-0 shadow-sm h-100 py-3 rounded-4">
                <div class="card-body text-center">
                    <p class="text-uppercase small fw-bold mb-1 opacity-75">Solde Actuel</p>
                    <h2 class="fw-bold mb-3">{{ number_format(\$compte_bancaire->solde_actuel, 0, ',', ' ') }} FCFA</h2>
                    <p class="mb-0 small"><i class='bx bx-credit-card'></i> {{ \$compte_bancaire->numero_compte ?? 'N/A' }}</p>
                </div>
            </div>
        </div>
        
        <div class="col-md-8 mb-4">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-header bg-white border-bottom-0 pt-4 pb-0">
                    <h5 class="fw-bold text-dark mb-0">Historique des Opérations</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle datatable">
                            <thead class="table-light">
                                <tr>
                                    <th>Date</th>
                                    <th>Motif</th>
                                    <th>Type</th>
                                    <th>Montant</th>
                                    <th>Réf. Pièce</th>
                                    <th class="text-end">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                @foreach(\$operations as \$op)
                                <tr>
                                    <td>{{ \Carbon\Carbon::parse(\$op->date_operation)->format('d/m/Y') }}</td>
                                    <td>
                                        <div class="fw-semibold">{{ \$op->motif }}</div>
                                        <small class="text-muted">Enregistré par {{ \$op->user->name ?? 'Système' }}</small>
                                    </td>
                                    <td>
                                        @if(\$op->type === 'depot')
                                            <span class="badge bg-success bg-opacity-10 text-success px-3 py-2 rounded-pill"><i class='bx bx-down-arrow-alt'></i> Dépôt</span>
                                        @elseif(\$op->type === 'retrait')
                                            <span class="badge bg-danger bg-opacity-10 text-danger px-3 py-2 rounded-pill"><i class='bx bx-up-arrow-alt'></i> Retrait</span>
                                        @else
                                            <span class="badge bg-warning bg-opacity-10 text-warning px-3 py-2 rounded-pill"><i class='bx bx-minus'></i> Frais</span>
                                        @endif
                                    </td>
                                    <td class="fw-bold text-{{ \$op->type === 'depot' ? 'success' : 'danger' }}">
                                        {{ \$op->type === 'depot' ? '+' : '-' }}{{ number_format(\$op->montant, 0, ',', ' ') }}
                                    </td>
                                    <td>{{ \$op->reference_piece ?? '-' }}</td>
                                    <td class="text-end">
                                        <form action="{{ route('operation_bancaires.destroy', \$op) }}" method="POST" onsubmit="return confirm('Annuler cette opération ? Cela modifiera le solde.');">
                                            @csrf @method('DELETE')
                                            <button type="submit" class="btn btn-sm btn-light text-danger rounded-circle"><i class='bx bx-trash'></i></button>
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
    </div>
</div>

<!-- Modal Add Operation -->
<div class="modal fade" id="addOperationModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <form action="{{ route('operation_bancaires.store') }}" method="POST">
                @csrf
                <input type="hidden" name="compte_bancaire_id" value="{{ \$compte_bancaire->id }}">
                <input type="hidden" name="type" id="operationTypeInput" value="depot">
                
                <div class="modal-header border-0 pb-0">
                    <h5 class="modal-title fw-bold" id="modalOperationTitle">Nouvelle Opération</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body py-4">
                    <div class="alert alert-info border-0 rounded-3 mb-4" id="modalOperationAlert">
                        <i class='bx bx-info-circle me-1'></i> Vous allez enregistrer un mouvement financier.
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Montant (FCFA) <span class="text-danger">*</span></label>
                        <input type="number" name="montant" class="form-control form-control-lg fw-bold text-end" required min="1" placeholder="0">
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Date de l'opération <span class="text-danger">*</span></label>
                        <input type="date" name="date_operation" class="form-control" required value="{{ date('Y-m-d') }}">
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Motif / Libellé <span class="text-danger">*</span></label>
                        <input type="text" name="motif" class="form-control" required placeholder="ex: Dépôt espèces scolarité, Paiement facture eau...">
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Référence / N° Pièce (Optionnel)</label>
                        <input type="text" name="reference_piece" class="form-control" placeholder="ex: CHQ-23456, BORDEREAU-12">
                    </div>
                </div>
                <div class="modal-footer border-0 bg-light rounded-bottom-3">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-primary px-4 shadow-sm" id="btnSubmitOperation">Valider l'opération</button>
                </div>
            </form>
        </div>
    </div>
</div>

@endsection

@section('scripts')
<script>
    const addOperationModal = document.getElementById('addOperationModal');
    if (addOperationModal) {
        addOperationModal.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget;
            const type = button.getAttribute('data-type');
            
            const title = addOperationModal.querySelector('#modalOperationTitle');
            const alert = addOperationModal.querySelector('#modalOperationAlert');
            const inputType = addOperationModal.querySelector('#operationTypeInput');
            const btnSubmit = addOperationModal.querySelector('#btnSubmitOperation');
            
            inputType.value = type;
            
            if (type === 'depot') {
                title.textContent = 'Enregistrer un Dépôt';
                alert.className = 'alert alert-success border-0 rounded-3 mb-4';
                alert.innerHTML = "<i class='bx bx-trending-up me-1'></i> Le solde du compte va <strong>augmenter</strong>.";
                btnSubmit.className = 'btn btn-success px-4 shadow-sm';
            } else {
                title.textContent = 'Enregistrer un Retrait / Dépense';
                alert.className = 'alert alert-danger border-0 rounded-3 mb-4';
                alert.innerHTML = "<i class='bx bx-trending-down me-1'></i> Le solde du compte va <strong>diminuer</strong>.";
                btnSubmit.className = 'btn btn-danger px-4 shadow-sm';
            }
        });
    }
</script>
@endsection
EOT;
file_put_contents($f, $c);
