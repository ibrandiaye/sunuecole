<?php
$f = 'resources/views/classes/index.blade.php';
$c = file_get_contents($f);

$transportBlockOld = <<<EOT
                        <div class="col-12">
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" role="switch" name="avec_transport" id="modal_avec_transport" value="1">
                                <label class="form-check-label fw-semibold" for="modal_avec_transport">
                                    <i class='bx bx-bus text-info me-1'></i> Transport Scolaire
                                    <span id="modal_transport_tarif" class="badge bg-info-subtle text-dark border ms-1 d-none"></span>
                                </label>
                            </div>
                        </div>
EOT;

$transportBlockNew = <<<EOT
                        <div class="col-12">
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" role="switch" name="avec_transport" id="modal_avec_transport" value="1" onchange="toggleModalZoneSelect()">
                                <label class="form-check-label fw-semibold" for="modal_avec_transport">
                                    <i class='bx bx-bus text-info me-1'></i> Transport Scolaire
                                    <span id="modal_transport_tarif" class="badge bg-info-subtle text-dark border ms-1 d-none"></span>
                                </label>
                            </div>
                            <div id="modal_zone_transport_container" style="display: none;">
                                <label class="form-label small mt-2">Choisir la Zone :</label>
                                <select name="zone_transport_id" class="form-select form-select-sm">
                                    <option value="">Sélectionner une zone...</option>
                                    @foreach(\$zones ?? [] as \$zone)
                                        <option value="{{ \$zone->id }}">{{ \$zone->nom }} ({{ number_format(\$zone->tarif_mensuel, 0, ',', ' ') }} F)</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>
EOT;

$c = str_replace($transportBlockOld, $transportBlockNew, $c);

$jsOld = <<<EOT
<script>
document.addEventListener('DOMContentLoaded', function() {
EOT;

$jsNew = <<<EOT
<script>
function toggleModalZoneSelect() {
    const cb = document.getElementById('modal_avec_transport');
    const container = document.getElementById('modal_zone_transport_container');
    if(cb && container) {
        container.style.display = cb.checked ? 'block' : 'none';
    }
}

document.addEventListener('DOMContentLoaded', function() {
EOT;

$c = str_replace($jsOld, $jsNew, $c);

file_put_contents($f, $c);
