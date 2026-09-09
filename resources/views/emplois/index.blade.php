@extends('layouts.app')

@section('title', 'Emploi du Temps')
@section('page_title', 'Planification Hebdomadaire')

@section('content')
<div class="row animate__animated animate__fadeIn">
    <!-- Barre de filtrage et Ajout -->
    <div class="col-md-12 mb-4">
        <div class="card p-3 shadow-sm border-0">
            <form action="{{ route('emplois.index') }}" method="GET" class="row align-items-end g-3">
                <div class="col-md-4">
                    <label class="form-label fw-bold small text-muted">SÉLECTIONNER UNE CLASSE</label>
                    <select name="classe_id" class="form-select border-0 bg-light" onchange="this.form.submit()">
                        <option value="">-- Choisir --</option>
                        @foreach($classes as $classe)
                            <option value="{{ $classe->id }}" {{ $selected_classe_id == $classe->id ? 'selected' : '' }}>
                                {{ $classe->nom }} ({{ $classe->niveau->code }})
                            </option>
                        @endforeach
                    </select>
                </div>
                <div class="col-md-8 text-end">
                    @if($selected_classe_id)
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addModal">
                            <i class='bx bx-plus me-1'></i> Ajouter un Créneau
                        </button>
                    @endif
                </div>
            </form>
        </div>
    </div>

    <!-- Grille de l'emploi du temps -->
    <div class="col-md-12">
        <div class="card p-4 border-0 shadow-sm">
            @if(!$selected_classe_id)
                <div class="text-center py-5">
                    <i class='bx bx-search-alt fs-1 text-muted opacity-25'></i>
                    <p class="mt-3 text-muted">Veuillez sélectionner une classe pour afficher son emploi du temps.</p>
                </div>
            @else
                <div class="table-responsive">
                    <table class="table table-bordered text-center">
                        <thead class="table-light">
                            <tr>
                                <th width="12%">Lundi</th>
                                <th width="12%">Mardi</th>
                                <th width="12%">Mercredi</th>
                                <th width="12%">Jeudi</th>
                                <th width="12%">Vendredi</th>
                                <th width="12%">Samedi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                @php
                                    $joursMap = [
                                        'Lundi' => 1, 'Mardi' => 2, 'Mercredi' => 3, 
                                        'Jeudi' => 4, 'Vendredi' => 5, 'Samedi' => 6
                                    ];
                                @endphp
                                @foreach($joursMap as $nom => $index)
                                    <td class="p-2" style="min-height: 400px; vertical-align: top; background: #fafafa;">
                                        @if(isset($emplois[$index]))
                                            @foreach($emplois[$index]->sortBy('heure_debut') as $item)
                                                <div class="card mb-2 border-0 shadow-sm text-start p-2 border-start border-4 border-primary" style="font-size: 11px;">
                                                    <div class="d-flex justify-content-between">
                                                        <span class="fw-bold text-primary">{{ $item->heure_debut }} - {{ $item->heure_fin }}</span>
                                                        <form action="{{ route('emplois.destroy', $item) }}" method="POST">
                                                            @csrf @method('DELETE')
                                                            <button class="btn btn-link p-0 text-danger" onclick="return confirm('Retirer ce cours ?')"><i class='bx bx-x'></i></button>
                                                        </form>
                                                    </div>
                                                    <div class="fw-bold mt-1 text-dark uppercase">{{ $item->matiere->nom }}</div>
                                                    <div class="text-muted"><i class='bx bx-user'></i> {{ $item->enseignant->user->name }}</div>
                                                    <div class="text-muted"><i class='bx bx-map-pin'></i> {{ $item->salle->nom ?? 'Standard' }}</div>
                                                </div>
                                            @endforeach
                                        @else
                                            <span class="text-muted mt-5 d-block opacity-25 small">Libre</span>
                                        @endif
                                    </td>
                                @endforeach
                            </tr>
                        </tbody>
                    </table>
                </div>
            @endif
        </div>
    </div>
</div>

<!-- Modal Ajout -->
@if($selected_classe_id)
<div class="modal fade" id="addModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content border-0 rounded-4 shadow">
            <form action="{{ route('emplois.store') }}" method="POST">
                @csrf
                <input type="hidden" name="classe_id" value="{{ $selected_classe_id }}">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold">Planifier un nouveau cours</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-12">
                            <label class="form-label">Jour</label>
                            <select name="jour" class="form-select" required>
                                <option value="Lundi">Lundi</option>
                                <option value="Mardi">Mardi</option>
                                <option value="Mercredi">Mercredi</option>
                                <option value="Jeudi">Jeudi</option>
                                <option value="Vendredi">Vendredi</option>
                                <option value="Samedi">Samedi</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Heure Début</label>
                            <input type="time" name="heure_debut" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Heure Fin</label>
                            <input type="time" name="heure_fin" class="form-control" required>
                        </div>
                        <div class="col-md-12">
                            <label class="form-label">Matière</label>
                            <select name="matiere_id" class="form-select" required id="modalMatiereSelect">
                                @foreach($matieres as $matiere)
                                    <option value="{{ $matiere->id }}">{{ $matiere->nom }} ({{ $matiere->code }})</option>
                                @endforeach
                            </select>
                            @if($matieres->isEmpty())
                                <small class="text-danger">Aucune matière n'est associée à cette classe. Allez dans Programme & Matières pour en ajouter.</small>
                            @endif
                        </div>
                        <div class="col-md-12">
                            <label class="form-label">Enseignant</label>
                            <select name="enseignant_id" class="form-select" required>
                                @foreach($enseignants as $enseignant)
                                    <option value="{{ $enseignant->id }}">{{ $enseignant->user->name }} - {{ $enseignant->specialite }}</option>
                                @endforeach
                            </select>
                        </div>
                        <div class="col-md-12">
                            <label class="form-label">Salle</label>
                            <select name="salle_id" class="form-select">
                                <option value="">-- Sans salle (Lien Vidéo ou Extérieur) --</option>
                                @foreach($salles as $salle)
                                    <option value="{{ $salle->id }}">{{ $salle->nom }} (Capacité: {{ $salle->capacite }})</option>
                                @endforeach
                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-primary px-4">Ajouter au calendrier</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endif

@endsection
