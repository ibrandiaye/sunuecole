@extends('layouts.app')

@section('title', 'Gestion des Depenses')
@section('page_title', 'Depenses et Finances')

@section('content')
<div class="row g-3 mb-4">
    <div class="col-md-4">
        <div class="card border-0 rounded-4 h-100" style="background:linear-gradient(135deg,#16a34a,#15803d); color:white;">
            <div class="card-body p-4">
                <div class="d-flex justify-content-between align-items-start">
                    <div>
                        <p class="mb-1 opacity-75 small">Recettes Encaissees</p>
                        <h3 class="fw-bold mb-0">{{ number_format($totalRecettes, 0, ',', ' ') }} FCFA</h3>
                    </div>
                    <div class="rounded-3 p-2" style="background:rgba(255,255,255,.2);"><i class='bx bx-trending-up fs-3'></i></div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card border-0 rounded-4 h-100" style="background:linear-gradient(135deg,#dc2626,#b91c1c); color:white;">
            <div class="card-body p-4">
                <div class="d-flex justify-content-between align-items-start">
                    <div>
                        <p class="mb-1 opacity-75 small">Total Depenses</p>
                        <h3 class="fw-bold mb-0">{{ number_format($totalDepenses, 0, ',', ' ') }} FCFA</h3>
                    </div>
                    <div class="rounded-3 p-2" style="background:rgba(255,255,255,.2);"><i class='bx bx-trending-down fs-3'></i></div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        @if($benefice >= 0)
        <div class="card border-0 rounded-4 h-100" style="background:linear-gradient(135deg,#0052cc,#1a63d1); color:white;">
        @else
        <div class="card border-0 rounded-4 h-100" style="background:linear-gradient(135deg,#7c2d12,#991b1b); color:white;">
        @endif
            <div class="card-body p-4">
                <div class="d-flex justify-content-between align-items-start">
                    <div>
                        <p class="mb-1 opacity-75 small">Benefice Net</p>
                        <h3 class="fw-bold mb-0">{{ $benefice >= 0 ? '+' : '' }}{{ number_format($benefice, 0, ',', ' ') }} FCFA</h3>
                    </div>
                    <div class="rounded-3 p-2" style="background:rgba(255,255,255,.2);">
                        @if($benefice >= 0)
                        <i class='bx bx-happy fs-3'></i>
                        @else
                        <i class='bx bx-sad fs-3'></i>
                        @endif
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="card border-0 rounded-4 mb-4">
    <div class="card-body p-3">
        <form method="GET" class="row g-2 align-items-end">
            <div class="col-md-4">
                <label class="form-label small fw-semibold mb-1">Annee Scolaire</label>
                <select name="annee_id" class="form-select form-select-sm" onchange="this.form.submit()">
                    @foreach($annees as $a)
                        <option value="{{ $a->id }}" {{ $selected_annee_id == $a->id ? 'selected' : '' }}>
                            {{ $a->libelle }}{{ $a->active ? ' (Active)' : '' }}
                        </option>
                    @endforeach
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label small fw-semibold mb-1">Categorie</label>
                <select name="categorie" class="form-select form-select-sm" onchange="this.form.submit()">
                    <option value="">Toutes les categories</option>
                    @foreach($categories as $key => $label)
                        <option value="{{ $key }}" {{ request('categorie') == $key ? 'selected' : '' }}>{{ $label }}</option>
                    @endforeach
                </select>
            </div>
            <div class="col-md-5 text-end">
                <a href="{{ route('depenses.create') }}" class="btn btn-primary rounded-3 px-4">
                    <i class='bx bx-plus me-1'></i> Nouvelle Depense
                </a>
            </div>
        </form>
    </div>
</div>

@if($parCategorie->isNotEmpty())
<div class="card border-0 rounded-4 mb-4">
    <div class="card-body p-4">
        <h6 class="fw-bold mb-3"><i class='bx bx-pie-chart me-2 text-primary'></i>Repartition des Depenses</h6>
        <div class="row g-2">
            @foreach($parCategorie as $cat => $montant)
            @php $pct = $totalDepenses > 0 ? round(($montant / $totalDepenses) * 100) : 0; @endphp
            <div class="col-12">
                <div class="d-flex justify-content-between mb-1">
                    <small class="fw-semibold">{{ $categories[$cat] ?? ucfirst($cat) }}</small>
                    <small class="text-muted">{{ number_format($montant, 0, ',', ' ') }} FCFA ({{ $pct }}%)</small>
                </div>
                <div class="progress" style="height:8px; border-radius:8px;">
                    @php
                    $barColor = match($cat) {
                        'salaires' => '#0052cc',
                        'fournitures' => '#16a34a',
                        'infrastructure' => '#f59e0b',
                        'entretien' => '#8b5cf6',
                        default => '#6b7280'
                    };
                    @endphp
                    <div class="progress-bar" style="width:{{ $pct }}%; border-radius:8px; background:{{ $barColor }};"></div>
                </div>
            </div>
            @endforeach
        </div>
    </div>
</div>
@endif

<div class="card border-0 rounded-4">
    <div class="card-body p-0">
        @if($depenses->isEmpty())
            <div class="text-center py-5 text-muted">
                <i class='bx bx-receipt fs-1 d-block mb-2'></i>
                <p>Aucune depense enregistree pour cette periode.</p>
                <a href="{{ route('depenses.create') }}" class="btn btn-primary rounded-3">Enregistrer une depense</a>
            </div>
        @else
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th class="ps-4">Date</th>
                        <th>Libelle</th>
                        <th>Categorie</th>
                        <th>Mode</th>
                        <th class="text-end">Montant</th>
                        <th class="text-center pe-4">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($depenses as $dep)
                    <tr>
                        <td class="ps-4 text-muted small">{{ $dep->date_depense->format('d/m/Y') }}</td>
                        <td>
                            <div class="fw-semibold">{{ $dep->libelle }}</div>
                            @if($dep->notes)<small class="text-muted">{{ Str::limit($dep->notes, 60) }}</small>@endif
                        </td>
                        <td>
                            @php
                            $colorMap = ['salaires'=>'primary','fournitures'=>'success','infrastructure'=>'warning','entretien'=>'info','autre'=>'secondary'];
                            $badgeColor = $colorMap[$dep->categorie] ?? 'secondary';
                            @endphp
                            <span class="badge rounded-pill px-3 text-bg-{{ $badgeColor }}">
                                {{ $categories[$dep->categorie] ?? ucfirst($dep->categorie) }}
                            </span>
                        </td>
                        <td class="text-capitalize small text-muted">{{ $dep->mode_paiement }}</td>
                        <td class="text-end fw-bold text-danger">{{ number_format($dep->montant, 0, ',', ' ') }} FCFA</td>
                        <td class="text-center pe-4">
                            <a href="{{ route('depenses.edit', $dep) }}" class="btn btn-sm btn-light me-1"><i class='bx bx-edit'></i></a>
                            <form action="{{ route('depenses.destroy', $dep) }}" method="POST" class="d-inline"
                                  onsubmit="return confirm('Supprimer cette depense ?')">
                                @csrf @method('DELETE')
                                <button class="btn btn-sm btn-light text-danger"><i class='bx bx-trash'></i></button>
                            </form>
                        </td>
                    </tr>
                    @endforeach
                </tbody>
                <tfoot class="table-light">
                    <tr>
                        <td colspan="4" class="ps-4 fw-bold text-end">TOTAL</td>
                        <td class="text-end fw-bold text-danger">{{ number_format($totalDepenses, 0, ',', ' ') }} FCFA</td>
                        <td></td>
                    </tr>
                </tfoot>
            </table>
        </div>
        @endif
    </div>
</div>
@endsection
