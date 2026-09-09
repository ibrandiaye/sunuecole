<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <title>Appel — {{ $classe->nom }}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <style>
        :root { --primary: #f59e0b; --bg: #fffbeb; --success: #10b981; --danger: #ef4444; --warning: #f59e0b; }
        body { background: var(--bg); font-family: 'Segoe UI', sans-serif; min-height: 100vh; padding-bottom: 90px; }
        .top-bar { background: var(--primary); color: white; padding: 16px 20px; position: sticky; top: 0; z-index: 100; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .top-bar a { color: white; text-decoration: none; }
        .top-bar h5 { margin: 0; font-size: 1.1rem; font-weight: 700; }
        
        .section-title { font-size: 0.75rem; font-weight: 800; color: #9ca3af; letter-spacing: 0.08em; margin: 24px 0 12px; padding: 0 4px; }
        
        .card-cahier { background: white; border-radius: 16px; padding: 16px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); margin-bottom: 20px; }
        .form-control { border-radius: 10px; border: 2px solid #e9ecef; padding: 12px; font-size: 0.95rem; }
        .form-control:focus { border-color: var(--primary); box-shadow: none; }
        
        .eleve-card { background: white; border-radius: 14px; padding: 14px; box-shadow: 0 2px 8px rgba(0,0,0,0.04); margin-bottom: 12px; display: flex; align-items: center; justify-content: space-between; }
        .eleve-name { font-weight: 700; font-size: 0.95rem; color: #374151; }
        
        .status-group { display: flex; gap: 6px; }
        .status-btn { width: 40px; height: 40px; border-radius: 50%; border: 2px solid #e5e7eb; background: white; color: #9ca3af; display: flex; align-items: center; justify-content: center; font-size: 1.2rem; cursor: pointer; transition: all 0.2s; }
        
        .radio-hidden { display: none; }
        
        /* Present */
        .radio-hidden[value="present"]:checked + .status-btn { border-color: var(--success); background: var(--success); color: white; }
        /* Absent */
        .radio-hidden[value="absent"]:checked + .status-btn { border-color: var(--danger); background: var(--danger); color: white; }
        /* Retard */
        .radio-hidden[value="retard"]:checked + .status-btn { border-color: var(--warning); background: var(--warning); color: white; }
        
        .fixed-bottom-bar { position: fixed; bottom: 0; left: 0; right: 0; background: white; padding: 16px; box-shadow: 0 -4px 20px rgba(0,0,0,0.08); z-index: 100; border-top-left-radius: 20px; border-top-right-radius: 20px; }
        .btn-save { background: var(--primary); color: white; border: none; border-radius: 14px; padding: 16px; font-size: 1.05rem; font-weight: 700; width: 100%; }
        .btn-save:active { opacity: 0.85; }
    </style>
</head>
<body>

<form action="{{ route('professeur.absences.store') }}" method="POST">
    @csrf
    <input type="hidden" name="classe_id" value="{{ $classe->id }}">
    <input type="hidden" name="matiere_id" value="{{ $matiere->id }}">
    <input type="hidden" name="date_absence" value="{{ $date }}">
    <input type="hidden" name="heure_debut" value="{{ $heure_debut }}">
    <input type="hidden" name="heure_fin" value="{{ $heure_fin }}">

    <div class="top-bar">
        <div class="d-flex align-items-center gap-3">
            <a href="{{ route('professeur.absences.index') }}"><i class='bx bx-left-arrow-alt fs-3'></i></a>
            <div>
                <h5>{{ $classe->nom }}</h5>
                <small class="opacity-75">
                    {{ \Carbon\Carbon::parse($date)->format('d/m/Y') }} • {{ $heure_debut }} - {{ $heure_fin }}
                </small>
            </div>
        </div>
    </div>

    <div class="p-3">

        {{-- CAHIER DE TEXTES --}}
        <div class="section-title">CAHIER DE TEXTES</div>
        <div class="card-cahier">
            <input type="text" name="titre_lecon" class="form-control mb-3 fw-bold" placeholder="Titre de la leçon / Chapitre (Requis)" value="{{ old('titre_lecon', $cahier?->titre_lecon) }}" required>
            <textarea name="contenu_lecon" class="form-control" rows="3" placeholder="Contenu détaillé, notions abordées (Optionnel)">{{ old('contenu_lecon', $cahier?->contenu_lecon) }}</textarea>
        </div>

        {{-- APPEL --}}
        <div class="section-title d-flex justify-content-between align-items-end">
            <span>APPEL DES ÉLÈVES</span>
            <span class="badge bg-light text-dark">{{ count($eleves) }} Élèves</span>
        </div>

        @foreach($eleves as $eleve)
            @php
                $statut = 'present'; // defaut
                if (isset($absencesExistantes[$eleve->id])) {
                    $statut = $absencesExistantes[$eleve->id]->type; // 'absent' ou 'retard'
                }
            @endphp
            <div class="eleve-card">
                <div class="eleve-name">{{ $eleve->nom }} {{ $eleve->prenom }}</div>
                
                <div class="status-group">
                    <label>
                        <input type="radio" name="eleves[{{ $eleve->id }}]" value="present" class="radio-hidden" {{ $statut === 'present' ? 'checked' : '' }}>
                        <div class="status-btn"><i class='bx bx-check'></i></div>
                    </label>
                    
                    <label>
                        <input type="radio" name="eleves[{{ $eleve->id }}]" value="absent" class="radio-hidden" {{ $statut === 'absent' ? 'checked' : '' }}>
                        <div class="status-btn"><i class='bx bx-x'></i></div>
                    </label>
                    
                    <label>
                        <input type="radio" name="eleves[{{ $eleve->id }}]" value="retard" class="radio-hidden" {{ $statut === 'retard' ? 'checked' : '' }}>
                        <div class="status-btn"><i class='bx bx-time'></i></div>
                    </label>
                </div>
            </div>
        @endforeach

    </div>

    <div class="fixed-bottom-bar">
        <button type="submit" class="btn-save">
            <i class='bx bx-save me-2'></i>Enregistrer
        </button>
    </div>
</form>

</body>
</html>
