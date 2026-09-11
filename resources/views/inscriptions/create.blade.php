@extends('layouts.app')

@section('title', 'Nouvelle Inscription')
@section('page_title', 'Inscrire un Élève')

@section('content')
<div class="row justify-content-center animate__animated animate__fadeIn">
    <div class="col-md-8">
        <div class="card p-4">
            <form action="{{ route('inscriptions.store') }}" method="POST">
                @csrf
                
                <div class="mb-3">
                    <div class="d-flex justify-content-between align-items-center mb-1">
                        <label class="form-label fw-bold mb-0">Élève à inscrire <span class="text-danger">*</span></label>
                        <span class="badge bg-primary-subtle text-primary border border-primary-subtle rounded-pill px-3 py-1">
                            {{ $eleves->count() }} élève(s) en attente d'inscription
                        </span>
                    </div>
                    <select name="eleve_id" id="eleve_id_select" class="form-select select2 @error('eleve_id') is-invalid @enderror" data-placeholder="Rechercher un élève par nom ou matricule..." required>
                        @if($eleves->isEmpty())
                            <option value="">-- Aucun élève disponible (tous les élèves sont déjà inscrits cette année) --</option>
                        @else
                            <option value=""></option>
                            @foreach($eleves as $eleve)
                                <option value="{{ $eleve->id }}" {{ (old('eleve_id', $selected_eleve ?? '') == $eleve->id) ? 'selected' : '' }}>
                                    {{ $eleve->nom }} {{ $eleve->prenom }} &bull; Matricule: {{ $eleve->matricule }}
                                </option>
                            @endforeach
                        @endif
                    </select>
                    @error('eleve_id') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    <small class="text-muted mt-1 d-block">
                        <i class='bx bx-info-circle me-1 text-primary'></i> Seuls les élèves qui ne disposent d'aucune inscription pour l'année scolaire active ({{ $anneeActive?->libelle ?? 'en cours' }}) sont listés.
                    </small>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Année Scolaire</label>
                        <select name="annee_scolaire_id" class="form-select select2 @error('annee_scolaire_id') is-invalid @enderror" required>
                            @foreach($annees as $annee)
                                <option value="{{ $annee->id }}" {{ $annee->active ? 'selected' : '' }}>
                                    {{ $annee->libelle }} {{ $annee->active ? '(Active)' : '' }}
                                </option>
                            @endforeach
                        </select>
                        @error('annee_scolaire_id') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Classe</label>
                        <select name="classe_id" id="classe_id_select" class="form-select select2 @error('classe_id') is-invalid @enderror" data-placeholder="Sélectionner la classe..." onchange="updateTarifsDisplay()" required>
                            <option value=""></option>
                            @foreach($classes as $classe)
                                <option value="{{ $classe->id }}" 
                                    data-cantine="{{ $classe->getEffectiveTarif('CANT') ?? '' }}"
                                    data-transport="{{ $classe->getEffectiveTarif('TRANSP') ?? '' }}"
                                    {{ (old('classe_id', $selected_classe_id ?? '') == $classe->id) ? 'selected' : '' }}>
                                    {{ $classe->nom }} @if($classe->niveau) ({{ $classe->niveau->nom }}) @endif
                                </option>
                            @endforeach
                        </select>
                        @error('classe_id') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-bold">Date de l'inscription</label>
                    <input type="date" name="date_inscription" class="form-control" value="{{ date('Y-m-d') }}" required>
                </div>

                <div class="card bg-light border-0 mb-4 p-3 rounded-3">
                    <h6 class="fw-bold text-secondary mb-3"><i class='bx bx-check-shield me-2 text-primary'></i>Services Optionnels</h6>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="p-3 bg-white rounded-3 border h-100">
                                <div class="form-check form-switch mb-2">
                                    <input class="form-check-input" type="checkbox" role="switch" name="avec_cantine" id="avec_cantine" value="1" {{ old('avec_cantine') ? 'checked' : '' }}>
                                    <label class="form-check-label fw-bold" for="avec_cantine">
                                        <i class='bx bx-restaurant text-warning me-1'></i> Cantine Scolaire
                                    </label>
                                </div>
                                <div class="small text-muted" id="cantine_tarif_info">
                                    Prise en charge de la demi-pension / cantine.
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="p-3 bg-white rounded-3 border h-100">
                                <div class="form-check form-switch mb-2">
                                    <input class="form-check-input" type="checkbox" role="switch" name="avec_transport" id="avec_transport" value="1" {{ old('avec_transport') ? 'checked' : '' }}>
                                    <label class="form-check-label fw-bold" for="avec_transport">
                                        <i class='bx bx-bus text-info me-1'></i> Transport Scolaire
                                    </label>
                                </div>
                                <div class="small text-muted" id="transport_tarif_info">
                                    Abonnement aux circuits de transport scolaire.
                                </div>
                            </div>
                        </div>

                        <div class="col-12">
                            <a class="text-decoration-none small text-muted d-inline-flex align-items-center" data-bs-toggle="collapse" href="#collapseRemises" role="button" aria-expanded="false">
                                <i class='bx bx-purchase-tag-alt me-1 text-primary'></i> Accorder une remise tarifaire (facultatif) <i class='bx bx-chevron-down ms-1'></i>
                            </a>
                            <div class="collapse mt-2 {{ (old('remise_inscription') > 0 || old('remise_mensualite') > 0) ? 'show' : '' }}" id="collapseRemises">
                                <div class="row g-3 p-3 bg-white rounded-3 border">
                                    <div class="col-md-6">
                                        <label class="form-label small fw-semibold">Remise sur l'inscription (FCFA)</label>
                                        <input type="number" name="remise_inscription" class="form-control form-control-sm" value="{{ old('remise_inscription', 0) }}" min="0" step="500">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label small fw-semibold">Remise sur mensualité (FCFA)</label>
                                        <input type="number" name="remise_mensualite" class="form-control form-control-sm" value="{{ old('remise_mensualite', 0) }}" min="0" step="500">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="d-flex justify-content-between">
                    <a href="{{ route('inscriptions.index') }}" class="btn btn-light">Annuler</a>
                    <button type="submit" class="btn btn-primary px-5">Valider l'Inscription</button>
                </div>
            </form>
        </div>

        <script>
        function updateTarifsDisplay() {
            const select = document.getElementById('classe_id_select');
            if (!select) return;
            const opt = select.options[select.selectedIndex];
            if (!opt || !opt.value) return;

            const cantine = opt.getAttribute('data-cantine');
            const transport = opt.getAttribute('data-transport');

            const cantineInfo = document.getElementById('cantine_tarif_info');
            if (cantineInfo) {
                cantineInfo.innerHTML = cantine && parseFloat(cantine) > 0
                    ? `<span class="badge bg-warning-subtle text-dark border"><i class='bx bx-coin-stack me-1'></i>${new Intl.NumberFormat('fr-FR').format(cantine)} FCFA / mois</span>`
                    : 'Prise en charge de la demi-pension / cantine.';
            }

            const transportInfo = document.getElementById('transport_tarif_info');
            if (transportInfo) {
                transportInfo.innerHTML = transport && parseFloat(transport) > 0
                    ? `<span class="badge bg-info-subtle text-dark border"><i class='bx bx-coin-stack me-1'></i>${new Intl.NumberFormat('fr-FR').format(transport)} FCFA / mois</span>`
                    : 'Abonnement aux circuits de transport scolaire.';
            }
        }
        document.addEventListener('DOMContentLoaded', function() {
            updateTarifsDisplay();
            $('#classe_id_select').on('select2:select select2:clear change', updateTarifsDisplay);
        });
        </script>

        <div class="alert alert-info mt-4 border-0 rounded-4">
            <i class='bx bx-info-circle me-1'></i>
            L'inscription d'un élève dans l'année scolaire <strong>Active</strong> mettra automatiquement à jour sa classe actuelle affichée dans sa fiche de profil.
        </div>
    </div>
</div>
@endsection
