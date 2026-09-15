<?php
$f='app/Services/NotificationService.php';
$c=file_get_contents($f);
if(substr($c,0,3)==="\xEF\xBB\xBF") {
    file_put_contents($f, substr($c,3));
}
