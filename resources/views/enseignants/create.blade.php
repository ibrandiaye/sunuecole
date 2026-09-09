@extends('layouts.app')

@section('title', 'Nouvel Enseignant')
@section('page_title', 'Ajouter un Enseignant')

@section('content')
<div class="row justify-content-center animate__animated animate__fadeInUp">
    <div class="col-md-10">
        <div class="card p-4">
            <form action="{{ route('enseignants.store') }}" method="POST" enctype="multipart/form-data">
                @csrf
                
                <h5 class="fw-bold mb-4 text-primary border-bottom pb-2"><i class='bx bx-user-plus me-2'></i>Informations du Compte & Profil</h5>
                
                <div class="row g-3">
                    <!-- Compte Utilisateur -->
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Nom Complet <span class="text-danger">*</span></label>
                        <input type="text" name="name" class="form-control @error('name') is-invalid @enderror" value="{{ old('name') }}" placeholder="Prénom et Nom">
                        @error('name') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Email Professionnel <span class="text-danger">*</span></label>
                        <input type="email" name="email" class="form-control @error('email') is-invalid @enderror" value="{{ old('email') }}" placeholder="enseignant@sunuecole.sn">
                        @error('email') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Téléphone <span class="text-danger">*</span></label>
                        <input type="text" name="telephone" class="form-control @error('telephone') is-invalid @enderror" value="{{ old('telephone') }}" placeholder="77 000 00 00">
                        @error('telephone') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                    
                    <!-- Profil Enseignant -->
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Spécialité / Discipline</label>
                        <input type="text" name="specialite" class="form-control @error('specialite') is-invalid @enderror" value="{{ old('specialite') }}" placeholder="Ex: Mathématiques, Français...">
                        @error('specialite') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Type de contrat <span class="text-danger">*</span></label>
                        <select name="statut" class="form-select @error('statut') is-invalid @enderror">
                            <option value="permanent" {{ old('statut') == 'permanent' ? 'selected' : '' }}>Permanent (Titulaire)</option>
                            <option value="vacataire" {{ old('statut') == 'vacataire' ? 'selected' : '' }}>Vacataire</option>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Date d'embauche</label>
                        <input type="date" name="date_embauche" class="form-control" value="{{ old('date_embauche', date('Y-m-d')) }}">
                    </div>

                    <div class="col-md-12">
                        <label class="form-label fw-semibold">Photo de profil</label>
                        <input type="file" name="photo" class="form-control">
                    </div>

                    <div class="col-md-12">
                        <label class="form-label fw-semibold">Matières enseignées (Peut en choisir plusieurs)</label>
                        <select name="matieres[]" class="form-select select2-multiple @error('matieres') is-invalid @enderror" multiple data-placeholder="Sélectionnez les matières...">
                            @foreach($matieres as $matiere)
                                <option value="{{ $matiere->id }}" {{ (is_array(old('matieres')) && in_array($matiere->id, old('matieres'))) ? 'selected' : '' }}>
                                    [{{ $matiere->code }}] {{ $matiere->nom }} - {{ ucfirst($matiere->cycle->nom ?? '') }}
                                </option>
                            @endforeach
                        </select>
                        <div class="form-text">Maintenez la touche Ctrl pour sélectionner plusieurs éléments.</div>
                        @error('matieres') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>

                    <div class="col-md-12">
                        <div class="alert alert-light border rounded-4 small">
                            <i class='bx bx-info-circle me-1'></i> Un compte utilisateur sera automatiquement créé. Le mot de passe par défaut est : <strong>password</strong>.
                        </div>
                    </div>
                </div>

                <div class="d-flex justify-content-end gap-3 mt-5">
                    <a href="{{ route('enseignants.index') }}" class="btn btn-light px-4">Annuler</a>
                    <button type="submit" class="btn btn-primary px-5">Créer l'Enseignant</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection
