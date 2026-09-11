@extends('layouts.app')

@section('title', 'Suivi des Paiements')
@section('page_title', 'Suivi des Paiements Mensuels')

@section('content')
<div class="card p-4 animate__animated animate__fadeIn">

    {{-- ===== FILTRES ===== --}}
    <form method="GET" action="{{ route('paiements.suivi') }}" id="filtreForm" class="row g-3 mb-4">
        <input type="hidden" name="tab" id="tabInput" value="{{ $tab }}">

        <div class="col-md-4">
            <label class="form-label fw-bold">Classe</label>
            <select name="classe_id" class="form-select" onchange="this.form.submit()">
                <option value="">-- Toutes les classes --</option>
                @foreach($classes as $classe)
                    <option value="{{ $classe->id }}" {{ $selected_classe_id == $classe->id ? 'selected' : '' }}>
                        {{ $classe->nom }} {{ $classe->niveau?->nom ? '('.$classe->niveau->nom.')' : '' }}
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
                <input class="form-check-input" type="checkbox" role="switch" id="retardsOnly"
                    name="retards_only" value="1" {{ $retards_only ? 'checked' : '' }}
                    onchange="this.form.submit()">
                <label class="form-check-label text-danger fw-bold" for="retardsOnly">
                    Retards uniquement
                </label>
            </div>
        </div>

        <div class="col-md-2 d-flex align-items-end">
            <button type="submit" class="btn btn-primary w-100">
                <i class='bx bx-filter-alt me-1'></i> Filtrer
            </button>
        </div>
    </form>

    {{-- ===== ONGLETS ===== --}}
    <div class="d-flex align-items-center flex-wrap gap-2 mb-4">
        @php
            $tabItems = [
                ['key' => 'mensualite', 'label' => 'Mensualité',  'icon' => 'bx-money',      'color' => 'primary', 'type' => $typeMensualite],
                ['key' => 'cantine',    'label' => 'Cantine',     'icon' => 'bx-restaurant', 'color' => 'warning', 'type' => $typeCantine],
                ['key' => 'transport',  'label' => 'Transport',   'icon' => 'bx-bus',        'color' => 'info',    'type' => $typeTransport],
            ];
        @endphp

        @foreach($tabItems as $item)
            <button type="button"
                class="btn {{ $tab === $item['key'] ? 'btn-'.$item['color'] : 'btn-outline-'.$item['color'] }} px-4 py-2 fw-semibold rounded-pill"
                onclick="switchTab('{{ $item['key'] }}')"
                {{ !$item['type'] ? 'disabled' : '' }}>
                <i class='bx {{ $item['icon'] }} me-1'></i> {{ $item['label'] }}
                @if(!$item['type'])
                    <small class="ms-1 opacity-50">(non configuré)</small>
                @endif
            </button>
        @endforeach

        @if(!$eleves->isEmpty() && $totalReste > 0)
            <div class="ms-auto">
                <a href="{{ route('paiements.suivi', ['classe_id' => $selected_classe_id, 'mois' => $selected_mois, 'tab' => $tab, 'export' => 1]) }}"
                   class="btn btn-outline-danger px-3">
                    <i class='bx bxs-file-pdf me-1'></i> Exporter les impayés
                </a>
            </div>
        @endif
    </div>

    <hr class="text-muted opacity-25 mb-4">

    {{-- ===== RÉSULTATS ===== --}}
    @if(!$typeActif)
        <div class="alert alert-warning text-center border-0 rounded-4">
            <i class='bx bx-error-circle fs-4 mb-2 d-block'></i>
            Type de paiement introuvable pour cet onglet. Configurez-le dans la gestion financière.
        </div>

    @elseif($eleves->isEmpty())
        <div class="alert alert-info border-0 bg-light text-center py-5 rounded-4">
            <i class='bx bx-info-circle fs-1 text-muted mb-3 d-block'></i>
            <h5 class="fw-bold">Aucun élève trouvé</h5>
            @if($tab === 'cantine')
                <p class="text-muted mb-0">Aucun élève inscrit à la cantine pour cette sélection.</p>
            @elseif($tab === 'transport')
                <p class="text-muted mb-0">Aucun élève inscrit au transport pour cette sélection.</p>
            @else
                <p class="text-muted mb-0">Aucun résultat pour les critères sélectionnés.</p>
            @endif
        </div>

    @else
        {{-- Compteurs --}}
        @php
            $totalEleves  = $eleves->count();
            $nbPayes      = $eleves->where('statut_paiement', 'Payé')->count();
            $nbIncomplets = $eleves->where('statut_paiement', 'Incomplet')->count();
            $nbImpayes    = $eleves->where('statut_paiement', 'Impayé')->count();
            $totalAttendu = $eleves->sum('montant_attendu');
            $totalPaye    = $eleves->sum('montant_paye');

            $tabColor = match($tab) { 'cantine' => 'warning', 'transport' => 'info', default => 'danger' };
            $tabIcon  = match($tab) { 'cantine' => 'bx-restaurant', 'transport' => 'bx-bus', default => 'bx-wallet' };
        @endphp

        <div class="row g-3 mb-4">
            <div class="col-6 col-md-3">
                <div class="card border-0 bg-primary bg-opacity-10 text-primary p-3 rounded-4 text-center">
                    <div class="fs-2 fw-bold">{{ $totalEleves }}</div>
                    <small class="fw-semibold">Élèves concernés</small>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="card border-0 bg-success bg-opacity-10 text-success p-3 rounded-4 text-center">
                    <div class="fs-2 fw-bold">{{ $nbPayes }}</div>
                    <small class="fw-semibold">Payé ✓</small>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="card border-0 bg-warning bg-opacity-10 text-warning p-3 rounded-4 text-center">
                    <div class="fs-2 fw-bold">{{ $nbIncomplets }}</div>
                    <small class="fw-semibold">Incomplet</small>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="card border-0 bg-danger bg-opacity-10 text-danger p-3 rounded-4 text-center">
                    <div class="fs-2 fw-bold">{{ $nbImpayes }}</div>
                    <small class="fw-semibold">Impayé ✗</small>
                </div>
            </div>
        </div>

        <div class="alert alert-{{ $tabColor }} shadow-sm border-0 d-flex justify-content-between align-items-center rounded-4 mb-4">
            <div class="d-flex align-items-center">
                <i class='bx {{ $tabIcon }} fs-2 me-3'></i>
                <div>
                    <h6 class="mb-0 fw-bold">Reste à percevoir — {{ $typeActif->nom }} / {{ $selected_mois }}</h6>
                    <small>
                        Attendu : <strong>{{ number_format($totalAttendu, 0, ',', ' ') }} FCFA</strong>
                        &nbsp;|&nbsp;
                        Encaissé : <strong>{{ number_format($totalPaye, 0, ',', ' ') }} FCFA</strong>
                    </small>
                </div>
            </div>
            <h3 class="mb-0 fw-bold">{{ number_format($totalReste, 0, ',', ' ') }} FCFA</h3>
        </div>

        <div class="table-responsive mt-2">
            <table class="table table-hover align-middle datatable">
                <thead class="bg-light">
                    <tr>
                        <th>CLASSE</th>
                        <th>MATRICULE</th>
                        <th>ÉLÈVE</th>
                        <th class="text-end">ATTENDU</th>
                        <th class="text-end">PAYÉ</th>
                        <th class="text-end text-danger">RESTE</th>
                        <th class="text-center">STATUT</th>
                        <th class="text-end">ACTION</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($eleves as $eleve)
                        <tr>
                            <td>
                                <span class="badge bg-light text-dark border">
                                    {{ $eleve->classe?->nom ?? '—' }}
                                </span>
                            </td>
                            <td>
                                <span class="badge bg-secondary-subtle text-secondary border">
                                    {{ $eleve->matricule }}
                                </span>
                            </td>
                            <td class="fw-bold">
                                <div class="d-flex align-items-center">
                                    @if($eleve->photo)
                                        <img src="{{ asset('storage/' . $eleve->photo) }}"
                                             class="rounded-circle me-2 flex-shrink-0"
                                             width="36" height="36" style="object-fit:cover;">
                                    @else
                                        <div class="rounded-circle bg-primary bg-opacity-10 text-primary d-flex align-items-center justify-content-center me-2 fw-bold flex-shrink-0"
                                             style="width:36px;height:36px;font-size:.8rem;">
                                            {{ substr($eleve->prenom,0,1) }}{{ substr($eleve->nom,0,1) }}
                                        </div>
                                    @endif
                                    <div>
                                        <div>{{ $eleve->prenom }} {{ $eleve->nom }}</div>
                                        @if($eleve->inscriptionActuelle)
                                            <div class="d-flex gap-1 mt-1">
                                                @if($eleve->inscriptionActuelle->avec_cantine)
                                                    <span class="badge bg-warning-subtle text-warning border" style="font-size:.7rem;">
                                                        <i class='bx bx-restaurant'></i> Cantine
                                                    </span>
                                                @endif
                                                @if($eleve->inscriptionActuelle->avec_transport)
                                                    <span class="badge bg-info-subtle text-info border" style="font-size:.7rem;">
                                                        <i class='bx bx-bus'></i> Transport
                                                    </span>
                                                @endif
                                            </div>
                                        @endif
                                    </div>
                                </div>
                            </td>
                            <td class="text-end">{{ number_format($eleve->montant_attendu, 0, ',', ' ') }} FCFA</td>
                            <td class="text-end text-success fw-semibold">{{ number_format($eleve->montant_paye, 0, ',', ' ') }} FCFA</td>
                            <td class="text-end fw-bold {{ $eleve->reste_a_payer > 0 ? 'text-danger' : 'text-success' }}">
                                {{ number_format($eleve->reste_a_payer, 0, ',', ' ') }} FCFA
                            </td>
                            <td class="text-center">
                                @if($eleve->statut_paiement === 'Payé')
                                    <span class="badge bg-success-subtle text-success px-2 py-1 rounded-pill">
                                        <i class='bx bx-check-circle me-1'></i>Payé
                                    </span>
                                @elseif($eleve->statut_paiement === 'Incomplet')
                                    <span class="badge bg-warning-subtle text-warning px-2 py-1 rounded-pill">
                                        <i class='bx bx-error me-1'></i>Incomplet
                                    </span>
                                @else
                                    <span class="badge bg-danger-subtle text-danger px-2 py-1 rounded-pill">
                                        <i class='bx bx-x-circle me-1'></i>Impayé
                                    </span>
                                @endif
                            </td>
                            <td class="text-end">
                                @if($eleve->reste_a_payer > 0)
                                    <a href="{{ route('paiements.create', [
                                            'eleve_id'         => $eleve->id,
                                            'type_paiement_id' => $typeActif->id,
                                            'mois'             => $selected_mois
                                        ]) }}"
                                       class="btn btn-sm btn-primary">
                                        <i class='bx bx-cart-add me-1'></i> Encaisser
                                    </a>
                                @else
                                    <a href="{{ route('paiements.index', ['eleve_id' => $eleve->id]) }}"
                                       class="btn btn-sm btn-light border" title="Historique">
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

@section('scripts')
<script>
function switchTab(tabKey) {
    document.getElementById('tabInput').value = tabKey;
    document.getElementById('filtreForm').submit();
}
</script>
@endsection

@endsection


