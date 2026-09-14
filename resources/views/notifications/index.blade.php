@extends('layouts.app')

@section('title', 'Notifications')
@section('page_title', 'Gestion des Notifications')

@section('content')
<div class="row">
    <div class="col-12">
        <div class="card p-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h5 class="fw-bold mb-0"><i class='bx bx-bell me-2 text-primary'></i>Historique des Notifications</h5>
                <a href="{{ route('notifications.create') }}" class="btn btn-primary">
                    <i class='bx bx-send me-1'></i> Envoyer une Notification
                </a>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Date</th>
                            <th>Destinataire</th>
                            <th>Titre</th>
                            <th>Message</th>
                            <th>Type</th>
                            <th>Statut</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($notifications as $notif)
                        <tr>
                            <td>{{ $notif->created_at->format('d/m/Y H:i') }}</td>
                            <td>
                                @if($notif->user)
                                    <div class="d-flex align-items-center">
                                        @if($notif->user->photo)
                                            <img src="{{ asset('storage/' . $notif->user->photo) }}" class="rounded-circle me-2" width="30" height="30">
                                        @else
                                            <div class="rounded-circle bg-light d-flex justify-content-center align-items-center me-2" style="width: 30px; height: 30px;">
                                                <i class='bx bx-user text-muted'></i>
                                            </div>
                                        @endif
                                        <span>{{ $notif->user->name }}</span>
                                    </div>
                                @else
                                    <span class="text-muted"><i class='bx bx-broadcast'></i> À tous</span>
                                @endif
                            </td>
                            <td class="fw-bold">{{ $notif->titre }}</td>
                            <td class="text-truncate" style="max-width: 250px;" title="{{ $notif->message }}">{{ $notif->message }}</td>
                            <td>
                                @if($notif->type == 'alerte' || $notif->type == 'retard' || $notif->type == 'absence')
                                    <span class="badge bg-danger">Alerte</span>
                                @elseif($notif->type == 'paiement')
                                    <span class="badge bg-success">Paiement</span>
                                @elseif($notif->type == 'note')
                                    <span class="badge bg-info">Note</span>
                                @elseif($notif->type == 'convocation')
                                    <span class="badge bg-warning text-dark">Convocation</span>
                                @else
                                    <span class="badge bg-secondary">Info</span>
                                @endif
                            </td>
                            <td>
                                @if($notif->lu)
                                    <span class="text-success"><i class='bx bx-check-double'></i> Lue</span>
                                @else
                                    <span class="text-muted"><i class='bx bx-check'></i> Non lue</span>
                                @endif
                            </td>
                        </tr>
                        @empty
                        <tr>
                            <td colspan="6" class="text-center py-4 text-muted">Aucune notification envoyée.</td>
                        </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
            
            <div class="mt-3">
                {{ $notifications->links() }}
            </div>
        </div>
    </div>
</div>
@endsection
