<?php

use App\Http\Controllers\Web\EleveController;
use App\Http\Controllers\Web\ClasseController;
use App\Http\Controllers\Web\NiveauController;
use App\Http\Controllers\Web\DashboardController;
use App\Http\Controllers\Web\EnseignantController;
use App\Http\Controllers\Web\MatiereController;
use App\Http\Controllers\Web\EmploiController;
use App\Http\Controllers\Web\NoteController;
use App\Http\Controllers\Web\BulletinController;
use App\Http\Controllers\Web\AbsenceController;
use App\Http\Controllers\Web\ConvocationController;
use App\Http\Controllers\Web\PaiementController;
use App\Http\Controllers\Web\UserController;
use App\Http\Controllers\Web\AuthController;
use App\Http\Controllers\Web\ProfileController;
use App\Http\Controllers\Web\InscriptionController;
use App\Http\Controllers\Web\TuteurController;
use Illuminate\Support\Facades\Route;

// Authentification
Route::get('login', [AuthController::class, 'showLogin'])->name('login');
Route::post('login', [AuthController::class, 'login'])->name('login.post');
Route::post('logout', [AuthController::class, 'logout'])->name('logout');

Route::middleware(['auth'])->group(function () {
    
    // === Routes communes (tous les utilisateurs authentifiés) ===
    Route::get('/', [DashboardController::class, 'index'])->name('dashboard');
    Route::get('profile', [ProfileController::class, 'index'])->name('profile.index');
    Route::patch('profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::put('profile/password', [ProfileController::class, 'updatePassword'])->name('profile.password');

    // === Espace Professeur (Mobile-friendly) ===
    Route::prefix('professeur')->name('professeur.')->group(function () {
        Route::get('/', [\App\Http\Controllers\Web\ProfesseurController::class, 'dashboard'])->name('dashboard');
        Route::get('notes', [NoteController::class, 'mobileIndex'])->name('notes.index');
        Route::get('notes/devoirs', [NoteController::class, 'mobileDevoirs'])->name('notes.devoirs');
        Route::post('notes/evaluations', [NoteController::class, 'storeEvaluationWeb'])->name('notes.evaluations.store');
        Route::get('notes/saisie', [NoteController::class, 'mobileSaisie'])->name('notes.saisie');
        Route::post('notes/store', [NoteController::class, 'mobileStore'])->name('notes.store');
        Route::get('absences', [\App\Http\Controllers\Web\ProfesseurController::class, 'absencesIndex'])->name('absences.index');
        Route::get('absences/appel', [\App\Http\Controllers\Web\ProfesseurController::class, 'absencesAppel'])->name('absences.appel');
        Route::post('absences/store', [\App\Http\Controllers\Web\ProfesseurController::class, 'absencesStore'])->name('absences.store');
        Route::get('absences/historique', [\App\Http\Controllers\Web\ProfesseurController::class, 'absencesHistorique'])->name('absences.historique');
    });

    // =========================================================
    // === ROUTES FINANCIÈRES : super_admin | directeur | comptable
    // =========================================================
    Route::middleware(['role:super_admin|directeur|comptable'])->group(function () {

        // Paiements
        Route::get('paiements/suivi/mensualites', [PaiementController::class, 'suivi'])->name('paiements.suivi');
        Route::get('paiements/get-amount', [PaiementController::class, 'getAmount'])->name('paiements.getAmount');
        Route::resource('paiements', PaiementController::class);
        Route::get('paiements/{paiement}/receipt', [PaiementController::class, 'receipt'])->name('paiements.receipt');

        // Notifications
        Route::get('notifications', [\App\Http\Controllers\Web\NotificationController::class, 'index'])->name('notifications.index');
        Route::get('notifications/create', [\App\Http\Controllers\Web\NotificationController::class, 'create'])->name('notifications.create');
        Route::post('notifications', [\App\Http\Controllers\Web\NotificationController::class, 'store'])->name('notifications.store');

        // Rapport Financier
        Route::get('rapport-financier', [\App\Http\Controllers\Web\RapportController::class, 'financier'])->name('rapports.financier');

        // Dépenses
        Route::resource('depenses', \App\Http\Controllers\Web\DepenseController::class)->except(['show']);

        // Types de Frais
        Route::resource('types_paiements', \App\Http\Controllers\Web\TypePaiementController::class);

        // Niveaux & Tarifs (lecture + mise à jour tarifs)
        Route::resource('niveaux', NiveauController::class)->parameters(['niveaux' => 'niveau']);
        Route::post('niveaux/{niveau}/tarifs', [NiveauController::class, 'updateTarifs'])->name('niveaux.tarifs.update');
    });

    // =========================================================
    // === ROUTES ADMINISTRATIVES : super_admin | directeur | administratif
    // =========================================================
    Route::middleware(['role:super_admin|directeur|administratif'])->group(function () {

        // Élèves — opérations d'écriture (create/edit/delete)
        Route::get('eleves/import-template', [\App\Http\Controllers\Web\EleveController::class, 'downloadTemplate'])->name('eleves.import_template');
        Route::post('eleves/import', [\App\Http\Controllers\Web\EleveController::class, 'import'])->name('eleves.import');
        Route::get('eleves/create', [EleveController::class, 'create'])->name('eleves.create');
        Route::post('eleves', [EleveController::class, 'store'])->name('eleves.store');
        Route::get('eleves/{eleve}/edit', [EleveController::class, 'edit'])->name('eleves.edit');
        Route::put('eleves/{eleve}', [EleveController::class, 'update'])->name('eleves.update');
        Route::patch('eleves/{eleve}', [EleveController::class, 'update']);
        Route::delete('eleves/{eleve}', [EleveController::class, 'destroy'])->name('eleves.destroy');

        // Tuteurs — opérations d'écriture
        Route::post('tuteurs/{tuteur}/toggle', [TuteurController::class, 'toggleStatus'])->name('tuteurs.toggle');
        Route::get('tuteurs/{tuteur}/edit', [TuteurController::class, 'edit'])->name('tuteurs.edit');
        Route::put('tuteurs/{tuteur}', [TuteurController::class, 'update'])->name('tuteurs.update');
        Route::patch('tuteurs/{tuteur}', [TuteurController::class, 'update']);

        // Classes — opérations d'écriture
        Route::post('classes/{classe}/matieres', [ClasseController::class, 'attachMatiere'])->name('classes.matieres.attach');
        Route::delete('classes/{classe}/matieres/{matiere}', [ClasseController::class, 'detachMatiere'])->name('classes.matieres.detach');
        Route::get('classes/create', [ClasseController::class, 'create'])->name('classes.create');
        Route::post('classes', [ClasseController::class, 'store'])->name('classes.store');
        Route::get('classes/{classe}', [ClasseController::class, 'show'])->name('classes.show');
        Route::get('classes/{classe}/edit', [ClasseController::class, 'edit'])->name('classes.edit');
        Route::put('classes/{classe}', [ClasseController::class, 'update'])->name('classes.update');
        Route::patch('classes/{classe}', [ClasseController::class, 'update']);
        Route::delete('classes/{classe}', [ClasseController::class, 'destroy'])->name('classes.destroy');

        // Enseignants
        Route::resource('enseignants', EnseignantController::class)->parameters(['enseignants' => 'enseignant']);

        // Matières
        Route::resource('matieres', MatiereController::class)->parameters(['matieres' => 'matiere']);

        // Emplois du Temps
        Route::resource('emplois', EmploiController::class)->parameters(['emplois' => 'emploi']);

        // Notes
        Route::resource('notes', NoteController::class)->only(['index', 'store']);

        // Bulletins
        Route::get('bulletins', [BulletinController::class, 'index'])->name('bulletins.index');
        Route::get('bulletins/{eleve}/generate', [BulletinController::class, 'generate'])->name('bulletins.generate');
        Route::get('bulletins/verify/{token}', [BulletinController::class, 'verify'])->name('bulletins.verify');

        // Absences
        Route::resource('absences', AbsenceController::class)->only(['index', 'store']);

        // Convocations
        Route::resource('convocations', ConvocationController::class)->only(['index', 'create', 'store', 'destroy']);

        // Inscriptions — opérations d'écriture (index déjà défini en read-only)
        Route::get('inscriptions/create', [InscriptionController::class, 'create'])->name('inscriptions.create');
        Route::post('inscriptions', [InscriptionController::class, 'store'])->name('inscriptions.store');
        Route::delete('inscriptions/{inscription}', [InscriptionController::class, 'destroy'])->name('inscriptions.destroy');

        // Paramètres administratifs (salles, séries)
        Route::resource('salles', \App\Http\Controllers\Web\SalleController::class);
        Route::resource('series', \App\Http\Controllers\Web\SerieController::class);
    });

    // =========================================================
    // === ROUTES READ-ONLY (comptable + administratif + admin) ===
    // Vue des élèves, classes, inscriptions, tuteurs — accessible aux deux rôles staff
    // =========================================================
    Route::middleware(['role:super_admin|directeur|comptable|administratif'])->group(function () {
        Route::get('eleves', [EleveController::class, 'index'])->name('eleves.index');
        Route::get('eleves/{eleve}', [EleveController::class, 'show'])->name('eleves.show');
        Route::get('classes', [ClasseController::class, 'index'])->name('classes.index');
        Route::get('inscriptions', [InscriptionController::class, 'index'])->name('inscriptions.index');
        Route::get('tuteurs', [TuteurController::class, 'index'])->name('tuteurs.index');
    });

    // =========================================================
    // === PARAMÈTRES GLOBAUX : super_admin | directeur
    // =========================================================
    Route::middleware(['role:super_admin|directeur'])->group(function () {
        Route::resource('etablissements', \App\Http\Controllers\Web\EtablissementController::class);
        Route::post('annee_scolaires/{annee_scolaire}/activate', [\App\Http\Controllers\Web\AnneeScolaireController::class, 'activate'])->name('annee_scolaires.activate');
        Route::resource('annee_scolaires', \App\Http\Controllers\Web\AnneeScolaireController::class);
    });

    // Page Paramètres (visible par tous les rôles staff)
    Route::get('parametres', [\App\Http\Controllers\Web\SettingsController::class, 'index'])->name('settings.index');

    // === Gestion des Utilisateurs (super_admin seulement) ===
    Route::middleware(['role:super_admin'])->group(function () {
        Route::resource('users', UserController::class);
        Route::post('users/{user}/toggle', [UserController::class, 'toggleStatus'])->name('users.toggle');
    });
});

