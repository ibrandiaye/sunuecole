<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Document;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class DocumentController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'nom' => 'required|string|max:255',
            'type_document' => 'nullable|string|max:100',
            'fichier' => 'required|file|mimes:pdf,jpg,jpeg,png|max:5120', // 5MB max
            'documentable_id' => 'required|integer',
            'documentable_type' => 'required|string',
        ]);

        $file = $request->file('fichier');
        $path = $file->store('documents', 'public');

        Document::create([
            'nom' => $request->nom,
            'type_document' => $request->type_document,
            'fichier_path' => $path,
            'documentable_id' => $request->documentable_id,
            'documentable_type' => $request->documentable_type,
            'uploaded_by' => auth()->id(),
        ]);

        return back()->with('success', 'Document ajouté avec succès.');
    }

    public function destroy(Document $document)
    {
        if (Storage::disk('public')->exists($document->fichier_path)) {
            Storage::disk('public')->delete($document->fichier_path);
        }
        
        $document->delete();
        
        return back()->with('success', 'Document supprimé avec succès.');
    }
}