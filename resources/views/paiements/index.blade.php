@extends('layouts.app')

@section('title', 'Gestion des Paiements')
@section('page_title', 'Journal des Encaissements')

@section('content')
<div class="row animate__animated animate__fadeIn">
    <div class="col-md-12">
        <div class="card p-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h5 class="fw-bold mb-0">Historique des transactions</h5>
                <a href="{{ route('paiements.create') }}" class="btn btn-success">
                    <i class='bx bx-plus me-1'></i> Encaisser un Paiement
                </a>
            </div>

            <div class="mb-4">
                <form action="{{ route('paiements.index') }}" method="GET" class="row g-2">
                    <div class="col-md-4">
                        <input type="text" name="search" class="form-control" placeholder="Rechercher par nom ou matricule..." value="{{ request('search') }}">
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-light"><i class='bx bx-search'></i></button>
                    </div>
                </form>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle datatable">
                    <thead class="table-light">
                        <tr>
                            <th>Référence</th>
                            <th>Élève</th>
                            <th>Type</th>
                            <th>Montant</th>
                            <th>Date</th>
                            <th>Mode</th>
                            <th class="text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($paiements as $paiement)
                        <tr>
                            <td><code>{{ $paiement->reference }}</code></td>
                            <td>
                                <div class="fw-bold">{{ $paiement->eleve->prenom }} {{ $paiement->eleve->nom }}</div>
                                <div class="small text-muted">{{ $paiement->eleve->matricule }}</div>
                            </td>
                            <td><span class="badge bg-info-subtle text-info">{{ $paiement->typePaiement->libelle }}</span></td>
                            <td class="fw-bold">{{ number_format($paiement->montant_paye, 0, ',', ' ') }} FCFA</td>
                            <td>{{ \Carbon\Carbon::parse($paiement->date_paiement)->format('d/m/Y') }}</td>
                            <td><span class="badge bg-light text-dark border">{{ $paiement->mode_paiement }}</span></td>
                            <td class="text-center">
                                <a href="{{ route('paiements.receipt', $paiement) }}" target="_blank" class="btn btn-sm btn-light text-primary" title="Imprimer le reçu">
                                    <i class='bx bx-printer'></i>
                                </a>
                            </td>
                        </tr>
                        @empty
                        <tr>
                            <td colspan="7" class="text-center py-5">Aucun paiement enregistré.</td>
                        </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
            <div class="mt-4">
                {{-- Pagination DataTables gérée côté client --}}
            </div>
        </div>
    </div>
</div>
@endsection
