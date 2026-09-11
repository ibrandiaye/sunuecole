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
    
    Route::get('/', [DashboardController::class, 'index'])->name('dashboard');

    // Gestion des Élèves
    Route::resource('eleves', EleveController::class)->parameters(['eleves' => 'eleve']);

    // Gestion des Tuteurs / Parents
    Route::post('tuteurs/{tuteur}/toggle', [TuteurController::class, 'toggleStatus'])->name('tuteurs.toggle');
    Route::resource('tuteurs', TuteurController::class)->parameters(['tuteurs' => 'tuteur'])->only(['index', 'edit', 'update']);

    // Gestion des Classes
    Route::post('classes/{classe}/matieres', [ClasseController::class, 'attachMatiere'])->name('classes.matieres.attach');
    Route::delete('classes/{classe}/matieres/{matiere}', [ClasseController::class, 'detachMatiere'])->name('classes.matieres.detach');
    Route::resource('classes', ClasseController::class)->parameters(['classes' => 'classe']);

    // Gestion des Enseignants
    Route::resource('enseignants', EnseignantController::class)->parameters(['enseignants' => 'enseignant']);

    // Gestion des Matières
    Route::resource('matieres', MatiereController::class)->parameters(['matieres' => 'matiere']);

    // Gestion des Emplois du Temps
    Route::resource('emplois', EmploiController::class)->parameters(['emplois' => 'emploi']);

    // Gestion des Notes
    Route::resource('notes', NoteController::class)->only(['index', 'store']);

    // Espace Professeur (Mobile-friendly)
    Route::prefix('professeur')->name('professeur.')->group(function () {
        // Dashboard
        Route::get('/', [\App\Http\Controllers\Web\ProfesseurController::class, 'dashboard'])->name('dashboard');

        // Notes
        Route::get('notes', [NoteController::class, 'mobileIndex'])->name('notes.index');
        Route::get('notes/devoirs', [NoteController::class, 'mobileDevoirs'])->name('notes.devoirs');
        Route::post('notes/evaluations', [NoteController::class, 'storeEvaluationWeb'])->name('notes.evaluations.store');
        Route::get('notes/saisie', [NoteController::class, 'mobileSaisie'])->name('notes.saisie');
        Route::post('notes/store', [NoteController::class, 'mobileStore'])->name('notes.store');

        // Absences & Cahier de textes
        Route::get('absences', [\App\Http\Controllers\Web\ProfesseurController::class, 'absencesIndex'])->name('absences.index');
        Route::get('absences/appel', [\App\Http\Controllers\Web\ProfesseurController::class, 'absencesAppel'])->name('absences.appel');
        Route::post('absences/store', [\App\Http\Controllers\Web\ProfesseurController::class, 'absencesStore'])->name('absences.store');
        Route::get('absences/historique', [\App\Http\Controllers\Web\ProfesseurController::class, 'absencesHistorique'])->name('absences.historique');
    });

    // Gestion des Bulletins
    Route::get('bulletins', [BulletinController::class, 'index'])->name('bulletins.index');
    Route::get('bulletins/{eleve}/generate', [BulletinController::class, 'generate'])->name('bulletins.generate');
    Route::get('bulletins/verify/{token}', [BulletinController::class, 'verify'])->name('bulletins.verify');

    // Gestion des Absences
    Route::resource('absences', AbsenceController::class)->only(['index', 'store']);

    // Gestion des Convocations / Sanctions
    Route::resource('convocations', ConvocationController::class)->only(['index', 'create', 'store', 'destroy']);

    // Gestion des Dépenses
    Route::resource('depenses', \App\Http\Controllers\Web\DepenseController::class)->except(['show']);

    // Gestion des Inscriptions
    Route::resource('inscriptions', InscriptionController::class)->except(['edit', 'update', 'show']);

    // Gestion des Paiements
    Route::get('paiements/suivi/mensualites', [PaiementController::class, 'suivi'])->name('paiements.suivi');
    Route::get('paiements/get-amount', [PaiementController::class, 'getAmount'])->name('paiements.getAmount');
    Route::resource('paiements', PaiementController::class);
    Route::get('paiements/{paiement}/receipt', [PaiementController::class, 'receipt'])->name('paiements.receipt');
    Route::get('rapport-financier', [\App\Http\Controllers\Web\RapportController::class, 'financier'])->name('rapports.financier');

    // Paramètres Globaux & Configuration
    Route::get('parametres', [\App\Http\Controllers\Web\SettingsController::class, 'index'])->name('settings.index');
    Route::resource('etablissements', \App\Http\Controllers\Web\EtablissementController::class);
    Route::post('annee_scolaires/{annee_scolaire}/activate', [\App\Http\Controllers\Web\AnneeScolaireController::class, 'activate'])->name('annee_scolaires.activate');
    Route::resource('annee_scolaires', \App\Http\Controllers\Web\AnneeScolaireController::class);
    Route::resource('salles', \App\Http\Controllers\Web\SalleController::class);
    Route::resource('series', \App\Http\Controllers\Web\SerieController::class);
    Route::resource('types_paiements', \App\Http\Controllers\Web\TypePaiementController::class);

    // Gestion des Niveaux et Tarifs
    Route::resource('niveaux', NiveauController::class)->parameters(['niveaux' => 'niveau']);
    Route::post('niveaux/{niveau}/tarifs', [NiveauController::class, 'updateTarifs'])->name('niveaux.tarifs.update');

    // Gestion des Utilisateurs (Admin seulement)
    Route::group(['middleware' => ['role:super_admin']], function () {
        Route::resource('users', UserController::class);
        Route::post('users/{user}/toggle', [UserController::class, 'toggleStatus'])->name('users.toggle');
    });

    // Profil (Personnel)
    Route::get('profile', [ProfileController::class, 'index'])->name('profile.index');
    Route::patch('profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::put('profile/password', [ProfileController::class, 'updatePassword'])->name('profile.password');
});
