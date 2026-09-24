<?php
$f = 'resources/views/eleves/create.blade.php';
$c = file_get_contents($f);

$oldBlock = <<<'OLD'
                                <div id="zone_transport_container" style="display: {{ old('avec_transport') ? 'block' : 'none' }};">
                                    <label class="form-label small mt-2">Choisir la Zone :</label>
                                    <select name="zone_transport_id" class="form-select form-select-sm @error('zone_transport_id') is-invalid @enderror">
                                        @error('zone_transport_id') <div class="invalid-feedback">Veuillez sélectionner une zone si le transport est coché.</div> @enderror
                                        <option value="">Sélectionner une zone...</option>
                                        @foreach($zones ?? [] as $zone)
                                            <option value="{{ $zone->id }}" {{ old('zone_transport_id') == $zone->id ? 'selected' : '' }}>{{ $zone->nom }} ({{ number_format($zone->tarif_mensuel, 0, ',', ' ') }} F)</option>
                                        @endforeach
                                    </select>
                                </div>
OLD;

$newBlock = <<<'NEW'
                                <div id="zone_transport_container" style="display: {{ old('avec_transport') ? 'block' : 'none' }};">
                                    <label class="form-label small mt-2">Choisir la Zone :</label>
                                    <select name="zone_transport_id" id="zone_select" class="form-select form-select-sm @error('zone_transport_id') is-invalid @enderror" onchange="loadVehiculesPourZone(this.value, document.getElementById('vehicule_select'))">
                                        <option value="">Sélectionner une zone...</option>
                                        @foreach($zones ?? [] as $zone)
                                            <option value="{{ $zone->id }}" {{ old('zone_transport_id') == $zone->id ? 'selected' : '' }}>{{ $zone->nom }} ({{ number_format($zone->tarif_mensuel, 0, ',', ' ') }} F)</option>
                                        @endforeach
                                    </select>
                                    @error('zone_transport_id') <div class="invalid-feedback">Veuillez sélectionner une zone si le transport est coché.</div> @enderror
                                    
                                    <label class="form-label small mt-2">Véhicule <span class="text-danger">*</span></label>
                                    <select name="vehicule_id" id="vehicule_select" class="form-select form-select-sm @error('vehicule_id') is-invalid @enderror">
                                        <option value="">Choisir d'abord une zone...</option>
                                    </select>
                                    @error('vehicule_id') <div class="invalid-feedback">{{ $message }}</div> @enderror
                                    <small class="text-muted">Les places disponibles s'affichent en temps réel.</small>
                                </div>
NEW;

$c = str_replace($oldBlock, $newBlock, $c);

// add js helper
$jsHelper = <<<'JS'
function loadVehiculesPourZone(zoneId, selectEl, selectedVehiculeId = null) {
    if(!zoneId) { selectEl.innerHTML = '<option value="">Choisir d\'abord une zone...</option>'; return; }
    selectEl.innerHTML = '<option>Chargement...</option>';
    fetch('/vehicules-par-zone/' + zoneId)
        .then(r => r.json())
        .then(function(data) {
            if(data.length === 0) { selectEl.innerHTML = '<option value="">Aucun véhicule pour cette zone</option>'; return; }
            var opts = '<option value="">-- Sélectionner un véhicule --</option>';
            data.forEach(function(v) {
                var isSelected = (selectedVehiculeId && selectedVehiculeId == v.id) ? 'selected' : '';
                var disabled = (v.complet && !isSelected) ? 'disabled' : '';
                var badge = v.complet ? ' 🚫 COMPLET' : ' (' + v.places_dispo + ' place(s) dispo)';
                opts += '<option value="' + v.id + '" ' + disabled + ' ' + isSelected + '>' + v.label + badge + '</option>';
            });
            selectEl.innerHTML = opts;
        })
        .catch(function() { selectEl.innerHTML = '<option value="">Erreur de chargement</option>'; });
}
JS;

$preload = <<<'PRELOAD'
    document.addEventListener('DOMContentLoaded', function() {
        var zoneSelect = document.getElementById('zone_select');
        var vehiculeSelect = document.getElementById('vehicule_select');
        if(zoneSelect && zoneSelect.value && vehiculeSelect) {
            var oldVehicule = "{{ old('vehicule_id') }}";
            loadVehiculesPourZone(zoneSelect.value, vehiculeSelect, oldVehicule);
        }
    });
PRELOAD;

if (!str_contains($c, 'loadVehiculesPourZone')) {
    $c = str_replace('<script>', "<script>\n" . $jsHelper . "\n" . $preload, $c);
} else {
    // Already has some JS, we just update it
}

file_put_contents($f, $c);
echo "eleves/create patched manually\n";
