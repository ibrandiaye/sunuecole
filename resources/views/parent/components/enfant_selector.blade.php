@if($enfants->count() > 1)
    <div class="card border-0 shadow-sm rounded-4 p-3 mb-4 bg-white">
        <div class="d-flex flex-wrap align-items-center justify-content-between gap-3">
            <div class="d-flex align-items-center gap-2">
                <i class='bx bxs-user-check text-primary fs-4'></i>
                <span class="fw-bold small text-muted text-uppercase">Sélectionner un enfant :</span>
            </div>
            <div class="d-flex flex-wrap gap-2">
                @foreach($enfants as $enf)
                    @php
                        $isActive = ($enfantActif && $enfantActif->id === $enf->id);
                        $currentRoute = Route::currentRouteName();
                    @endphp
                    <a href="{{ route($currentRoute, array_merge(request()->query(), ['enfant_id' => $enf->id])) }}" 
                       class="btn btn-sm rounded-pill px-3 py-2 fw-semibold d-flex align-items-center gap-2 {{ $isActive ? 'btn-primary shadow-sm' : 'btn-light border' }}">
                        <div class="rounded-circle {{ $isActive ? 'bg-white text-primary' : 'bg-primary text-white' }} d-flex align-items-center justify-content-center fw-bold" style="width: 22px; height: 22px; font-size: 0.75rem;">
                            {{ strtoupper(substr($enf->prenom, 0, 1)) }}
                        </div>
                        <span>{{ $enf->prenom }} {{ $enf->nom }}</span>
                        <small class="opacity-75 font-monospace">({{ $enf->classe->nom ?? 'N/A' }})</small>
                    </a>
                @endforeach
            </div>
        </div>
    </div>
@endif
