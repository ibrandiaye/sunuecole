<?php
$f = 'resources/views/enseignants/show.blade.php';
$c = file_get_contents($f);

// We need to inject after the end of pills-classes tab pane.
// The easiest way is to find `<style>` and inject right before `</div>` block preceding it?
// Let's use str_replace
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

            </div> <!-- End tab-content -->
EOT;

$c = str_replace('            </div>'."\n".'        </div>'."\n".'    </div>'."\n".'</div>'."\n\n".'<style>', $newContent . "\n".'        </div>'."\n".'    </div>'."\n".'</div>'."\n\n".'<style>', $c);
file_put_contents($f, $c);
