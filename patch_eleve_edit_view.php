<?php
$f = 'resources/views/eleves/edit.blade.php';
$c = file_get_contents($f);

$transportBlockOld = <<<EOT
                            <div class="col-md-6">
                                <div class="p-3 border rounded-3 bg-light">
                                    <div class="form-check form-switch">
                                        <input class="form-check-input" type="checkbox" role="switch" name="avec_transport" id="edit_avec_transport" value="1" 
                                            {{ old('avec_transport', \$eleve->inscriptionActuelle?->avec_transport) ? 'checked' : '' }}>
                                        <label class="form-check-label fw-bold" for="edit_avec_transport">
                                            <i class='bx bx-bus text-info me-1'></i> Transport Scolaire
                                        </label>
                                    </div>
                                    <div class="small text-muted mt-1">Élève abonné aux circuits de transport scolaire.</div>
                                </div>
                            </div>
EOT;

$transportBlockNew = <<<EOT
                            <div class="col-md-6">
                                <div class="p-3 border rounded-3 bg-light">
                                    <div class="form-check form-switch">
                                        <input class="form-check-input" type="checkbox" role="switch" name="avec_transport" id="edit_avec_transport" value="1" 
                                            {{ old('avec_transport', \$eleve->inscriptionActuelle?->avec_transport) ? 'checked' : '' }} onchange="toggleZoneSelect()">
                                        <label class="form-check-label fw-bold" for="edit_avec_transport">
                                            <i class='bx bx-bus text-info me-1'></i> Transport Scolaire
                                        </label>
                                    </div>
                                    <div id="zone_transport_container" style="display: {{ old('avec_transport', \$eleve->inscriptionActuelle?->avec_transport) ? 'block' : 'none' }};">
                                        <label class="form-label small mt-2">Choisir la Zone :</label>
                                        <select name="zone_transport_id" class="form-select form-select-sm">
                                            <option value="">Sélectionner une zone...</option>
                                            @foreach(\$zones ?? [] as \$zone)
                                                <option value="{{ \$zone->id }}" {{ old('zone_transport_id', \$abonnementTransport?->zone_transport_id) == \$zone->id ? 'selected' : '' }}>{{ \$zone->nom }} ({{ number_format(\$zone->tarif_mensuel, 0, ',', ' ') }} F)</option>
                                            @endforeach
                                        </select>
                                    </div>
                                </div>
                            </div>
EOT;

$c = str_replace($transportBlockOld, $transportBlockNew, $c);

// Add JS
$jsOld = <<<EOT
document.addEventListener('DOMContentLoaded', function() {
EOT;

$jsNew = <<<EOT
function toggleZoneSelect() {
    const cb = document.getElementById('edit_avec_transport');
    const container = document.getElementById('zone_transport_container');
    if(cb && container) {
        container.style.display = cb.checked ? 'block' : 'none';
    }
}

document.addEventListener('DOMContentLoaded', function() {
    toggleZoneSelect();
EOT;

$c = str_replace($jsOld, $jsNew, $c);
file_put_contents($f, $c);
