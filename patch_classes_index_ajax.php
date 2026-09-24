<?php
// ============================================================
// 4. classes/index.blade.php (modal)
// ============================================================
$f = 'resources/views/classes/index.blade.php';
$c = file_get_contents($f);

$oldBlock = <<<'OLD'
                            <div id="modal_zone_transport_container" style="display: none;">
                                <label class="form-label small mt-2">Choisir la Zone :</label>
                                <select name="zone_transport_id" class="form-select form-select-sm">
                                    <option value="">Sélectionner une zone...</option>
                                    @foreach($zones ?? [] as $zone)
                                        <option value="{{ $zone->id }}">{{ $zone->nom }} ({{ number_format($zone->tarif_mensuel, 0, ',', ' ') }} F)</option>
                                    @endforeach
                                </select>
                            </div>
OLD;

$newBlock = <<<'NEW'
                            <div id="modal_zone_transport_container" style="display: none;">
                                <label class="form-label small mt-2">Choisir la Zone :</label>
                                <select name="zone_transport_id" id="modal_zone_select" class="form-select form-select-sm" onchange="loadVehiculesPourZone(this.value, document.getElementById('modal_vehicule_select'))">
                                    <option value="">Sélectionner une zone...</option>
                                    @foreach($zones ?? [] as $zone)
                                        <option value="{{ $zone->id }}">{{ $zone->nom }} ({{ number_format($zone->tarif_mensuel, 0, ',', ' ') }} F)</option>
                                    @endforeach
                                </select>
                                <label class="form-label small mt-2">Véhicule <span class="text-danger">*</span></label>
                                <select name="vehicule_id" id="modal_vehicule_select" class="form-select form-select-sm">
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

// Reset zone + vehicule select when modal opens
$c = str_replace(
    "function toggleModalZoneSelect() {",
    $jsHelper . "\nfunction toggleModalZoneSelect() {",
    $c
);

// Reset vehicule select when modal resets
$c = str_replace(
    "document.getElementById('modal_classe_id').value = classeId;",
    "document.getElementById('modal_classe_id').value = classeId;\n            document.getElementById('modal_zone_select').value = '';\n            document.getElementById('modal_vehicule_select').innerHTML = '<option value=\"\">Choisir d\\'abord une zone...</option>';\n            document.getElementById('modal_zone_transport_container').style.display = 'none';\n            var cb = document.getElementById('modal_avec_transport');\n            if(cb) cb.checked = false;",
    $c
);

file_put_contents($f, $c);
echo "classes/index OK\n";
