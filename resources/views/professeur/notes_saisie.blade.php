<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <title>Saisie — {{ $classe->nom }}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <style>
        :root { --primary: #4361ee; --bg: #f0f4ff; }
        body { background: var(--bg); font-family: 'Segoe UI', sans-serif; min-height: 100vh; padding-bottom: 90px; }
        .top-bar { background: var(--primary); color: white; padding: 16px 20px; position: sticky; top: 0; z-index: 100; }
        .top-bar h5 { margin: 0; font-size: 1.05rem; font-weight: 700; }
        .top-bar a { color: white; text-decoration: none; }
        .info-banner { background: white; border-radius: 14px; padding: 14px 16px; margin-bottom: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.05); }
        .badge-coef { background: #eef2ff; color: #4361ee; font-size: 0.8rem; font-weight: 700; padding: 4px 10px; border-radius: 50px; }
        .badge-sem { background: #e8f5e9; color: #2e7d32; font-size: 0.8rem; font-weight: 700; padding: 4px 10px; border-radius: 50px; }
        .student-card { background: white; border-radius: 12px; box-shadow: 0 1px 6px rgba(0,0,0,0.06); margin-bottom: 10px; padding: 12px 14px; display: flex; align-items: center; justify-content: space-between; }
        .note-input { width: 78px; text-align: center; font-weight: 700; font-size: 1.15rem; border-radius: 10px; border: 2px solid #e2e8f0; background: #f8fafc; padding: 6px 4px; transition: all .2s; }
        .note-input:focus { outline: none; border-color: var(--primary); background: #eef2ff; }
        .note-input.has-value { background: #eef2ff; border-color: var(--primary); color: var(--primary); }
        .floating-bar { position: fixed; bottom: 0; left: 0; right: 0; background: white; padding: 14px 16px; box-shadow: 0 -4px 20px rgba(0,0,0,0.08); z-index: 1000; }
        .btn-save { background: var(--primary); color: white; border: none; border-radius: 14px; padding: 14px; font-size: 1rem; font-weight: 700; width: 100%; }
    </style>
</head>
<body>

<div class="top-bar">
    <div class="d-flex align-items-center gap-3">
        <a href="{{ route('professeur.notes.devoirs', ['classe_id'=>$classe->id, 'matiere_id'=>$matiere->id, 'periode'=>$evaluation->semestre]) }}"><i class='bx bx-left-arrow-alt fs-3'></i></a>
        <div class="flex-grow-1">
            <h5>Saisie : {{ $evaluation->titre }}</h5>
            <small class="opacity-75">
                {{ $classe->nom }} &bull; {{ $matiere->nom }} &bull; Coef. {{ number_format($coefficient, 0) }}
            </small>
        </div>
    </div>
</div>

<form action="{{ route('professeur.notes.store') }}" method="POST">
    @csrf
    <input type="hidden" name="evaluation_id" value="{{ $evaluation->id }}">
    
    <div class="p-3">

        <div class="d-flex justify-content-between align-items-center mb-3 mt-2">
            <span class="fw-bold text-secondary">{{ count($eleves) }} Élèves</span>
            <button type="submit" class="btn btn-primary btn-sm rounded-pill px-3 shadow-sm">
                Enregistrer
            </button>
        </div>

        {{-- Erreurs de validation --}}
        @if ($errors->any())
            <div class="alert alert-danger rounded-4 mb-3 small">
                @foreach ($errors->all() as $error)
                    <div><i class='bx bx-error-circle me-1'></i>{{ $error }}</div>
                @endforeach
            </div>
        @endif

        {{-- Fiche récapitulative (lecture seule, informations automatiques) --}}
        <div class="info-banner mb-3">
            <div class="d-flex justify-content-between align-items-center mb-2">
                <span class="fw-bold text-dark small">{{ $matiere->nom }}</span>
                <div class="d-flex gap-2">
                    <span class="badge-coef">Coef. {{ number_format($coefficient, 0) }}</span>
                    <span class="badge-sem">{{ $evaluation->semestre === 'Premier Semestre' ? 'Sem. 1' : 'Sem. 2' }}</span>
                </div>
            </div>
            <div class="d-flex gap-3 text-muted small">
                <span><i class='bx bx-group me-1'></i>{{ count($eleves) }} élèves</span>
                <span><i class='bx bx-check-circle me-1 text-success'></i>{{ $notesExistantes->count() }} notes saisies</span>
                @if($notesExistantes->count() > 0)
                    <span class="text-warning fw-bold"><i class='bx bx-edit me-1'></i>Mode modification</span>
                @endif
            </div>
        </div>

        {{-- Date d'évaluation --}}
        <div class="info-banner mb-3">
            <label class="fw-bold text-muted small d-block mb-1">DATE DE L'ÉVALUATION</label>
            <input type="date" name="date_evaluation"
                   class="form-control border-0 bg-light fw-bold"
                   value="{{ \Carbon\Carbon::parse($evaluation->date_evaluation)->format('Y-m-d') }}" readonly>
        </div>

        {{-- Liste des élèves --}}
        @foreach($eleves as $index => $eleve)
            @php
                $noteExistante = $notesExistantes->get($eleve->id);
                $valeur = $noteExistante ? floatval($noteExistante->valeur) : '';
                $oldVal = old('notes.'.$index.'.valeur', $valeur);
            @endphp
            <div class="student-card">
                <div>
                    <div class="fw-bold text-dark">{{ $eleve->prenom }} {{ $eleve->nom }}</div>
                    <div class="text-muted small">{{ $eleve->matricule }}</div>
                </div>
                <div>
                    <input type="hidden" name="notes[{{ $index }}][eleve_id]" value="{{ $eleve->id }}">
                    <input type="number"
                           step="0.01" min="0" max="20"
                           name="notes[{{ $index }}][valeur]"
                           class="note-input {{ $oldVal !== '' ? 'has-value' : '' }}"
                           placeholder="--"
                           value="{{ $oldVal }}"
                           inputmode="decimal"
                           onchange="this.classList.toggle('has-value', this.value !== '')">
                </div>
            </div>
        @endforeach

    </div>

    <div class="floating-bar">
        <button type="submit" class="btn-save">
            <i class='bx bx-cloud-upload me-2'></i>
            {{ $notesExistantes->count() > 0 ? 'Mettre à jour les notes' : 'Enregistrer les notes' }}
        </button>
    </div>
</form>

</body>
</html>