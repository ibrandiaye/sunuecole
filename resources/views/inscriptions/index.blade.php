@extends('layouts.app')

@section('title', 'Gestion des Inscriptions')
@section('page_title', 'Liste des Inscriptions')

@section('content')
<div class="card p-4 animate__animated animate__fadeIn">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h5 class="fw-bold mb-0">Cursus des Élèves</h5>
        <a href="{{ route('inscriptions.create') }}" class="btn btn-primary d-flex align-items-center">
            <i class='bx bx-plus-circle me-1'></i> Nouvelle Inscription
        </a>
    </div>

    <div class="table-responsive">
        <table class="table table-hover align-middle">
            <thead class="bg-light">
                <tr>
                    <th>ÉLÈVE</th>
                    <th>CLASSE</th>
                    <th>ANNÉE SCOLAIRE</th>
                    <th>DATE</th>
                    <th>STATUT</th>
                    <th class="text-end">ACTIONS</th>
                </tr>
            </thead>
            <tbody>
                @forelse($inscriptions as $inscription)
                <tr>
                    <td>
                        <div class="d-flex align-items-center">
                            <i class='bx bxs-user-circle text-primary fs-3 me-2'></i>
                            <div>
                                <h6 class="mb-0 fw-bold">{{ $inscription->eleve->prenom }} {{ $inscription->eleve->nom }}</h6>
                                <small class="text-muted">{{ $inscription->eleve->matricule }}</small>
                            </div>
                        </div>
                    </td>
                    <td><span class="badge bg-primary-subtle text-primary">{{ $inscription->classe->nom }}</span></td>
                    <td>{{ $inscription->anneeScolaire->libelle }}</td>
                    <td>{{ $inscription->date_inscription->format('d/m/Y') }}</td>
                    <td>
                        <span class="badge {{ $inscription->statut == 'actif' ? 'bg-success' : 'bg-secondary' }}">
                            {{ strtoupper($inscription->statut) }}
                        </span>
                    </td>
                    <td class="text-end">
                        <form action="{{ route('inscriptions.destroy', $inscription) }}" method="POST" class="d-inline">
                            @csrf @method('DELETE')
                            <button type="submit" class="btn btn-sm btn-outline-danger" onclick="return confirm('Annuler cette inscription ?')">
                                <i class='bx bx-trash'></i>
                            </button>
                        </form>
                    </td>
                </tr>
                @empty
                <tr>
                    <td colspan="6" class="text-center py-5">
                        <i class='bx bx-archive fs-1 text-muted d-block mb-2'></i>
                        <span class="text-muted">Aucune inscription trouvée</span>
                    </td>
                </tr>
                @endforelse
            </tbody>
        </table>
    </div>
    
    <div class="mt-4">
        {{ $inscriptions->links() }}
    </div>
</div>
@endsection
