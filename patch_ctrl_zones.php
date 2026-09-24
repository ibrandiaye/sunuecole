<?php
$f = 'app/Http/Controllers/Web/EleveController.php';
$c = file_get_contents($f);

// Fix create()
$c = preg_replace(
    "/\\\$selected_classe_id = \\\$request->get\('classe_id'\);/s",
    "\$selected_classe_id = \$request->get('classe_id');\n        \$zones = \App\Models\ZoneTransport::all();",
    $c
);
$c = preg_replace(
    "/return view\('eleves\.create', compact\('parents', 'classes', 'selected_classe_id'\)\);/s",
    "return view('eleves.create', compact('parents', 'classes', 'selected_classe_id', 'zones'));",
    $c
);

// Fix edit()
$c = preg_replace(
    "/\\\$classes = Classe::visible\(\)->where\('active', true\)->with\('niveau'\)->orderBy\('nom'\)->get\(\);/s",
    "\$classes = Classe::visible()->where('active', true)->with('niveau')->orderBy('nom')->get();\n        \$zones = \App\Models\ZoneTransport::all();\n        \$abonnementCantine = \App\Models\AbonnementCantine::where('eleve_id', \$eleve->id)->where('actif', true)->first();\n        \$abonnementTransport = \App\Models\AbonnementTransport::where('eleve_id', \$eleve->id)->where('actif', true)->first();",
    $c,
    1 // only for edit, actually I'll just use replace_file_content for edit if needed.
);
file_put_contents($f, $c);
