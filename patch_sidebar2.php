<?php
$f = 'resources/views/layouts/app.blade.php';
$c = file_get_contents($f);

$search = <<<EOT
            @endhasanyrole

            {{-- Comptable : lien direct vers Niveaux & Tarifs --}}
EOT;

$menu = <<<EOT
            @endhasanyrole

            {{-- === MODULE RAPPORTS === --}}
            @hasanyrole(['super_admin', 'directeur'])
                <div class="nav-section-label mt-3 mb-1 px-3" style="font-size:0.7rem;text-transform:uppercase;letter-spacing:.08em;color:rgba(255,255,255,.45);font-weight:600;">Tableaux de bord</div>
                <a href="{{ route('rapports.synthese') }}" class="nav-link {{ request()->routeIs('rapports.synthese') ? 'active' : '' }}"><i class='bx bx-pie-chart-alt-2'></i> Synthèse Globale</a>
                <a href="{{ route('rapports.financier') }}" class="nav-link {{ request()->routeIs('rapports.financier') ? 'active' : '' }}"><i class='bx bx-line-chart'></i> Rapports Financiers</a>
            @endhasanyrole

            {{-- Comptable : lien direct vers Niveaux & Tarifs --}}
EOT;

$c = str_replace($search, $menu, $c);
file_put_contents($f, $c);
