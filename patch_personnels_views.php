<?php
$dir = 'resources/views/personnels/';
$files = glob($dir . '*.blade.php');
foreach ($files as $f) {
    $c = file_get_contents($f);
    
    // Replace terms
    $c = str_replace('Enseignant', 'Personnel', $c);
    $c = str_replace('enseignant', 'personnel', $c);
    $c = str_replace('ENSEIGNANT', 'PERSONNEL', $c);
    $c = str_replace('Spécialité', 'Fonction', $c);
    $c = str_replace('specialite', 'fonction', $c);
    
    // In Personnel we don't have 'statut' (permanent/vacataire), 'matieres', 'classes'
    // Let's remove the "Classes & Matières" tab from the show view
    if (basename($f) == 'show.blade.php') {
        $c = preg_replace('/<li class="nav-item" role="presentation">\s*<button class="nav-link rounded-pill px-4" id="pills-classes-tab".*?<\/li>/s', '', $c);
        $c = preg_replace('/<!-- Classes Tab -->.*?<!-- End Classes Tab -->/s', '', $c);
        // also remove matieres from pills-classes content completely
        $c = preg_replace('/<div class="tab-pane fade" id="pills-classes" role="tabpanel">.*?<\/div>\s*<\/div>\s*<\/div>\s*<!-- Documents -->/s', '<!-- Documents -->', $c);
    }
    
    if (basename($f) == 'create.blade.php' || basename($f) == 'edit.blade.php') {
        // Remove 'matieres' field
        $c = preg_replace('/<div class="mb-4">.*?<select name="matieres\[\].*?<\/div>.*?<\/div>/s', '', $c);
        // Replace 'Statut' block with 'Créer compte utilisateur ?' (in create only)
    }

    file_put_contents($f, $c);
}
