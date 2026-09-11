@extends('layouts.app')

@section('title', 'Modifier le Tuteur')
@section('page_title', 'Modifier les informations du tuteur')

@section('content')
<div class="row justify-content-center animate__animated animate__fadeIn">
    <div class="col-lg-9">

        {{-- Carte infos rapides --}}
        <div class="card border-0 shadow-sm rounded-4 mb-4 p-4">
            <div class="d-flex align-items-center gap-4">
                @if($tuteur->photo)
                    <img src="{{ asset('storage/' . $tuteur->photo) }}"
                         class="rounded-circle border shadow-sm"
                         width="80" height="80" style="object-fit:cover;">
                @else
                    <div class="rounded-circle bg-primary bg-opacity-10 text-primary d-flex align-items-center justify-content-center fw-bold"
                         style="width:80px;height:80px;font-size:1.6rem;">
                        {{ strtoupper(substr($tuteur->user?->name ?? '?', 0, 2)) }}
                    </div>
                @endif
                <div>
                    <h4 class="fw-bold mb-1">{{ $tuteur->user?->name }}</h4>
                    <div class="text-muted small">
                        <i class='bx bx-envelope me-1'></i>{{ $tuteur->user?->email }}
                        @if($tuteur->telephone)
                            &nbsp;·&nbsp;<i class='bx bx-phone me-1'></i>{{ $tuteur->telephone }}
                        @endif
                    </div>
                    <div class="mt-2 d-flex gap-2 flex-wrap">
                        @php
                            $relColors = ['parent' => 'primary', 'tuteur' => 'info', 'gardien' => 'warning'];
                            $rc = $relColors[$tuteur->relation ?? 'parent'] ?? 'secondary';
                        @endphp
                        <span class="badge bg-{{ $rc }}-subtle text-{{ $rc }} border rounded-pill px-2">
                            {{ ucfirst($tuteur->relation ?? 'parent') }}
                        </span>
                        @if($tuteur->actif)
                            <span class="badge bg-success-subtle text-success border rounded-pill px-2">Actif</span>
                        @else
                            <span class="badge bg-danger-subtle text-danger border rounded-pill px-2">Inactif</span>
                        @endif
                        @foreach($tuteur->eleves as $eleve)
                            <span class="badge bg-light text-dark border">
                                <i class='bx bx-user me-1'></i>{{ $eleve->prenom }} {{ $eleve->nom }}
                                @if($eleve->classe) ({{ $eleve->classe->nom }}) @endif
                            </span>
                        @endforeach
                    </div>
                </div>
            </div>
        </div>

        {{-- Formulaire d'édition --}}
        <div class="card border-0 shadow-sm rounded-4 p-4">
            <h6 class="fw-bold mb-4 text-primary">
                <i class='bx bx-edit-alt me-2'></i>Modifier les informations
            </h6>

            @if($errors->any())
                <div class="alert alert-danger border-0 rounded-4 mb-4">
                    <ul class="mb-0">
                        @foreach($errors->all() as $error)
                            <li>{{ $error }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <form action="{{ route('tuteurs.update', $tuteur->id) }}" method="POST" enctype="multipart/form-data">
                @csrf
                @method('PUT')

                {{-- === INFORMATIONS PERSONNELLES === --}}
                <div class="row g-3 mb-4">
                    <div class="col-12">
                        <h6 class="text-muted text-uppercase fw-semibold" style="font-size:.75rem;letter-spacing:.05em;">
                            <i class='bx bx-user me-1'></i> Informations personnelles
                        </h6>
                        <hr class="mt-1 mb-3 opacity-25">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Nom complet <span class="text-danger">*</span></label>
                        <input type="text" name="name" class="form-control @error('name') is-invalid @enderror"
                               value="{{ old('name', $tuteur->user?->name) }}" required>
                        @error('name')<div class="invalid-feedback">{{ $message }}</div>@enderror
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Email <span class="text-danger">*</span></label>
                        <input type="email" name="email" class="form-control @error('email') is-invalid @enderror"
                               value="{{ old('email', $tuteur->user?->email) }}" required>
                        @error('email')<div class="invalid-feedback">{{ $message }}</div>@enderror
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Téléphone</label>
                        <input type="text" name="telephone" class="form-control @error('telephone') is-invalid @enderror"
                               value="{{ old('telephone', $tuteur->telephone) }}"
                               placeholder="ex: 77 123 45 67">
                        @error('telephone')<div class="invalid-feedback">{{ $message }}</div>@enderror
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">NIN (Numéro Identité Nationale)</label>
                        <input type="text" name="nin" class="form-control @error('nin') is-invalid @enderror"
                               value="{{ old('nin', $tuteur->nin) }}" placeholder="ex: 1 9780012345">
                        @error('nin')<div class="invalid-feedback">{{ $message }}</div>@enderror
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Profession</label>
                        <input type="text" name="profession" class="form-control @error('profession') is-invalid @enderror"
                               value="{{ old('profession', $tuteur->profession) }}" placeholder="ex: Commerçant, Fonctionnaire...">
                        @error('profession')<div class="invalid-feedback">{{ $message }}</div>@enderror
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Relation avec l'élève <span class="text-danger">*</span></label>
                        <select name="relation" class="form-select @error('relation') is-invalid @enderror" required>
                            <option value="parent"  {{ old('relation', $tuteur->relation) === 'parent'  ? 'selected' : '' }}>Parent</option>
                            <option value="tuteur"  {{ old('relation', $tuteur->relation) === 'tuteur'  ? 'selected' : '' }}>Tuteur légal</option>
                            <option value="gardien" {{ old('relation', $tuteur->relation) === 'gardien' ? 'selected' : '' }}>Gardien</option>
                        </select>
                        @error('relation')<div class="invalid-feedback">{{ $message }}</div>@enderror
                    </div>

                    <div class="col-12">
                        <label class="form-label fw-semibold">Adresse</label>
                        <textarea name="adresse" class="form-control @error('adresse') is-invalid @enderror"
                                  rows="2" placeholder="Quartier, ville...">{{ old('adresse', $tuteur->adresse) }}</textarea>
                        @error('adresse')<div class="invalid-feedback">{{ $message }}</div>@enderror
                    </div>
                </div>

                {{-- === PHOTO === --}}
                <div class="row g-3 mb-4">
                    <div class="col-12">
                        <h6 class="text-muted text-uppercase fw-semibold" style="font-size:.75rem;letter-spacing:.05em;">
                            <i class='bx bx-image me-1'></i> Photo de profil
                        </h6>
                        <hr class="mt-1 mb-3 opacity-25">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Changer la photo</label>
                        <input type="file" name="photo" class="form-control @error('photo') is-invalid @enderror"
                               accept="image/*">
                        @error('photo')<div class="invalid-feedback">{{ $message }}</div>@enderror
                        @if($tuteur->photo)
                            <div class="mt-2">
                                <img src="{{ asset('storage/' . $tuteur->photo) }}"
                                     class="rounded border" width="80" height="80" style="object-fit:cover;"
                                     alt="Photo actuelle">
                                <small class="text-muted ms-2">Photo actuelle</small>
                            </div>
                        @endif
                    </div>
                    <div class="col-md-6 d-flex align-items-center">
                        <div class="form-check form-switch mt-2">
                            <input class="form-check-input" type="checkbox" role="switch"
                                   id="actif" name="actif" value="1"
                                   {{ old('actif', $tuteur->actif) ? 'checked' : '' }}>
                            <label class="form-check-label fw-semibold" for="actif">
                                Compte actif (accès à l'application mobile)
                            </label>
                        </div>
                    </div>
                </div>

                {{-- === MOT DE PASSE === --}}
                <div class="row g-3 mb-4">
                    <div class="col-12">
                        <h6 class="text-muted text-uppercase fw-semibold" style="font-size:.75rem;letter-spacing:.05em;">
                            <i class='bx bx-lock-alt me-1'></i> Réinitialiser le mot de passe
                            <span class="ms-2 text-muted fw-normal">(laisser vide pour ne pas changer)</span>
                        </h6>
                        <hr class="mt-1 mb-3 opacity-25">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Nouveau mot de passe</label>
                        <input type="password" name="password"
                               class="form-control @error('password') is-invalid @enderror"
                               placeholder="Minimum 6 caractères">
                        @error('password')<div class="invalid-feedback">{{ $message }}</div>@enderror
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Confirmer le mot de passe</label>
                        <input type="password" name="password_confirmation"
                               class="form-control" placeholder="Répéter le mot de passe">
                    </div>
                </div>

                {{-- === ACTIONS === --}}
                <div class="d-flex justify-content-between align-items-center pt-2">
                    <a href="{{ route('tuteurs.index') }}" class="btn btn-light border px-4">
                        <i class='bx bx-arrow-back me-1'></i> Annuler
                    </a>
                    <button type="submit" class="btn btn-primary px-5 fw-semibold">
                        <i class='bx bx-save me-1'></i> Enregistrer les modifications
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection
