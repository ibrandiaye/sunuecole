@extends('layouts.app')

@section('title', 'Années Scolaires')
@section('page_title', 'Calendrier Académique')

@section('content')
<div class="row animate__animated animate__fadeIn">
    <div class="col-md-4">
        <div class="card p-4 shadow-sm border-0">
            <h5 class="fw-bold mb-4 text-primary"><i class='bx bx-plus-circle me-2'></i>Nouvelle Année</h5>
            <form action="{{ route('annee_scolaires.store') }}" method="POST">
                @csrf
                <div class="mb-3">
                    <label class="form-label fw-bold">Libellé (ex: 2025-2026)</label>
                    <input type="text" name="libelle" class="form-control" placeholder="2025-2026" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-bold">Date de Début</label>
                    <input type="date" name="date_debut" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-bold">Date de Fin</label>
                    <input type="date" name="date_fin" class="form-control" required>
                </div>
                <div class="form-check form-switch mb-4">
                    <input class="form-check-input" type="checkbox" name="active" value="1" id="activeSwitch">
                    <label class="form-check-label" for="activeSwitch">Définir comme année active</label>
                </div>
                <button type="submit" class="btn btn-primary w-100 py-2 fw-bold">Créer l'année</button>
            </form>
        </div>
    </div>

    <div class="col-md-8">
        <div class="card p-4 shadow-sm border-0">
            <h5 class="fw-bold mb-4">Historique des Ans</h5>
            <div class="table-responsive">
                <table class="table table-hover align-middle datatable">
                    <thead class="table-light">
                        <tr>
                            <th class="border-0 rounded-start">Libellé</th>
                            <th class="border-0">Période</th>
                            <th class="border-0 text-center">Statut</th>
                            <th class="border-0 rounded-end text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($annees as $annee)
                        <tr>
                            <td class="fw-bold">{{ $annee->libelle }}</td>
                            <td>
                                Du {{ \Carbon\Carbon::parse($annee->date_debut)->format('d/m/Y') }} 
                                au {{ \Carbon\Carbon::parse($annee->date_fin)->format('d/m/Y') }}
                            </td>
                            <td class="text-center">
                                @if($annee->active)
                                    <span class="badge bg-success border border-success px-3 py-2">ACTIF</span>
                                @else
                                    <form action="{{ route('annee_scolaires.activate', $annee) }}" method="POST" class="d-inline">
                                        @csrf
                                        <button type="submit" class="btn btn-sm btn-outline-primary py-0 px-2 fw-bold" title="Activer cette année">
                                            Activer
                                        </button>
                                    </form>
                                @endif
                            </td>
                            <td class="text-end">
                                <form action="{{ route('annee_scolaires.destroy', $annee) }}" method="POST" class="d-inline">
                                    @csrf @method('DELETE')
                                    <button class="btn btn-sm btn-light text-danger" onclick="return confirm('Supprimer cette année scolaire ?')" {{ $annee->active ? 'disabled' : '' }}>
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
