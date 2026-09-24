<?php
$f = 'resources/views/inscriptions/create.blade.php';
$c = file_get_contents($f);

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

$c = preg_replace('/function loadVehiculesPourZone.*?\n        \}/s', $jsHelper, $c);

$preload = <<<'PRELOAD'
        document.addEventListener('DOMContentLoaded', function() {
            var zoneSelect = document.getElementById('zone_select');
            var vehiculeSelect = document.getElementById('vehicule_select');
            if(zoneSelect && zoneSelect.value && vehiculeSelect) {
                var oldVehicule = "{{ old('vehicule_id') }}";
                loadVehiculesPourZone(zoneSelect.value, vehiculeSelect, oldVehicule);
            }
            updateTarifsDisplay();
PRELOAD;

$c = str_replace(
    "document.addEventListener('DOMContentLoaded', function() {\n            updateTarifsDisplay();",
    $preload,
    $c
);

file_put_contents($f, $c);
echo "inscriptions/create patched with preload\n";
