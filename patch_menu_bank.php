<?php
$f = 'resources/views/layouts/app.blade.php';
$c = file_get_contents($f);
$menu = <<<EOT
                <a href="{{ route('paiements.suivi') }}" class="nav-link {{ request()->routeIs('paiements.suivi') ? 'active' : '' }}"><i class='bx bx-search-alt'></i> Suivi Mensualités</a>
                <a href="{{ route('compte_bancaires.index') }}" class="nav-link {{ request()->routeIs('compte_bancaires.*') ? 'active' : '' }}"><i class='bx bxs-bank'></i> Trésorerie & Banque</a>
EOT;
$c = str_replace("<a href=\"{{ route('paiements.suivi') }}\" class=\"nav-link {{ request()->routeIs('paiements.suivi') ? 'active' : '' }}\"><i class='bx bx-search-alt'></i> Suivi MensualitǸs</a>", $menu, $c);
$c = str_replace("<a href=\"{{ route('paiements.suivi') }}\" class=\"nav-link {{ request()->routeIs('paiements.suivi') ? 'active' : '' }}\"><i class='bx bx-search-alt'></i> Suivi Mensualités</a>", $menu, $c);
file_put_contents($f, $c);
