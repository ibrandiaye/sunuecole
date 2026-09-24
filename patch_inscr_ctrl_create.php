<?php
$f = 'app/Http/Controllers/Web/InscriptionController.php';
$c = file_get_contents($f);
$c = str_replace(
    "\$classes = Classe::with('niveau')->get();",
    "\$classes = Classe::with('niveau')->get();\n        \$zones = \App\Models\ZoneTransport::all();",
    $c
);
$c = str_replace(
    "return view('inscriptions.create', compact('eleves', 'classes', 'anneeActive', 'selected_eleve_id', 'selected_classe_id'));",
    "return view('inscriptions.create', compact('eleves', 'classes', 'anneeActive', 'selected_eleve_id', 'selected_classe_id', 'zones'));",
    $c
);
file_put_contents($f, $c);
