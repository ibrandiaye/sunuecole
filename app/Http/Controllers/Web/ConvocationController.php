<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Convocation;
use App\Models\Classe;
use App\Models\Eleve;

class ConvocationController extends Controller
{
    public function index(Request $request)
    {
        $classes = Classe::where('active', true)->get();
        $selected_classe_id = $request->get('classe_id');

        $convocations = collect();
        $eleves = collect();

        if ($selected_classe_id) {
            $classe = Classe::find($selected_classe_id);
            if ($classe) {
                $eleves = Eleve::where('classe_id', $selected_classe_id)->get();
                $eleveIds = $eleves->pluck('id');
                $convocations = Convocation::with('eleve')->whereIn('eleve_id', $eleveIds)->orderBy('date_convocation', 'desc')->get();
            }
        } else {
            $convocations = Convocation::with(['eleve.classe'])->orderBy('date_convocation', 'desc')->get();
        }

        return view('convocations.index', compact('classes', 'selected_classe_id', 'convocations', 'eleves'));
    }

    public function create(Request $request)
    {
        $classes = Classe::where('active', true)->get();
        $selected_classe_id = $request->get('classe_id');
        $eleves = collect();

        if ($selected_classe_id) {
            $eleves = Eleve::where('classe_id', $selected_classe_id)->get();
        }

        return view('convocations.create', compact('classes', 'selected_classe_id', 'eleves'));
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'eleve_id' => 'required|exists:eleves,id',
            'motif' => 'required|string|max:255',
            'description' => 'nullable|string',
            'date_convocation' => 'required|date',
            'parent_informe' => 'boolean'
        ]);

        $data['parent_informe'] = $request->has('parent_informe') ? true : false;

        Convocation::create($data);

        $eleve = Eleve::find($data['eleve_id']);

        return redirect()->route('convocations.index', ['classe_id' => $eleve->classe_id])
            ->with('success', 'Convocation ajoutée avec succès.');
    }

    public function destroy(Convocation $convocation)
    {
        $convocation->delete();
        return back()->with('success', 'Convocation supprimée avec succès.');
    }
}
