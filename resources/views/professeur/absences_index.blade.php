@extends('layouts.app')

@section('title', "Faire l'Appel")
@section('page_title', "Faire l'Appel & Présences")

@section('content')
<div class="container-fluid p-0">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h4 class="fw-bold mb-1">Pointage des Présences</h4>
            <p class="text-muted small mb-0">Sélectionnez la classe, la matière et le créneau horaire pour démarrer l'appel.</p>
        </div>
        <div class="d-flex gap-2">
            <a href="{{ route('professeur.absences.historique') }}" class="btn btn-outline-secondary btn-sm rounded-3">
                <i class='bx bx-history me-1'></i> Historique des absences
            </a>
            <a href="{{ route('professeur.dashboard') }}" class="btn btn-outline-secondary btn-sm rounded-3">
                <i class='bx bx-arrow-back me-1'></i> Tableau de bord
            </a>
        </div>
    </div>

    @if(session('success'))
        <div class="alert alert-success border-0 shadow-sm rounded-4 mb-4">
            <i class='bx bx-check-circle me-1'></i> {{ session('success') }}
        </div>
    @endif

    @if($classes->isEmpty())
        <div class="card border-0 shadow-sm rounded-4 p-5 text-center">
            <div class="mb-3">
                <i class='bx bx-user-x text-muted' style="font-size: 3.5rem;"></i>
            </div>
            <h5 class="fw-bold">Aucun cours assigné</h5>
            <p class="text-muted small">Aucun cours n'est actuellement assigné à votre compte.<br>Veuillez contacter l'administration de l'établissement.</p>
        </div>
    @else
        <div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
            <h5 class="fw-bold mb-3 text-dark">
                <i class='bx bx-calendar-check text-success me-2'></i>Sélectionner la séance de cours
            </h5>

            <form action="{{ route('professeur.absences.appel') }}" method="GET">
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
                        <label class="form-label small fw-bold text-uppercase text-muted">Matière</label>
                        <select name="matiere_id" id="matiereSelect" class="form-select rounded-3 py-2" required>
                            <option value="">— Choisir d'abord la classe —</option>
                        </select>
                    </div>

                    {{-- Date --}}
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-uppercase text-muted">Date du cours</label>
                        <input type="date" name="date" class="form-control rounded-3 py-2" value="{{ date('Y-m-d') }}" required>
                    </div>

                    {{-- Heure Début --}}
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-uppercase text-muted">Heure Début</label>
                        <input type="time" name="heure_debut" class="form-control rounded-3 py-2" value="08:00" required>
                    </div>

                    {{-- Heure Fin --}}
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-uppercase text-muted">Heure Fin</label>
                        <input type="time" name="heure_fin" class="form-control rounded-3 py-2" value="10:00" required>
                    </div>
                </div>

                <div class="pt-3 border-top d-flex justify-content-end">
                    <button type="submit" class="btn btn-success rounded-3 px-4 py-2 fw-bold shadow-sm">
                        <i class='bx bx-user-check me-2'></i>Démarrer la feuille d'appel
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

if (classeSelect && matiereSelect) {
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
}
</script>
@endsection
@endsection
