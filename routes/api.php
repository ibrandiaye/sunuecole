<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\EleveApiController;
use App\Http\Controllers\Api\EnseignantApiController;
use App\Http\Controllers\Api\NotificationApiController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
*/

Route::group(['prefix' => 'auth'], function () {
    Route::post('login', [AuthController::class, 'login']);
    Route::post('logout', [AuthController::class, 'logout'])->middleware('auth:api');
    Route::post('refresh', [AuthController::class, 'refresh'])->middleware('auth:api');
    Route::get('me', [AuthController::class, 'me'])->middleware('auth:api');
});

Route::middleware(['auth:api'])->group(function () {
    // Endpoints pour les Élèves
    Route::get('eleve/profil', [EleveApiController::class, 'getProfil']);
    Route::get('eleve/emploi-du-temps', [EleveApiController::class, 'getEmploiDuTemps']);
    Route::get('eleve/notes', [EleveApiController::class, 'getNotes']);
    Route::get('eleve/absences', [EleveApiController::class, 'getAbsences']);
    Route::get('eleve/convocations', [EleveApiController::class, 'getConvocations']);
    
    // Endpoints pour les Parents
    Route::get('parent/profil', [\App\Http\Controllers\Api\ParentApiController::class, 'getProfil']);
    Route::get('parent/enfant/{id}/notes', [\App\Http\Controllers\Api\ParentApiController::class, 'getNotesEnfant']);
    Route::get('parent/enfant/{id}/absences', [\App\Http\Controllers\Api\ParentApiController::class, 'getAbsencesEnfant']);
    Route::get('parent/enfant/{id}/emploi-du-temps', [\App\Http\Controllers\Api\ParentApiController::class, 'getEmploiDuTempsEnfant']);
    Route::get('parent/enfant/{id}/convocations', [\App\Http\Controllers\Api\ParentApiController::class, 'getConvocationsEnfant']);
    
    // Endpoints pour les Enseignants
    Route::get('enseignant/classes', [EnseignantApiController::class, 'getClasses']);
    Route::get('enseignant/planning', [EnseignantApiController::class, 'getPlanning']);
    Route::post('enseignant/absences', [EnseignantApiController::class, 'storeAbsence']);
    Route::post('enseignant/notes', [EnseignantApiController::class, 'storeNote']);
    Route::post('enseignant/seances', [EnseignantApiController::class, 'storeSeance']);
    Route::get('enseignant/classes/{id}/eleves', [EnseignantApiController::class, 'getElevesByClasse']);
    Route::get('enseignant/classes/{id}/matieres', [EnseignantApiController::class, 'getMatieresByClasse']);
    Route::get('enseignant/classes/{id}/evaluations', [EnseignantApiController::class, 'getEvaluationsByClasse']);
    Route::get('enseignant/classes/{id}/cahier-textes', [EnseignantApiController::class, 'getCahierTextesByClasse']);
    Route::get('enseignant/evaluations/{id}/notes', [EnseignantApiController::class, 'getEvaluationNotes']);
    Route::get('enseignant/classes/{id}/planning', [EnseignantApiController::class, 'getPlanningByClasse']);
    Route::post('enseignant/evaluations', [EnseignantApiController::class, 'storeEvaluation']);
    Route::post('enseignant/evaluations/{id}/notes', [EnseignantApiController::class, 'storeNotesBatch']);
    Route::post('enseignant/absences/batch', [EnseignantApiController::class, 'storeAbsencesBatch']);
    Route::put('enseignant/profil', [EnseignantApiController::class, 'updateProfil']);
    // Notifications
    Route::post('notifications/token', [NotificationApiController::class, 'updateToken']);
    Route::get('notifications', [NotificationApiController::class, 'getNotifications']);
});
