@extends('layouts.app')

@section('title', 'Profil Élève')
@section('page_title', 'Dossier de l\'Élève')

@section('content')
<div class="row animate__animated animate__fadeIn">
    <div class="col-md-4">
        <div class="card p-4 text-center mb-4">
            <div class="mb-3">
                @if($eleve->photo)
                    <img src="{{ asset('storage/' . $eleve->photo) }}" class="rounded-4 shadow-sm" width="150" height="150" alt="">
                @else
                    <div class="rounded-4 bg-light d-inline-flex align-items-center justify-content-center shadow-sm" style="width: 150px; height: 150px;">
                        <i class='bx bxs-user text-muted' style="font-size: 80px;"></i>
                    </div>
                @endif
            </div>
            <h5 class="fw-bold mb-1">{{ $eleve->prenom }} {{ $eleve->nom }}</h5>
            <p class="text-primary fw-semibold mb-3">{{ $eleve->matricule }}</p>
            <span class="badge bg-primary-subtle text-primary px-3 py-2 rounded-pill mb-3">{{ $eleve->classe->nom ?? 'Sans Classe' }}</span>
            
            <div class="d-flex justify-content-center gap-2 mt-2 flex-wrap">
                <a href="{{ route('eleves.edit', $eleve) }}" class="btn btn-primary btn-sm"><i class='bx bx-edit-alt me-1'></i> Modifier</a>
                <a href="{{ route('inscriptions.create', ['eleve_id' => $eleve->id]) }}" class="btn btn-dark btn-sm"><i class='bx bx-book-add me-1'></i> {{ $eleve->classe_id ? 'Réinscrire' : 'Inscrire dans une classe' }}</a>
                <a href="#" class="btn btn-outline-secondary btn-sm"><i class='bx bx-printer me-1'></i> Carte</a>
            </div>
        </div>

        <div class="card p-4">
            <h6 class="fw-bold mb-3 border-bottom pb-2">Détails Personnels</h6>
            <div class="mb-3">
                <small class="text-muted d-block">Date de naissance</small>
                <span class="fw-medium">{{ \Carbon\Carbon::parse($eleve->date_naissance)->format('d/m/Y') }}</span>
            </div>
            <div class="mb-3">
                <small class="text-muted d-block">Lieu de naissance</small>
                <span class="fw-medium">{{ $eleve->lieu_naissance ?: 'N/A' }}</span>
            </div>
            <div class="mb-3">
                <small class="text-muted d-block">Nationalité</small>
                <span class="fw-medium">{{ $eleve->nationalite }}</span>
            </div>
            <div class="mb-0">
                <small class="text-muted d-block">Groupe Sanguin</small>
                <span class="badge bg-danger-subtle text-danger">{{ $eleve->groupe_sanguin ?: 'Inconnu' }}</span>
            </div>
        </div>
    </div>

    <div class="col-md-8">
        <div class="card mb-4">
            <div class="card-header bg-transparent border-0 pt-4 px-4">
                <ul class="nav nav-pills card-header-tabs" id="profileTabs" role="tablist">
                    <li class="nav-item">
                        <button class="nav-link active" id="academic-tab" data-bs-toggle="tab" data-bs-target="#academic" type="button">Cursus Académique</button>
                    </li>
                    <li class="nav-item">
                        <button class="nav-link" id="parents-tab" data-bs-toggle="tab" data-bs-target="#parents" type="button">Parents / Tuteurs</button>
                    </li>
                    <li class="nav-item">
                        <button class="nav-link" id="financial-tab" data-bs-toggle="tab" data-bs-target="#financial" type="button">Finances</button>
                    </li>
                    <li class="nav-item">
                        <button class="nav-link" id="bulletin-tab" data-bs-toggle="tab" data-bs-target="#bulletins" type="button">Bulletins</button>
                    </li>
                    <li class="nav-item">
                        <button class="nav-link text-danger" id="absence-tab" data-bs-toggle="tab" data-bs-target="#absences" type="button">Absences</button>
                    </li>
                </ul>
            </div>
            <div class="card-body p-4">
                <div class="tab-content" id="profileTabsContent">
                    <!-- Tab: Académique -->
                    <div class="tab-pane fade show active" id="academic" role="tabpanel">
                        <div class="row g-4">
                            <div class="col-md-6">
                                <div class="p-3 border rounded-4 bg-light">
                                    <h6 class="fw-bold text-muted small mb-2 uppercase">ANNEE SCOLAIRE ACTUALLE</h6>
                                    <h4 class="mb-0">{{ $eleve->anneeScolaire->libelle ?? 'N/A' }}</h4>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="p-3 border rounded-4 bg-primary text-white text-center">
                                    <h6 class="fw-bold small mb-2 uppercase text-white-50">MOYENNE GENERALE</h6>
                                    <h4 class="mb-0">{{ $moyenne ? number_format($moyenne, 2) : '--' }} / 20</h4>
                                </div>
                            </div>
                        </div>
                        
                        <h6 class="fw-bold mt-4 mb-3">Dernières Notes</h6>
                        <div class="table-responsive">
                            <table class="table table-sm">
                                <thead>
                                    <tr class="text-muted small">
                                        <th>MATIÈRE</th>
                                        <th>NOTE</th>
                                        <th>COEFF</th>
                                        <th>TYPE</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse($eleve->notes->take(5) as $note)
                                    <tr class="align-middle">
                                        <td>{{ $note->matiere->nom }}</td>
                                        <td><span class="fw-bold {{ $note->valeur < 10 ? 'text-danger' : 'text-success' }}">{{ $note->valeur }}</span></td>
                                        <td>{{ $note->coefficient }}</td>
                                        <td><span class="badge bg-light text-dark text-capitalize">{{ $note->type_evaluation }}</span></td>
                                    </tr>
                                    @empty
                                    <tr class="align-middle">
                                        <td colspan="4" class="text-center py-4 text-muted small">Aucune note enregistrée</td>
                                    </tr>
                                    @endforelse
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Tab: Parents -->
                    <div class="tab-pane fade" id="parents" role="tabpanel">
                        @if($eleve->parent)
                            <div class="p-3 border rounded-4 mb-3">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h6 class="fw-bold mb-0">Tuteur Principal ({{ $eleve->parent->user->name }})</h6>
                                    <span class="badge bg-light text-dark border">Parent</span>
                                </div>
                                <p class="mb-1 text-muted small"><i class='bx bx-phone me-1'></i> {{ $eleve->parent->telephone ?: 'Aucun numéro' }}</p>
                                <p class="mb-0 text-muted small"><i class='bx bx-envelope me-1'></i> {{ $eleve->parent->user->email }}</p>
                            </div>
                        @endif

                        <div class="p-3 border rounded-4 mb-3 bg-light">
                            <h6 class="fw-bold mb-3 small text-uppercase">Infos de contact tuteur (Urgence)</h6>
                            <p class="mb-1 fw-bold">{{ $eleve->nom_tuteur ?: 'Non renseigné' }}</p>
                            <p class="mb-1 text-muted small"><i class='bx bx-phone me-1'></i> {{ $eleve->tel_tuteur ?: 'Aucun numéro' }}</p>
                            <p class="mb-0 text-muted small"><i class='bx bx-link-alt me-1'></i> Relation: {{ $eleve->relation_tuteur ?: 'N/A' }}</p>
                        </div>
                    </div>

                    <!-- Tab: Finances -->
                    <div class="tab-pane fade" id="financial" role="tabpanel">
                        <div class="mb-3 d-flex justify-content-between align-items-center">
                            <h6 class="fw-bold mb-0">Historique des Paiements</h6>
                            <a href="{{ route('paiements.create', ['eleve_id' => $eleve->id]) }}" class="btn btn-sm btn-success">+ Nouveau</a>
                        </div>
                        
                        <div class="table-responsive">
                            <table class="table table-sm">
                                <thead>
                                    <tr class="small text-muted">
                                        <th>DATE</th>
                                        <th>TYPE</th>
                                        <th>MONTANT</th>
                                        <th>STATUT</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse($eleve->paiements as $paiement)
                                    <tr class="small">
                                        <td>{{ $paiement->date_paiement->format('d/m/Y') }}</td>
                                        <td>{{ $paiement->typePaiement->nom }}</td>
                                        <td class="fw-bold text-dark">{{ number_format($paiement->montant_paye, 0, ',', ' ') }} FCFA</td>
                                        <td>
                                            <span class="badge {{ $paiement->statut == 'paye' ? 'bg-success' : 'bg-warning' }} small">
                                                {{ $paiement->statut }}
                                            </span>
                                        </td>
                                    </tr>
                                    @empty
                                    <tr>
                                        <td colspan="4" class="text-center py-4 text-muted">Aucun paiement trouvé</td>
                                    </tr>
                                    @endforelse
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Tab: Bulletins -->
                    <div class="tab-pane fade" id="bulletins" role="tabpanel">
                        <div class="mb-3 d-flex justify-content-between align-items-center">
                            <h6 class="fw-bold mb-0">Bulletins Scolaires</h6>
                            <a href="{{ route('bulletins.generate', $eleve) }}" class="btn btn-sm btn-primary"><i class='bx bx-refresh me-1'></i> Générer Nouveau</a>
                        </div>
                        
                        <div class="list-group list-group-flush">
                            @forelse($eleve->bulletins as $bulletin)
                            <div class="list-group-item d-flex justify-content-between align-items-center px-0 py-3">
                                <div>
                                    <h6 class="mb-1 fw-bold">Semestre {{ $bulletin->trimestre }}</h6>
                                    <p class="mb-0 text-muted small">Moyenne: <span class="text-primary fw-bold">{{ $bulletin->moyenne_generale }}</span> | Rang: {{ $bulletin->rang }}/{{ $bulletin->effectif_classe }}</p>
                                </div>
                                <div class="d-flex gap-2">
                                    @if($bulletin->pdf_path)
                                        <a href="{{ asset('storage/' . $bulletin->pdf_path) }}" class="btn btn-sm btn-outline-danger" target="_blank text-center">
                                            <i class='bx bxs-file-pdf'></i> PDF
                                        </a>
                                    @endif
                                </div>
                            </div>
                            @empty
                            <div class="text-center py-4">
                                <i class='bx bx-file text-muted' style="font-size: 3rem;"></i>
                                <p class="text-muted mt-2">Aucun bulletin généré pour le moment.</p>
                            </div>
                            @endforelse
                        </div>
                    </div>

                    <!-- Tab: Absences -->
                    <div class="tab-pane fade" id="absences" role="tabpanel">
                        <div class="row mb-4">
                            <div class="col-md-4">
                                <div class="p-3 border rounded-4 bg-danger-subtle text-danger text-center">
                                    <h6 class="fw-bold small mb-2 uppercase text-danger">TOTAL ABSENCES</h6>
                                    <h4 class="mb-0">{{ $eleve->absences->where('type', 'absent')->count() }}</h4>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="p-3 border rounded-4 bg-warning-subtle text-warning text-center">
                                    <h6 class="fw-bold small mb-2 uppercase text-warning">TOTAL RETARDS</h6>
                                    <h4 class="mb-0">{{ $eleve->absences->where('type', 'retard')->count() }}</h4>
                                </div>
                            </div>
                        </div>

                        <h6 class="fw-bold mb-3">Détail des cours manqués</h6>
                        <div class="table-responsive">
                            <table class="table table-hover table-sm align-middle">
                                <thead class="table-light">
                                    <tr class="small text-muted">
                                        <th>DATE & HEURES</th>
                                        <th>MATIÈRE</th>
                                        <th>LEÇON DU JOUR</th>
                                        <th>STATUT</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse($eleve->absences->sortByDesc('date_absence') as $absence)
                                    <tr>
                                        <td>
                                            <div class="fw-bold">{{ \Carbon\Carbon::parse($absence->date_absence)->format('d/m/Y') }}</div>
                                            <span class="badge bg-light text-dark">
                                                @if($absence->heure_debut && $absence->heure_fin)
                                                    {{ \Carbon\Carbon::parse($absence->heure_debut)->format('H:i') }} - {{ \Carbon\Carbon::parse($absence->heure_fin)->format('H:i') }}
                                                @else
                                                    {{ ucfirst($absence->periode ?? 'Non défini') }}
                                                @endif
                                            </span>
                                        </td>
                                        <td class="fw-bold text-primary">{{ $absence->matiere->nom ?? 'Général' }}</td>
                                        <td>
                                            @if($absence->cahierTexte)
                                                <span class="fw-semibold d-block">{{ $absence->cahierTexte->titre_lecon }}</span>
                                                @if($absence->cahierTexte->contenu_lecon)
                                                    <small class="text-muted d-inline-block text-truncate" style="max-width: 200px;" title="{{ $absence->cahierTexte->contenu_lecon }}">
                                                        {{ $absence->cahierTexte->contenu_lecon }}
                                                    </small>
                                                @endif
                                            @else
                                                <span class="text-muted fst-italic">Appel simple</span>
                                            @endif
                                        </td>
                                        <td>
                                            @if($absence->type == 'absent')
                                                <span class="badge bg-danger">Absent</span>
                                            @elseif($absence->type == 'retard')
                                                <span class="badge bg-warning">Retard</span>
                                            @endif
                                        </td>
                                    </tr>
                                    @empty
                                    <tr>
                                        <td colspan="4" class="text-center py-4 text-muted">Aucune absence enregistrée. Élève assidu ! <i class='bx bx-smile'></i></td>
                                    </tr>
                                    @endforelse
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
