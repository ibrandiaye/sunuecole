@extends('layouts.app')

@section('title', 'Suivi des Mensualités')
@section('page_title', 'Suivi des Mensualités (Impayés)')

@section('content')
<div class="card p-4 animate__animated animate__fadeIn">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h5 class="fw-bold text-primary mb-0"><i class='bx bx-search-alt me-2'></i>Filtre de recherche</h5>
        @if(!$eleves->isEmpty() && $totalReste > 0)
            <a href="{{ route('paiements.suivi', ['classe_id' => $selected_classe_id, 'mois' => $selected_mois, 'export' => 1]) }}" class="btn btn-danger">
                <i class='bx bxs-file-pdf me-1'></i> Exporter les impayés (PDF)
            </a>
        @endif
    </div>

    <!-- Filtre -->
    <form method="GET" action="{{ route('paiements.suivi') }}" class="row g-3 mb-4">
        <div class="col-md-4">
            <label class="form-label fw-bold">Classe (Optionnel)</label>
            <select name="classe_id" class="form-select" onchange="this.form.submit()">
                <option value="">-- Toutes les classes --</option>
                @foreach($classes as $classe)
                    <option value="{{ $classe->id }}" {{ $selected_classe_id == $classe->id ? 'selected' : '' }}>
                        {{ $classe->nom }} ({{ $classe->niveau->nom ?? '' }})
                    </option>
                @endforeach
            </select>
        </div>
        <div class="col-md-3">
            <label class="form-label fw-bold">Mois concerné</label>
            <select name="mois" class="form-select" onchange="this.form.submit()">
                @foreach($moisList as $valeur => $nomMois)
                    <option value="{{ $valeur }}" {{ $selected_mois == $valeur ? 'selected' : '' }}>
                        {{ $nomMois }} ({{ $valeur }})
                    </option>
                @endforeach
            </select>
        </div>
        <div class="col-md-3 d-flex align-items-end">
            <div class="form-check form-switch mb-2">
                <input class="form-check-input" type="checkbox" role="switch" id="retardsOnly" name="retards_only" value="1" {{ $retards_only ? 'checked' : '' }} onchange="this.form.submit()">
                <label class="form-check-label text-danger fw-bold" for="retardsOnly">Afficher uniquement les retards</label>
            </div>
        </div>
        <div class="col-md-2 d-flex align-items-end">
            <button type="submit" class="btn btn-primary w-100"><i class='bx bx-filter-alt me-2'></i>Filtrer</button>
        </div>
    </form>

    <hr class="text-muted opacity-25">

    <!-- Résultats -->
    @if(!$typeMensualite)
        <div class="alert alert-warning text-center">
            <i class='bx bx-error-circle fs-4 mb-2'></i><br>
            Type de paiement "Mensualité" introuvable dans le système. Veuillez le configurer dans la gestion financière.
        </div>
    @elseif($eleves->isEmpty())
        <div class="alert alert-info border-0 bg-light text-center py-5">
            <i class='bx bx-info-circle fs-1 text-muted mb-3'></i>
            <h5>Aucun résultat trouvé</h5>
            <p class="text-muted mb-0">Il n'y a aucun élève correspondant aux critères de recherche actuels.</p>
        </div>
    @else
        <div class="alert alert-danger shadow-sm border-0 d-flex justify-content-between align-items-center mb-4">
            <div class="d-flex align-items-center">
                <i class='bx bx-wallet fs-2 me-3'></i>
                <div>
                    <h6 class="mb-0 fw-bold">Montant total des impayés (Reste à payer)</h6>
                    <small>Pour la sélection actuelle (Mois: {{ $selected_mois }})</small>
                </div>
            </div>
            <h3 class="mb-0 fw-bold">{{ number_format($totalReste, 0, ',', ' ') }} FCFA</h3>
        </div>

        <div class="table-responsive mt-3">
            <table class="table table-hover align-middle datatable">
                <thead class="bg-light">
                    <tr>
                        <th>CLASSE</th>
                        <th>MATRICULE</th>
                        <th>ÉLÈVE</th>
                        <th class="text-end">MONTANT ATTENDU</th>
                        <th class="text-end">MONTANT PAYÉ</th>
                        <th class="text-end text-danger">RESTE À PAYER</th>
                        <th class="text-center">STATUT</th>
                        <th class="text-end">ACTION</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($eleves as $eleve)
                        <tr>
                            <td>{{ $eleve->classe->nom }}</td>
                            <td><span class="badge bg-light text-dark border">{{ $eleve->matricule }}</span></td>
                            <td class="fw-bold">
                                <div class="d-flex align-items-center">
                                    @if($eleve->photo)
                                        <img src="{{ asset('storage/' . $eleve->photo) }}" class="rounded-circle me-3" width="40" height="40" style="object-fit: cover;">
                                    @else
                                        <div class="rounded-circle bg-primary bg-opacity-10 text-primary d-flex align-items-center justify-content-center me-3 fw-bold" style="width: 40px; height: 40px;">
                                            {{ substr($eleve->prenom, 0, 1) }}{{ substr($eleve->nom, 0, 1) }}
                                        </div>
                                    @endif
                                    {{ $eleve->prenom }} {{ $eleve->nom }}
                                </div>
                            </td>
                            <td class="text-end">{{ number_format($eleve->montant_attendu, 0, ',', ' ') }} FCFA</td>
                            <td class="text-end text-success fw-semibold">{{ number_format($eleve->montant_paye, 0, ',', ' ') }} FCFA</td>
                            <td class="text-end text-danger fw-bold">{{ number_format($eleve->reste_a_payer, 0, ',', ' ') }} FCFA</td>
                            <td class="text-center">
                                @if($eleve->statut_paiement === 'Payé')
                                    <span class="badge bg-success-subtle text-success px-3 py-2"><i class='bx bx-check-circle me-1'></i> Payé</span>
                                @elseif($eleve->statut_paiement === 'Incomplet')
                                    <span class="badge bg-warning-subtle text-warning px-3 py-2"><i class='bx bx-error me-1'></i> Incomplet</span>
                                @else
                                    <span class="badge bg-danger-subtle text-danger px-3 py-2"><i class='bx bx-x-circle me-1'></i> Impayé</span>
                                @endif
                            </td>
                            <td class="text-end">
                                @if($eleve->reste_a_payer > 0)
                                    <a href="{{ route('paiements.create', ['eleve_id' => $eleve->id, 'type_paiement_id' => $typeMensualite->id, 'mois' => $selected_mois]) }}" class="btn btn-sm btn-primary">
                                        <i class='bx bx-cart-add me-1'></i> Encaisser
                                    </a>
                                @else
                                    <a href="{{ route('paiements.index', ['eleve_id' => $eleve->id]) }}" class="btn btn-sm btn-light border" title="Historique">
                                        <i class='bx bx-history text-muted'></i>
                                    </a>
                                @endif
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    @endif
</div>
@endsection
