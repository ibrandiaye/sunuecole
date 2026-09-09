@extends('layouts.app')

@section('title', 'Détails Enseignant - ' . $enseignant->user->name)

@section('content')
<div class="row">
    <!-- Profil Card -->
    <div class="col-md-4">
        <div class="card p-4 text-center shadow-sm border-0 animate__animated animate__fadeInLeft">
            <div class="position-relative d-inline-block mb-3">
                @if($enseignant->photo)
                    <img src="{{ asset('storage/' . $enseignant->photo) }}" class="rounded-circle border border-4 border-white shadow-sm" style="width: 150px; height: 150px; object-fit: cover;">
                @else
                    <div class="rounded-circle bg-primary-subtle text-primary d-flex align-items-center justify-content-center mx-auto" style="width: 150px; height: 150px; font-size: 64px;">
                        {{ strtoupper(substr($enseignant->user->name, 0, 1)) }}
                    </div>
                @endif
                <span class="position-absolute bottom-0 end-0 p-2 badge rounded-pill {{ $enseignant->actif ? 'bg-success' : 'bg-danger' }}">
                    {{ $enseignant->actif ? 'Actif' : 'Inactif' }}
                </span>
            </div>
            
            <h4 class="fw-bold mb-1">{{ $enseignant->user->name }}</h4>
            <p class="text-muted small mb-3"><i class='bx bx-id-card me-1'></i> {{ $enseignant->matricule ?? 'Sans matricule' }}</p>
            
            <div class="d-grid gap-2">
                <button class="btn btn-outline-primary btn-sm rounded-pill font-weight-bold">
                    <i class='bx bx-envelope me-1'></i> Message
                </button>
            </div>

            <hr class="my-4 opacity-25">

            <div class="text-start">
                <h6 class="fw-bold small text-uppercase text-muted mb-3">Informations de contact</h6>
                <div class="mb-2 small d-flex align-items-center">
                    <i class='bx bx-mail-send text-primary me-2 fs-5'></i>
                    <span>{{ $enseignant->user->email }}</span>
                </div>
                <div class="mb-2 small d-flex align-items-center">
                    <i class='bx bx-phone text-primary me-2 fs-5'></i>
                    <span>{{ $enseignant->user->telephone ?? 'Non renseigné' }}</span>
                </div>
                <div class="mb-2 small d-flex align-items-center">
                    <i class='bx bx-map text-primary me-2 fs-5'></i>
                    <span>{{ $enseignant->adresse ?? 'Adresse non renseignée' }}</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Info Area -->
    <div class="col-md-8">
        <div class="card p-4 shadow-sm border-0 animate__animated animate__fadeInRight">
            <ul class="nav nav-pills mb-4 bg-light p-1 rounded-pill d-inline-flex" id="pills-tab" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active rounded-pill px-4" id="pills-overview-tab" data-bs-toggle="pill" data-bs-target="#pills-overview" type="button" role="tab">Aperçu</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link rounded-pill px-4" id="pills-classes-tab" data-bs-toggle="pill" data-bs-target="#pills-classes" type="button" role="tab">Classes & Matières</button>
                </li>
            </ul>

            <div class="tab-content" id="pills-tabContent">
                <!-- Overview -->
                <div class="tab-pane fade show active" id="pills-overview" role="tabpanel">
                    <div class="row g-4 mb-4">
                        <div class="col-md-6">
                            <div class="p-3 border rounded-3 bg-light-subtle">
                                <label class="fw-bold text-muted small mb-1">Spécialité</label>
                                <div class="fw-semibold">{{ $enseignant->specialite }}</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="p-3 border rounded-3 bg-light-subtle">
                                <label class="fw-bold text-muted small mb-1">Statut</label>
                                <div class="fw-semibold text-capitalize text-primary">{{ $enseignant->statut }}</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="p-3 border rounded-3 bg-light-subtle">
                                <label class="fw-bold text-muted small mb-1">Date d'embauche</label>
                                <div class="fw-semibold">{{ \Carbon\Carbon::parse($enseignant->date_embauche)->format('d F Y') }}</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="p-3 border rounded-3 bg-light-subtle">
                                <label class="fw-bold text-muted small mb-1">Charge horaire</label>
                                <div class="fw-semibold">{{ $enseignant->heure_service ?? 0 }}h / semaine</div>
                            </div>
                        </div>
                    </div>

                    <h6 class="fw-bold mb-3"><i class='bx bx-info-circle me-2'></i>Détails Personnels</h6>
                    <div class="table-responsive">
                        <table class="table table-borderless table-sm">
                            <tr>
                                <td width="150" class="text-muted">Genre</td>
                                <td class="fw-bold">{{ $enseignant->sexe == 'M' ? 'Masculin' : 'Féminin' }}</td>
                            </tr>
                            <tr>
                                <td class="text-muted">Date de naissance</td>
                                <td class="fw-bold">{{ $enseignant->date_naissance ? \Carbon\Carbon::parse($enseignant->date_naissance)->format('d/m/Y') : '-' }}</td>
                            </tr>
                            <tr>
                                <td class="text-muted">Nationalité</td>
                                <td class="fw-bold">{{ $enseignant->nationalite ?? '-' }}</td>
                            </tr>
                            <tr>
                                <td class="text-muted">Dernier diplôme</td>
                                <td class="fw-bold">{{ $enseignant->diplome ?? 'Non renseigné' }}</td>
                            </tr>
                        </table>
                    </div>
                </div>

                <!-- Classes & Matières -->
                <div class="tab-pane fade" id="pills-classes" role="tabpanel">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="fw-bold mb-0">Classes & Matières enseignées</h6>
                    </div>
                    
                    @if($enseignant->classes->isEmpty())
                        <div class="alert alert-light border border-dashed text-center py-4">
                            <i class='bx bx-error-circle fs-2 text-muted mb-2'></i>
                            <p class="mb-0 text-muted small">Aucune classe officiellement assignée.</p>
                        </div>
                    @else
                        <div class="table-responsive">
                            <table class="table table-hover align-middle shadow-none">
                                <thead class="bg-light bg-opacity-50">
                                    <tr class="small text-muted">
                                        <th>CLASSE</th>
                                        <th>MATIÈRE</th>
                                        <th>COEFFICIENT</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($enseignant->classes as $classe)
                                    <tr>
                                        <td>
                                            <span class="fw-bold text-primary">{{ $classe->nom }}</span>
                                        </td>
                                        <td>
                                            @php
                                                $matiere = \App\Models\Matiere::find($classe->pivot->matiere_id);
                                            @endphp
                                            {{ $matiere->nom ?? 'Inconnue' }}
                                        </td>
                                        <td>
                                            @if($classe->pivot->coefficient_override)
                                                <span class="badge bg-warning-subtle text-warning border border-warning-subtle">{{ $classe->pivot->coefficient_override }}</span>
                                            @else
                                                <span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle">Défaut</span>
                                            @endif
                                        </td>
                                    </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    @endif
                </div>
            </div>
        </div>
    </div>
</div>

<style>
.bg-primary-subtle { background-color: #e7f1ff; }
.text-primary { color: #0d6efd !important; }
.nav-pills .nav-link.active { background-color: #0d6efd; box-shadow: 0 4px 10px rgba(13, 110, 253, 0.2); }
.border-dashed { border-style: dashed !important; }
</style>
@endsection
