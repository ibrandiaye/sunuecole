<?php
$f = 'app/Http/Controllers/Web/EleveController.php';
$c = file_get_contents($f);

$c = preg_replace(
    "/public function create.*?return view\('eleves\.create'/s",
    "public function create(Request \$request)\n    {\n        \$parents = \App\Models\ParentEleve::with('user')->get();\n        \$classes = Classe::visible()->where('active', true)->with('niveau')->orderBy('nom')->get();\n        \$selected_classe_id = \$request->get('classe_id');\n        \$zones = \App\Models\ZoneTransport::all();\n        return view('eleves.create'",
    $c
);
file_put_contents($f, $c);
