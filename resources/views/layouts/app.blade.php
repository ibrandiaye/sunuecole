<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>@yield('title', 'Dashboard') | SunuEcole Digital</title>
    
    <!-- Google Fonts: Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Boxicons for icons -->
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    
    <!-- DataTables Bootstrap 5 CSS & Buttons -->
    <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.bootstrap5.min.css" rel="stylesheet">

    <!-- Select2 CSS & Bootstrap 5 Theme -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/select2-bootstrap-5-theme@1.3.0/dist/select2-bootstrap-5-theme.min.css" rel="stylesheet" />

    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --success-color: #4cc9f0;
            --bg-color: #f8f9fa;
            --sidebar-width: 260px;
            --card-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
        }

        /* Personnalisation Select2 avec Bootstrap 5 */
        .select2-container--bootstrap-5 .select2-selection {
            border-radius: 0.5rem;
            font-size: 0.95rem;
            min-height: calc(2.45rem + 2px);
            padding: 0.35rem 0.75rem;
            border-color: #dee2e6;
            transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
        }
        .select2-container--bootstrap-5.select2-container--focus .select2-selection,
        .select2-container--bootstrap-5.select2-container--open .select2-selection {
            border-color: var(--primary-color) !important;
            box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.15) !important;
        }
        .select2-dropdown {
            border-radius: 0.5rem !important;
            border-color: #dee2e6 !important;
            box-shadow: 0 10px 30px rgba(0,0,0,0.12) !important;
            font-size: 0.95rem;
            z-index: 99999 !important;
        }
        .select2-container--bootstrap-5 .select2-dropdown .select2-results__option--highlighted[aria-selected] {
            background-color: var(--primary-color) !important;
            color: #ffffff !important;
        }
        .select2-search--dropdown .select2-search__field {
            border-radius: 0.375rem;
            padding: 0.45rem 0.75rem;
            border: 1px solid #dee2e6;
        }
        .select2-search--dropdown .select2-search__field:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 0.2rem rgba(67, 97, 238, 0.15);
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-color);
            color: #2b2d42;
            overflow-x: hidden;
        }

        .sidebar {
            width: var(--sidebar-width);
            height: 100vh;
            position: fixed;
            background: #ffffff;
            border-right: 1px solid rgba(0,0,0,0.05);
            padding: 20px;
            transition: all 0.3s ease;
            z-index: 1000;
            overflow-y: auto;
        }

        /* Personnalisation de la barre de défilement du menu */
        .sidebar::-webkit-scrollbar {
            width: 6px;
        }
        .sidebar::-webkit-scrollbar-track {
            background: transparent;
        }
        .sidebar::-webkit-scrollbar-thumb {
            background: rgba(0,0,0,0.1);
            border-radius: 10px;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 40px;
            padding: 0 10px;
        }

        .brand-logo {
            width: 40px;
            height: 40px;
            background: var(--primary-color);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
        }

        .brand-name {
            font-weight: 700;
            font-size: 20px;
            color: var(--primary-color);
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 10px 14px;
            color: #495057;
            border-radius: 10px;
            transition: all 0.2s ease;
            margin-bottom: 4px;
            font-weight: 600;
            font-size: 0.88rem;
        }

        .nav-link:hover, .nav-link.active {
            background: rgba(67, 97, 238, 0.1);
            color: var(--primary-color);
        }

        .nav-link i {
            font-size: 20px;
        }

        /* Collapsible Menu Categories */
        .nav-category {
            margin-bottom: 4px;
        }

        .nav-category-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 9px 12px;
            color: #495057;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 600;
            font-size: 0.87rem;
            transition: all 0.2s ease;
            text-decoration: none;
            user-select: none;
        }

        .nav-category-header:hover {
            background: rgba(67, 97, 238, 0.08);
            color: var(--primary-color);
        }

        .nav-category-header.active-group {
            color: var(--primary-color);
            background: rgba(67, 97, 238, 0.07);
        }

        .nav-category-header .category-icon {
            font-size: 1.15rem;
            min-width: 22px;
            color: inherit;
        }

        .nav-category-header .category-title {
            flex-grow: 1;
            margin-left: 8px;
        }

        .nav-category-header .chevron-icon {
            font-size: 1.05rem;
            transition: transform 0.25s ease;
            color: #adb5bd;
        }

        .nav-category-header[aria-expanded="true"] .chevron-icon {
            transform: rotate(180deg);
            color: var(--primary-color);
        }

        .nav-sub-menu {
            list-style: none;
            padding: 3px 0 5px 12px;
            margin: 0 0 4px 14px;
            border-left: 2px solid rgba(67, 97, 238, 0.15);
        }

        .nav-sub-item {
            margin-bottom: 2px;
        }

        .nav-sub-link {
            display: flex;
            align-items: center;
            padding: 6px 10px;
            color: #6c757d;
            font-size: 0.83rem;
            border-radius: 8px;
            text-decoration: none;
            transition: all 0.15s ease;
            font-weight: 500;
        }

        .nav-sub-link:hover {
            color: var(--primary-color);
            background: rgba(67, 97, 238, 0.06);
            transform: translateX(2px);
        }

        .nav-sub-link.active {
            color: var(--primary-color);
            background: rgba(67, 97, 238, 0.12);
            font-weight: 600;
        }

        .nav-sub-link i {
            font-size: 0.95rem;
            margin-right: 8px;
            opacity: 0.85;
        }

        /* Main Content */
        .main-content {
            margin-left: var(--sidebar-width);
            padding: 30px;
            transition: all 0.3s ease;
        }

        /* Card Styles */
        .card {
            border: none;
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .btn-primary {
            background: var(--primary-color);
            border: none;
            border-radius: 12px;
            padding: 10px 25px;
            font-weight: 600;
            box-shadow: 0 4px 15px rgba(67, 97, 238, 0.3);
        }
        .nav-pills .nav-link.active
        {
            color: #005c37 !important;
        }

        .btn-primary:hover {
            background: var(--secondary-color);
            transform: scale(1.02);
        }

        /* Topbar */
        .top-navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 12px;
            background: white;
            padding: 8px 15px;
            border-radius: 15px;
            box-shadow: var(--card-shadow);
        }

        .user-avatar {
            width: 35px;
            height: 35px;
            border-radius: 10px;
            background: #e9ecef;
        }
        
        .nav-pills {
            --bs-nav-pills-link-active-color: #0d6efd !important;
        }   
  
    </style>
    @yield('styles')
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <div class="brand">
            <div class="brand-logo"><i class='bx bxs-graduation'></i></div>
            <span class="brand-name">SunuEcole</span>
        </div>

        <nav class="nav flex-column" id="sidebarMenu">
            {{-- Dashboard principal --}}
            <a href="{{ route('dashboard') }}" class="nav-link {{ request()->routeIs('dashboard') ? 'active' : '' }}">
                <i class='bx bxs-dashboard'></i> <span>Dashboard</span>
            </a>

            {{-- 1. ANALYSES & RAPPORTS --}}
            @hasanyrole(['super_admin', 'directeur'])
                @php
                    $isRapportsActive = request()->routeIs('rapports.*');
                @endphp
                <div class="nav-category">
                    <div class="nav-category-header {{ $isRapportsActive ? 'active-group' : '' }}" 
                         data-bs-toggle="collapse" 
                         data-bs-target="#menuRapports" 
                         aria-expanded="{{ $isRapportsActive ? 'true' : 'false' }}">
                        <i class='bx bxs-pie-chart-alt-2 category-icon text-primary'></i>
                        <span class="category-title">Analyses & Rapports</span>
                        <i class='bx bx-chevron-down chevron-icon'></i>
                    </div>
                    <div class="collapse {{ $isRapportsActive ? 'show' : '' }}" id="menuRapports">
                        <ul class="nav-sub-menu">
                            <li class="nav-sub-item">
                                <a href="{{ route('rapports.synthese') }}" class="nav-sub-link {{ request()->routeIs('rapports.synthese') ? 'active' : '' }}">
                                    <i class='bx bx-pie-chart'></i> Synthèse Globale
                                </a>
                            </li>
                            <li class="nav-sub-item">
                                <a href="{{ route('rapports.financier') }}" class="nav-sub-link {{ request()->routeIs('rapports.financier') ? 'active' : '' }}">
                                    <i class='bx bx-line-chart'></i> Rapport Financier
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            @endhasanyrole

            {{-- 2. SCOLARITÉ --}}
            @hasanyrole(['super_admin', 'directeur', 'administratif', 'secretaire', 'comptable'])
                @php
                    $isScolariteActive = request()->routeIs('eleves.*') || request()->routeIs('inscriptions.*') || request()->routeIs('classes.*') || request()->routeIs('tuteurs.*');
                @endphp
                <div class="nav-category">
                    <div class="nav-category-header {{ $isScolariteActive ? 'active-group' : '' }}" 
                         data-bs-toggle="collapse" 
                         data-bs-target="#menuScolarite" 
                         aria-expanded="{{ $isScolariteActive ? 'true' : 'false' }}">
                        <i class='bx bxs-graduation category-icon text-info'></i>
                        <span class="category-title">Scolarité</span>
                        <i class='bx bx-chevron-down chevron-icon'></i>
                    </div>
                    <div class="collapse {{ $isScolariteActive ? 'show' : '' }}" id="menuScolarite">
                        <ul class="nav-sub-menu">
                            @hasanyrole(['super_admin', 'directeur', 'administratif', 'secretaire'])
                                <li class="nav-sub-item">
                                    <a href="{{ route('inscriptions.index') }}" class="nav-sub-link {{ request()->routeIs('inscriptions.*') ? 'active' : '' }}">
                                        <i class='bx bx-history'></i> Inscriptions
                                    </a>
                                </li>
                            @endhasanyrole
                            <li class="nav-sub-item">
                                <a href="{{ route('eleves.index') }}" class="nav-sub-link {{ request()->routeIs('eleves.*') ? 'active' : '' }}">
                                    <i class='bx bxs-user-badge'></i> Élèves
                                </a>
                            </li>
                            @hasanyrole(['super_admin', 'directeur', 'administratif', 'secretaire'])
                                <li class="nav-sub-item">
                                    <a href="{{ route('classes.index') }}" class="nav-sub-link {{ request()->routeIs('classes.*') ? 'active' : '' }}">
                                        <i class='bx bxs-school'></i> Classes
                                    </a>
                                </li>
                            @endhasanyrole
                            <li class="nav-sub-item">
                                <a href="{{ route('tuteurs.index') }}" class="nav-sub-link {{ request()->routeIs('tuteurs.*') ? 'active' : '' }}">
                                    <i class='bx bxs-user-account'></i> Tuteurs
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            @endhasanyrole

            {{-- 3. PÉDAGOGIE --}}
            @hasanyrole(['super_admin', 'directeur', 'administratif', 'secretaire'])
                @php
                    $isPedagogieActive = request()->routeIs('matieres.*') || request()->routeIs('emplois.*') || request()->routeIs('notes.*') || request()->routeIs('bulletins.*') || request()->routeIs('absences.*') || request()->routeIs('convocations.*') || request()->routeIs('notifications.*');
                @endphp
                <div class="nav-category">
                    <div class="nav-category-header {{ $isPedagogieActive ? 'active-group' : '' }}" 
                         data-bs-toggle="collapse" 
                         data-bs-target="#menuPedagogie" 
                         aria-expanded="{{ $isPedagogieActive ? 'true' : 'false' }}">
                        <i class='bx bxs-book-open category-icon text-warning'></i>
                        <span class="category-title">Pédagogie</span>
                        <i class='bx bx-chevron-down chevron-icon'></i>
                    </div>
                    <div class="collapse {{ $isPedagogieActive ? 'show' : '' }}" id="menuPedagogie">
                        <ul class="nav-sub-menu">
                            <li class="nav-sub-item">
                                <a href="{{ route('emplois.index') }}" class="nav-sub-link {{ request()->routeIs('emplois.*') ? 'active' : '' }}">
                                    <i class='bx bxs-calendar'></i> Emploi du Temps
                                </a>
                            </li>
                            <li class="nav-sub-item">
                                <a href="{{ route('notes.index') }}" class="nav-sub-link {{ request()->routeIs('notes.*') ? 'active' : '' }}">
                                    <i class='bx bxs-edit'></i> Notes & Évaluations
                                </a>
                            </li>
                            <li class="nav-sub-item">
                                <a href="{{ route('bulletins.index') }}" class="nav-sub-link {{ request()->routeIs('bulletins.*') ? 'active' : '' }}">
                                    <i class='bx bxs-file-pdf'></i> Bulletins
                                </a>
                            </li>
                            <li class="nav-sub-item">
                                <a href="{{ route('matieres.index') }}" class="nav-sub-link {{ request()->routeIs('matieres.*') ? 'active' : '' }}">
                                    <i class='bx bxs-book'></i> Matières
                                </a>
                            </li>
                            <li class="nav-sub-item">
                                <a href="{{ route('absences.index') }}" class="nav-sub-link {{ request()->routeIs('absences.*') ? 'active' : '' }}">
                                    <i class='bx bxs-time-five'></i> Absences
                                </a>
                            </li>
                            <li class="nav-sub-item">
                                <a href="{{ route('convocations.index') }}" class="nav-sub-link {{ request()->routeIs('convocations.*') ? 'active' : '' }}">
                                    <i class='bx bxs-error-circle'></i> Convocations
                                </a>
                            </li>
                            <li class="nav-sub-item">
                                <a href="{{ route('notifications.index') }}" class="nav-sub-link {{ request()->routeIs('notifications.*') ? 'active' : '' }}">
                                    <i class='bx bxs-bell-ring'></i> Notifications
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            @endhasanyrole

            {{-- 4. FINANCES --}}
            @hasanyrole(['super_admin', 'directeur', 'comptable'])
                @php
                    $isFinanceActive = request()->routeIs('paiements.*') || request()->routeIs('compte_bancaires.*') || request()->routeIs('depenses.*');
                @endphp
                <div class="nav-category">
                    <div class="nav-category-header {{ $isFinanceActive ? 'active-group' : '' }}" 
                         data-bs-toggle="collapse" 
                         data-bs-target="#menuFinance" 
                         aria-expanded="{{ $isFinanceActive ? 'true' : 'false' }}">
                        <i class='bx bxs-wallet category-icon text-success'></i>
                        <span class="category-title">Finances</span>
                        <i class='bx bx-chevron-down chevron-icon'></i>
                    </div>
                    <div class="collapse {{ $isFinanceActive ? 'show' : '' }}" id="menuFinance">
                        <ul class="nav-sub-menu">
                            <li class="nav-sub-item">
                                <a href="{{ route('paiements.index') }}" class="nav-sub-link {{ request()->routeIs('paiements.index') || request()->routeIs('paiements.create') ? 'active' : '' }}">
                                    <i class='bx bx-receipt'></i> Encaissements
                                </a>
                            </li>
                            <li class="nav-sub-item">
                                <a href="{{ route('paiements.suivi') }}" class="nav-sub-link {{ request()->routeIs('paiements.suivi') ? 'active' : '' }}">
                                    <i class='bx bx-search-alt'></i> Suivi Mensualités
                                </a>
                            </li>
                            <li class="nav-sub-item">
                                <a href="{{ route('depenses.index') }}" class="nav-sub-link {{ request()->routeIs('depenses.*') ? 'active' : '' }}">
                                    <i class='bx bx-money-withdraw'></i> Dépenses
                                </a>
                            </li>
                            <li class="nav-sub-item">
                                <a href="{{ route('compte_bancaires.index') }}" class="nav-sub-link {{ request()->routeIs('compte_bancaires.*') ? 'active' : '' }}">
                                    <i class='bx bxs-bank'></i> Trésorerie & Banque
                                </a>
                            </li>
                            @role('comptable')
                                <li class="nav-sub-item">
                                    <a href="{{ route('rapports.financier') }}" class="nav-sub-link {{ request()->routeIs('rapports.financier') ? 'active' : '' }}">
                                        <i class='bx bxs-pie-chart-alt-2'></i> Rapport Financier
                                    </a>
                                </li>
                            @endrole
                        </ul>
                    </div>
                </div>
            @endhasanyrole

            {{-- 5. RESSOURCES HUMAINES --}}
            @hasanyrole(['super_admin', 'directeur', 'administratif', 'rh'])
                @php
                    $isRhActive = request()->routeIs('enseignants.*') || request()->routeIs('personnels.*');
                @endphp
                <div class="nav-category">
                    <div class="nav-category-header {{ $isRhActive ? 'active-group' : '' }}" 
                         data-bs-toggle="collapse" 
                         data-bs-target="#menuRh" 
                         aria-expanded="{{ $isRhActive ? 'true' : 'false' }}">
                        <i class='bx bxs-user-detail category-icon text-secondary'></i>
                        <span class="category-title">Ressources Humaines</span>
                        <i class='bx bx-chevron-down chevron-icon'></i>
                    </div>
                    <div class="collapse {{ $isRhActive ? 'show' : '' }}" id="menuRh">
                        <ul class="nav-sub-menu">
                            <li class="nav-sub-item">
                                <a href="{{ route('enseignants.index') }}" class="nav-sub-link {{ request()->routeIs('enseignants.*') ? 'active' : '' }}">
                                    <i class='bx bxs-group'></i> Enseignants
                                </a>
                            </li>
                            <li class="nav-sub-item">
                                <a href="{{ route('personnels.index') }}" class="nav-sub-link {{ request()->routeIs('personnels.*') ? 'active' : '' }}">
                                    <i class='bx bx-user-check'></i> Personnel Admin.
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            @endhasanyrole

            {{-- 6. LOGISTIQUE & SERVICES --}}
            @hasanyrole(['super_admin', 'directeur', 'logistique'])
                @php
                    $isLogistiqueActive = request()->routeIs('vehicules.*') || request()->routeIs('chauffeurs.*') || request()->routeIs('zone_transports.*') || request()->routeIs('abonnement_transports.*') || request()->routeIs('abonnement_cantines.*');
                @endphp
                <div class="nav-category">
                    <div class="nav-category-header {{ $isLogistiqueActive ? 'active-group' : '' }}" 
                         data-bs-toggle="collapse" 
                         data-bs-target="#menuLogistique" 
                         aria-expanded="{{ $isLogistiqueActive ? 'true' : 'false' }}">
                        <i class='bx bxs-bus category-icon text-danger'></i>
                        <span class="category-title">Logistique & Services</span>
                        <i class='bx bx-chevron-down chevron-icon'></i>
                    </div>
                    <div class="collapse {{ $isLogistiqueActive ? 'show' : '' }}" id="menuLogistique">
                        <ul class="nav-sub-menu">
                            <li class="nav-sub-item">
                                <a href="{{ route('vehicules.index') }}" class="nav-sub-link {{ request()->routeIs('vehicules.*') ? 'active' : '' }}">
                                    <i class='bx bxs-car'></i> Véhicules
                                </a>
                            </li>
                            <li class="nav-sub-item">
                                <a href="{{ route('chauffeurs.index') }}" class="nav-sub-link {{ request()->routeIs('chauffeurs.*') ? 'active' : '' }}">
                                    <i class='bx bxs-user-badge'></i> Chauffeurs
                                </a>
                            </li>
                            <li class="nav-sub-item">
                                <a href="{{ route('zone_transports.index') }}" class="nav-sub-link {{ request()->routeIs('zone_transports.*') ? 'active' : '' }}">
                                    <i class='bx bx-map'></i> Zones Transport
                                </a>
                            </li>
                            <li class="nav-sub-item">
                                <a href="{{ route('abonnement_transports.index') }}" class="nav-sub-link {{ request()->routeIs('abonnement_transports.*') ? 'active' : '' }}">
                                    <i class='bx bx-transfer-alt'></i> Abonnements Transport
                                </a>
                            </li>
                            <li class="nav-sub-item">
                                <a href="{{ route('abonnement_cantines.index') }}" class="nav-sub-link {{ request()->routeIs('abonnement_cantines.*') ? 'active' : '' }}">
                                    <i class='bx bx-restaurant'></i> Cantine Scolaire
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            @endhasanyrole

            {{-- 7. PARAMÈTRES & CONFIGURATION --}}
            @hasanyrole(['super_admin', 'directeur', 'comptable'])
                @php
                    $isSettingsActive = request()->routeIs('settings.*') || request()->routeIs('users.*') || request()->routeIs('niveaux.*') || request()->routeIs('types_paiements.*');
                @endphp
                <div class="nav-category">
                    <div class="nav-category-header {{ $isSettingsActive ? 'active-group' : '' }}" 
                         data-bs-toggle="collapse" 
                         data-bs-target="#menuSettings" 
                         aria-expanded="{{ $isSettingsActive ? 'true' : 'false' }}">
                        <i class='bx bxs-cog category-icon text-dark'></i>
                        <span class="category-title">Paramètres</span>
                        <i class='bx bx-chevron-down chevron-icon'></i>
                    </div>
                    <div class="collapse {{ $isSettingsActive ? 'show' : '' }}" id="menuSettings">
                        <ul class="nav-sub-menu">
                            <li class="nav-sub-item">
                                <a href="{{ route('niveaux.index') }}" class="nav-sub-link {{ request()->routeIs('niveaux.*') ? 'active' : '' }}">
                                    <i class='bx bxs-bar-chart-alt-2'></i> Niveaux & Tarifs
                                </a>
                            </li>
                            @hasanyrole(['super_admin', 'directeur'])
                                <li class="nav-sub-item">
                                    <a href="{{ route('settings.index') }}" class="nav-sub-link {{ request()->routeIs('settings.*') || request()->routeIs('users.*') || request()->routeIs('types_paiements.*') ? 'active' : '' }}">
                                        <i class='bx bx-slider-alt'></i> Configuration Générale
                                    </a>
                                </li>
                            @endhasanyrole
                        </ul>
                    </div>
                </div>
            @endhasanyrole
        </nav>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="top-navbar">
            <h4 class="fw-bold">@yield('page_title')</h4>
            <div class="user-profile dropdown" style="cursor: pointer;" data-bs-toggle="dropdown">
                <div class="text-end me-2">
                    <p class="mb-0 fw-bold">{{ auth()->user()->name ?? 'Invité' }}</p>
                    <small class="text-muted">{{ auth()->user()?->roles->first()?->name ?? 'Visiteur' }}</small>
                </div>
                <div class="user-avatar bg-primary text-white d-flex align-items-center justify-content-center">
                    {{ strtoupper(substr(auth()->user()->name ?? 'I', 0, 1)) }}
                </div>
                <ul class="dropdown-menu dropdown-menu-end shadow border-0 p-2 mt-2">
                    <li><a class="dropdown-item rounded-3" href="{{ route('profile.index') }}"><i class='bx bx-user me-2'></i> Mon Profil</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li>
                        <a class="dropdown-item rounded-3 text-danger" href="{{ route('logout') }}"
                           onclick="event.preventDefault(); document.getElementById('logout-form').submit();">
                            <i class='bx bx-log-out me-2'></i> Déconnexion
                        </a>
                        <form id="logout-form" action="{{ route('logout') }}" method="POST" class="d-none">
                            @csrf
                        </form>
                    </li>
                </ul>
            </div>
        </div>

        @if(session('success'))
            <div class="alert alert-success border-0 shadow-sm rounded-4 mb-4 animate__animated animate__fadeIn" role="alert">
                <i class='bx bxs-check-circle me-2'></i> {{ session('success') }}
            </div>
        @endif

        @if(session('error'))
            <div class="alert alert-danger border-0 shadow-sm rounded-4 mb-4 animate__animated animate__shakeX" role="alert">
                <i class='bx bxs-error-circle me-2'></i> {{ session('error') }}
            </div>
        @endif

        @if($errors->any())
            <div class="alert alert-danger border-0 shadow-sm rounded-4 mb-4 animate__animated animate__shakeX" role="alert">
                <ul class="mb-0">
                    @foreach($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </div>
        @endif

        @yield('content')
    </div>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>

    <!-- Bootstrap & Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- DataTables Core & Bootstrap 5 -->
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
    
    <!-- DataTables Export Plugins (JSZip, pdfmake, Buttons) -->
    <script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.bootstrap5.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.print.min.js"></script>

    <!-- Select2 JS & French Language -->
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/i18n/fr.js"></script>

    <script>
        /**
         * Initialise Select2 sur les éléments du contexte donné.
         * Passe les éléments déjà initialisés pour éviter les doublons.
         * Pour les modals, on détruit et réinitialise à chaque ouverture (hidden → shown).
         */
        function initSelect2(context, insideModal) {
            const $ctx = context ? $(context) : $(document.body);

            // Sélecteurs simples (select.select2)
            const selector = '.select2, select.select2-enable';
            let $selects = $ctx.find(selector);

            // Sur le document global (hors modal), on exclut les selects dans .modal
            // pour éviter l'initialisation avec width:0 quand le modal est caché
            if (!insideModal) {
                $selects = $selects.filter(function() {
                    return $(this).closest('.modal').length === 0;
                });
            }

            $selects.each(function() {
                const $this = $(this);

                // Si déjà initialisé et qu'on n'est pas en mode réinitialisation modale, on skip
                if ($this.hasClass('select2-hidden-accessible') && !insideModal) {
                    return;
                }
                // Détruire proprement si déjà initialisé (cas modal réouverture)
                if ($this.hasClass('select2-hidden-accessible')) {
                    try { $this.select2('destroy'); } catch(e) {}
                }

                const $modal = $this.closest('.modal');
                const isModal = $modal.length > 0;
                const placeholder = $this.data('placeholder') || '';

                $this.select2({
                    theme: 'bootstrap-5',
                    width: '100%',
                    language: 'fr',
                    placeholder: placeholder,
                    allowClear: !!placeholder && !$this.prop('required'),
                    dropdownParent: isModal ? $modal : $(document.body)
                });
            });

            // Selects multiples
            $ctx.find('.select2-multiple').each(function() {
                const $this = $(this);
                if ($this.hasClass('select2-hidden-accessible') && !insideModal) {
                    return;
                }
                if ($this.hasClass('select2-hidden-accessible')) {
                    try { $this.select2('destroy'); } catch(e) {}
                }
                const $modal = $this.closest('.modal');
                const isModal = $modal.length > 0;

                $this.select2({
                    theme: 'bootstrap-5',
                    width: '100%',
                    language: 'fr',
                    placeholder: $this.data('placeholder') || 'Sélectionner des options...',
                    dropdownParent: isModal ? $modal : $(document.body)
                });
            });
        }

        $(document).ready(function() {
            $('.datatable').DataTable({
                language: {
                    url: '//cdn.datatables.net/plug-ins/1.13.6/i18n/fr-FR.json',
                },
                dom: "<'row mb-3 align-items-center'<'col-sm-12 col-md-4'l><'col-sm-12 col-md-4 text-center'B><'col-sm-12 col-md-4 d-flex justify-content-end'f>>" +
                     "<'row'<'col-sm-12'tr>>" +
                     "<'row mt-3'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 d-flex justify-content-end'p>>",
                buttons: [
                    { extend: 'excelHtml5', className: 'btn btn-sm btn-success', text: '<i class="bx bx-spreadsheet"></i> Excel' },
                    { extend: 'pdfHtml5', className: 'btn btn-sm btn-danger', text: '<i class="bx bxs-file-pdf"></i> PDF', orientation: 'landscape', pageSize: 'A4' },
                    { extend: 'print', className: 'btn btn-sm btn-info text-white', text: '<i class="bx bx-printer"></i> Imprimer' }
                ],
                pageLength: 25,
                bSort: true,
                order: []
            });

            // Initialiser Select2 uniquement sur les éléments HORS modaux
            initSelect2(document.body, false);
        });

        // Réinitialiser Select2 à chaque ouverture de modal (destroy + reinit)
        // On utilise "shown.bs.modal" pour que le modal soit visible (width calculable)
        $(document).on('shown.bs.modal', '.modal', function() {
            initSelect2(this, true);
        });

        // Nettoyage à la fermeture du modal pour éviter les doublons
        $(document).on('hidden.bs.modal', '.modal', function() {
            $(this).find('.select2-hidden-accessible').each(function() {
                try { $(this).select2('destroy'); } catch(e) {}
            });
        });
    </script>

    @yield('scripts')
</body>
</html>
