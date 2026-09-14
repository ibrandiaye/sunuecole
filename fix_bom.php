<?php
$files = ['app/Http/Controllers/Web/NotificationController.php', 'app/Services/NotificationService.php'];
foreach($files as $file) {
    if (!file_exists($file)) continue;
    $content = file_get_contents($file);
    // Remove BOM if present
    if (substr($content, 0, 3) === "\xEF\xBB\xBF") {
        $content = substr($content, 3);
    }
    // Also remove any leading whitespace/newlines just in case
    $content = ltrim($content);
    file_put_contents($file, "<?php\n" . preg_replace('/^<\?php\s*/i', '', $content));
}
echo "Fixed files!";
