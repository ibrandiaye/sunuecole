<?php

// ============================================================
// 1. /inscriptions/create  (standalone)
// ============================================================
$f = 'resources/views/inscriptions/create.blade.php';
$c = file_get_contents($f);

// Replace zone dropdown static with dynamic
$oldBlock = <<<'OLD'
                                <div id="zone_transport_container" style="display: {{ old('avec_transport') ? 'block' : 'none' }};">
                                    <label class="form-label small mt-2">Choisir la Zone :</label>
                                    <select name="zone_transport_id" class="form-select form-select-sm @error('zone_transport_id') is-invalid @enderror">
                                        <option value="">Sélectionner une zone...</option>
                                        @foreach($zones ?? [] as $zone)
                                            <option value="{{ $zone->id }}" {{ old('zone_transport_id') == $zone->id ? 'selected' : '' }}>{{ $zone->nom }} ({{ number_format($zone->tarif_mensuel, 0, ',', ' ') }} F)</option>
                                        @endforeach
                                    </select>
                                    @error('zone_transport_id') <div class="invalid-feedback">Veuillez sélectionner une zone si le transport est coché.</div> @enderror
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
                                    <select name="vehicule_id" id="vehicule_select" class="form-select form-select-sm">
                                        <option value="">Choisir d'abord une zone...</option>
                                    </select>
                                    <small class="text-muted">Les places disponibles s'affichent en temps réel.</small>
                                </div>
NEW;

$c = str_replace($oldBlock, $newBlock, $c);

// Inject JS before closing </script>
$jsHelper = <<<'JS'

        function toggleZoneSelect() {
            var cb = document.getElementById('avec_transport');
            var container = document.getElementById('zone_transport_container');
            if(cb && container) { container.style.display = cb.checked ? 'block' : 'none'; }
        }

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

// Remove old toggleZoneSelect definition and add new one with vehicule loader
$c = preg_replace('/function toggleZoneSelect\(\)\s*\{[^}]+\}/s', '', $c);
$c = str_replace("        function updateTarifsDisplay() {", $jsHelper . "\n        function updateTarifsDisplay() {", $c);

file_put_contents($f, $c);
echo "inscriptions/create OK\n";
