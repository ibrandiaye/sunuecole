<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <title>Espace Professeur</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <style>
        :root { --primary: #4361ee; --bg: #f0f4ff; }
        body { background: var(--bg); font-family: 'Segoe UI', sans-serif; min-height: 100vh; padding-bottom: 20px; }
        .top-bar { background: var(--primary); color: white; padding: 18px 20px; }
        .top-bar h5 { margin: 0; font-size: 1.1rem; font-weight: 700; }
        .card-form { background: white; border-radius: 18px; box-shadow: 0 4px 20px rgba(0,0,0,0.07); padding: 22px; margin-bottom: 16px; }
        .form-label { font-size: 0.75rem; font-weight: 700; color: #6c757d; letter-spacing: 0.05em; margin-bottom: 6px; }
        .form-select { border-radius: 12px; border: 2px solid #e9ecef; padding: 12px 14px; font-weight: 600; }
        .form-select:focus { border-color: var(--primary); box-shadow: none; }
        .chip-group { display: flex; gap: 10px; }
        .chip { flex: 1; border: 2px solid #e9ecef; background: white; border-radius: 50px; padding: 11px 8px; text-align: center; font-weight: 700; font-size: 0.9rem; cursor: pointer; transition: all .15s; }
        .btn-check:checked + .chip { border-color: var(--primary); background: var(--primary); color: white; }
        .coef-badge { display: none; background: #eef2ff; color: var(--primary); font-weight: 700; font-size: 0.8rem; padding: 4px 12px; border-radius: 50px; }
        .coef-badge.visible { display: inline-block; }
        .btn-go { background: var(--primary); color: white; border: none; border-radius: 14px; padding: 15px; font-size: 1rem; font-weight: 700; width: 100%; }
        .btn-go:active { opacity: 0.85; }
    </style>
</head>
<body>

<div class="top-bar d-flex align-items-center gap-3">
    <a href="{{ route('professeur.dashboard') }}"><i class='bx bx-left-arrow-alt fs-3 text-white'></i></a>
    <div>
        <h5>Saisie des Notes</h5>
        <small class="opacity-75">Sélection de la matière</small>
    </div>
</div>

<div class="p-3 pt-4">

    @if(session('success'))
        <div class="alert alert-success rounded-4 mb-3">{{ session('success') }}</div>
    @endif

    @if(isset($enseignant) && $enseignant)
        <div class="mb-4 p-3 bg-white rounded-4 shadow-sm d-flex align-items-center gap-3">
            <div style="width:44px;height:44px;border-radius:50%;background:var(--primary);display:flex;align-items:center;justify-content:center;color:white;font-weight:700;font-size:1.1rem;flex-shrink:0">
                {{ strtoupper(substr(auth()->user()->name, 0, 1)) }}
            </div>
            <div>
                <div class="fw-bold text-dark small">{{ auth()->user()->name }}</div>
                <div class="text-muted" style="font-size:0.75rem">{{ $enseignant->specialite }} • {{ $classes->count() }} classe(s)</div>
            </div>
        </div>
    @endif

    @if($classes->isEmpty())
        <div class="text-center py-5">
            <i class='bx bx-book-open text-muted' style="font-size:3rem"></i>
            <p class="text-muted mt-3">Aucun cours assigné à votre profil.<br>Contactez l'administration.</p>
        </div>
    @else

    <form action="{{ route('professeur.notes.devoirs') }}" method="GET">

        <div class="card-form">

            {{-- Classe --}}
            <label class="form-label">CLASSE</label>
            <select name="classe_id" id="classeSelect" class="form-select mb-4" required>
                <option value="">— Choisir la classe —</option>
                @foreach($classes as $classe)
                    <option value="{{ $classe->id }}">{{ $classe->nom }}</option>
                @endforeach
            </select>

            {{-- Matière + badge coefficient --}}
            <div class="d-flex justify-content-between align-items-center mb-1">
                <label class="form-label mb-0">MATIÈRE</label>
                <span class="coef-badge" id="coefBadge"></span>
            </div>
            <select name="matiere_id" id="matiereSelect" class="form-select mb-4" required>
                <option value="">— Choisir la matière —</option>
            </select>

            {{-- Semestre --}}
            <label class="form-label mb-2">SEMESTRE</label>
            <div class="chip-group mb-1">
                <input type="radio" class="btn-check" name="periode" id="p1" value="Premier Semestre" checked>
                <label class="chip" for="p1">Semestre 1</label>

                <input type="radio" class="btn-check" name="periode" id="p2" value="Second Semestre">
                <label class="chip" for="p2">Semestre 2</label>
            </div>

        </div>

        <button type="submit" class="btn-go">
            <i class='bx bx-list-ul me-2'></i>Voir les évaluations
        </button>

    </form>
    @endif {{-- fin @else classes non vides --}}
</div>

<script>
const classeMatieres = @json($classeMatieres);
const classeSelect = document.getElementById('classeSelect');
const matiereSelect = document.getElementById('matiereSelect');
const coefBadge = document.getElementById('coefBadge');

classeSelect.addEventListener('change', function () {
    const id = this.value;
    matiereSelect.innerHTML = '<option value="">— Choisir la matière —</option>';
    coefBadge.textContent = '';
    coefBadge.classList.remove('visible');

    if (id && classeMatieres[id]) {
        classeMatieres[id].forEach(m => {
            const opt = document.createElement('option');
            opt.value = m.id;
            opt.textContent = m.nom;
            opt.dataset.coef = m.coefficient;
            matiereSelect.appendChild(opt);
        });
    }
});

matiereSelect.addEventListener('change', function () {
    const selected = this.options[this.selectedIndex];
    const coef = selected?.dataset?.coef;
    if (coef && this.value) {
        coefBadge.textContent = 'Coef. ' + parseFloat(coef).toFixed(0);
        coefBadge.classList.add('visible');
    } else {
        coefBadge.textContent = '';
        coefBadge.classList.remove('visible');
    }
});
</script>

</body>
</html>
