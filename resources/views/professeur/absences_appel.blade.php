@extends('layouts.app')

@section('title', 'Feuille d\'Appel — ' . $classe->nom)
@section('page_title', 'Appel : ' . $classe->nom)

@section('content')
<div class="container-fluid p-0">
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-2">
        <div>
            <a href="{{ route('professeur.absences.index') }}" class="btn btn-outline-secondary btn-sm rounded-3 mb-2">
                <i class='bx bx-arrow-back me-1'></i> Changer de créneau
            </a>
            <h4 class="fw-bold mb-1">{{ $classe->nom }} &bull; {{ $matiere->nom }}</h4>
            <div class="d-flex flex-wrap gap-2 align-items-center text-muted small">
                <span class="badge bg-primary bg-opacity-10 text-primary">
                    <i class='bx bx-calendar me-1'></i>{{ \Carbon\Carbon::parse($date)->format('d/m/Y') }}
                </span>
                <span class="badge bg-secondary bg-opacity-10 text-secondary">
                    <i class='bx bx-time me-1'></i>{{ $heure_debut }} - {{ $heure_fin }}
                </span>
                <span>Total : <strong>{{ count($eleves) }} élève(s)</strong></span>
            </div>
        </div>
        <div>
            <button type="submit" form="appelForm" class="btn btn-success rounded-3 px-4 py-2 fw-bold shadow-sm">
                <i class='bx bx-check-double me-1'></i> Valider l'Appel
            </button>
        </div>
    </div>

    @if ($errors->any())
        <div class="alert alert-danger border-0 shadow-sm rounded-4 mb-4">
            <ul class="mb-0">
                @foreach ($errors->all() as $error)
                    <li><i class='bx bx-error-circle me-1'></i>{{ $error }}</li>
                @endforeach
            </ul>
        </div>
    @endif

    <form id="appelForm" action="{{ route('professeur.absences.store') }}" method="POST">
        @csrf
        <input type="hidden" name="classe_id" value="{{ $classe->id }}">
        <input type="hidden" name="matiere_id" value="{{ $matiere->id }}">
        <input type="hidden" name="date_absence" value="{{ $date }}">
        <input type="hidden" name="heure_debut" value="{{ $heure_debut }}">
        <input type="hidden" name="heure_fin" value="{{ $heure_fin }}">

        <!-- Section 1 : Cahier de Textes / Leçon du jour -->
        <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
            <h5 class="fw-bold mb-3 text-dark">
                <i class='bx bx-book-content text-primary me-2'></i>Cahier de Textes & Séance du Jour
            </h5>
            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label small fw-bold text-muted text-uppercase">Titre de la leçon / Chapitre *</label>
                    <input type="text" name="titre_lecon" class="form-control rounded-3" 
                           placeholder="Ex: Chapitre 3 - Equations du second degré" 
                           value="{{ old('titre_lecon', $cahier->titre_lecon ?? '') }}" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label small fw-bold text-muted text-uppercase">Résumé du cours & Devoirs à la maison</label>
                    <input type="text" name="contenu_lecon" class="form-control rounded-3" 
                           placeholder="Contenu abordé, exercices à préparer pour le prochain cours..." 
                           value="{{ old('contenu_lecon', $cahier->contenu_lecon ?? '') }}">
                </div>
            </div>
        </div>

        <!-- Section 2 : Pointage des Élèves -->
        <div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white mb-4">
            <div class="card-header bg-white py-3 px-4 border-0 d-flex justify-content-between align-items-center">
                <h5 class="fw-bold mb-0">Feuille d'Appel des Élèves ({{ count($eleves) }})</h5>
                <div class="d-flex gap-2">
                    <button type="button" class="btn btn-outline-success btn-sm rounded-pill px-3" onclick="setAllStatus('present')">
                        Tous Présents
                    </button>
                    <button type="button" class="btn btn-outline-danger btn-sm rounded-pill px-3" onclick="setAllStatus('absent')">
                        Tous Absents
                    </button>
                </div>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="bg-light">
                            <tr>
                                <th class="ps-4" style="width: 50px;">#</th>
                                <th>Élève</th>
                                <th>Matricule</th>
                                <th class="text-center" style="width: 320px;">Statut de Présence</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($eleves as $index => $eleve)
                                @php
                                    $ex = $absencesExistantes->get($eleve->id);
                                    $currentStatut = $ex ? $ex->type : 'present';
                                @endphp
                                <tr>
                                    <td class="ps-4 text-muted small">{{ $index + 1 }}</td>
                                    <td>
                                        <div class="d-flex align-items-center gap-3">
                                            <div class="rounded-circle bg-primary bg-opacity-10 text-primary fw-bold d-flex align-items-center justify-content-center" style="width: 36px; height: 36px;">
                                                {{ strtoupper(substr($eleve->prenom, 0, 1)) }}{{ strtoupper(substr($eleve->nom, 0, 1)) }}
                                            </div>
                                            <div>
                                                <div class="fw-bold text-dark">{{ $eleve->nom }} {{ $eleve->prenom }}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="badge bg-light text-dark border font-monospace">{{ $eleve->matricule }}</span>
                                    </td>
                                    <td class="text-center">
                                        <div class="btn-group w-100" role="group">
                                            <input type="radio" class="btn-check" name="eleves[{{ $eleve->id }}]" id="statut_pres_{{ $eleve->id }}" value="present" {{ $currentStatut === 'present' ? 'checked' : '' }}>
                                            <label class="btn btn-outline-success btn-sm px-3" for="statut_pres_{{ $eleve->id }}">
                                                <i class='bx bx-check me-1'></i>Présent
                                            </label>

                                            <input type="radio" class="btn-check" name="eleves[{{ $eleve->id }}]" id="statut_ret_{{ $eleve->id }}" value="retard" {{ $currentStatut === 'retard' ? 'checked' : '' }}>
                                            <label class="btn btn-outline-warning btn-sm px-3" for="statut_ret_{{ $eleve->id }}">
                                                <i class='bx bx-time me-1'></i>Retard
                                            </label>

                                            <input type="radio" class="btn-check" name="eleves[{{ $eleve->id }}]" id="statut_abs_{{ $eleve->id }}" value="absent" {{ $currentStatut === 'absent' ? 'checked' : '' }}>
                                            <label class="btn btn-outline-danger btn-sm px-3" for="statut_abs_{{ $eleve->id }}">
                                                <i class='bx bx-x me-1'></i>Absent
                                            </label>
                                        </div>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="4" class="text-center py-5 text-muted">
                                        Aucun élève trouvé dans cette classe.
                                    </td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="card-footer bg-white border-0 py-3 px-4 d-flex justify-content-between align-items-center">
                <span class="text-muted small">L'appel enregistrera également la séance dans le cahier de textes.</span>
                <button type="submit" class="btn btn-success rounded-3 px-4 py-2 fw-bold shadow-sm">
                    <i class='bx bx-check-double me-1'></i> Valider & Enregistrer l'Appel
                </button>
            </div>
        </div>
    </form>
</div>

@section('scripts')
<script>
function setAllStatus(status) {
    document.querySelectorAll(`input[type="radio"][value="${status}"]`).forEach(radio => {
        radio.checked = true;
    });
}
</script>
@endsection
@endsection
