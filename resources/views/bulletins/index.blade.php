@extends('layouts.app')

@section('title', 'Gestion des Bulletins')
@section('page_title', 'Édition des Bulletins')

@section('content')
<div class="row animate__animated animate__fadeIn">
    <div class="col-md-12 mb-4">
        <div class="card p-3 shadow-sm border-0">
            <form action="{{ route('bulletins.index') }}" method="GET" class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label fw-bold small text-muted">FILTRER PAR CLASSE</label>
                    <select name="classe_id" class="form-select border-0 bg-light" required onchange="this.form.submit()">
                        <option value="">-- Choisir une classe --</option>
                        @foreach($classes as $classe)
                            <option value="{{ $classe->id }}" {{ $selected_classe_id == $classe->id ? 'selected' : '' }}>
                                {{ $classe->nom }}
                            </option>
                        @endforeach
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-bold small text-muted">PÉRIODE SCOLAIRE</label>
                    <select name="periode" class="form-select border-0 bg-light" onchange="this.form.submit()">
                        <option value="Premier Semestre" {{ $periode == 'Premier Semestre' ? 'selected' : '' }}>Premier Semestre</option>
                        <option value="Second Semestre" {{ $periode == 'Second Semestre' ? 'selected' : '' }}>Second Semestre</option>
                    </select>
                </div>
            </form>
        </div>
    </div>

    @if($selected_classe_id)
    <div class="col-md-12">
        <div class="card p-4 border-0 shadow-sm">
            <h5 class="fw-bold mb-4">Élèves de la classe : <span class="text-primary">{{ $classes->find($selected_classe_id)->nom }}</span></h5>
            
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Matricule</th>
                            <th>Nom Complet</th>
                            <th>Sexe</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($eleves as $eleve)
                        <tr>
                            <td class="fw-bold">{{ $eleve->matricule }}</td>
                            <td>{{ $eleve->prenom }} {{ $eleve->nom }}</td>
                            <td>{{ $eleve->sexe }}</td>
                            <td class="text-end">
                                <a href="{{ route('bulletins.generate', ['eleve' => $eleve->id, 'periode' => $periode]) }}" class="btn btn-sm btn-primary rounded-pill">
                                    <i class='bx bxs-file-pdf me-1'></i> Générer Bulletin
                                </a>
                            </td>
                        </tr>
                        @empty
                        <tr>
                            <td colspan="4" class="text-center py-4">Aucun élève dans cette classe.</td>
                        </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    @endif
</div>
@endsection
