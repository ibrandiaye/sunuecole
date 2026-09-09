@extends('layouts.app')

@section('title', 'Types de Frais')
@section('page_title', 'Configuration Financière')

@section('content')
<div class="row animate__animated animate__fadeIn">
    <div class="col-md-4">
        <div class="card p-4 shadow-sm border-0">
            <h5 class="fw-bold mb-4 text-success"><i class='bx bx-plus-circle me-2'></i>Nouveau Type de Frais</h5>
            <form action="{{ route('types_paiements.store') }}" method="POST">
                @csrf
                <div class="mb-3">
                    <label class="form-label fw-bold">Nom du frais (Journal)</label>
                    <input type="text" name="nom" class="form-control" placeholder="Ex: Inscription" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-bold">Code système</label>
                    <input type="text" name="code" class="form-control" placeholder="Ex: INSCR, MENS" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-bold">Montant par défaut (FCFA)</label>
                    <input type="number" name="montant_defaut" class="form-control" value="0">
                </div>
                <div class="mb-4">
                    <label class="form-label fw-bold">Périodicité</label>
                    <select name="periodicite" class="form-select">
                        <option value="unique">Paiement unique</option>
                        <option value="mensuel">Mensuel</option>
                        <option value="trimestriel">Trimestriel</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-success w-100 py-2 fw-bold text-white">Enregistrer le motif</button>
            </form>
        </div>
    </div>

    <div class="col-md-8">
        <div class="card p-4 shadow-sm border-0">
            <h5 class="fw-bold mb-4">Rubriques financières</h5>
            <div class="table-responsive">
                <table class="table table-hover align-middle datatable">
                    <thead class="table-light">
                        <tr>
                            <th class="border-0 rounded-start">Nom</th>
                            <th class="border-0">Code</th>
                            <th class="border-0">Montant Défaut</th>
                            <th class="border-0 text-center">Périodicité</th>
                            <th class="border-0 rounded-end text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($types as $type)
                        <tr>
                            <td class="fw-bold">{{ $type->nom }}</td>
                            <td><code>{{ $type->code }}</code></td>
                            <td>{{ number_format($type->montant_defaut, 0, ',', ' ') }} FCFA</td>
                            <td class="text-center">
                                <span class="badge bg-light text-dark border">{{ ucfirst($type->periodicite) }}</span>
                            </td>
                            <td class="text-end">
                                <form action="{{ route('types_paiements.destroy', $type) }}" method="POST" class="d-inline">
                                    @csrf @method('DELETE')
                                    <button class="btn btn-sm btn-light text-danger" onclick="return confirm('Supprimer ce motif de frais ?')" title="Supprimer">
                                        <i class='bx bx-trash'></i>
                                    </button>
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
@endsection
