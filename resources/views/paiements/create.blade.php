@extends('layouts.app')

@section('title', 'Nouvel Encaissement')
@section('page_title', 'Effectuer un paiement')

@section('content')
<div class="row justify-content-center animate__animated animate__fadeInUp">
    <div class="col-md-8">
        <div class="card p-4">
            <form action="{{ route('paiements.store') }}" method="POST">
                @csrf
                
                <h5 class="fw-bold mb-4 text-primary"><i class='bx bx-wallet me-2'></i>Détails du paiement</h5>
                
                <div class="row g-3">
                    <div class="col-md-12">
                        <label class="form-label fw-bold">Élève <span class="text-danger">*</span></label>
                        <select name="eleve_id" id="eleve_id" class="form-select select2 @error('eleve_id') is-invalid @enderror" data-placeholder="Rechercher un élève par nom, prénom ou matricule..." required>
                            <option value=""></option>
                            @foreach($eleves as $eleve)
                                <option value="{{ $eleve->id }}" {{ old('eleve_id', request('eleve_id')) == $eleve->id ? 'selected' : '' }}>
                                    {{ $eleve->matricule }} - {{ $eleve->prenom }} {{ $eleve->nom }} ({{ $eleve->classe->nom ?? 'Sans classe' }})
                                </option>
                            @endforeach
                        </select>
                        @error('eleve_id') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-bold">Type de frais <span class="text-danger">*</span></label>
                        <select name="type_paiement_id" id="type_paiement_id" class="form-select select2" data-placeholder="-- Sélectionner le motif --" required>
                            <option value=""></option>
                            @foreach($types as $type)
                                <option value="{{ $type->id }}" {{ old('type_paiement_id', request('type_paiement_id')) == $type->id ? 'selected' : '' }}>{{ $type->nom }}</option>
                            @endforeach
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-bold">Montant attendu (Tarif - Remise)</label>
                        <div class="input-group">
                            <input type="text" id="montant_du_display" class="form-control text-muted bg-light" readonly placeholder="Calcul automatique...">
                            <span class="input-group-text bg-light fw-bold text-muted">FCFA</span>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-bold">Montant à encaisser (FCFA) <span class="text-danger">*</span></label>
                        <input type="number" id="montant_paye" name="montant_paye" class="form-control border-success" required placeholder="Ex: 25000">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-bold">Mode de règlement <span class="text-danger">*</span></label>
                        <select name="mode_paiement" class="form-select" required>
                            <option value="espèces">Espèces</option>
                            <option value="chèque">Chèque</option>
                            <option value="virement">Virement Bancaire</option>
                            <option value="mobile_money">Mobile Money (Wave/Orange)</option>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label fw-bold">Date de paiement</label>
                        <input type="date" name="date_paiement" class="form-control" value="{{ date('Y-m-d') }}" required>
                    </div>

                    <div class="col-md-12">
                        <label class="form-label fw-bold">Mois concerné <span class="text-muted fw-normal">(Laisser vide si hors mensualité)</span></label>
                        <select name="mois" class="form-select">
                            <option value="">-- Sélectionner le mois (Octobre à Juin) --</option>
                            @foreach($moisList as $valeurFormattee => $nomMois)
                                <option value="{{ $valeurFormattee }}" {{ old('mois', request('mois')) == $valeurFormattee ? 'selected' : '' }}>
                                    {{ $nomMois }} ({{ $valeurFormattee }})
                                </option>
                            @endforeach
                        </select>
                    </div>
                </div>

                <div class="d-flex justify-content-end gap-3 mt-5">
                    <a href="{{ route('paiements.index') }}" class="btn btn-light px-4">Annuler</a>
                    <button type="submit" class="btn btn-success px-5 fw-bold shadow">
                        Valider & Encaisser
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection

@section('scripts')
<script>
document.addEventListener('DOMContentLoaded', function() {
    const eleveSelect = document.getElementById('eleve_id');
    const typeSelect = document.getElementById('type_paiement_id');
    const montantDuDisplay = document.getElementById('montant_du_display');
    const montantPayeInput = document.getElementById('montant_paye');

    function fetchAmount() {
        const eleveId = eleveSelect.value;
        const typeId = typeSelect.value;

        if (!eleveId || !typeId) {
            montantDuDisplay.value = '';
            return;
        }

        montantDuDisplay.value = 'Chargement...';

        fetch(`{{ route('paiements.getAmount') }}?eleve_id=${eleveId}&type_paiement_id=${typeId}`)
            .then(response => response.json())
            .then(data => {
                montantDuDisplay.value = data.montant_final;
                montantPayeInput.value = data.montant_final; // Auto-fill
            })
            .catch(error => {
                console.error('Erreur:', error);
                montantDuDisplay.value = 'Erreur';
            });
    }

    eleveSelect.addEventListener('change', fetchAmount);
    typeSelect.addEventListener('change', fetchAmount);
    $('#eleve_id, #type_paiement_id').on('select2:select select2:clear change', fetchAmount);

    // Initial check if values are pre-selected
    if(eleveSelect.value && typeSelect.value) {
        fetchAmount();
    }
});
</script>
@endsection
