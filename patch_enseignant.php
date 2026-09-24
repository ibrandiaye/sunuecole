<?php
$f = 'app/Http/Controllers/Web/EnseignantController.php';
$c = file_get_contents($f);
$c = str_replace("\$enseignant->load(['user', 'classes', 'matieres']);", "\$enseignant->load(['user', 'classes', 'matieres', 'documents']);", $c);
file_put_contents($f, $c);
