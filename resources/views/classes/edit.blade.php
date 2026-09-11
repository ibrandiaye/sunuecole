@extends('layouts.app')

@section('title', 'Modifier Classe')
@section('page_title', 'Édition de la Classe')

@section('content')
<div class="row justify-content-center animate__animated animate__fadeInUp">
    <div class="col-md-8">
        <div class="card p-4">
            <form action="{{ route('classes.update', $classe) }}" method="POST">
                @csrf
                @method('PUT')
                
                <h5 class="fw-bold mb-4 text-primary"><i class='bx bx-edit-alt me-2'></i>Modifier la classe : {{ $classe->nom }}</h5>
                
                <div class="row g-3">
                    <div class="col-md-12">
                        <label class="form-label fw-semibold">Nom de la classe <span class="text-danger">*</span></label>
                        <input type="text" name="nom" class="form-control @error('nom') is-invalid @enderror" value="{{ old('nom', $classe->nom) }}">
                        @error('nom') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Niveau <span class="text-danger">*</span></label>
                        <select name="niveau_id" id="niveau_id_select" class="form-select @error('niveau_id') is-invalid @enderror" onchange="updateTarifHints()">
                            @foreach($niveaux as $niveau)
                                <option value="{{ $niveau->id }}" {{ old('niveau_id', $classe->niveau_id) == $niveau->id ? 'selected' : '' }}>
                                    {{ $niveau->nom }}
                                </option>
                            @endforeach
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Série</label>
                        <select name="serie_id" class="form-select">
                            <option value="">-- Sans série --</option>
                            @foreach($series as $serie)
                                <option value="{{ $serie->id }}" {{ old('serie_id', $classe->serie_id) == $serie->id ? 'selected' : '' }}>
                                    {{ $serie->nom }}
                                </option>
                            @endforeach
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Capacité Maximale</label>
                        <input type="number" name="effectif_max" class="form-control" value="{{ old('effectif_max', $classe->effectif_max) }}">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Statut</label>
                        <select name="active" class="form-select">
                            <option value="1" {{ $classe->active ? 'selected' : '' }}>Ouverte (Active)</option>
                            <option value="0" {{ !$classe->active ? 'selected' : '' }}>Fermée (Inactive)</option>
                        </select>
                    </div>

                    <div class="col-12 mt-4">
                        <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
                            <h6 class="fw-bold text-secondary mb-0"><i class='bx bx-money me-2'></i>Configuration Financière</h6>
                            <button type="button" class="btn btn-sm btn-outline-primary" onclick="applyNiveauTarifs()">
                                <i class='bx bx-reset me-1'></i>Réinitialiser aux tarifs du niveau
                            </button>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Montant Inscription (FCFA)</label>
                        <input type="number" step="0.01" name="montant_inscription" id="montant_inscription" class="form-control" value="{{ old('montant_inscription', $classe->montant_inscription) }}" placeholder="Ex: 50000">
                        <small class="text-muted mt-1 d-block" id="hint_inscription"></small>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Mensualité (FCFA)</label>
                        <input type="number" step="0.01" name="montant_mensualite" id="montant_mensualite" class="form-control" value="{{ old('montant_mensualite', $classe->montant_mensualite) }}" placeholder="Ex: 30000">
                        <small class="text-muted mt-1 d-block" id="hint_mensualite"></small>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Montant Cantine / Mois (FCFA)</label>
                        <input type="number" step="0.01" name="montant_cantine" id="montant_cantine" class="form-control" value="{{ old('montant_cantine', $classe->montant_cantine) }}" placeholder="Facultatif">
                        <small class="text-muted mt-1 d-block" id="hint_cantine"></small>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Montant Transport / Mois (FCFA)</label>
                        <input type="number" step="0.01" name="montant_transport" id="montant_transport" class="form-control" value="{{ old('montant_transport', $classe->montant_transport) }}" placeholder="Facultatif">
                        <small class="text-muted mt-1 d-block" id="hint_transport"></small>
                    </div>
                </div>

                <div class="d-flex justify-content-end gap-3 mt-5">
                    <a href="{{ route('classes.index') }}" class="btn btn-light px-4">Annuler</a>
                    <button type="submit" class="btn btn-primary px-5">Enregistrer les modifications</button>
                </div>
            </form>
        </div>
    </div>
</div>

@php
    $niveauxTarifs = [];
    foreach($niveaux as $n) {
        $tarifsMap = [];
        foreach($n->tarifs as $t) {
            if ($t->typePaiement) {
                $tarifsMap[$t->typePaiement->code] = (float) $t->montant;
            }
        }
        $niveauxTarifs[$n->id] = $tarifsMap;
    }
@endphp

@section('scripts')
<script>
const tarifsByNiveau = @json($niveauxTarifs);

function updateTarifHints() {
    const select = document.getElementById('niveau_id_select');
    if (!select) return;
    const niveauId = select.value;
    const tarifs = tarifsByNiveau[niveauId] || null;

    const fields = [
        { id: 'montant_inscription', key: 'INSCR' },
        { id: 'montant_mensualite',  key: 'MENS' },
        { id: 'montant_cantine',     key: 'CANT' },
        { id: 'montant_transport',   key: 'TRANSP' }
    ];

    fields.forEach(f => {
        const hint = document.getElementById('hint_' + f.id.replace('montant_', ''));
        if (hint) {
            if (tarifs && tarifs[f.key] !== undefined) {
                hint.innerHTML = `<span class="text-muted"><i class='bx bx-info-circle me-1 text-primary'></i>Tarif standard niveau : <strong>${new Intl.NumberFormat('fr-FR').format(tarifs[f.key])} FCFA</strong></span>`;
            } else {
                hint.innerHTML = '';
            }
        }
    });
}

function applyNiveauTarifs() {
    const select = document.getElementById('niveau_id_select');
    if (!select) return;
    const niveauId = select.value;
    const tarifs = tarifsByNiveau[niveauId] || null;
    if (!tarifs) {
        alert('Aucun tarif configuré pour ce niveau.');
        return;
    }

    if (tarifs['INSCR'] !== undefined) document.getElementById('montant_inscription').value = tarifs['INSCR'];
    if (tarifs['MENS'] !== undefined)  document.getElementById('montant_mensualite').value = tarifs['MENS'];
    if (tarifs['CANT'] !== undefined)  document.getElementById('montant_cantine').value = tarifs['CANT'];
    if (tarifs['TRANSP'] !== undefined) document.getElementById('montant_transport').value = tarifs['TRANSP'];
}

document.addEventListener('DOMContentLoaded', function() {
    updateTarifHints();
});
</script>
@endsection
@endsection
