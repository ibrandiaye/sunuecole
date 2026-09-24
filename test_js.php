<?php
// Shared JS snippet to inject in all 3 inscription forms
$zoneSelectJs = <<<'JSEOF'
function toggleZoneSelect(cbId, containerId) {
    var cb = document.getElementById(cbId);
    var container = document.getElementById(containerId);
    if(cb && container) { container.style.display = cb.checked ? 'block' : 'none'; }
}

function loadVehiculesPourZone(zoneId, selectEl) {
    if(!zoneId) {
        selectEl.innerHTML = '<option value="">Choisir d\'abord une zone...</option>';
        return;
    }
    selectEl.innerHTML = '<option>Chargement...</option>';
    fetch('/vehicules-par-zone/' + zoneId)
        .then(r => r.json())
        .then(function(data) {
            if(data.length === 0) {
                selectEl.innerHTML = '<option value="">Aucun véhicule pour cette zone</option>';
                return;
            }
            var opts = '<option value="">-- Sélectionner un véhicule --</option>';
            data.forEach(function(v) {
                var disabled = v.complet ? 'disabled' : '';
                var badge = v.complet ? ' 🚫 COMPLET' : ' (' + v.places_dispo + ' place(s) dispo)';
                opts += '<option value="' + v.id + '" ' + disabled + '>' + v.label + badge + '</option>';
            });
            selectEl.innerHTML = opts;
        })
        .catch(function() {
            selectEl.innerHTML = '<option value="">Erreur de chargement</option>';
        });
}
JSEOF;

echo $zoneSelectJs;
