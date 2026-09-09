@extends('layouts.app')

@section('title', 'Modifier Enseignant')
@section('page_title', "Modifier l'Enseignant")

@section('content')
<div class="row justify-content-center animate__animated animate__fadeInUp">
    <div class="col-md-10">
        <div class="card p-4">
            <form action="{{ route('enseignants.update', $enseignant) }}" method="POST">
                @csrf
                @method('PATCH')
                
                <h5 class="fw-bold mb-4 text-primary border-bottom pb-2"><i class='bx bx-edit me-2'></i>Informations du Profil</h5>
                
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Nom Complet <span class="text-danger">*</span></label>
                        <input type="text" name="name" class="form-control @error('name') is-invalid @enderror" value="{{ old('name', $enseignant->user->name) }}" required>
                        @error('name') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Email Professionnel <span class="text-danger">*</span></label>
                        <input type="email" name="email" class="form-control @error('email') is-invalid @enderror" value="{{ old('email', $enseignant->user->email) }}" required>
                        @error('email') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Téléphone <span class="text-danger">*</span></label>
                        <input type="text" name="telephone" class="form-control @error('telephone') is-invalid @enderror" value="{{ old('telephone', $enseignant->user->telephone) }}" required>
                        @error('telephone') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Spécialité / Discipline</label>
                        <input type="text" name="specialite" class="form-control @error('specialite') is-invalid @enderror" value="{{ old('specialite', $enseignant->specialite) }}">
                        @error('specialite') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Type de contrat <span class="text-danger">*</span></label>
                        <select name="statut" class="form-select @error('statut') is-invalid @enderror">
                            <option value="permanent" {{ old('statut', $enseignant->statut) == 'permanent' ? 'selected' : '' }}>Permanent (Titulaire)</option>
                            <option value="vacataire" {{ old('statut', $enseignant->statut) == 'vacataire' ? 'selected' : '' }}>Vacataire</option>
                        </select>
                    </div>

                    <div class="col-md-12">
                        <label class="form-label fw-semibold">Matières enseignées</label>
                        <select name="matieres[]" class="form-select @error('matieres') is-invalid @enderror" multiple style="height: 150px;">
                            @php $selectedMatieres = old('matieres', $enseignant->matieres->pluck('id')->toArray()); @endphp
                            @foreach($matieres as $matiere)
                                <option value="{{ $matiere->id }}" {{ in_array($matiere->id, $selectedMatieres) ? 'selected' : '' }}>
                                    [{{ $matiere->code }}] {{ $matiere->nom }} - {{ ucfirst($matiere->cycle->nom ?? '') }}
                                </option>
                            @endforeach
                        </select>
                        <div class="form-text mt-1">Utilisez Ctrl+Clic pour sélectionner plusieurs matières.</div>
                        @error('matieres') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                </div>

                <div class="d-flex justify-content-end gap-3 mt-5">
                    <a href="{{ route('enseignants.index') }}" class="btn btn-light px-4">Annuler</a>
                    <button type="submit" class="btn btn-primary px-5">Mettre à jour le profil</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection
