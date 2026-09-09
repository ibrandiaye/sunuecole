@extends('layouts.app')

@section('title', 'Gestion des Absences')
@section('page_title', 'Feuille de Présence')

@section('content')
<div class="row animate__animated animate__fadeIn">
    <!-- Sélection Classe et Date -->
    <div class="col-md-12 mb-4">
        <div class="card p-3 shadow-sm border-0">
            <form action="{{ route('absences.index') }}" method="GET" class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label fw-bold small text-muted">CLASSE</label>
                    <select name="classe_id" class="form-select border-0 bg-light" required onchange="this.form.submit()">
                        <option value="">-- Sélectionner la classe --</option>
                        @foreach($classes as $classe)
                            <option value="{{ $classe->id }}" {{ $selected_classe_id == $classe->id ? 'selected' : '' }}>
                                {{ $classe->nom }}
                            </option>
                        @endforeach
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label fw-bold small text-muted">DATE</label>
                    <input type="date" name="date_absence" class="form-control border-0 bg-light" value="{{ $date_absence }}" onchange="this.form.submit()">
                </div>
            </form>
        </div>
    </div>

    <!-- Tableau d'appel -->
    @if($selected_classe_id)
    <div class="col-md-12">
        <form action="{{ route('absences.store') }}" method="POST">
            @csrf
            <input type="hidden" name="classe_id" value="{{ $selected_classe_id }}">
            <input type="hidden" name="date_absence" value="{{ $date_absence }}">

            <div class="card p-4 border-0 shadow-sm">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h5 class="fw-bold mb-0 text-primary"><i class='bx bx-book-open me-2'></i>Cahier de Textes & Appel</h5>
                    <div class="col-md-5 d-flex gap-2">
                        <div class="input-group input-group-sm">
                            <span class="input-group-text bg-light border-0 fw-bold text-muted">De</span>
                            <input type="time" name="heure_debut" class="form-control border-0 bg-light" required>
                        </div>
                        <div class="input-group input-group-sm">
                            <span class="input-group-text bg-light border-0 fw-bold text-muted">À</span>
                            <input type="time" name="heure_fin" class="form-control border-0 bg-light" required>
                        </div>
                    </div>
                </div>

                <!-- Section Cahier de textes -->
                <div class="row g-3 mb-4 p-3 bg-light rounded-3">
                    <div class="col-md-4">
                        <label class="form-label fw-bold small text-muted">Matière <span class="text-danger">*</span></label>
                        <select name="matiere_id" class="form-select border-0" required>
                            <option value="">-- Choisir la matière --</option>
                            @foreach($matieres as $matiere)
                                <option value="{{ $matiere->id }}">{{ $matiere->nom }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="col-md-8">
                        <label class="form-label fw-bold small text-muted">Titre de la leçon / Chapitre <span class="text-danger">*</span></label>
                        <input type="text" name="titre_lecon" class="form-control border-0" required placeholder="Ex: Résolution d'équations du second degré">
                    </div>
                    <div class="col-md-12">
                        <label class="form-label fw-bold small text-muted">Contenu détaillé / Devoirs (Optionnel)</label>
                        <textarea name="contenu_lecon" class="form-control border-0" rows="2" placeholder="Résumé du cours ou exercices donnés..."></textarea>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th width="15%">Matricule</th>
                                <th width="40%">Nom Complet</th>
                                <th width="45%" class="text-center">Statut de Présence</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($eleves as $index => $eleve)
                            <tr>
                                <td class="fw-bold">{{ $eleve->matricule }}</td>
                                <td>{{ $eleve->prenom }} {{ $eleve->nom }}</td>
                                <td>
                                    <input type="hidden" name="absences[{{ $index }}][eleve_id]" value="{{ $eleve->id }}">
                                    <div class="d-flex justify-content-center gap-3">
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="absences[{{ $index }}][statut]" id="p_{{ $eleve->id }}" value="present" checked>
                                            <label class="form-check-label text-success fw-bold" for="p_{{ $eleve->id }}">Présent</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="absences[{{ $index }}][statut]" id="a_{{ $eleve->id }}" value="absent">
                                            <label class="form-check-label text-danger fw-bold" for="a_{{ $eleve->id }}">Absent</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="absences[{{ $index }}][statut]" id="r_{{ $eleve->id }}" value="retard">
                                            <label class="form-check-label text-warning fw-bold" for="r_{{ $eleve->id }}">Retard</label>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>

                <div class="text-end mt-4">
                    <button type="submit" class="btn btn-primary px-5 py-2 fw-bold shadow">
                        Valider l'appel
                    </button>
                </div>
            </div>
        </form>
    </div>
    @endif
</div>
@endsection
