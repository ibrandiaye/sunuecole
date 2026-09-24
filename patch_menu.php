<?php
$f = 'resources/views/layouts/app.blade.php';
$c = file_get_contents($f);

$oldMenu = <<<EOT
            {{-- === MODULE ADMINISTRATIF === --}}
            @hasanyrole(['super_admin', 'directeur', 'administratif'])
                <a href="{{ route('eleves.index') }}" class="nav-link {{ request()->routeIs('eleves.*') ? 'active' : '' }}"><i class='bx bxs-user-badge'></i> Élèves</a>
                <a href="{{ route('tuteurs.index') }}" class="nav-link {{ request()->routeIs('tuteurs.*') ? 'active' : '' }}"><i class='bx bxs-user-account'></i> Tuteurs</a>
                <a href="{{ route('inscriptions.index') }}" class="nav-link {{ request()->routeIs('inscriptions.*') ? 'active' : '' }}"><i class='bx bx-history'></i> Inscriptions</a>
                <a href="{{ route('classes.index') }}" class="nav-link {{ request()->routeIs('classes.*') ? 'active' : '' }}"><i class='bx bxs-school'></i> Classes</a>
                <a href="{{ route('enseignants.index') }}" class="nav-link {{ request()->routeIs('enseignants.*') ? 'active' : '' }}"><i class='bx bxs-group'></i> Enseignants</a>
                <a href="{{ route('matieres.index') }}" class="nav-link {{ request()->routeIs('matieres.*') ? 'active' : '' }}"><i class='bx bxs-book'></i> Matières</a>
                <a href="{{ route('emplois.index') }}" class="nav-link {{ request()->routeIs('emplois.*') ? 'active' : '' }}"><i class='bx bxs-calendar'></i> Emploi du Temps</a>
                <a href="{{ route('notes.index') }}" class="nav-link {{ request()->routeIs('notes.*') ? 'active' : '' }}"><i class='bx bxs-edit'></i> Notes</a>
                <a href="{{ route('bulletins.index') }}" class="nav-link {{ request()->routeIs('bulletins.*') ? 'active' : '' }}"><i class='bx bxs-file-pdf'></i> Bulletins</a>
                <a href="{{ route('absences.index') }}" class="nav-link {{ request()->routeIs('absences.*') ? 'active' : '' }}"><i class='bx bxs-time-five'></i> Absences</a>
                <a href="{{ route('convocations.index') }}" class="nav-link {{ request()->routeIs('convocations.*') ? 'active' : '' }}"><i class='bx bxs-error-circle'></i> Convocations</a>
                <a href="{{ route('notifications.index') }}" class="nav-link {{ request()->routeIs('notifications.*') ? 'active' : '' }}"><i class='bx bxs-bell-ring'></i> Notifications</a>
            @endhasanyrole

            {{-- Vue élèves/classes/inscriptions/tuteurs pour comptable (lecture seule) --}}
            @role('comptable')
                <a href="{{ route('eleves.index') }}" class="nav-link {{ request()->routeIs('eleves.*') ? 'active' : '' }}"><i class='bx bxs-user-badge'></i> Élèves</a>
                <a href="{{ route('tuteurs.index') }}" class="nav-link {{ request()->routeIs('tuteurs.*') ? 'active' : '' }}"><i class='bx bxs-user-account'></i> Tuteurs</a>
            @endrole
EOT;

$newMenu = <<<EOT
            {{-- === SCOLARITÉ & INSCRIPTIONS === --}}
            @hasanyrole(['super_admin', 'directeur', 'administratif', 'secretaire', 'comptable'])
                <div class="nav-section-label mt-3 mb-1 px-3" style="font-size:0.7rem;text-transform:uppercase;letter-spacing:.08em;color:rgba(255,255,255,.45);font-weight:600;">Scolarité</div>
                <a href="{{ route('eleves.index') }}" class="nav-link {{ request()->routeIs('eleves.*') ? 'active' : '' }}"><i class='bx bxs-user-badge'></i> Élèves</a>
                <a href="{{ route('tuteurs.index') }}" class="nav-link {{ request()->routeIs('tuteurs.*') ? 'active' : '' }}"><i class='bx bxs-user-account'></i> Tuteurs</a>
            @endhasanyrole
            
            @hasanyrole(['super_admin', 'directeur', 'administratif', 'secretaire'])
                <a href="{{ route('inscriptions.index') }}" class="nav-link {{ request()->routeIs('inscriptions.*') ? 'active' : '' }}"><i class='bx bx-history'></i> Inscriptions</a>
                <a href="{{ route('classes.index') }}" class="nav-link {{ request()->routeIs('classes.*') ? 'active' : '' }}"><i class='bx bxs-school'></i> Classes</a>
            @endhasanyrole

            {{-- === PÉDAGOGIE === --}}
            @hasanyrole(['super_admin', 'directeur', 'administratif', 'secretaire'])
                <div class="nav-section-label mt-3 mb-1 px-3" style="font-size:0.7rem;text-transform:uppercase;letter-spacing:.08em;color:rgba(255,255,255,.45);font-weight:600;">Pédagogie</div>
                <a href="{{ route('matieres.index') }}" class="nav-link {{ request()->routeIs('matieres.*') ? 'active' : '' }}"><i class='bx bxs-book'></i> Matières</a>
                <a href="{{ route('emplois.index') }}" class="nav-link {{ request()->routeIs('emplois.*') ? 'active' : '' }}"><i class='bx bxs-calendar'></i> Emploi du Temps</a>
                <a href="{{ route('notes.index') }}" class="nav-link {{ request()->routeIs('notes.*') ? 'active' : '' }}"><i class='bx bxs-edit'></i> Notes</a>
                <a href="{{ route('bulletins.index') }}" class="nav-link {{ request()->routeIs('bulletins.*') ? 'active' : '' }}"><i class='bx bxs-file-pdf'></i> Bulletins</a>
                <a href="{{ route('absences.index') }}" class="nav-link {{ request()->routeIs('absences.*') ? 'active' : '' }}"><i class='bx bxs-time-five'></i> Absences</a>
                <a href="{{ route('convocations.index') }}" class="nav-link {{ request()->routeIs('convocations.*') ? 'active' : '' }}"><i class='bx bxs-error-circle'></i> Convocations</a>
                <a href="{{ route('notifications.index') }}" class="nav-link {{ request()->routeIs('notifications.*') ? 'active' : '' }}"><i class='bx bxs-bell-ring'></i> Notifications</a>
            @endhasanyrole

            {{-- === RESSOURCES HUMAINES === --}}
            @hasanyrole(['super_admin', 'directeur', 'administratif', 'rh'])
                <div class="nav-section-label mt-3 mb-1 px-3" style="font-size:0.7rem;text-transform:uppercase;letter-spacing:.08em;color:rgba(255,255,255,.45);font-weight:600;">Ressources Humaines</div>
                <a href="{{ route('enseignants.index') }}" class="nav-link {{ request()->routeIs('enseignants.*') ? 'active' : '' }}"><i class='bx bxs-group'></i> Enseignants</a>
            @endhasanyrole
EOT;

// Replacing the utf-8 variants carefully since there are Ã© in the original file
$c = preg_replace('/\{\{-- === MODULE ADMINISTRATIF === --\}\}.*?@endrole/s', $newMenu, $c);
file_put_contents($f, $c);
