<?php
$f = 'resources/views/layouts/app.blade.php';
$c = file_get_contents($f);

$menu = <<<EOT
            {{-- === LOGISTIQUE === --}}
            @hasanyrole(['super_admin', 'directeur', 'logistique'])
                <div class="nav-section-label mt-3 mb-1 px-3" style="font-size:0.7rem;text-transform:uppercase;letter-spacing:.08em;color:rgba(255,255,255,.45);font-weight:600;">Logistique</div>
                <a href="{{ route('abonnement_cantines.index') }}" class="nav-link {{ request()->routeIs('abonnement_cantines.*') ? 'active' : '' }}"><i class='bx bx-restaurant'></i> Cantine</a>
                <a href="{{ route('abonnement_transports.index') }}" class="nav-link {{ request()->routeIs('abonnement_transports.*') ? 'active' : '' }}"><i class='bx bx-bus'></i> Transport Scolaire</a>
            @endhasanyrole

            {{-- === MODULE FINANCIER === --}}
EOT;

$c = str_replace('{{-- === MODULE FINANCIER === --}}', $menu, $c);
file_put_contents($f, $c);
