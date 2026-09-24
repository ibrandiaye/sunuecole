<?php
$files = [
    'resources/views/inscriptions/create.blade.php',
    'resources/views/eleves/create.blade.php',
    'resources/views/eleves/edit.blade.php',
    'resources/views/classes/index.blade.php'
];

foreach ($files as $f) {
    $c = file_get_contents($f);
    $c = str_replace("fetch('/vehicules-par-zone/' + zoneId)", "fetch('{{ url('vehicules-par-zone') }}/' + zoneId)", $c);
    file_put_contents($f, $c);
}
echo "fetch urls updated\n";
