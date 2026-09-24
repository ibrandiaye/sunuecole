<?php
$f = 'app/Http/Controllers/Web/InscriptionController.php';
$c = file_get_contents($f);

$c = preg_replace(
    "/\\\$classes = Classe::visible\(\)->where\('active', true\)->with\('niveau'\)->orderBy\('nom'\)->get\(\);\s*\\\$annees = AnneeScolaire::all\(\);\s*return view\('inscriptions.create', compact\('eleves', 'classes', 'annees', 'selected_eleve', 'selected_classe_id', 'anneeActive'\)\);/s",
    "\$classes = Classe::visible()->where('active', true)->with('niveau')->orderBy('nom')->get();\n        \$annees = AnneeScolaire::all();\n        \$zones = \App\Models\ZoneTransport::all();\n\n        return view('inscriptions.create', compact('eleves', 'classes', 'annees', 'selected_eleve', 'selected_classe_id', 'anneeActive', 'zones'));",
    $c
);

file_put_contents($f, $c);
