<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <title>Historique des Absences</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <style>
        :root { --primary: #f59e0b; --bg: #fffbeb; }
        body { background: var(--bg); font-family: 'Segoe UI', sans-serif; min-height: 100vh; padding-bottom: 20px; }
        .top-bar { background: var(--primary); color: white; padding: 18px 20px; }
        .top-bar a { color: white; text-decoration: none; }
        .top-bar h5 { margin: 0; font-size: 1.1rem; font-weight: 700; }
        .filter-card { background: white; border-radius: 16px; padding: 16px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); margin-bottom: 20px; }
        .date-divider { font-size: 0.8rem; font-weight: 800; color: #9ca3af; letter-spacing: 0.05em; margin: 20px 0 10px; border-bottom: 2px dashed #e5e7eb; padding-bottom: 8px; }
        .absence-item { background: white; border-radius: 12px; padding: 14px; margin-bottom: 10px; box-shadow: 0 2px 8px rgba(0,0,0,0.04); display: flex; align-items: center; gap: 12px; border-left: 4px solid #ef4444; }
        .absence-item.retard { border-left-color: #f59e0b; }
        .student-name { font-weight: 700; font-size: 0.95rem; color: #374151; margin-bottom: 2px; }
        .meta-info { font-size: 0.8rem; color: #6c757d; }
    </style>
</head>
<body>

<div class="top-bar d-flex align-items-center gap-3">
    <a href="{{ route('professeur.dashboard') }}"><i class='bx bx-left-arrow-alt fs-3'></i></a>
    <div>
        <h5>Historique des absences</h5>
        <small class="opacity-75">Consultation par classe</small>
    </div>
</div>

<div class="p-3">
    
    <div class="filter-card">
        <form action="{{ route('professeur.absences.historique') }}" method="GET">
            <label class="form-label fw-bold small text-muted mb-2">CLASSE</label>
            <select name="classe_id" class="form-select mb-3" onchange="this.form.submit()" style="border-radius:10px; font-weight:600;">
                @foreach($classes as $c)
                    <option value="{{ $c->id }}" {{ $c->id == $classe_id ? 'selected' : '' }}>{{ $c->nom }}</option>
                @endforeach
            </select>
        </form>
    </div>

    @if(!$classe)
        <div class="text-center py-5 text-muted small">Veuillez sélectionner une classe.</div>
    @elseif($absences->isEmpty())
        <div class="text-center py-5 bg-white rounded-4 shadow-sm text-muted small">
            <i class='bx bx-check-shield fs-1 mb-2 text-success opacity-50'></i><br>
            Aucune absence enregistrée pour cette classe.
        </div>
    @else
        @foreach($absences as $date => $absencesDuJour)
            <div class="date-divider">{{ \Carbon\Carbon::parse($date)->format('d/m/Y') }}</div>
            
            @foreach($absencesDuJour as $abs)
                <div class="absence-item {{ $abs->type === 'retard' ? 'retard' : '' }}">
                    <div style="width:40px;height:40px;border-radius:50%;background:#f3f4f6;display:flex;align-items:center;justify-content:center;color:#6b7280;font-weight:700;">
                        {{ strtoupper(substr($abs->eleve->nom, 0, 1)) }}
                    </div>
                    <div class="flex-grow-1">
                        <div class="student-name">{{ $abs->eleve->nom }} {{ $abs->eleve->prenom }}</div>
                        <div class="meta-info">
                            <span class="badge {{ $abs->type === 'retard' ? 'bg-warning' : 'bg-danger' }} text-white me-1">
                                {{ ucfirst($abs->type) }}
                            </span>
                            {{ $abs->matiere->nom ?? 'Matière' }} • {{ \Carbon\Carbon::parse($abs->heure_debut)->format('H:i') }} - {{ \Carbon\Carbon::parse($abs->heure_fin)->format('H:i') }}
                        </div>
                    </div>
                </div>
            @endforeach
        @endforeach
    @endif

</div>

</body>
</html>
