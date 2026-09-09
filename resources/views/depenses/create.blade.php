@extends('layouts.app')

@section('title', 'Nouvelle Depense')
@section('page_title', 'Enregistrer une Depense')

@section('content')
<div class="row justify-content-center animate__animated animate__fadeInUp">
    <div class="col-md-7">
        <div class="card p-4 border-0 rounded-4">
            <h5 class="fw-bold mb-4 text-primary"><i class='bx bx-minus-circle me-2'></i>Nouvelle Depense</h5>
            <form action="{{ route('depenses.store') }}" method="POST">
                @csrf
                <div class="row g-3">
                    <div class="col-12">
                        <label class="form-label fw-semibold">Libelle <span class="text-danger">*</span></label>
                        <input type="text" name="libelle" class="form-control @error('libelle') is-invalid @enderror"
                            value="{{ old('libelle') }}" placeholder="Ex: Achat de craies, Salaire gardien...">
                        @error('libelle')<div class="invalid-feedback">{{ $message }}</div>@enderror
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Categorie <span class="text-danger">*</span></label>
                        <select name="categorie" class="form-select @error('categorie') is-invalid @enderror">
                            @foreach($categories as $key => $label)
                                <option value="{{ $key }}" {{ old('categorie') == $key ? 'selected' : '' }}>{{ $label }}</option>
                            @endforeach
                        </select>
                        @error('categorie')<div class="invalid-feedback">{{ $message }}</div>@enderror
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Montant (FCFA) <span class="text-danger">*</span></label>
                        <input type="number" step="1" name="montant" class="form-control @error('montant') is-invalid @enderror"
                            value="{{ old('montant') }}" placeholder="Ex: 50000">
                        @error('montant')<div class="invalid-feedback">{{ $message }}</div>@enderror
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Date <span class="text-danger">*</span></label>
                        <input type="date" name="date_depense" class="form-control @error('date_depense') is-invalid @enderror"
                            value="{{ old('date_depense', date('Y-m-d')) }}">
                        @error('date_depense')<div class="invalid-feedback">{{ $message }}</div>@enderror
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Mode de Paiement</label>
                        <select name="mode_paiement" class="form-select">
                            <option value="especes" {{ old('mode_paiement','especes')=='especes' ? 'selected' : '' }}>Especes</option>
                            <option value="wave" {{ old('mode_paiement')=='wave' ? 'selected' : '' }}>Wave</option>
                            <option value="OM" {{ old('mode_paiement')=='OM' ? 'selected' : '' }}>Orange Money</option>
                            <option value="virement" {{ old('mode_paiement')=='virement' ? 'selected' : '' }}>Virement Bancaire</option>
                        </select>
                    </div>

                    <div class="col-12">
                        <label class="form-label fw-semibold">Annee Scolaire <span class="text-danger">*</span></label>
                        <input type="hidden" name="annee_scolaire_id" value="{{ $annee?->id }}">
                        <input type="text" class="form-control" value="{{ $annee?->libelle ?? 'Aucune annee active' }}" readonly>
                    </div>

                    <div class="col-12">
                        <label class="form-label fw-semibold">Notes / Justificatif</label>
                        <textarea name="notes" class="form-control" rows="3"
                            placeholder="Details supplementaires...">{{ old('notes') }}</textarea>
                    </div>
                </div>

                <div class="d-flex justify-content-end gap-3 mt-4">
                    <a href="{{ route('depenses.index') }}" class="btn btn-light px-4">Annuler</a>
                    <button type="submit" class="btn btn-danger px-5"><i class='bx bx-save me-1'></i>Enregistrer</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection
