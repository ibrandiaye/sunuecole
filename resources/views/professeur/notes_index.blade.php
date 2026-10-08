@extends('layouts.app')

@section('title', 'Saisie des Notes')
@section('page_title', 'Saisie des Notes')

@section('content')
<div class="container-fluid p-0">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h4 class="fw-bold mb-1">Saisie des Notes & Évaluations</h4>
            <p class="text-muted small mb-0">Sélectionnez la classe, la matière et la période pour gérer les devoirs et compositions.</p>
        </div>
        <a href="{{ route('professeur.dashboard') }}" class="btn btn-outline-secondary btn-sm rounded-3">
            <i class='bx bx-arrow-back me-1'></i> Tableau de bord
        </a>
    </div>

    @if(session('success'))
        <div class="alert alert-success border-0 shadow-sm rounded-4 mb-4">
            <i class='bx bx-check-circle me-1'></i> {{ session('success') }}
        </div>
    @endif

    @if(isset($enseignant) && $enseignant)
        <div class="card border-0 shadow-sm rounded-4 p-3 mb-4 bg-white">
            <div class="d-flex align-items-center gap-3">
                <div class="rounded-circle bg-primary bg-opacity-10 text-primary d-flex align-items-center justify-content-center fw-bold fs-4" style="width: 48px; height: 48px;">
                    {{ strtoupper(substr(auth()->user()->name, 0, 1)) }}
                </div>
                <div>
                    <h6 class="fw-bold mb-0 text-dark">{{ auth()->user()->name }}</h6>
                    <small class="text-muted">{{ $enseignant->specialite ?? 'Professeur' }} &bull; {{ $classes->count() }} classe(s) assignée(s)</small>
                </div>
            </div>
        </div>
    @endif

    @if($classes->isEmpty())
        <div class="card border-0 shadow-sm rounded-4 p-5 text-center">
            <div class="mb-3">
                <i class='bx bx-book-open text-muted' style="font-size: 3.5rem;"></i>
            </div>
            <h5 class="fw-bold">Aucun cours assigné</h5>
            <p class="text-muted small">Aucun cours n'est actuellement assigné à votre compte.<br>Veuillez contacter l'administration de l'établissement.</p>
        </div>
    @else
        <div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
            <h5 class="fw-bold mb-3 text-dark">
                <i class='bx bx-filter-alt text-primary me-2'></i>Sélectionner le cours
            </h5>

            <form action="{{ route('professeur.notes.devoirs') }}" method="GET">
                <div class="row g-4 mb-4">
                    {{-- Classe --}}
                    <div class="col-md-6">
                        <label class="form-label small fw-bold text-uppercase text-muted">Classe</label>
                        <select name="classe_id" id="classeSelect" class="form-select rounded-3 py-2" required>
                            <option value="">— Choisir la classe —</option>
                            @foreach($classes as $classe)
                                <option value="{{ $classe->id }}">{{ $classe->nom }}</option>
                            @endforeach
                        </select>
                    </div>

                    {{-- Matière --}}
                    <div class="col-md-6">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <label class="form-label small fw-bold text-uppercase text-muted mb-0">Matière</label>
                            <span class="badge bg-primary bg-opacity-10 text-primary rounded-pill px-2" id="coefBadge" style="display: none;"></span>
                        </div>
                        <select name="matiere_id" id="matiereSelect" class="form-select rounded-3 py-2" required>
                            <option value="">— Choisir d'abord la classe —</option>
                        </select>
                    </div>

                    {{-- Semestre --}}
                    <div class="col-12">
                        <label class="form-label small fw-bold text-uppercase text-muted mb-2">Période / Semestre</label>
                        <div class="d-flex gap-3">
                            <div class="form-check form-check-inline p-0 m-0">
                                <input type="radio" class="btn-check" name="periode" id="p1" value="Premier Semestre" checked>
                                <label class="btn btn-outline-primary rounded-3 px-4 py-2 fw-semibold" for="p1">
                                    <i class='bx bx-calendar me-1'></i> 1er Semestre
                                </label>
                            </div>
                            <div class="form-check form-check-inline p-0 m-0">
                                <input type="radio" class="btn-check" name="periode" id="p2" value="Second Semestre">
                                <label class="btn btn-outline-primary rounded-3 px-4 py-2 fw-semibold" for="p2">
                                    <i class='bx bx-calendar me-1'></i> 2ème Semestre
                                </label>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="pt-3 border-top d-flex justify-content-end">
                    <button type="submit" class="btn btn-primary rounded-3 px-4 py-2 fw-bold shadow-sm">
                        <i class='bx bx-list-ul me-2'></i>Accéder aux Évaluations
                    </button>
                </div>
            </form>
        </div>
    @endif
</div>

@section('scripts')
<script>
const classeMatieres = @json($classeMatieres);
const classeSelect = document.getElementById('classeSelect');
const matiereSelect = document.getElementById('matiereSelect');
const coefBadge = document.getElementById('coefBadge');

if (classeSelect && matiereSelect) {
    classeSelect.addEventListener('change', function () {
        const id = this.value;
        matiereSelect.innerHTML = '<option value="">— Choisir la matière —</option>';
        if (coefBadge) {
            coefBadge.textContent = '';
            coefBadge.style.display = 'none';
        }

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
        if (coef && this.value && coefBadge) {
            coefBadge.textContent = 'Coefficient : ' + parseFloat(coef).toFixed(0);
            coefBadge.style.display = 'inline-block';
        } else if (coefBadge) {
            coefBadge.textContent = '';
            coefBadge.style.display = 'none';
        }
    });
}
</script>
@endsection
@endsection
