@extends('layouts.app')

@section('title', 'Envoyer une Notification')
@section('page_title', 'Nouvelle Notification')

@section('content')
<div class="row justify-content-center animate__animated animate__fadeIn">
    <div class="col-md-8">
        <div class="card p-4">
            <h5 class="fw-bold mb-4"><i class='bx bx-send me-2 text-primary'></i>Envoyer une Notification (Web & Mobile)</h5>

            <form action="{{ route('notifications.store') }}" method="POST">
                @csrf
                <div class="mb-3">
                    <label class="form-label">Destinataire</label>
                    <select name="user_id" class="form-select select2">
                        <option value="">Tous les utilisateurs (Envoi massif)</option>
                        @foreach($users as $user)
                            <option value="{{ $user->id }}">{{ $user->name }} ({{ $user->email }})</option>
                        @endforeach
                    </select>
                    <div class="form-text">Laissez vide pour envoyer à tout le monde.</div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Type de Notification</label>
                    <select name="type" class="form-select" required>
                        <option value="info">Information générale</option>
                        <option value="alerte">Alerte / Urgence</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Titre</label>
                    <input type="text" name="titre" class="form-control" required placeholder="Ex: Réunion des parents d'élèves">
                </div>

                <div class="mb-3">
                    <label class="form-label">Message</label>
                    <textarea name="message" rows="4" class="form-control" required placeholder="Saisissez le contenu de votre message..."></textarea>
                </div>

                <div class="d-flex justify-content-between mt-4">
                    <a href="{{ route('notifications.index') }}" class="btn btn-secondary">Annuler</a>
                    <button type="submit" class="btn btn-primary"><i class='bx bx-paper-plane me-1'></i> Envoyer la notification</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection
