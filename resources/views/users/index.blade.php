@extends('layouts.app')

@section('title', 'Gestion des Utilisateurs')
@section('page_title', 'Utilisateurs & Accès')

@section('content')
<div class="card p-4 animate__animated animate__fadeIn">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h5 class="fw-bold mb-0">Liste des utilisateurs</h5>
        <a href="{{ route('users.create') }}" class="btn btn-primary fw-bold">
            <i class='bx bx-user-plus me-1'></i> Nouvel Utilisateur
        </a>
    </div>

    <div class="table-responsive">
        <table class="table table-hover align-middle datatable">
            <thead class="table-light">
                <tr>
                    <th class="border-0 rounded-start">Nom</th>
                    <th class="border-0">Email</th>
                    <th class="border-0">Rôle</th>
                    <th class="border-0">Cycle</th>
                    <th class="border-0">Statut</th>
                    <th class="border-0 rounded-end text-end">Actions</th>
                </tr>
            </thead>
            <tbody>
                @foreach($users as $user)
                <tr>
                    <td>
                        <div class="d-flex align-items-center">
                            <div class="avatar-sm me-3 bg-primary-subtle text-primary rounded-circle d-flex align-items-center justify-content-center fw-bold" style="width: 40px; height: 40px;">
                                {{ strtoupper(substr($user->name, 0, 1)) }}
                            </div>
                            <span class="fw-semibold">{{ $user->name }}</span>
                        </div>
                    </td>
                    <td>{{ $user->email }}</td>
                    <td>
                        @foreach($user->roles as $role)
                            <span class="badge bg-info-subtle text-info border border-info-subtle">{{ ucfirst($role->name) }}</span>
                        @endforeach
                    </td>
                    <td>
                        @if($user->cycle)
                            <span class="badge bg-primary-subtle text-primary">{{ $user->cycle->nom }}</span>
                        @else
                            <span class="badge bg-secondary-subtle text-secondary">Global</span>
                        @endif
                    </td>
                    <td>
                        <span class="badge bg-success-subtle text-success">Actif</span>
                    </td>
                    <td class="text-end">
                        <div class="dropdown">
                            <button class="btn btn-sm btn-light" type="button" data-bs-toggle="dropdown">
                                <i class='bx bx-dots-vertical-rounded'></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end shadow-sm border-0">
                                <li><a class="dropdown-item" href="{{ route('users.edit', $user) }}"><i class='bx bx-edit me-2'></i> Modifier</a></li>
                                <li>
                                    <form action="{{ route('users.toggle', $user) }}" method="POST">
                                        @csrf
                                        <button class="dropdown-item text-warning" type="submit"><i class='bx bx-block me-2'></i> Suspendre</button>
                                    </form>
                                </li>
                                @if($user->id !== auth()->id())
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <form action="{{ route('users.destroy', $user) }}" method="POST" onsubmit="return confirm('Supprimer cet utilisateur ?')">
                                        @csrf @method('DELETE')
                                        <button class="dropdown-item text-danger" type="submit"><i class='bx bx-trash me-2'></i> Supprimer</button>
                                    </form>
                                </li>
                                @endif
                            </ul>
                        </div>
                    </td>
                </tr>
                @endforeach
            </tbody>
        </table>
    </div>
    <div class="mt-3">
        {{-- Pagination DataTables gérée côté client --}}
    </div>
</div>
@endsection
