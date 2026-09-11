@extends('layouts.app')

@section('title', 'Nouvelle Classe')
@section('page_title', 'Ajouter une Classe')

@section('content')
<div class="row justify-content-center animate__animated animate__fadeInUp">
    <div class="col-md-8">
        <div class="card p-4">
            <form action="{{ route('classes.store') }}" method="POST">
                @csrf
                
                <h5 class="fw-bold mb-4 text-primary"><i class='bx bx-plus-circle me-2'></i>Configuration de la nouvelle classe</h5>
                
                <div class="row g-3">
                    <div class="col-md-12">
                        <label class="form-label fw-semibold">Nom de la classe <span class="text-danger">*</span></label>
                        <input type="text" name="nom" class="form-control @error('nom') is-invalid @enderror" value="{{ old('nom') }}" placeholder="Ex: 6ème A, Terminale S1...">
                        @error('nom') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Niveau <span class="text-danger">*</span></label>
                        <select name="niveau_id" id="niveau_id_select" class="form-select @error('niveau_id') is-invalid @enderror" onchange="prefillTarifsFromNiveau()">
                            <option value="">Sélectionner le niveau...</option>
                            @foreach($niveaux as $niveau)
                                <option value="{{ $niveau->id }}" {{ old('niveau_id') == $niveau->id ? 'selected' : '' }}>
                                    {{ $niveau->nom }} ({{ ucfirst($niveau->cycle->nom) }})
                                </option>
                            @endforeach
                        </select>
                        @error('niveau_id') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Série (facultatif)</label>
                        <select name="serie_id" class="form-select">
                            <option value="">-- Sans série --</option>
                            @foreach($series as $serie)
                                <option value="{{ $serie->id }}" {{ old('serie_id') == $serie->id ? 'selected' : '' }}>
                                    {{ $serie->nom }} - {{ $serie->code }}
                                </option>
                            @endforeach
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Capacité Maximale <span class="text-danger">*</span></label>
                        <input type="number" name="effectif_max" class="form-control @error('effectif_max') is-invalid @enderror" value="{{ old('effectif_max', 50) }}">
                        @error('effectif_max') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Statut</label>
                        <select name="active" class="form-select">
                            <option value="1" {{ old('active') == '1' ? 'selected' : '' }}>Ouverte (Active)</option>
                            <option value="0" {{ old('active') == '0' ? 'selected' : '' }}>Fermée (Inactive)</option>
                        </select>
                    </div>

                    <div class="col-12 mt-4">
                        <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
                            <h6 class="fw-bold text-secondary mb-0"><i class='bx bx-money me-2'></i>Configuration Financière</h6>
                            <span class="badge bg-light text-muted border fw-normal" id="info_tarifs_niveau">
                                <i class='bx bx-info-circle me-1 text-primary'></i>Pré-rempli selon les tarifs du niveau sélectionné
                            </span>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Montant Inscription (FCFA)</label>
                        <input type="number" step="0.01" name="montant_inscription" id="montant_inscription" class="form-control" value="{{ old('montant_inscription') }}" placeholder="Ex: 50000">
                        <small class="text-muted mt-1 d-block" id="hint_inscription"></small>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Mensualité (FCFA)</label>
                        <input type="number" step="0.01" name="montant_mensualite" id="montant_mensualite" class="form-control" value="{{ old('montant_mensualite') }}" placeholder="Ex: 30000">
                        <small class="text-muted mt-1 d-block" id="hint_mensualite"></small>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Montant Cantine / Mois (FCFA)</label>
                        <input type="number" step="0.01" name="montant_cantine" id="montant_cantine" class="form-control" value="{{ old('montant_cantine') }}" placeholder="Facultatif">
                        <small class="text-muted mt-1 d-block" id="hint_cantine"></small>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Montant Transport / Mois (FCFA)</label>
                        <input type="number" step="0.01" name="montant_transport" id="montant_transport" class="form-control" value="{{ old('montant_transport') }}" placeholder="Facultatif">
                        <small class="text-muted mt-1 d-block" id="hint_transport"></small>
                    </div>
                </div>

                <div class="d-flex justify-content-end gap-3 mt-5">
                    <a href="{{ route('classes.index') }}" class="btn btn-light px-4">Annuler</a>
                    <button type="submit" class="btn btn-primary px-5">Créer la Classe</button>
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

function prefillTarifsFromNiveau(force = false) {
    const select = document.getElementById('niveau_id_select');
    if (!select) return;
    const niveauId = select.value;
    const tarifs = tarifsByNiveau[niveauId] || null;

    const fields = [
        { id: 'montant_inscription', key: 'INSCR', label: 'Inscription' },
        { id: 'montant_mensualite',  key: 'MENS',  label: 'Mensualité' },
        { id: 'montant_cantine',     key: 'CANT',  label: 'Cantine' },
        { id: 'montant_transport',   key: 'TRANSP', label: 'Transport' }
    ];

    fields.forEach(f => {
        const input = document.getElementById(f.id);
        const hint = document.getElementById('hint_' + f.id.replace('montant_', ''));
        if (!input) return;

        if (tarifs && tarifs[f.key] !== undefined) {
            const montant = tarifs[f.key];
            if (force || !input.value || input.dataset.autoFilled === "1") {
                input.value = montant;
                input.dataset.autoFilled = "1";
            }
            if (hint) {
                hint.innerHTML = `<span class="text-success"><i class='bx bx-check-circle me-1'></i>Tarif standard niveau : <strong>${new Intl.NumberFormat('fr-FR').format(montant)} FCFA</strong></span>`;
            }
        } else {
            if (hint) hint.innerHTML = '';
        }

        // Si l'utilisateur modifie manuellement la valeur, on ne l'écrase plus automatiquement
        input.addEventListener('input', function() {
            this.dataset.autoFilled = "0";
        }, { once: true });
    });
}

document.addEventListener('DOMContentLoaded', function() {
    const select = document.getElementById('niveau_id_select');
    if (select && select.value) {
        prefillTarifsFromNiveau(false);
    }
});
</script>
@endsection
@endsection
