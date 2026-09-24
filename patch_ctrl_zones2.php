<?php
$f = 'app/Http/Controllers/Web/EleveController.php';
$c = file_get_contents($f);

$c = preg_replace(
    "/public function edit\(Eleve \\\$eleve\)\s*\{\s*\\\$eleve->load\('inscriptionActuelle'\);\s*\\\$classes = Classe::visible\(\)->where\('active', true\)->with\('niveau'\)->orderBy\('nom'\)->get\(\);\s*\\\$parents = \\\App\\\Models\\\ParentEleve::with\('user'\)->get\(\);\s*return view\('eleves.edit', compact\('eleve', 'classes', 'parents'\)\);\s*\}/s",
    "public function edit(Eleve \$eleve)\n    {\n        \$eleve->load('inscriptionActuelle');\n        \$classes = Classe::visible()->where('active', true)->with('niveau')->orderBy('nom')->get();\n        \$parents = \App\Models\ParentEleve::with('user')->get();\n        \$zones = \App\Models\ZoneTransport::all();\n        \$abonnementCantine = \App\Models\AbonnementCantine::where('eleve_id', \$eleve->id)->where('actif', true)->first();\n        \$abonnementTransport = \App\Models\AbonnementTransport::where('eleve_id', \$eleve->id)->where('actif', true)->first();\n        return view('eleves.edit', compact('eleve', 'classes', 'parents', 'zones', 'abonnementCantine', 'abonnementTransport'));\n    }",
    $c
);

file_put_contents($f, $c);
