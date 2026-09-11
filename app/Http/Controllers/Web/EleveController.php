<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Http\Requests\Eleve\StoreEleveRequest;
use App\Http\Requests\Eleve\UpdateEleveRequest;
use App\Models\Eleve;
use App\Models\Classe;
use App\Services\EleveService;
use Illuminate\Http\Request;

class EleveController extends Controller
{
    protected $eleveService;

    public function __construct(EleveService $eleveService)
    {
        $this->eleveService = $eleveService;
    }

    public function index(Request $request)
    {
        $query = Eleve::visible()->with('classe.niveau')->latest();

        if ($request->has('classe_id')) {
            $query->where('classe_id', $request->classe_id);
        }

        $eleves = $query->paginate(15)->appends($request->all());
        $selected_classe_id = $request->get('classe_id');

        return view('eleves.index', compact('eleves', 'selected_classe_id'));
    }

    public function create(Request $request)
    {
        $parents = \App\Models\ParentEleve::with('user')->get();
        $classes = Classe::visible()->where('active', true)->with('niveau')->orderBy('nom')->get();
        $selected_classe_id = $request->get('classe_id');
        return view('eleves.create', compact('parents', 'classes', 'selected_classe_id'));
    }

    public function store(StoreEleveRequest $request)
    {
        $data = $request->validated();
        $data['avec_cantine'] = $request->boolean('avec_cantine');
        $data['avec_transport'] = $request->boolean('avec_transport');
        
        if ($request->hasFile('photo')) {
            $data['photo'] = $request->file('photo')->store('eleves/photos', 'public');
        }

        $eleve = $this->eleveService->register($data);

        return redirect()->route('eleves.index')
            ->with('success', "L'élève {$eleve->prenom} {$eleve->nom} (Matricule: {$eleve->matricule}) a été enregistré avec succès !");
    }

    public function show(Eleve $eleve)
    {
        $eleve->load([
            'classe.niveau', 
            'parent.user', 
            'notes.matiere',
            'absences',
            'convocations',
            'bulletins.anneeScolaire',
            'paiements.recu'
        ]);

        $moyenne = $eleve->notes->avg('valeur');

        return view('eleves.show', compact('eleve', 'moyenne'));
    }

    public function edit(Eleve $eleve)
    {
        $eleve->load('inscriptionActuelle');
        $classes = Classe::visible()->where('active', true)->with('niveau')->orderBy('nom')->get();
        $parents = \App\Models\ParentEleve::with('user')->get();
        return view('eleves.edit', compact('eleve', 'classes', 'parents'));
    }

    public function update(UpdateEleveRequest $request, Eleve $eleve)
    {
        $data = $request->validated();
        $data['avec_cantine'] = $request->boolean('avec_cantine');
        $data['avec_transport'] = $request->boolean('avec_transport');

        if ($request->hasFile('photo')) {
            $data['photo'] = $request->file('photo')->store('eleves/photos', 'public');
        }

        // Si un parent existant est sélectionné, mettre à jour les infos tuteur
        if (!empty($data['parent_id'])) {
            $parent = \App\Models\ParentEleve::with('user')->find($data['parent_id']);
            if ($parent) {
                $data['nom_tuteur'] = $parent->user->name ?? $data['nom_tuteur'] ?? null;
                $data['tel_tuteur'] = $parent->telephone ?? $parent->user->telephone ?? $data['tel_tuteur'] ?? null;
                $data['email_tuteur'] = $parent->user->email ?? $data['email_tuteur'] ?? null;
                $data['relation_tuteur'] = $parent->relation ?? $data['relation_tuteur'] ?? 'parent';
            }
        }

        $eleve->update($data);

        $activeYear = \App\Models\AnneeScolaire::where('active', true)->first();
        if ($activeYear && !empty($eleve->classe_id)) {
            \App\Models\Inscription::updateOrCreate(
                [
                    'eleve_id' => $eleve->id,
                    'annee_scolaire_id' => $activeYear->id,
                ],
                [
                    'classe_id' => $eleve->classe_id,
                    'remise_inscription' => $data['remise_inscription'] ?? 0,
                    'remise_mensualite' => $data['remise_mensualite'] ?? 0,
                    'avec_cantine' => $data['avec_cantine'],
                    'avec_transport' => $data['avec_transport'],
                    'statut' => $data['statut'] ?? 'actif',
                    'date_inscription' => now(),
                ]
            );
        }

        return redirect()->route('eleves.index')
            ->with('success', 'Informations de l\'élève mises à jour !');
    }

    public function destroy(Eleve $eleve)
    {
        $eleve->delete();
        return redirect()->route('eleves.index')
            ->with('success', 'Élève supprimé avec succès.');
    }
}
