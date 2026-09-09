@extends('layouts.app')

@section('title', 'Paramètres Globaux')
@section('page_title', 'Configuration & Administration Système')

@section('content')
<div class="row animate__animated animate__fadeIn">
    <!-- Section: L'Établissement -->
    <h5 class="fw-bold mb-4"><i class='bx bxs-school text-primary me-2'></i>Mon Établissement</h5>
    <div class="row g-4 mb-5">
        <div class="col-md-4">
            <a href="{{ route('etablissements.index') ?? '#' }}" class="text-decoration-none">
                <div class="card p-4 h-100 border-0 bg-white">
                    <div class="d-flex align-items-center mb-3">
                        <div class="bg-primary-subtle text-primary p-3 rounded-circle me-3">
                            <i class='bx bxs-building-house fs-2'></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-0">Informations de l'École</h5>
                    </div>
                    <p class="text-muted small mb-0">Définissez le nom, l'adresse, le téléphone, et le logo de l'établissement utilisés sur les reçus/bulletins.</p>
                </div>
            </a>
        </div>
        <div class="col-md-4">
            <a href="{{ route('annee_scolaires.index') ?? '#' }}" class="text-decoration-none">
                <div class="card p-4 h-100 border-0 bg-white">
                    <div class="d-flex align-items-center mb-3">
                        <div class="bg-success-subtle text-success p-3 rounded-circle me-3">
                            <i class='bx bx-calendar-event fs-2'></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-0">Années Scolaires</h5>
                    </div>
                    <p class="text-muted small mb-0">Gestion de vos années académiques (ex: 2025-2026) et activation de l'année en cours.</p>
                </div>
            </a>
        </div>
        <div class="col-md-4">
            <a href="{{ route('users.index') }}" class="text-decoration-none">
                <div class="card p-4 h-100 border-0 bg-white">
                    <div class="d-flex align-items-center mb-3">
                        <div class="bg-danger-subtle text-danger p-3 rounded-circle me-3">
                            <i class='bx bxs-user-account fs-2'></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-0">Comptes & Accès</h5>
                    </div>
                    <p class="text-muted small mb-0">Créez et supprimez les comptes utilisateurs du système. Modifiez les mots de passe des employés.</p>
                </div>
            </a>
        </div>
    </div>

    <!-- Section: Organisation Pédagogique -->
    <h5 class="fw-bold mb-4"><i class='bx bxs-book-open text-info me-2'></i>Organisation Pédagogique & Financière</h5>
    <div class="row g-4 mb-4">
        <div class="col-md-4">
            <a href="{{ route('salles.index') ?? '#' }}" class="text-decoration-none">
                <div class="card p-4 h-100 border-0 bg-white">
                    <div class="d-flex align-items-center mb-3">
                        <div class="bg-info-subtle text-info p-3 rounded-circle me-3">
                            <i class='bx bxs-door-open fs-2'></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-0">Locaux & Salles</h5>
                    </div>
                    <p class="text-muted small mb-0">Déclarez les salles physiques disponibles (Amphi A, Salle 12, Laboratoire S) et leur contenance.</p>
                </div>
            </a>
        </div>
        <div class="col-md-4">
            <a href="{{ route('series.index') ?? '#' }}" class="text-decoration-none">
                <div class="card p-4 h-100 border-0 bg-white">
                    <div class="d-flex align-items-center mb-3">
                        <div class="bg-warning-subtle text-warning p-3 rounded-circle me-3">
                            <i class='bx bx-book-bookmark fs-2'></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-0">Séries / Filières</h5>
                    </div>
                    <p class="text-muted small mb-0">Gérez les filières de votre école (Terminale L, S1, S2, G, ou Général pour le reste).</p>
                </div>
            </a>
        </div>
        <div class="col-md-4">
            <a href="{{ route('niveaux.index') }}" class="text-decoration-none">
                <div class="card p-4 h-100 border-0 bg-white shadow-sm border border-primary">
                    <div class="d-flex align-items-center mb-3">
                        <div class="bg-primary text-white p-3 rounded-circle me-3">
                            <i class='bx bxs-bar-chart-alt-2 fs-2'></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-0">Niveaux & Tarifs</h5>
                    </div>
                    <p class="text-muted small mb-0">Défition des niveaux académiques (6ème, 3ème...) et <strong>Fixation des tarifs de scolarité associés</strong>.</p>
                </div>
            </a>
        </div>
    </div>
    
    <div class="row g-4 pb-5">
        <div class="col-md-4">
            <a href="{{ route('types_paiements.index') ?? '#' }}" class="text-decoration-none">
                <div class="card p-4 h-100 border-0 bg-white">
                    <div class="d-flex align-items-center mb-3">
                        <div class="bg-success-subtle text-success p-3 rounded-circle me-3">
                            <i class='bx bx-category fs-2'></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-0">Types de Frais</h5>
                    </div>
                    <p class="text-muted small mb-0">Ajoutez de nouveaux motifs d'encaissement (Inscription, Mensualité, Transport, Tenue Sport...).</p>
                </div>
            </a>
        </div>
    </div>
</div>
@endsection
