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

    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --success-color: #4cc9f0;
            --bg-color: #f8f9fa;
            --sidebar-width: 260px;
            --card-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
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
            gap: 15px;
            padding: 12px 15px;
            color: #6c757d;
            border-radius: 10px;
            transition: all 0.3s ease;
            margin-bottom: 5px;
            font-weight: 500;
        }

        .nav-link:hover, .nav-link.active {
            background: rgba(67, 97, 238, 0.1);
            color: var(--primary-color);
        }

        .nav-link i {
            font-size: 20px;
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

        <nav class="nav flex-column">
            <a href="{{ route('dashboard') }}" class="nav-link {{ request()->routeIs('dashboard') ? 'active' : '' }}"><i class='bx bxs-dashboard'></i> Dashboard</a>
            <a href="{{ route('eleves.index') }}" class="nav-link {{ request()->routeIs('eleves.*') ? 'active' : '' }}"><i class='bx bxs-user-badge'></i> Élèves</a>
            <a href="{{ route('inscriptions.index') }}" class="nav-link {{ request()->routeIs('inscriptions.*') ? 'active' : '' }}"><i class='bx bx-history'></i> Inscriptions</a>
            <a href="{{ route('classes.index') }}" class="nav-link {{ request()->routeIs('classes.*') ? 'active' : '' }}"><i class='bx bxs-school'></i> Classes</a>
            <a href="{{ route('enseignants.index') }}" class="nav-link {{ request()->routeIs('enseignants.*') ? 'active' : '' }}"><i class='bx bxs-group'></i> Enseignants</a>
            <a href="{{ route('matieres.index') }}" class="nav-link {{ request()->routeIs('matieres.*') ? 'active' : '' }}"><i class='bx bxs-book'></i> Matières</a>
            <a href="{{ route('emplois.index') }}" class="nav-link {{ request()->routeIs('emplois.*') ? 'active' : '' }}"><i class='bx bxs-calendar'></i> Emploi du Temps</a>
            <a href="{{ route('notes.index') }}" class="nav-link {{ request()->routeIs('notes.*') ? 'active' : '' }}"><i class='bx bxs-edit'></i> Notes</a>
            <a href="{{ route('paiements.index') }}" class="nav-link {{ request()->routeIs('paiements.index') || request()->routeIs('paiements.create') ? 'active' : '' }}"><i class='bx bxs-wallet'></i> Paiements</a>
            <a href="{{ route('paiements.suivi') }}" class="nav-link {{ request()->routeIs('paiements.suivi') ? 'active' : '' }}"><i class='bx bx-search-alt'></i> Suivi Mensualités</a>
            <a href="{{ route('rapports.financier') }}" class="nav-link {{ request()->routeIs('rapports.financier') ? 'active' : '' }}"><i class='bx bxs-pie-chart-alt-2'></i> Rapport Financier</a>
            <a href="{{ route('bulletins.index') }}" class="nav-link {{ request()->routeIs('bulletins.*') ? 'active' : '' }}"><i class='bx bxs-file-pdf'></i> Bulletins</a>
            <a href="{{ route('absences.index') }}" class="nav-link {{ request()->routeIs('absences.*') ? 'active' : '' }}"><i class='bx bxs-time-five'></i> Absences</a>
            <a href="{{ route('convocations.index') }}" class="nav-link {{ request()->routeIs('convocations.*') ? 'active' : '' }}"><i class='bx bxs-error-circle'></i> Convocations</a>
            <a href="{{ route('depenses.index') }}" class="nav-link {{ request()->routeIs('depenses.*') ? 'active' : '' }}"><i class='bx bx-money-withdraw'></i> Depenses</a>
            <a href="{{ route('settings.index') }}" class="nav-link {{ request()->routeIs('settings.*') || request()->routeIs('users.*') || request()->routeIs('niveaux.*') ? 'active' : '' }}"><i class='bx bxs-cog'></i> Admin & Paramètres</a>
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
                        <form action="{{ route('logout') }}" method="POST" id="logout-form">
                            @csrf
                            <button type="submit" class="dropdown-item rounded-3 text-danger"><i class='bx bx-log-out me-2'></i> Déconnexion</button>
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

    <script>
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
        });
    </script>

    @yield('scripts')
</body>
</html>
