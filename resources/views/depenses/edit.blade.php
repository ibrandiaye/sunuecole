@extends('layouts.app')

@section('title', 'Modifier Depense')
@section('page_title', 'Modifier une Depense')

@section('content')
<div class="row justify-content-center animate__animated animate__fadeInUp">
    <div class="col-md-7">
        <div class="card p-4 border-0 rounded-4">
            <h5 class="fw-bold mb-4 text-warning"><i class='bx bx-edit me-2'></i>Modifier la Depense</h5>
            <form action="{{ route('depenses.update', $depense) }}" method="POST">
                @csrf @method('PUT')
                <div class="row g-3">
                    <div class="col-12">
                        <label class="form-label fw-semibold">Libelle <span class="text-danger">*</span></label>
                        <input type="text" name="libelle" class="form-control @error('libelle') is-invalid @enderror"
                            value="{{ old('libelle', $depense->libelle) }}">
                        @error('libelle')<div class="invalid-feedback">{{ $message }}</div>@enderror
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Categorie <span class="text-danger">*</span></label>
                        <select name="categorie" class="form-select @error('categorie') is-invalid @enderror">
                            @foreach($categories as $key => $label)
                                <option value="{{ $key }}" {{ old('categorie', $depense->categorie) == $key ? 'selected' : '' }}>{{ $label }}</option>
                            @endforeach
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Montant (FCFA) <span class="text-danger">*</span></label>
                        <input type="number" step="1" name="montant" class="form-control @error('montant') is-invalid @enderror"
                            value="{{ old('montant', $depense->montant) }}">
                        @error('montant')<div class="invalid-feedback">{{ $message }}</div>@enderror
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Date <span class="text-danger">*</span></label>
                        <input type="date" name="date_depense" class="form-control"
                            value="{{ old('date_depense', $depense->date_depense->format('Y-m-d')) }}">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Mode de Paiement</label>
                        <select name="mode_paiement" class="form-select">
                            @foreach(['especes'=>'Especes','wave'=>'Wave','OM'=>'Orange Money','virement'=>'Virement Bancaire'] as $v => $l)
                            <option value="{{ $v }}" {{ old('mode_paiement', $depense->mode_paiement) == $v ? 'selected' : '' }}>{{ $l }}</option>
                            @endforeach
                        </select>
                    </div>

                    <div class="col-12">
                        <label class="form-label fw-semibold">Notes / Justificatif</label>
                        <textarea name="notes" class="form-control" rows="3">{{ old('notes', $depense->notes) }}</textarea>
                    </div>
                </div>

                <div class="d-flex justify-content-end gap-3 mt-4">
                    <a href="{{ route('depenses.index') }}" class="btn btn-light px-4">Annuler</a>
                    <button type="submit" class="btn btn-warning px-5"><i class='bx bx-save me-1'></i>Mettre a jour</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection
