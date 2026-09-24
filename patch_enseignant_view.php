<?php
$f = 'resources/views/enseignants/show.blade.php';
$c = file_get_contents($f);

// Add tab button
$newTab = <<<EOT
                <li class="nav-item" role="presentation">
                    <button class="nav-link rounded-pill px-4" id="pills-documents-tab" data-bs-toggle="pill" data-bs-target="#pills-documents" type="button" role="tab">Documents</button>
                </li>
            </ul>
EOT;
$c = str_replace('</ul>', $newTab, $c);

// Add tab content
$newContent = <<<EOT
                <!-- Documents -->
                <div class="tab-pane fade" id="pills-documents" role="tabpanel">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h5 class="mb-0 fw-bold"><i class='bx bx-folder-open text-primary me-2'></i> Documents Administratifs</h5>
                        <button type="button" class="btn btn-sm btn-primary rounded-pill px-3 shadow-sm" data-bs-toggle="modal" data-bs-target="#addDocumentModal">
                            <i class='bx bx-upload me-1'></i> Ajouter un document
                        </button>
                    </div>

                    @if(\$enseignant->documents->isEmpty())
                        <div class="text-center py-5 bg-light rounded-4 border-dashed">
                            <i class='bx bx-file-blank text-muted' style="font-size: 3rem;"></i>
                            <p class="text-muted mt-2 mb-0">Aucun document n'a été ajouté pour le moment.</p>
                        </div>
                    @else
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead>
                                    <tr>
                                        <th>Nom du document</th>
                                        <th>Type</th>
                                        <th>Date d'ajout</th>
                                        <th class="text-end">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach(\$enseignant->documents as \$doc)
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="bg-light p-2 rounded-3 me-3 text-primary">
                                                    <i class='bx bxs-file-pdf fs-5'></i>
                                                </div>
                                                <span class="fw-semibold">{{ \$doc->nom }}</span>
                                            </div>
                                        </td>
                                        <td><span class="badge bg-secondary text-capitalize">{{ \$doc->type_document ?? 'Document' }}</span></td>
                                        <td>{{ \$doc->created_at->format('d/m/Y') }}</td>
                                        <td class="text-end">
                                            <a href="{{ Storage::url(\$doc->fichier_path) }}" target="_blank" class="btn btn-sm btn-light text-primary rounded-circle" title="Voir le document">
                                                <i class='bx bx-show'></i>
                                            </a>
                                            <form action="{{ route('documents.destroy', \$doc) }}" method="POST" class="d-inline" onsubmit="return confirm('Supprimer ce document ?');">
                                                @csrf @method('DELETE')
                                                <button type="submit" class="btn btn-sm btn-light text-danger rounded-circle" title="Supprimer">
                                                    <i class='bx bx-trash'></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    @endif
                </div>

            </div>
EOT;
$c = preg_replace('/<\/div>\s*$/', $newContent . "\n\n</div>", $c);

// Add the modal at the end of the file before @endsection
$modal = <<<EOT

<!-- Modal Add Document -->
<div class="modal fade" id="addDocumentModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <form action="{{ route('documents.store') }}" method="POST" enctype="multipart/form-data">
                @csrf
                <input type="hidden" name="documentable_id" value="{{ \$enseignant->id }}">
                <input type="hidden" name="documentable_type" value="{{ get_class(\$enseignant) }}">
                
                <div class="modal-header border-0 pb-0">
                    <h5 class="modal-title fw-bold">Ajouter un document</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body py-4">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Nom du document</label>
                        <input type="text" name="nom" class="form-control" placeholder="ex: Contrat de travail" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Type de document</label>
                        <select name="type_document" class="form-select">
                            <option value="contrat">Contrat</option>
                            <option value="cv">CV</option>
                            <option value="diplome">Diplôme / Attestation</option>
                            <option value="identite">Pièce d'identité</option>
                            <option value="autre">Autre document administratif</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Fichier (PDF, JPG, PNG)</label>
                        <input type="file" name="fichier" class="form-control" accept=".pdf,.jpg,.jpeg,.png" required>
                    </div>
                </div>
                <div class="modal-footer border-0 bg-light rounded-bottom-3">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-primary px-4 shadow-sm">Enregistrer</button>
                </div>
            </form>
        </div>
    </div>
</div>

@endsection
EOT;
$c = str_replace('@endsection', $modal, $c);

// Wait, the previous replacement `/<\/div>\s*$/` is wrong because there are many divs and `@endsection` at the end!
// Let's replace carefully using the DOM structure.
