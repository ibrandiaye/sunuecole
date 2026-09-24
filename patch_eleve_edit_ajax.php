<?php
// ============================================================
// 3. eleves/edit.blade.php
// ============================================================
$f = 'resources/views/eleves/edit.blade.php';
$c = file_get_contents($f);

$oldBlock = <<<'OLD'
                                    <div id="zone_transport_container" style="display: {{ old('avec_transport', $eleve->inscriptionActuelle?->avec_transport) ? 'block' : 'none' }};">
                                        <label class="form-label small mt-2">Choisir la Zone :</label>
                                        <select name="zone_transport_id" class="form-select form-select-sm @error('zone_transport_id') is-invalid @enderror">
                                            <option value="">Sélectionner une zone...</option>
                                            @foreach($zones ?? [] as $zone)
                                                <option value="{{ $zone->id }}" {{ old('zone_transport_id', $abonnementTransport?->zone_transport_id) == $zone->id ? 'selected' : '' }}>{{ $zone->nom }} ({{ number_format($zone->tarif_mensuel, 0, ',', ' ') }} F)</option>
                                            @endforeach
                                        </select>
                                        @error('zone_transport_id') <div class="invalid-feedback">Veuillez sélectionner une zone si le transport est coché.</div> @enderror
                                    </div>
OLD;

$newBlock = <<<'NEW'
                                    <div id="zone_transport_container" style="display: {{ old('avec_transport', $eleve->inscriptionActuelle?->avec_transport) ? 'block' : 'none' }};">
                                        <label class="form-label small mt-2">Choisir la Zone :</label>
                                        <select name="zone_transport_id" id="zone_select" class="form-select form-select-sm @error('zone_transport_id') is-invalid @enderror" onchange="loadVehiculesPourZone(this.value, document.getElementById('vehicule_select'))">
                                            <option value="">Sélectionner une zone...</option>
                                            @foreach($zones ?? [] as $zone)
                                                <option value="{{ $zone->id }}" {{ old('zone_transport_id', $abonnementTransport?->zone_transport_id) == $zone->id ? 'selected' : '' }}>{{ $zone->nom }} ({{ number_format($zone->tarif_mensuel, 0, ',', ' ') }} F)</option>
                                            @endforeach
                                        </select>
                                        @error('zone_transport_id') <div class="invalid-feedback">Veuillez sélectionner une zone si le transport est coché.</div> @enderror
                                        <label class="form-label small mt-2">Véhicule <span class="text-danger">*</span></label>
                                        <select name="vehicule_id" id="vehicule_select" class="form-select form-select-sm">
                                            <option value="">Choisir d'abord une zone...</option>
                                        </select>
                                        <small class="text-muted">Les places disponibles s'affichent en temps réel.</small>
                                    </div>
NEW;

$c = str_replace($oldBlock, $newBlock, $c);

$jsHelper = <<<'JS'
function loadVehiculesPourZone(zoneId, selectEl) {
    if(!zoneId) { selectEl.innerHTML = '<option value="">Choisir d\'abord une zone...</option>'; return; }
    selectEl.innerHTML = '<option>Chargement...</option>';
    fetch('/vehicules-par-zone/' + zoneId)
        .then(r => r.json())
        .then(function(data) {
            if(data.length === 0) { selectEl.innerHTML = '<option value="">Aucun véhicule pour cette zone</option>'; return; }
            var opts = '<option value="">-- Sélectionner un véhicule --</option>';
            data.forEach(function(v) {
                var disabled = v.complet ? 'disabled' : '';
                var badge = v.complet ? ' 🚫 COMPLET' : ' (' + v.places_dispo + ' place(s) dispo)';
                opts += '<option value="' + v.id + '" ' + disabled + '>' + v.label + badge + '</option>';
            });
            selectEl.innerHTML = opts;
        })
        .catch(function() { selectEl.innerHTML = '<option value="">Erreur de chargement</option>'; });
}
JS;

$c = str_replace('<script>', '<script>' . "\n" . $jsHelper, $c);

// Pre-load existing zone on page load
$preload = <<<'PRELOAD'
    // Pre-charger le véhicule si une zone est déjà sélectionnée
    document.addEventListener('DOMContentLoaded', function() {
        var zoneSelect = document.getElementById('zone_select');
        var vehiculeSelect = document.getElementById('vehicule_select');
        if(zoneSelect && zoneSelect.value && vehiculeSelect) {
            var currentVehiculeId = {{ $abonnementTransport?->vehicule_id ?? 'null' }};
            fetch('/vehicules-par-zone/' + zoneSelect.value)
                .then(r => r.json())
                .then(function(data) {
                    var opts = '<option value="">-- Sélectionner un véhicule --</option>';
                    data.forEach(function(v) {
                        var disabled = (v.complet && v.id != currentVehiculeId) ? 'disabled' : '';
                        var selected = (v.id == currentVehiculeId) ? 'selected' : '';
                        var badge = v.complet ? ' 🚫 COMPLET' : ' (' + v.places_dispo + ' place(s) dispo)';
                        opts += '<option value="' + v.id + '" ' + disabled + ' ' + selected + '>' + v.label + badge + '</option>';
                    });
                    vehiculeSelect.innerHTML = opts;
                });
        }
    });
PRELOAD;

$c = str_replace('</script>', $preload . "\n</script>", $c);

file_put_contents($f, $c);
echo "eleves/edit OK\n";
