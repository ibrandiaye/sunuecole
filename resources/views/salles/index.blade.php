@extends('layouts.app')

@section('title', 'Gestion des Salles')
@section('page_title', 'Configuration des Locaux')

@section('content')
<div class="row animate__animated animate__fadeIn">
    <div class="col-md-4">
        <div class="card p-4">
            <h5 class="fw-bold mb-4 text-primary"><i class='bx bx-plus-circle me-2'></i>Nouvelle Salle</h5>
            <form action="{{ route('salles.store') }}" method="POST">
                @csrf
                <div class="mb-3">
                    <label class="form-label fw-bold">Nom de la salle</label>
                    <input type="text" name="nom" class="form-control" placeholder="Ex: Amphi A ou Salle 101" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-bold">Capacité (Nb. places)</label>
                    <input type="number" name="capacite" class="form-control" value="30" required>
                </div>
                <div class="mb-4">
                    <label class="form-label fw-bold">Type de salle</label>
                    <select name="type" class="form-select">
                        <option value="classe">Salle de classe</option>
                        <option value="laboratoire">Laboratoire</option>
                        <option value="informatique">Salle Informatique</option>
                        <option value="amphi">Amphithéâtre</option>
                        <option value="autre">Autre</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary w-100 py-2 fw-bold">Enregistrer la salle</button>
            </form>
        </div>
    </div>

    <div class="col-md-8">
        <div class="card p-4">
            <h5 class="fw-bold mb-4">Salles enregistrées</h5>
            <div class="table-responsive">
                <table class="table table-hover align-middle datatable">
                    <thead class="table-light">
                        <tr>
                            <th>Nom</th>
                            <th>Capacité</th>
                            <th>Type</th>
                            <th>Statut</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($salles as $salle)
                        <tr>
                            <td class="fw-bold">{{ $salle->nom }}</td>
                            <td>{{ $salle->capacite }} places</td>
                            <td><span class="badge bg-light text-dark border">{{ ucfirst($salle->type) }}</span></td>
                            <td>
                                @if($salle->disponible)
                                    <span class="badge bg-success-subtle text-success border border-success-subtle">Disponible</span>
                                @else
                                    <span class="badge bg-danger-subtle text-danger border border-danger-subtle">Occupée / HS</span>
                                @endif
                            </td>
                            <td class="text-end">
                                <form action="{{ route('salles.destroy', $salle) }}" method="POST" class="d-inline">
                                    @csrf @method('DELETE')
                                    <button class="btn btn-sm btn-light text-danger" onclick="return confirm('Supprimer cette salle ?')">
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
