@extends('layouts.app')
@section('title', 'Trésorerie et Banque')
@section('content')
<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="h3 mb-0 text-gray-800"><i class='bx bxs-bank text-primary me-2'></i> Trésorerie & Comptes Bancaires</h2>
        <button class="btn btn-primary px-4" data-bs-toggle="modal" data-bs-target="#addAccountModal">
            <i class='bx bx-plus'></i> Nouveau Compte
        </button>
    </div>

    <!-- Summary Widgets -->
    <div class="row mb-4">
        <div class="col-xl-4 col-md-6 mb-4">
            <div class="card border-0 border-start border-primary border-4 shadow-sm h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Solde Total Global</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">{{ number_format($totalSolde, 0, ',', ' ') }} FCFA</div>
                        </div>
                        <div class="col-auto">
                            <i class='bx bx-money fa-2x text-gray-300' style="font-size: 2.5rem; opacity: 0.3;"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        @forelse($comptes as $compte)
        <div class="col-md-4 mb-4">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-header bg-white border-0 pt-4 pb-0 d-flex justify-content-between align-items-center">
                    <h5 class="fw-bold text-primary mb-0"><i class='bx bxs-institution me-1'></i> {{ $compte->nom_banque }}</h5>
                    <span class="badge bg-{{ $compte->solde_actuel >= 0 ? 'success' : 'danger' }} rounded-pill px-3 py-2">
                        {{ number_format($compte->solde_actuel, 0, ',', ' ') }} FCFA
                    </span>
                </div>
                <div class="card-body">
                    <p class="text-muted small mb-3">Compte N° : <span class="fw-semibold text-dark">{{ $compte->numero_compte ?? 'Non renseigné' }}</span></p>
                    
                    <div class="d-flex justify-content-between text-muted small mt-4 pt-3 border-top">
                        <span><i class='bx bx-history'></i> {{ $compte->operations_count }} opérations</span>
                        <a href="{{ route('compte_bancaires.show', $compte) }}" class="text-primary text-decoration-none fw-bold">Détails <i class='bx bx-right-arrow-alt'></i></a>
                    </div>
                </div>
            </div>
        </div>
        @empty
        <div class="col-12">
            <div class="text-center py-5 bg-light rounded-4 border-dashed">
                <i class='bx bx-wallet text-muted' style="font-size: 3rem;"></i>
                <p class="text-muted mt-2 mb-0">Aucun compte bancaire configuré.</p>
            </div>
        </div>
        @endforelse
    </div>
</div>

<!-- Modal Add Account -->
<div class="modal fade" id="addAccountModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <form action="{{ route('compte_bancaires.store') }}" method="POST">
                @csrf
                <div class="modal-header border-0 pb-0">
                    <h5 class="modal-title fw-bold">Ajouter un Compte Bancaire ou Caisse</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body py-4">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Nom de la Banque ou Caisse <span class="text-danger">*</span></label>
                        <input type="text" name="nom_banque" class="form-control" placeholder="ex: CBAO, Ecobank, Caisse Principale" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Numéro de compte / IBAN</label>
                        <input type="text" name="numero_compte" class="form-control" placeholder="Facultatif pour la caisse liquide">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Solde Initial (FCFA) <span class="text-danger">*</span></label>
                        <input type="number" name="solde_initial" class="form-control" value="0" min="0" required>
                        <small class="text-muted">Le montant actuellement disponible dans ce compte.</small>
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