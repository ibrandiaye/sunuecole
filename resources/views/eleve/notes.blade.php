@extends('layouts.app')

@section('title', 'Mes Notes & Bulletins')
@section('page_title', 'Mes Notes & Évaluations')

@section('content')
<div class="container-fluid p-0">
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-2">
        <div>
            <h4 class="fw-bold mb-1">Relevé des Notes</h4>
            <p class="text-muted small mb-0">Classe : <strong>{{ $eleve->classe->nom ?? 'N/A' }}</strong> &bull; Année scolaire active</p>
        </div>
        @if($moyenneGenerale)
            <div class="card border-0 shadow-sm rounded-4 px-4 py-2 bg-primary text-white text-center">
                <small class="text-white-50 text-uppercase fw-bold" style="font-size: 0.7rem;">Moyenne Générale</small>
                <div class="fs-4 fw-bold font-monospace">{{ number_format($moyenneGenerale, 2) }}/20</div>
            </div>
        @endif
    </div>

    <!-- Section Bulletins Scolaires -->
    @if($bulletins->isNotEmpty())
        <div class="card border-0 shadow-sm rounded-4 p-4 mb-4 bg-white">
            <h5 class="fw-bold mb-3"><i class='bx bxs-file-pdf text-danger me-2'></i>Mes Bulletins Scolaires</h5>
            <div class="row g-3">
                @foreach($bulletins as $bulletin)
                    <div class="col-md-4">
                        <div class="p-3 rounded-3 border bg-light d-flex justify-content-between align-items-center">
                            <div>
                                <div class="fw-bold text-dark">{{ $bulletin->periode ?? 'Semestre / Trimestre' }}</div>
                                <small class="text-muted">Moyenne : <strong>{{ number_format($bulletin->moyenne, 2) }}/20</strong> &bull; Rang : {{ $bulletin->rang ?? '—' }}</small>
                            </div>
                            <a href="{{ route('bulletins.generate', $eleve->id) }}?bulletin_id={{ $bulletin->id }}" target="_blank" class="btn btn-danger btn-sm rounded-3">
                                <i class='bx bx-download me-1'></i> PDF
                            </a>
                        </div>
                    </div>
                @endforeach
            </div>
        </div>
    @endif

    <!-- Tableau de toutes les Notes -->
    <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
        <div class="card-header bg-white py-3 px-4 border-0 d-flex justify-content-between align-items-center">
            <h5 class="fw-bold mb-0">Toutes mes notes</h5>
            <span class="badge bg-light text-dark border">{{ $notes->count() }} note(s) au total</span>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0 datatable">
                    <thead class="bg-light">
                        <tr>
                            <th class="ps-4">Matière</th>
                            <th>Type d'Évaluation</th>
                            <th>Date</th>
                            <th>Période</th>
                            <th>Coefficient</th>
                            <th class="text-end pe-4">Note Obtenue</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($notes as $note)
                            <tr>
                                <td class="ps-4">
                                    <strong>{{ $note->matiere->nom ?? 'Matière' }}</strong>
                                </td>
                                <td>
                                    <span class="badge bg-secondary bg-opacity-10 text-secondary border">
                                        {{ ucfirst($note->type_evaluation) }}
                                    </span>
                                </td>
                                <td>
                                    {{ $note->date_evaluation ? \Carbon\Carbon::parse($note->date_evaluation)->format('d/m/Y') : '—' }}
                                </td>
                                <td>
                                    {{ $note->semestre ? ($note->semestre == 1 ? '1er Semestre' : '2ème Semestre') : ($note->periode ?? '—') }}
                                </td>
                                <td>
                                    {{ $note->matiere->coefficient ?? ($note->coefficient ?? '1') }}
                                </td>
                                <td class="text-end pe-4">
                                    <span class="badge {{ $note->valeur >= 10 ? 'bg-success' : 'bg-danger' }} fs-6 rounded-pill px-3 py-1 font-monospace">
                                        {{ number_format($note->valeur, 2) }}/20
                                    </span>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="6" class="text-center py-5 text-muted">
                                    <i class='bx bx-notepad fs-2 d-block mb-2 opacity-50'></i>
                                    Aucune note disponible pour le moment.
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
