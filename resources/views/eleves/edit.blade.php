@extends('layouts.app')

@section('title', 'Modifier Élève')
@section('page_title', 'Modification de l\'Élève')

@section('content')
<div class="row justify-content-center animate__animated animate__fadeInUp">
    <div class="col-md-10 col-lg-8">
        <form action="{{ route('eleves.update', $eleve) }}" method="POST" enctype="multipart/form-data">
            @csrf
            @method('PUT')
            
            <div class="card p-4 mb-4 border-0 rounded-4 shadow-sm">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h5 class="fw-bold mb-0 text-primary"><i class='bx bx-edit me-2'></i>Informations Personnelles</h5>
                    <span class="badge bg-primary-subtle text-primary border px-3 py-2 rounded-pill fw-bold">{{ $eleve->matricule }}</span>
                </div>
                
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Nom de famille <span class="text-danger">*</span></label>
                        <input type="text" name="nom" class="form-control @error('nom') is-invalid @enderror" value="{{ old('nom', $eleve->nom) }}" required>
                        @error('nom') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Prénom <span class="text-danger">*</span></label>
                        <input type="text" name="prenom" class="form-control @error('prenom') is-invalid @enderror" value="{{ old('prenom', $eleve->prenom) }}" required>
                        @error('prenom') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Date de naissance <span class="text-danger">*</span></label>
                        <input type="date" name="date_naissance" class="form-control @error('date_naissance') is-invalid @enderror" value="{{ old('date_naissance', $eleve->date_naissance) }}" required>
                        @error('date_naissance') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Lieu de naissance</label>
                        <input type="text" name="lieu_naissance" class="form-control" value="{{ old('lieu_naissance', $eleve->lieu_naissance) }}">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Sexe <span class="text-danger">*</span></label>
                        <select name="sexe" class="form-select @error('sexe') is-invalid @enderror" required>
                            <option value="M" {{ old('sexe', $eleve->sexe) == 'M' ? 'selected' : '' }}>Masculin</option>
                            <option value="F" {{ old('sexe', $eleve->sexe) == 'F' ? 'selected' : '' }}>Féminin</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Nationalité</label>
                        <input type="text" name="nationalite" class="form-control" value="{{ old('nationalite', $eleve->nationalite) }}">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Statut <span class="text-danger">*</span></label>
                        <select name="statut" class="form-select">
                            <option value="actif" {{ $eleve->statut == 'actif' ? 'selected' : '' }}>Actif</option>
                            <option value="archivé" {{ $eleve->statut == 'archivé' ? 'selected' : '' }}>Archivé</option>
                            <option value="transféré" {{ $eleve->statut == 'transféré' ? 'selected' : '' }}>Transféré</option>
                            <option value="exclu" {{ $eleve->statut == 'exclu' ? 'selected' : '' }}>Exclu</option>
                        </select>
                    </div>
                    <div class="col-12">
                        <label class="form-label fw-semibold">Photo (laisser vide pour conserver)</label>
                        <input type="file" name="photo" class="form-control" accept="image/*">
                    </div>
                </div>
            </div>

            {{-- CONTACT TUTEUR / PARENT --}}
            <div class="card p-4 mb-4 border-0 rounded-4 shadow-sm">
                <h5 class="fw-bold mb-3 text-primary"><i class='bx bx-user-voice me-2'></i>Responsable Légal / Tuteur</h5>
                
                <div class="row g-3">
                    <div class="col-12">
                        <label class="form-label fw-semibold">Rattacher à un tuteur enregistré</label>
                        <select name="parent_id" class="form-select">
                            <option value="">-- Aucun parent sélectionné / Saisie manuelle --</option>
                            @foreach($parents as $parent)
                                <option value="{{ $parent->id }}" {{ old('parent_id', $eleve->parent_id) == $parent->id ? 'selected' : '' }}>
                                    {{ $parent->user->name ?? 'Parent #' . $parent->id }} &bull; Tél: {{ $parent->telephone ?? $parent->user->telephone ?? 'Non renseigné' }}
                                </option>
                            @endforeach
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Nom du Tuteur</label>
                        <input type="text" name="nom_tuteur" class="form-control" value="{{ old('nom_tuteur', $eleve->nom_tuteur) }}" placeholder="Nom complet">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Téléphone Tuteur</label>
                        <input type="text" name="tel_tuteur" class="form-control" value="{{ old('tel_tuteur', $eleve->tel_tuteur) }}" placeholder="77 000 00 00">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Email Tuteur</label>
                        <input type="email" name="email_tuteur" class="form-control" value="{{ old('email_tuteur', $eleve->email_tuteur) }}" placeholder="parent@gmail.com">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Lien de parenté</label>
                        <input type="text" name="relation_tuteur" class="form-control" value="{{ old('relation_tuteur', $eleve->relation_tuteur) }}" placeholder="Père, Mère, Tuteur...">
                    </div>
                </div>
            </div>

            <div class="d-flex justify-content-end gap-3 mb-5">
                <a href="{{ route('eleves.index') }}" class="btn btn-light px-4 rounded-3">Annuler</a>
                <button type="submit" class="btn btn-primary px-5 rounded-3 fw-semibold">
                    <i class='bx bx-save me-1'></i> Mettre à jour
                </button>
            </div>
        </form>
    </div>
</div>
@endsection