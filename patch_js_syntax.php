<?php
$f = 'resources/views/inscriptions/create.blade.php';
$c = file_get_contents($f);

$c = preg_replace('/<script>\s*\}\s*function toggleZoneSelect\(\)/s', "<script>\n        function toggleZoneSelect()", $c);

file_put_contents($f, $c);
echo "fixed js syntax\n";
