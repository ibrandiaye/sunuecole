<?php
$f = 'routes/web.php';
$c = file_get_contents($f);
$c = str_replace(
    "Route::get('rapport-financier', [\App\Http\Controllers\Web\RapportController::class, 'financier'])->name('rapports.financier');",
    "Route::get('rapport-synthese', [\App\Http\Controllers\Web\RapportController::class, 'synthese'])->name('rapports.synthese');\n        Route::get('rapport-financier', [\App\Http\Controllers\Web\RapportController::class, 'financier'])->name('rapports.financier');",
    $c
);
file_put_contents($f, $c);

$f2 = 'resources/views/layouts/app.blade.php';
$c2 = file_get_contents($f2);
$menu = <<<EOT
            {{-- === MODULE RAPPORTS === --}}
            @hasanyrole(['super_admin', 'directeur'])
                <div class="nav-section-label mt-3 mb-1 px-3" style="font-size:0.7rem;text-transform:uppercase;letter-spacing:.08em;color:rgba(255,255,255,.45);font-weight:600;">Tableaux de bord</div>
                <a href="{{ route('rapports.synthese') }}" class="nav-link {{ request()->routeIs('rapports.synthese') ? 'active' : '' }}"><i class='bx bx-pie-chart-alt-2'></i> Synthèse Globale</a>
                <a href="{{ route('rapports.financier') }}" class="nav-link {{ request()->routeIs('rapports.financier') ? 'active' : '' }}"><i class='bx bx-line-chart'></i> Rapports Financiers</a>
            @endhasanyrole
EOT;
$c2 = str_replace("{{-- === FIN MENU === --}}", $menu . "\n\n            {{-- === FIN MENU === --}}", $c2);
file_put_contents($f2, $c2);
