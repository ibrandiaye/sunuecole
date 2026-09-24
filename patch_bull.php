<?php
$files = [
    'resources/views/classes/index.blade.php',
    'resources/views/eleves/create.blade.php',
    'resources/views/eleves/edit.blade.php',
    'resources/views/inscriptions/create.blade.php',
    'resources/views/professeur/notes_saisie.blade.php'
];
foreach($files as $f) {
    if (file_exists($f)) {
        $c = file_get_contents($f);
        $c = str_replace('&bull;', '•', $c);
        file_put_contents($f, $c);
    }
}
