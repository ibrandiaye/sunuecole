@extends('layouts.app')

@section('title', 'Gestion des Niveaux')
@section('page_title', 'Configuration des Niveaux')

@section('content')
<div class="row animate__animated animate__fadeIn">
    <div class="col-md-5">
        <div class="card p-4">
            <h5 class="fw-bold mb-4 text-primary"><i class='bx bx-plus-circle me-2'></i>Ajouter un Niveau</h5>
            <form action="{{ route('niveaux.store') }}" method="POST">
                @csrf
                <div class="mb-3">
                    <label class="form-label">Nom du niveau</label>
                    <input type="text" name="nom" class="form-control" placeholder="Ex: Cours Moyen 2ème année" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Code</label>
                    <input type="text" name="code" class="form-control" placeholder="Ex: CM2" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Cycle</label>
                    <select name="cycle_id" class="form-select" required>
                        @foreach($cycles as $cycle)
                            <option value="{{ $cycle->id }}">{{ $cycle->nom }}</option>
                        @endforeach
                    </select>
                </div>
                <div class="mb-4">
                    <label class="form-label">Ordre d'affichage</label>
                    <input type="number" name="ordre" class="form-control" value="1" required>
                </div>
                <button type="submit" class="btn btn-primary w-100">Enregistrer</button>
            </form>
        </div>
    </div>

    <div class="col-md-7">
        <div class="card p-4">
            <h5 class="fw-bold mb-4">Niveaux Configurés</h5>
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr class="text-muted small">
                            <th>ORDRE</th>
                            <th>NOM</th>
                            <th>CODE</th>
                            <th>CYCLE</th>
                            <th class="text-end">ACTIONS</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($niveaux as $niveau)
                        <tr>
                            <td><span class="badge bg-light text-dark border">{{ $niveau->ordre }}</span></td>
                            <td class="fw-bold">{{ $niveau->nom }}</td>
                            <td><code>{{ $niveau->code }}</code></td>
                            <td><span class="badge bg-info-subtle text-info">{{ ucfirst($niveau->cycle->nom ?? 'N/A') }}</span></td>
                            <td class="text-end">
                                <button type="button" class="btn btn-sm btn-light text-primary" data-bs-toggle="modal" data-bs-target="#tarifsModal{{ $niveau->id }}" title="Configurer les tarifs">
                                    <i class='bx bx-money'></i>
                                </button>
                                <form action="{{ route('niveaux.destroy', $niveau) }}" method="POST" class="d-inline">
                                    @csrf @method('DELETE')
                                    <button class="btn btn-sm btn-light text-danger" onclick="return confirm('Supprimer ce niveau ?')"><i class='bx bx-trash'></i></button>
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

{{-- Modals déplacés hors du tableau pour un affichage correct --}}
@foreach($niveaux as $niveau)
    <div class="modal fade" id="tarifsModal{{ $niveau->id }}" tabindex="-1" aria-labelledby="tarifsModalLabel{{ $niveau->id }}" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <form action="{{ route('niveaux.tarifs.update', $niveau) }}" method="POST" class="modal-content border-0 shadow">
                @csrf
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title fw-bold" id="tarifsModalLabel{{ $niveau->id }}"><i class='bx bx-money me-2'></i>Tarifs - {{ $niveau->nom }}</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <p class="text-muted small mb-4">Définissez les montants spécifiques pour ce niveau. Si laissé tel quel, les montants par défaut seront utilisés.</p>
                    @foreach($types_paiement as $type)
                        @php 
                            $tarifActuel = $niveau->tarifs->where('type_paiement_id', $type->id)->first();
                        @endphp
                        <div class="mb-3">
                            <label class="form-label fw-bold d-flex justify-content-between">
                                {{ $type->nom }}
                                <small class="text-muted">(Défaut: {{ number_format($type->montant_defaut, 0, ',', ' ') }} FCFA)</small>
                            </label>
                            <div class="input-group shadow-sm">
                                <span class="input-group-text bg-white border-end-0"><i class='bx bx-wallet text-muted'></i></span>
                                <input type="number" name="tarifs[{{ $type->id }}]" class="form-control border-start-0 ps-0" value="{{ $tarifActuel ? $tarifActuel->montant : $type->montant_defaut }}" min="0" required>
                                <span class="input-group-text bg-light text-primary fw-bold border-start-0">FCFA</span>
                            </div>
                        </div>
                    @endforeach
                </div>
                <div class="modal-footer border-0 bg-light-subtle">
                    <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-primary px-4 fw-bold">Sauvegarder les tarifs</button>
                </div>
            </form>
        </div>
    </div>
@endforeach

@endsection
