@extends('layouts.app')

@section('title', 'Mes Enfants')
@section('page_title', 'Mes Enfants')

@section('content')
<div class="container-fluid p-0">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h4 class="fw-bold mb-1">Dossiers de vos enfants</h4>
            <p class="text-muted small mb-0">Retrouvez les fiches d'inscription et informations scolaires de vos enfants.</p>
        </div>
    </div>

    @if($enfants->isEmpty())
        <div class="card p-5 text-center border-0 shadow-sm rounded-4">
            <h5 class="fw-bold">Aucun enfant trouvé</h5>
            <p class="text-muted small">Aucun élève n'est associé à votre compte parent.</p>
        </div>
    @else
        <div class="row g-4">
            @foreach($enfants as $enf)
                <div class="col-md-6 col-xl-4">
                    <div class="card h-100 shadow-sm border-0 rounded-4 overflow-hidden">
                        <div class="card-body p-4 d-flex flex-column justify-content-between">
                            <div>
                                <div class="d-flex align-items-center gap-3 mb-3">
                                    <div class="rounded-4 bg-primary bg-opacity-10 text-primary p-3 d-flex align-items-center justify-content-center fw-bold fs-3" style="width: 58px; height: 58px;">
                                        {{ strtoupper(substr($enf->prenom, 0, 1)) }}{{ strtoupper(substr($enf->nom, 0, 1)) }}
                                    </div>
                                    <div>
                                        <h5 class="fw-bold mb-0 text-dark">{{ $enf->prenom }} {{ $enf->nom }}</h5>
                                        <span class="badge bg-light text-dark border font-monospace">{{ $enf->matricule }}</span>
                                    </div>
                                </div>

                                <div class="p-3 bg-light rounded-3 mb-3 small">
                                    <div class="d-flex justify-content-between mb-1">
                                        <span class="text-muted">Classe :</span>
                                        <strong class="text-dark">{{ $enf->classe->nom ?? 'N/A' }}</strong>
                                    </div>
                                    <div class="d-flex justify-content-between mb-1">
                                        <span class="text-muted">Niveau :</span>
                                        <span>{{ $enf->classe->niveau->nom ?? 'N/A' }}</span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-1">
                                        <span class="text-muted">Date de naissance :</span>
                                        <span>{{ $enf->date_naissance ? \Carbon\Carbon::parse($enf->date_naissance)->format('d/m/Y') : '—' }}</span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-1">
                                        <span class="text-muted">Sexe :</span>
                                        <span>{{ $enf->sexe == 'M' ? 'Masculin' : 'Féminin' }}</span>
                                    </div>
                                    @if($enf->groupe_sanguin)
                                        <div class="d-flex justify-content-between mb-1">
                                            <span class="text-muted">Groupe sanguin :</span>
                                            <span class="badge bg-danger bg-opacity-10 text-danger">{{ $enf->groupe_sanguin }}</span>
                                        </div>
                                    @endif
                                </div>

                                <div class="d-flex flex-wrap gap-2 mb-3">
                                    @if($enf->inscriptionActuelle?->avec_cantine)
                                        <span class="badge bg-warning bg-opacity-20 text-dark border border-warning"><i class='bx bx-restaurant me-1'></i>Cantine</span>
                                    @endif
                                    @if($enf->inscriptionActuelle?->avec_transport)
                                        <span class="badge bg-info bg-opacity-20 text-dark border border-info"><i class='bx bx-bus me-1'></i>Transport</span>
                                    @endif
                                </div>
                            </div>

                            <div class="pt-3 border-top d-flex gap-2">
                                <a href="{{ route('parent.notes', ['enfant_id' => $enf->id]) }}" class="btn btn-outline-primary btn-sm flex-grow-1 rounded-3 fw-bold">
                                    <i class='bx bx-award me-1'></i> Notes
                                </a>
                                <a href="{{ route('parent.planning', ['enfant_id' => $enf->id]) }}" class="btn btn-outline-success btn-sm flex-grow-1 rounded-3 fw-bold">
                                    <i class='bx bx-calendar me-1'></i> Emploi
                                </a>
                                <a href="{{ route('parent.paiements', ['enfant_id' => $enf->id]) }}" class="btn btn-outline-dark btn-sm rounded-3 fw-bold" title="Scolarité">
                                    <i class='bx bx-credit-card'></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            @endforeach
        </div>
    @endif
</div>
@endsection
