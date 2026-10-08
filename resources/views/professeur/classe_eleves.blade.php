@extends('layouts.app')

@section('title', 'Élèves — ' . $classe->nom)
@section('page_title', 'Classe : ' . $classe->nom)

@section('content')
<div class="container-fluid p-0">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <a href="{{ route('professeur.classes') }}" class="btn btn-outline-secondary btn-sm rounded-3 mb-2">
                <i class='bx bx-arrow-back me-1'></i> Retour aux classes
            </a>
            <h4 class="fw-bold mb-1">{{ $classe->nom }} &bull; Liste des Élèves</h4>
            <p class="text-muted small mb-0">
                Niveau : <strong>{{ $classe->niveau->nom ?? 'N/A' }}</strong> &bull; Total : <strong>{{ $eleves->count() }} élève(s)</strong>
            </p>
        </div>
        <div class="d-flex gap-2">
            <a href="{{ route('professeur.notes.index') }}" class="btn btn-primary btn-sm rounded-3">
                <i class='bx bx-edit me-1'></i> Saisie des Notes
            </a>
            <a href="{{ route('professeur.absences.index') }}" class="btn btn-success btn-sm rounded-3">
                <i class='bx bx-user-check me-1'></i> Faire l'Appel
            </a>
        </div>
    </div>

    <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0 datatable">
                    <thead class="bg-light">
                        <tr>
                            <th class="ps-4">Élève</th>
                            <th>Matricule</th>
                            <th>Genre</th>
                            <th>Date de Naissance</th>
                            <th>Tuteur / Contact</th>
                            <th class="text-end pe-4">Statut</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($eleves as $eleve)
                            <tr>
                                <td class="ps-4">
                                    <div class="d-flex align-items-center gap-3">
                                        <div class="rounded-circle bg-primary bg-opacity-10 text-primary fw-bold d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                            {{ strtoupper(substr($eleve->prenom, 0, 1)) }}{{ strtoupper(substr($eleve->nom, 0, 1)) }}
                                        </div>
                                        <div>
                                            <div class="fw-bold text-dark">{{ $eleve->nom }} {{ $eleve->prenom }}</div>
                                            <small class="text-muted">{{ $eleve->email ?? ($eleve->user?->email ?? '—') }}</small>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <span class="badge bg-light text-dark border font-monospace">{{ $eleve->matricule }}</span>
                                </td>
                                <td>
                                    <span class="badge {{ $eleve->sexe == 'M' ? 'bg-info bg-opacity-10 text-info' : 'bg-danger bg-opacity-10 text-danger' }}">
                                        {{ $eleve->sexe == 'M' ? 'Masculin' : 'Féminin' }}
                                    </span>
                                </td>
                                <td>
                                    {{ $eleve->date_naissance ? \Carbon\Carbon::parse($eleve->date_naissance)->format('d/m/Y') : '—' }}
                                    @if($eleve->lieu_naissance)
                                        <br><small class="text-muted">à {{ $eleve->lieu_naissance }}</small>
                                    @endif
                                </td>
                                <td>
                                    <div>{{ $eleve->nom_tuteur ?? '—' }}</div>
                                    <small class="text-muted">
                                        <i class='bx bx-phone me-1'></i>{{ $eleve->tel_tuteur ?? 'Non renseigné' }}
                                    </small>
                                </td>
                                <td class="text-end pe-4">
                                    <span class="badge bg-success bg-opacity-10 text-success rounded-pill px-3 py-1">Inscrit</span>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="6" class="text-center py-4 text-muted">
                                    Aucun élève inscrit dans cette classe.
                                </td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
@endsection
