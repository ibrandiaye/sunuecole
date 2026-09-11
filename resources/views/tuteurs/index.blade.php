@extends('layouts.app')

@section('title', 'Gestion des Tuteurs')
@section('page_title', "Tuteurs & Parents d'Élèves")

@section('content')
<div class="card p-4 animate__animated animate__fadeIn">

    {{-- En-tête --}}
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h5 class="fw-bold mb-0">
            <i class='bx bxs-user-account me-2 text-primary'></i>
            Tuteurs / Parents enregistrés
        </h5>
        <span class="badge bg-primary-subtle text-primary fs-6 px-3 py-2 rounded-pill">
            {{ $tuteurs->count() }} tuteur{{ $tuteurs->count() > 1 ? 's' : '' }}
        </span>
    </div>

    @if(session('success'))
        <div class="alert alert-success border-0 rounded-4 shadow-sm mb-4">
            <i class='bx bx-check-circle me-2'></i>{{ session('success') }}
        </div>
    @endif

    {{-- Filtres --}}
    <form method="GET" action="{{ route('tuteurs.index') }}" class="row g-3 mb-4">
        <div class="col-md-5">
            <div class="input-group">
                <span class="input-group-text bg-white border-end-0">
                    <i class='bx bx-search text-muted'></i>
                </span>
                <input type="text" name="search" class="form-control border-start-0"
                       placeholder="Rechercher par nom, email, téléphone, NIN..."
                       value="{{ $search }}">
            </div>
        </div>
        <div class="col-md-2">
            <select name="relation" class="form-select" onchange="this.form.submit()">
                <option value="">-- Toutes relations --</option>
                <option value="parent"  {{ $relation === 'parent'  ? 'selected' : '' }}>Parent</option>
                <option value="tuteur"  {{ $relation === 'tuteur'  ? 'selected' : '' }}>Tuteur</option>
                <option value="gardien" {{ $relation === 'gardien' ? 'selected' : '' }}>Gardien</option>
            </select>
        </div>
        <div class="col-md-2">
            <select name="statut" class="form-select" onchange="this.form.submit()">
                <option value="tous"    {{ $statut === 'tous'    ? 'selected' : '' }}>Tous</option>
                <option value="actif"   {{ $statut === 'actif'   ? 'selected' : '' }}>Actifs</option>
                <option value="inactif" {{ $statut === 'inactif' ? 'selected' : '' }}>Inactifs</option>
            </select>
        </div>
        <div class="col-md-3 d-flex gap-2">
            <button type="submit" class="btn btn-primary flex-fill">
                <i class='bx bx-filter-alt me-1'></i> Filtrer
            </button>
            <a href="{{ route('tuteurs.index') }}" class="btn btn-light border" title="Réinitialiser">
                <i class='bx bx-reset'></i>
            </a>
        </div>
    </form>

    <hr class="opacity-25 mb-3">

    {{-- Tableau --}}
    @if($tuteurs->isEmpty())
        <div class="text-center py-5">
            <i class='bx bx-user-x fs-1 text-muted mb-3 d-block'></i>
            <h5 class="text-muted fw-semibold">Aucun tuteur trouvé</h5>
            <p class="text-muted">Modifiez vos critères ou ajoutez des tuteurs via la fiche élève.</p>
        </div>
    @else
        <div class="table-responsive">
            <table class="table table-hover align-middle datatable">
                <thead class="bg-light">
                    <tr>
                        <th>TUTEUR</th>
                        <th>CONTACT</th>
                        <th>RELATION</th>
                        <th>PROFESSION</th>
                        <th>ÉLÈVES LIÉS</th>
                        <th class="text-center">STATUT</th>
                        <th class="text-end">ACTIONS</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($tuteurs as $tuteur)
                        @php $user = $tuteur->user; @endphp
                        <tr>
                            {{-- Photo + Nom --}}
                            <td>
                                <div class="d-flex align-items-center">
                                    @if($tuteur->photo)
                                        <img src="{{ asset('storage/' . $tuteur->photo) }}"
                                             class="rounded-circle me-2 flex-shrink-0 border"
                                             width="42" height="42" style="object-fit:cover;">
                                    @else
                                        <div class="rounded-circle bg-primary bg-opacity-10 text-primary d-flex align-items-center justify-content-center me-2 fw-bold flex-shrink-0"
                                             style="width:42px;height:42px;font-size:.85rem;">
                                            {{ strtoupper(substr($user?->name ?? '?', 0, 2)) }}
                                        </div>
                                    @endif
                                    <div>
                                        <div class="fw-semibold">{{ $user?->name ?? '—' }}</div>
                                        <small class="text-muted">{{ $user?->email ?? '' }}</small>
                                    </div>
                                </div>
                            </td>

                            {{-- Contact --}}
                            <td>
                                @if($tuteur->telephone)
                                    <div><i class='bx bx-phone-call text-success me-1'></i>{{ $tuteur->telephone }}</div>
                                @endif
                                @if($tuteur->adresse)
                                    <small class="text-muted d-block">
                                        <i class='bx bx-map-pin me-1'></i>{{ Str::limit($tuteur->adresse, 35) }}
                                    </small>
                                @endif
                                @if($tuteur->nin)
                                    <small class="text-muted d-block">
                                        <i class='bx bx-id-card me-1'></i>NIN: {{ $tuteur->nin }}
                                    </small>
                                @endif
                            </td>

                            {{-- Relation --}}
                            <td>
                                @php
                                    $relColors = ['parent' => 'primary', 'tuteur' => 'info', 'gardien' => 'warning'];
                                    $color = $relColors[$tuteur->relation ?? 'parent'] ?? 'secondary';
                                @endphp
                                <span class="badge bg-{{ $color }}-subtle text-{{ $color }} border border-{{ $color }}-subtle rounded-pill px-2 py-1">
                                    {{ ucfirst($tuteur->relation ?? 'parent') }}
                                </span>
                            </td>

                            {{-- Profession --}}
                            <td class="text-muted">
                                {{ $tuteur->profession ? Str::limit($tuteur->profession, 30) : '—' }}
                            </td>

                            {{-- Élèves liés --}}
                            <td>
                                @if($tuteur->eleves->isEmpty())
                                    <span class="text-muted small fst-italic">Aucun élève</span>
                                @else
                                    <div class="d-flex flex-wrap gap-1">
                                        @foreach($tuteur->eleves->take(3) as $eleve)
                                            <a href="{{ route('eleves.show', $eleve->id) }}"
                                               class="badge bg-light text-dark border text-decoration-none"
                                               title="{{ $eleve->nom }} {{ $eleve->prenom }}">
                                                <i class='bx bx-user me-1'></i>{{ $eleve->prenom }} {{ $eleve->nom }}
                                                @if($eleve->classe)
                                                    <span class="opacity-50">({{ $eleve->classe->nom }})</span>
                                                @endif
                                            </a>
                                        @endforeach
                                        @if($tuteur->eleves->count() > 3)
                                            <span class="badge bg-secondary-subtle text-secondary border">
                                                +{{ $tuteur->eleves->count() - 3 }} autre(s)
                                            </span>
                                        @endif
                                    </div>
                                @endif
                            </td>

                            {{-- Statut --}}
                            <td class="text-center">
                                @if($tuteur->actif)
                                    <span class="badge bg-success-subtle text-success px-2 py-1 rounded-pill">
                                        <i class='bx bx-check-circle me-1'></i>Actif
                                    </span>
                                @else
                                    <span class="badge bg-danger-subtle text-danger px-2 py-1 rounded-pill">
                                        <i class='bx bx-x-circle me-1'></i>Inactif
                                    </span>
                                @endif
                            </td>

                            {{-- Actions --}}
                            <td class="text-end">
                                <div class="d-flex gap-2 justify-content-end">
                                    <a href="{{ route('tuteurs.edit', $tuteur->id) }}"
                                       class="btn btn-sm btn-outline-primary" title="Modifier">
                                        <i class='bx bx-edit'></i>
                                    </a>
                                    <form action="{{ route('tuteurs.toggle', $tuteur->id) }}" method="POST" class="d-inline">
                                        @csrf
                                        <button type="submit"
                                            class="btn btn-sm {{ $tuteur->actif ? 'btn-outline-danger' : 'btn-outline-success' }}"
                                            title="{{ $tuteur->actif ? 'Désactiver' : 'Activer' }}"
                                            onclick="return confirm('{{ $tuteur->actif ? 'Désactiver' : 'Activer' }} ce tuteur ?')">
                                            <i class='bx {{ $tuteur->actif ? "bx-block" : "bx-check" }}'></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    @endif
</div>
@endsection
