@extends('layouts.app')

@section('title', 'Détails Personnel - ' . ($personnel->user ? $personnel->user->name : $personnel->prenom))

@section('content')
<div class="row">
    <!-- Profil Card -->
    <div class="col-md-4">
        <div class="card p-4 text-center shadow-sm border-0 animate__animated animate__fadeInLeft">
            <div class="position-relative d-inline-block mb-3">
                @if($personnel->photo)
                    <img src="{{ asset('storage/' . $personnel->photo) }}" class="rounded-circle border border-4 border-white shadow-sm" style="width: 150px; height: 150px; object-fit: cover;">
                @else
                    <div class="rounded-circle bg-primary-subtle text-primary d-flex align-items-center justify-content-center mx-auto" style="width: 150px; height: 150px; font-size: 64px;">
                        {{ strtoupper(substr($personnel->user ? $personnel->user->name : $personnel->prenom, 0, 1)) }}
                    </div>
                @endif
                <span class="position-absolute bottom-0 end-0 p-2 badge rounded-pill {{ $personnel->actif ? 'bg-success' : 'bg-danger' }}">
                    {{ $personnel->actif ? 'Actif' : 'Inactif' }}
                </span>
            </div>
            
            <h4 class="fw-bold mb-1">{{ $personnel->user ? $personnel->user->name : $personnel->prenom }}</h4>
            <p class="text-muted small mb-3"><i class='bx bx-id-card me-1'></i> {{ $personnel->matricule ?? 'Sans matricule' }}</p>
            
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
                    <span>{{ $personnel->user ? $personnel->user->email : $personnel->email }}</span>
                </div>
                <div class="mb-2 small d-flex align-items-center">
                    <i class='bx bx-phone text-primary me-2 fs-5'></i>
                    <span>{{ $personnel->user ? $personnel->user->telephone : $personnel->telephone }}</span>
                </div>
                <div class="mb-2 small d-flex align-items-center">
                    <i class='bx bx-map text-primary me-2 fs-5'></i>
                    <span>{{ $personnel->adresse ?? 'Adresse non renseignée' }}</span>
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
                    <button class="nav-link rounded-pill px-4" id="pills-documents-tab" data-bs-toggle="pill" data-bs-target="#pills-documents" type="button" role="tab">Documents</button>
                </li>
            </ul>

            <div class="tab-content" id="pills-tabContent">
                <!-- Overview -->
                <div class="tab-pane fade show active" id="pills-overview" role="tabpanel">
                    <div class="row g-4 mb-4">
                        <div class="col-md-6">
                            <div class="p-3 border rounded-3 bg-light-subtle">
                                <label class="fw-bold text-muted small mb-1">Fonction</label>
                                <div class="fw-semibold">{{ $personnel->fonction }}</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="p-3 border rounded-3 bg-light-subtle">
                                <label class="fw-bold text-muted small mb-1">Statut</label>
                                <div class="fw-semibold text-capitalize text-primary">{{ $personnel->statut }}</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="p-3 border rounded-3 bg-light-subtle">
                                <label class="fw-bold text-muted small mb-1">Date d'embauche</label>
                                <div class="fw-semibold">{{ \Carbon\Carbon::parse($personnel->date_embauche)->format('d F Y') }}</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="p-3 border rounded-3 bg-light-subtle">
                                <label class="fw-bold text-muted small mb-1">Charge horaire</label>
                                <div class="fw-semibold">{{ $personnel->heure_service ?? 0 }}h / semaine</div>
                            </div>
                        </div>
                    </div>

                    <h6 class="fw-bold mb-3"><i class='bx bx-info-circle me-2'></i>Détails Personnels</h6>
                    <div class="table-responsive">
                        <table class="table table-borderless table-sm">
                            <tr>
                                <td width="150" class="text-muted">Genre</td>
                                <td class="fw-bold">{{ $personnel->sexe == 'M' ? 'Masculin' : 'Féminin' }}</td>
                            </tr>
                            <tr>
                                <td class="text-muted">Date de naissance</td>
                                <td class="fw-bold">{{ $personnel->date_naissance ? \Carbon\Carbon::parse($personnel->date_naissance)->format('d/m/Y') : '-' }}</td>
                            </tr>
                            <tr>
                                <td class="text-muted">Nationalité</td>
                                <td class="fw-bold">{{ $personnel->nationalite ?? '-' }}</td>
                            </tr>
                            <tr>
                                <td class="text-muted">Dernier diplôme</td>
                                <td class="fw-bold">{{ $personnel->diplome ?? 'Non renseigné' }}</td>
                            </tr>
                        </table>
                    </div>
                </div>

                <!-- Classes & Matières -->
                <div class="tab-pane fade" id="pills-classes" role="tabpanel">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="fw-bold mb-0">Classes & Matières enseignées</h6>
                    </div>
                    
                    @if(!method_exists($personnel, 'classes') || !$personnel->classes || $personnel->classes->isEmpty())
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
                                    @foreach($personnel->classes as $classe)
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
                <!-- Documents -->
                <div class="tab-pane fade" id="pills-documents" role="tabpanel">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h5 class="mb-0 fw-bold"><i class='bx bx-folder-open text-primary me-2'></i> Documents Administratifs</h5>
                        <button type="button" class="btn btn-sm btn-primary rounded-pill px-3 shadow-sm" data-bs-toggle="modal" data-bs-target="#addDocumentModal">
                            <i class='bx bx-upload me-1'></i> Ajouter un document
                        </button>
                    </div>

                    @if($personnel->documents->isEmpty())
                        <div class="text-center py-5 bg-light rounded-4 border-dashed">
                            <i class='bx bx-file-blank text-muted' style="font-size: 3rem;"></i>
                            <p class="text-muted mt-2 mb-0">Aucun document n'a été ajouté pour le moment.</p>
                        </div>
                    @else
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead>
                                    <tr>
                                        <th>Nom du document</th>
                                        <th>Type</th>
                                        <th>Date d'ajout</th>
                                        <th class="text-end">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($personnel->documents as $doc)
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="bg-light p-2 rounded-3 me-3 text-primary">
                                                    <i class='bx bxs-file-pdf fs-5'></i>
                                                </div>
                                                <span class="fw-semibold">{{ $doc->nom }}</span>
                                            </div>
                                        </td>
                                        <td><span class="badge bg-secondary text-capitalize">{{ $doc->type_document ?? 'Document' }}</span></td>
                                        <td>{{ $doc->created_at->format('d/m/Y') }}</td>
                                        <td class="text-end">
                                            <a href="{{ Storage::url($doc->fichier_path) }}" target="_blank" class="btn btn-sm btn-light text-primary rounded-circle" title="Voir le document">
                                                <i class='bx bx-show'></i>
                                            </a>
                                            <form action="{{ route('documents.destroy', $doc) }}" method="POST" class="d-inline" onsubmit="return confirm('Supprimer ce document ?');">
                                                @csrf @method('DELETE')
                                                <button type="submit" class="btn btn-sm btn-light text-danger rounded-circle" title="Supprimer">
                                                    <i class='bx bx-trash'></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    @endif
                </div>

            </div> <!-- End tab-content -->
        </div>
    </div>
</div>

<style>
.bg-primary-subtle { background-color: #e7f1ff; }
.text-primary { color: #0d6efd !important; }
.nav-pills .nav-link.active { background-color: #0d6efd; box-shadow: 0 4px 10px rgba(13, 110, 253, 0.2); }
.border-dashed { border-style: dashed !important; }
</style>

<!-- Modal Add Document -->
<div class="modal fade" id="addDocumentModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <form action="{{ route('documents.store') }}" method="POST" enctype="multipart/form-data">
                @csrf
                <input type="hidden" name="documentable_id" value="{{ $personnel->id }}">
                <input type="hidden" name="documentable_type" value="{{ get_class($personnel) }}">
                
                <div class="modal-header border-0 pb-0">
                    <h5 class="modal-title fw-bold">Ajouter un document</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body py-4">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Nom du document</label>
                        <input type="text" name="nom" class="form-control" placeholder="ex: Contrat de travail" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Type de document</label>
                        <select name="type_document" class="form-select">
                            <option value="contrat">Contrat</option>
                            <option value="cv">CV</option>
                            <option value="diplome">Diplôme / Attestation</option>
                            <option value="identite">Pièce d'identité</option>
                            <option value="autre">Autre document administratif</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Fichier (PDF, JPG, PNG)</label>
                        <input type="file" name="fichier" class="form-control" accept=".pdf,.jpg,.jpeg,.png" required>
                    </div>
                </div>
                <div class="modal-footer border-0 bg-light rounded-bottom-3">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-primary px-4 shadow-sm">Enregistrer</button>
                </div>
            </form>
        </div>
    </div>
</div>

@endsection
