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
                    <select name="parent_id" id="parent_id_select" class="form-select @error('parent_id') is-invalid @enderror">
                        <option value="">-- Choisir un tuteur existant --</option>
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

            {{-- BANDEAU INFORMATIF INSCRIPTION --}}
            <div class="alert alert-info border-0 rounded-4 p-3 d-flex align-items-center mb-4">
                <i class='bx bx-info-circle fs-3 text-primary me-3'></i>
                <div>
                    <strong>Affectation de classe &amp; frais scolaires :</strong>
                    <div class="small text-muted">L'affectation à une classe ainsi que la souscription aux options (cantine, transport) et les réductions tarifaires se font désormais dans le module <strong>Inscriptions</strong>.</div>
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

// Initialisation au chargement
document.addEventListener('DOMContentLoaded', function() {
    toggleTuteurMode();
});
</script>
@endsection