<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <title>Dashboard Professeur</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <style>
        :root { --primary: #4361ee; --bg: #f0f4ff; }
        body { background: var(--bg); font-family: 'Segoe UI', sans-serif; min-height: 100vh; padding-bottom: 90px; }
        .top-bar { background: var(--primary); color: white; padding: 20px; border-bottom-left-radius: 24px; border-bottom-right-radius: 24px; }
        .top-bar h5 { margin: 0; font-size: 1.2rem; font-weight: 700; }
        .stat-card { background: white; border-radius: 16px; padding: 16px; text-align: center; box-shadow: 0 4px 15px rgba(0,0,0,0.05); flex: 1; }
        .stat-card .num { font-size: 1.8rem; font-weight: 800; color: var(--primary); line-height: 1; margin-bottom: 4px; }
        .stat-card .label { font-size: 0.75rem; font-weight: 700; color: #6c757d; text-transform: uppercase; letter-spacing: 0.05em; }
        .section-title { font-size: 0.8rem; font-weight: 800; color: #9ca3af; letter-spacing: 0.08em; margin: 24px 0 12px; padding: 0 4px; }
        .menu-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }
        .menu-card { background: white; border-radius: 16px; padding: 20px 16px; text-align: center; text-decoration: none; color: inherit; box-shadow: 0 4px 15px rgba(0,0,0,0.05); transition: transform 0.2s; }
        .menu-card:active { transform: scale(0.97); }
        .menu-card i { font-size: 2.5rem; margin-bottom: 12px; display: inline-block; }
        .menu-card .title { font-weight: 700; font-size: 0.95rem; }
        .course-item { background: white; border-radius: 12px; padding: 12px 16px; margin-bottom: 10px; display: flex; align-items: center; gap: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.03); }
        .course-time { font-weight: 800; color: var(--primary); font-size: 0.9rem; min-width: 50px; text-align: center; }
        .course-info .title { font-weight: 700; font-size: 0.95rem; margin-bottom: 2px; }
        .course-info .subtitle { font-size: 0.8rem; color: #6c757d; }
    </style>
</head>
<body>

<div class="top-bar mb-4">
    <div class="d-flex align-items-center gap-3">
        <div style="width:50px;height:50px;border-radius:50%;background:rgba(255,255,255,0.2);display:flex;align-items:center;justify-content:center;font-weight:700;font-size:1.4rem;">
            {{ strtoupper(substr(auth()->user()->name, 0, 1)) }}
        </div>
        <div>
            <h5>Bonjour, {{ explode(' ', auth()->user()->name)[0] }}</h5>
            <div class="opacity-75 small">
                {{ $enseignant->specialite ?? 'Professeur' }} • {{ $classes->count() }} classe(s)
            </div>
        </div>
    </div>
</div>

<div class="px-3">
    @if(session('success'))
        <div class="alert alert-success rounded-4 mb-3 small"><i class='bx bx-check-circle me-1'></i>{{ session('success') }}</div>
    @endif

    <!-- Statistiques -->
    <div class="d-flex gap-3 mb-4">
        <div class="stat-card">
            <div class="num">{{ $totalEleves }}</div>
            <div class="label">Élèves</div>
        </div>
        <div class="stat-card">
            <div class="num text-danger">{{ $absencesAujourdhui }}</div>
            <div class="label">Abs. (Jour)</div>
        </div>
        <div class="stat-card">
            <div class="num text-success">{{ $notesMois }}</div>
            <div class="label">Notes (Mois)</div>
        </div>
    </div>

    <!-- Actions Principales -->
    <div class="section-title">ACTIONS RAPIDES</div>
    <div class="menu-grid mb-4">
        <a href="{{ route('professeur.notes.index') }}" class="menu-card">
            <i class='bx bx-edit text-primary'></i>
            <div class="title">Saisie des Notes</div>
        </a>
        <a href="{{ route('professeur.absences.index') }}" class="menu-card">
            <i class='bx bx-user-check text-warning'></i>
            <div class="title">Faire l'Appel</div>
        </a>
    </div>

    <!-- Cours du jour -->
    <div class="d-flex justify-content-between align-items-end mb-2 px-1">
        <div class="section-title mb-0">CAHIER DE TEXTES ({{ \Carbon\Carbon::parse($today)->format('d/m') }})</div>
        <a href="{{ route('professeur.absences.historique') }}" class="small fw-bold text-decoration-none">Historique</a>
    </div>

    @forelse($coursDuJour as $cours)
        <div class="course-item">
            <div class="course-time">
                {{ \Carbon\Carbon::parse($cours->heure_debut)->format('H:i') }}<br>
                <small class="text-muted fw-normal">{{ \Carbon\Carbon::parse($cours->heure_fin)->format('H:i') }}</small>
            </div>
            <div class="course-info flex-grow-1 border-start ps-3">
                <div class="title">{{ $cours->classe->nom }} • {{ $cours->matiere->nom }}</div>
                <div class="subtitle text-truncate" style="max-width: 200px;">
                    {{ $cours->titre_lecon }}
                </div>
            </div>
        </div>
    @empty
        <div class="text-center py-4 bg-white rounded-4 shadow-sm text-muted small">
            Aucun cours enregistré aujourd'hui.
        </div>
    @endforelse

</div>

</body>
</html>
