<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <title>Appel & Cahier de textes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <style>
        :root { --primary: #f59e0b; --bg: #fffbeb; }
        body { background: var(--bg); font-family: 'Segoe UI', sans-serif; min-height: 100vh; padding-bottom: 20px; }
        .top-bar { background: var(--primary); color: white; padding: 18px 20px; }
        .top-bar a { color: white; text-decoration: none; }
        .top-bar h5 { margin: 0; font-size: 1.1rem; font-weight: 700; }
        .card-form { background: white; border-radius: 18px; box-shadow: 0 4px 20px rgba(0,0,0,0.05); padding: 22px; margin-bottom: 16px; }
        .form-label { font-size: 0.75rem; font-weight: 700; color: #6c757d; letter-spacing: 0.05em; margin-bottom: 6px; }
        .form-select, .form-control { border-radius: 12px; border: 2px solid #e9ecef; padding: 12px 14px; font-weight: 600; }
        .form-select:focus, .form-control:focus { border-color: var(--primary); box-shadow: none; }
        .btn-go { background: var(--primary); color: white; border: none; border-radius: 14px; padding: 15px; font-size: 1rem; font-weight: 700; width: 100%; }
        .btn-go:active { opacity: 0.85; }
    </style>
</head>
<body>

<div class="top-bar d-flex align-items-center gap-3">
    <a href="{{ route('professeur.dashboard') }}"><i class='bx bx-left-arrow-alt fs-3'></i></a>
    <div>
        <h5>Appel & Cahier de textes</h5>
        <small class="opacity-75">Sélection du cours</small>
    </div>
</div>

<div class="p-3 pt-4">

    @if($classes->isEmpty())
        <div class="text-center py-5">
            <i class='bx bx-book-open text-muted' style="font-size:3rem"></i>
            <p class="text-muted mt-3">Aucun cours assigné à votre profil.</p>
        </div>
    @else

    <form action="{{ route('professeur.absences.appel') }}" method="GET">

        <div class="card-form">

            {{-- Classe --}}
            <label class="form-label">CLASSE</label>
            <select name="classe_id" id="classeSelect" class="form-select mb-4" required>
                <option value="">— Choisir la classe —</option>
                @foreach($classes as $classe)
                    <option value="{{ $classe->id }}">{{ $classe->nom }}</option>
                @endforeach
            </select>

            {{-- Matière --}}
            <label class="form-label">MATIÈRE</label>
            <select name="matiere_id" id="matiereSelect" class="form-select mb-4" required>
                <option value="">— Choisir la matière —</option>
            </select>

            {{-- Date --}}
            <label class="form-label">DATE DU COURS</label>
            <input type="date" name="date" class="form-control mb-4" value="{{ date('Y-m-d') }}" required>

            {{-- Heures --}}
            <div class="row">
                <div class="col-6">
                    <label class="form-label">DÉBUT</label>
                    <input type="time" name="heure_debut" class="form-control" value="08:00" required>
                </div>
                <div class="col-6">
                    <label class="form-label">FIN</label>
                    <input type="time" name="heure_fin" class="form-control" value="10:00" required>
                </div>
            </div>

        </div>

        <button type="submit" class="btn-go">
            <i class='bx bx-user-check me-2'></i>Démarrer l'appel
        </button>

    </form>
    @endif
</div>

<script>
const classeMatieres = @json($classeMatieres);
const classeSelect = document.getElementById('classeSelect');
const matiereSelect = document.getElementById('matiereSelect');

classeSelect.addEventListener('change', function () {
    const id = this.value;
    matiereSelect.innerHTML = '<option value="">— Choisir la matière —</option>';

    if (id && classeMatieres[id]) {
        classeMatieres[id].forEach(m => {
            const opt = document.createElement('option');
            opt.value = m.id;
            opt.textContent = m.nom;
            matiereSelect.appendChild(opt);
        });
    }
});
</script>

</body>
</html>
