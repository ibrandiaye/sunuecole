@extends('layouts.app')

@section('title', 'Enregistrer un Élève')
@section('page_title', 'Nouvel Élève')

@section('content')
<div class="row justify-content-center animate__animated animate__fadeInUp">
    <div class="col-md-10 col-lg-8">
        <form action="{{ route('eleves.store') }}" method="POST" enctype="multipart/form-data">
            @csrf
            
            {{-- INFORMATIONS PERSONNELLES --}}
            <div class="card p-4 mb-4 border-0 rounded-4 shadow-sm">
                <h5 class="fw-bold mb-4 text-primary"><i class='bx bx-user-pin me-2'></i>Informations Personnelles de l'Élève</h5>
                
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Nom de famille <span class="text-danger">*</span></label>
                        <input type="text" name="nom" class="form-control @error('nom') is-invalid @enderror" value="{{ old('nom') }}" placeholder="Ex: DIOP" required>
                        @error('nom') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Prénom <span class="text-danger">*</span></label>
                        <input type="text" name="prenom" class="form-control @error('prenom') is-invalid @enderror" value="{{ old('prenom') }}" placeholder="Ex: Moussa" required>
                        @error('prenom') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Date de naissance <span class="text-danger">*</span></label>
                        <input type="date" name="date_naissance" class="form-control @error('date_naissance') is-invalid @enderror" value="{{ old('date_naissance') }}" required>
                        @error('date_naissance') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Lieu de naissance</label>
                        <input type="text" name="lieu_naissance" class="form-control" value="{{ old('lieu_naissance') }}" placeholder="Ex: Dakar">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Sexe <span class="text-danger">*</span></label>
                        <select name="sexe" class="form-select @error('sexe') is-invalid @enderror" required>
                            <option value="">Sélectionner...</option>
                            <option value="M" {{ old('sexe') == 'M' ? 'selected' : '' }}>Masculin</option>
                            <option value="F" {{ old('sexe') == 'F' ? 'selected' : '' }}>Féminin</option>
                        </select>
                        @error('sexe') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Nationalité</label>
                        <input type="text" name="nationalite" class="form-control" value="{{ old('nationalite', 'Sénégalaise') }}">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Photo</label>
                        <input type="file" name="photo" class="form-control" accept="image/*">
                    </div>
                </div>
            </div>

            {{-- CONTACT TUTEUR / PARENT --}}
            <div class="card p-4 mb-4 border-0 rounded-4 shadow-sm">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold mb-0 text-primary"><i class='bx bx-user-voice me-2'></i>Responsable Légal / Tuteur</h5>
                </div>

                <div class="p-3 bg-light rounded-3 mb-3">
                    <label class="form-label fw-semibold d-block mb-2">Le tuteur est-il déjà enregistré dans l'établissement ?</label>
                    <div class="btn-group w-100" role="group">
                        <input type="radio" class="btn-check" name="tuteur_mode" id="mode_existant" value="existant" {{ (old('tuteur_mode', 'existant') == 'existant' && count($parents) > 0) ? 'checked' : '' }} onchange="toggleTuteurMode()">
                        <label class="btn btn-outline-primary" for="mode_existant"><i class='bx bx-user-check me-1'></i> Tuteur déjà enregistré</label>

                        <input type="radio" class="btn-check" name="tuteur_mode" id="mode_nouveau" value="nouveau" {{ (old('tuteur_mode') == 'nouveau' || count($parents) == 0) ? 'checked' : '' }} onchange="toggleTuteurMode()">
                        <label class="btn btn-outline-primary" for="mode_nouveau"><i class='bx bx-user-plus me-1'></i> Nouveau tuteur</label>
                    </div>
                </div>

                {{-- SECTION TUTEUR EXISTANT --}}
                <div id="section_tuteur_existant" class="mt-3">
                    <label class="form-label fw-semibold">Sélectionner le tuteur existant</label>
                    <select name="parent_id" id="parent_id_select" class="form-select select2 @error('parent_id') is-invalid @enderror" data-placeholder="-- Choisir un tuteur existant (Recherche par nom ou tél) --">
                        <option value=""></option>
                        @foreach($parents as $parent)
                            <option value="{{ $parent->id }}" {{ old('parent_id') == $parent->id ? 'selected' : '' }}>
                                {{ $parent->user->name ?? 'Parent #' . $parent->id }} &bull; Tél: {{ $parent->telephone ?? $parent->user->telephone ?? 'Non renseigné' }}
                            </option>
                        @endforeach
                    </select>
                    @error('parent_id') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    <small class="text-muted mt-1 d-block">
                        <i class='bx bx-info-circle me-1'></i> Cet élève sera automatiquement rattaché à ce parent (utile pour les fratries et l'accès mobile parent).
                    </small>
                </div>

                {{-- SECTION NOUVEAU TUTEUR --}}
                <div id="section_tuteur_nouveau" class="mt-3" style="display: none;">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Nom complet du tuteur</label>
                            <input type="text" name="nom_tuteur" id="nom_tuteur" class="form-control" value="{{ old('nom_tuteur') }}" placeholder="Ex: Ibrahima DIOP">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Téléphone tuteur</label>
                            <input type="text" name="tel_tuteur" id="tel_tuteur" class="form-control" value="{{ old('tel_tuteur') }}" placeholder="Ex: 77 123 45 67">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Email tuteur (facultatif)</label>
                            <input type="email" name="email_tuteur" id="email_tuteur" class="form-control" value="{{ old('email_tuteur') }}" placeholder="Ex: parent@gmail.com">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Lien de parenté</label>
                            <select name="relation_tuteur" class="form-select">
                                <option value="Père" {{ old('relation_tuteur') == 'Père' ? 'selected' : '' }}>Père</option>
                                <option value="Mère" {{ old('relation_tuteur') == 'Mère' ? 'selected' : '' }}>Mère</option>
                                <option value="Tuteur légal" {{ old('relation_tuteur') == 'Tuteur légal' ? 'selected' : '' }}>Tuteur légal</option>
                                <option value="Oncle / Tante" {{ old('relation_tuteur') == 'Oncle / Tante' ? 'selected' : '' }}>Oncle / Tante</option>
                                <option value="Autre" {{ old('relation_tuteur') == 'Autre' ? 'selected' : '' }}>Autre</option>
                            </select>
                        </div>
                    </div>
                    <small class="text-muted mt-2 d-block">
                        <i class='bx bx-check-circle text-success me-1'></i> Un compte d'accès parent sera automatiquement créé pour lui permettre de suivre son enfant sur mobile.
                    </small>
                </div>
            </div>

            {{-- AFFECTATION DE CLASSE --}}
            <div class="card p-4 mb-4 border-0 rounded-4 shadow-sm">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold mb-0 text-primary">
                        <i class='bx bx-building-house me-2'></i>Affectation de Classe
                    </h5>
                    @if(!empty($selected_classe_id))
                        <span class="badge bg-success-subtle text-success border border-success-subtle px-3 py-2 rounded-pill">
                            <i class='bx bx-check-circle me-1'></i> Inscription directe
                        </span>
                    @else
                        <span class="badge bg-secondary-subtle text-secondary px-3 py-2 rounded-pill">Optionnel</span>
                    @endif
                </div>

                @if(!empty($selected_classe_id))
                    @php
                        $preselectedClasse = $classes->firstWhere('id', $selected_classe_id);
                    @endphp
                    @if($preselectedClasse)
                        <div class="alert alert-success border-0 rounded-3 p-3 mb-3 d-flex align-items-center">
                            <i class='bx bx-check-double fs-3 me-3 text-success'></i>
                            <div>
                                <strong>Inscription directe dans : {{ $preselectedClasse->nom }}</strong>
                                @if($preselectedClasse->niveau) &bull; <span class="badge bg-white text-success border border-success-subtle">{{ $preselectedClasse->niveau->nom }}</span> @endif
                                <div class="small text-muted">L'élève sera automatiquement inscrit dans cette classe pour l'année scolaire en cours dès l'enregistrement.</div>
                            </div>
                        </div>
                    @endif
                @endif

                <div class="row g-3">
                    <div class="col-md-12">
                        <label class="form-label fw-semibold">Classe de l'élève</label>
                        <select name="classe_id" id="classe_id_select" class="form-select select2 @error('classe_id') is-invalid @enderror" data-placeholder="-- Aucune classe pour le moment (Inscription ultérieure) --" onchange="onClasseChange()">
                            <option value=""></option>
                            @foreach($classes as $c)
                                <option value="{{ $c->id }}" 
                                    data-cantine="{{ $c->montant_cantine ?? '' }}" 
                                    data-transport="{{ $c->montant_transport ?? '' }}" 
                                    {{ old('classe_id', $selected_classe_id) == $c->id ? 'selected' : '' }}>
                                    {{ $c->nom }} @if($c->niveau) ({{ $c->niveau->nom }}) @endif
                                </option>
                            @endforeach
                        </select>
                        @error('classe_id') <div class="invalid-feedback">{{ $message }}</div> @enderror
                        <small class="text-muted mt-1 d-block">
                            <i class='bx bx-info-circle me-1'></i> En choisissant une classe, l'inscription administrative de l'élève est générée immédiatement pour l'année scolaire active.
                        </small>
                    </div>
                </div>

                {{-- SERVICES OPTIONNELS (CANTINE & TRANSPORT) --}}
                <div id="section_services_options" class="mt-3 pt-3 border-top" style="{{ (!empty($selected_classe_id) || old('classe_id')) ? '' : 'display: none;' }}">
                    <h6 class="fw-bold text-secondary mb-3">
                        <i class='bx bx-check-shield me-1 text-primary'></i> Services Optionnels &amp; Prise en charge
                    </h6>
                    
                    <div class="row g-3">
                        {{-- CANTINE --}}
                        <div class="col-md-6">
                            <div class="p-3 border rounded-3 h-100 bg-light">
                                <div class="form-check form-switch mb-2">
                                    <input class="form-check-input" type="checkbox" role="switch" name="avec_cantine" id="avec_cantine" value="1" {{ old('avec_cantine') ? 'checked' : '' }}>
                                    <label class="form-check-label fw-bold" for="avec_cantine">
                                        <i class='bx bx-restaurant text-warning me-1'></i> Cantine Scolaire
                                    </label>
                                </div>
                                <div class="small text-muted" id="cantine_tarif_text">
                                    Inscrire l'élève à la cantine scolaire.
                                </div>
                            </div>
                        </div>

                        {{-- TRANSPORT --}}
                        <div class="col-md-6">
                            <div class="p-3 border rounded-3 h-100 bg-light">
                                <div class="form-check form-switch mb-2">
                                    <input class="form-check-input" type="checkbox" role="switch" name="avec_transport" id="avec_transport" value="1" {{ old('avec_transport') ? 'checked' : '' }}>
                                    <label class="form-check-label fw-bold" for="avec_transport">
                                        <i class='bx bx-bus text-info me-1'></i> Transport Scolaire
                                    </label>
                                </div>
                                <div class="small text-muted" id="transport_tarif_text">
                                    Abonner l'élève aux circuits de transport scolaire.
                                </div>
                            </div>
                        </div>

                        {{-- REMISES OPTIONNELLES --}}
                        <div class="col-12 mt-2">
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
            </div>

            <div class="d-flex justify-content-end gap-3 mb-5">
                <a href="{{ route('eleves.index') }}" class="btn btn-light px-4 rounded-3">Annuler</a>
                <button type="submit" class="btn btn-primary px-5 rounded-3 fw-semibold">
                    <i class='bx bx-save me-1'></i> Enregistrer l'Élève
                </button>
            </div>
        </form>
    </div>
</div>

<script>
function toggleTuteurMode() {
    const isExistant = document.getElementById('mode_existant').checked;
    const secExistant = document.getElementById('section_tuteur_existant');
    const secNouveau = document.getElementById('section_tuteur_nouveau');

    if (isExistant) {
        secExistant.style.display = 'block';
        secNouveau.style.display = 'none';
    } else {
        secExistant.style.display = 'none';
        secNouveau.style.display = 'block';
    }
}

function onClasseChange() {
    const select = document.getElementById('classe_id_select');
    const optionsSection = document.getElementById('section_services_options');
    if (!select || !optionsSection) return;

    const selectedOption = select.options[select.selectedIndex];
    if (selectedOption && selectedOption.value) {
        optionsSection.style.display = 'block';
        const cantineTarif = selectedOption.getAttribute('data-cantine');
        const transportTarif = selectedOption.getAttribute('data-transport');

        const cantineText = document.getElementById('cantine_tarif_text');
        if (cantineText) {
            cantineText.innerHTML = cantineTarif && parseFloat(cantineTarif) > 0 
                ? `<span class="badge bg-warning-subtle text-dark border"><i class='bx bx-coin-stack me-1'></i>${new Intl.NumberFormat('fr-FR').format(cantineTarif)} FCFA / mois</span>`
                : 'Inscrire l\'élève à la cantine scolaire.';
        }

        const transportText = document.getElementById('transport_tarif_text');
        if (transportText) {
            transportText.innerHTML = transportTarif && parseFloat(transportTarif) > 0
                ? `<span class="badge bg-info-subtle text-dark border"><i class='bx bx-coin-stack me-1'></i>${new Intl.NumberFormat('fr-FR').format(transportTarif)} FCFA / mois</span>`
                : 'Abonner l\'élève aux circuits de transport scolaire.';
        }
    } else {
        optionsSection.style.display = 'none';
    }
}

// Initialisation au chargement
document.addEventListener('DOMContentLoaded', function() {
    toggleTuteurMode();
    onClasseChange();
    $('#classe_id_select').on('select2:select select2:clear change', onClasseChange);
});
</script>
@endsection