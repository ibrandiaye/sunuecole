<?php
$f = 'resources/views/logistique/transport/zones.blade.php';
$c = file_get_contents($f);

// 1. Remove the modal loop from inside the table
$modalPattern = '/<!-- Modal Edit Zone -->.*?<\/form>\s*<\/div>\s*<\/div>\s*<\/div>/s';
// Save the modal content for later, wait, since the modal uses $zone, I can just generate a second loop.
$c = preg_replace($modalPattern, '', $c);

// 2. Append a second loop for the modals just before <!-- Modal Add Zone -->
$modalsLoop = <<<EOT
@foreach(\$zones as \$zone)
<!-- Modal Edit Zone -->
<div class="modal fade" id="editZoneModal{{ \$zone->id }}" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <form action="{{ route('zone_transports.update', \$zone) }}" method="POST">
                @csrf @method('PUT')
                <div class="modal-header border-0 pb-0">
                    <h5 class="modal-title fw-bold">Modifier la Zone</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body py-4 text-start">
                    <div class="mb-3">
                        <label class="form-label">Nom de la Zone</label>
                        <input type="text" name="nom" class="form-control" required value="{{ \$zone->nom }}">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Tarif Mensuel (FCFA)</label>
                        <input type="number" name="tarif_mensuel" class="form-control" required min="0" value="{{ \$zone->tarif_mensuel }}">
                    </div>
                </div>
                <div class="modal-footer border-0 bg-light rounded-bottom-3">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-primary px-4 shadow-sm">Mettre à jour</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endforeach

<!-- Modal Add Zone -->
EOT;

$c = str_replace('<!-- Modal Add Zone -->', $modalsLoop, $c);

file_put_contents($f, $c);
