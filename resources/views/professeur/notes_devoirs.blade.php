<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <title>Évaluations — {{ $classe->nom }}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <style>
        :root { --primary: #4361ee; --bg: #f0f4ff; }
        body { background: var(--bg); font-family: 'Segoe UI', sans-serif; min-height: 100vh; padding-bottom: 30px; }
        .top-bar { background: var(--primary); color: white; padding: 16px 20px; position: sticky; top: 0; z-index: 100; }
        .top-bar a { color: white; text-decoration: none; }
        .top-bar h5 { margin: 0; font-size: 1rem; font-weight: 700; }
        .section-label { font-size: 0.7rem; font-weight: 800; letter-spacing: 0.08em; color: #9ca3af; margin: 20px 0 10px; }
        .eval-card { background: white; border-radius: 14px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 12px; text-decoration: none; color: inherit; display: block; position: relative; overflow: hidden; padding: 14px 16px 14px 22px; }
        .eval-card::before { content: ''; position: absolute; left: 0; top: 0; bottom: 0; width: 5px; background: var(--primary); }
        .eval-card.compo::before { background: #f59e0b; }
        .eval-card:active { background: #f8f9ff; }
        .eval-card .title { font-weight: 700; font-size: 0.95rem; }
        .eval-card .meta { font-size: 0.8rem; color: #6b7280; margin-top: 4px; }
        .progress-bar-wrap { height: 4px; background: #e5e7eb; border-radius: 10px; margin-top: 8px; }
        .progress-bar-fill { height: 4px; border-radius: 10px; background: var(--primary); transition: width .3s; }
        .progress-bar-fill.compo { background: #f59e0b; }
        .new-btn { border: 2px dashed #d1d5db; background: transparent; border-radius: 14px; padding: 14px; text-align: center; color: #6b7280; font-weight: 700; font-size: 0.9rem; display: block; text-decoration: none; cursor: pointer; }
        .new-btn:active { background: #f3f4f6; }
    </style>
</head>
<body>

<div class="top-bar">
    <div class="d-flex align-items-center gap-3">
        <a href="{{ route('professeur.notes.index') }}"><i class='bx bx-left-arrow-alt fs-3'></i></a>
        <div class="flex-grow-1">
            <h5>{{ $classe->nom }}</h5>
            <small class="opacity-75">
                {{ $matiere->nom }} &bull;
                {{ $periode === 'Premier Semestre' ? 'Semestre 1' : 'Semestre 2' }}
                &bull; Coef. {{ number_format($coefficient, 0) }}
            </small>
        </div>
    </div>
</div>

<div class="p-3">

    @if(session('success'))
        <div class="alert alert-success rounded-4 mb-3 small">
            <i class='bx bx-check-circle me-1'></i>{{ session('success') }}
        </div>
    @endif
    @if(session('warning'))
        <div class="alert alert-warning rounded-4 mb-3 small">
            <i class='bx bx-info-circle me-1'></i>{{ session('warning') }}
        </div>
    @endif

    <button type="button" class="new-btn w-100 mb-3" data-bs-toggle="modal" data-bs-target="#createEvalModal">
        <i class='bx bx-plus-circle me-1'></i> Nouvelle Évaluation
    </button>

    <div class="section-label">ÉVALUATIONS RÉCENTES</div>

    @forelse($evaluations as $eval)
        @php $pct = $totalEleves > 0 ? ($eval->notes_count / $totalEleves) * 100 : 0; @endphp
        <a href="{{ route('professeur.notes.saisie', ['evaluation_id' => $eval->id]) }}" class="eval-card {{ $eval->type_evaluation === 'composition' ? 'compo' : '' }}">
            <div class="d-flex justify-content-between align-items-start">
                <div class="title">{{ $eval->titre }} ({{ ucfirst($eval->type_evaluation) }})</div>
                <span style="font-size:0.75rem;color:#9ca3af;">{{ \Carbon\Carbon::parse($eval->date_evaluation)->format('d/m/Y') }}</span>
            </div>
            <div class="meta">
                {{ $eval->notes_count }}/{{ $totalEleves }} notes saisies
            </div>
            <div class="progress-bar-wrap">
                <div class="progress-bar-fill {{ $eval->type_evaluation === 'composition' ? 'compo' : '' }}" style="width:{{ $pct }}%"></div>
            </div>
        </a>
    @empty
        <div class="text-center text-muted small py-3">Aucune évaluation pour le moment. Créez-en une pour commencer à saisir des notes.</div>
    @endforelse

</div>

<!-- Modal Création Évaluation -->
<div class="modal fade" id="createEvalModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow" style="border-radius: 14px;">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-bold">Nouvelle Évaluation</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="{{ route('professeur.notes.evaluations.store') }}" method="POST">
                @csrf
                <input type="hidden" name="classe_id" value="{{ $classe->id }}">
                <input type="hidden" name="matiere_id" value="{{ $matiere->id }}">
                <input type="hidden" name="periode" value="{{ $periode }}">
                
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label small fw-bold">Titre de l'évaluation</label>
                        <input type="text" name="titre" class="form-control" placeholder="ex: Devoir 1, Test surprise..." required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-bold">Type</label>
                        <select name="type_evaluation" class="form-select" required>
                            <option value="devoir">Devoir</option>
                            <option value="composition">Composition</option>
                            <option value="examen">Examen</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-bold">Date de l'évaluation</label>
                        <input type="date" name="date_evaluation" class="form-control" value="{{ date('Y-m-d') }}" required>
                    </div>
                </div>
                <div class="modal-footer border-0 pt-0">
                    <button type="submit" class="btn btn-primary w-100 rounded-pill py-2">Créer et saisir les notes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>