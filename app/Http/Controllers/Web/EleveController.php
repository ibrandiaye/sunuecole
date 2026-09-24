<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Http\Requests\Eleve\StoreEleveRequest;
use App\Http\Requests\Eleve\UpdateEleveRequest;
use App\Models\Eleve;
use App\Models\Classe;
use App\Services\EleveService;
use Illuminate\Http\Request;

use Maatwebsite\Excel\Facades\Excel;
use App\Exports\ElevesTemplateExport;
use App\Imports\ElevesImport;

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
        $zones = \App\Models\ZoneTransport::all();

        return view('eleves.index', compact('eleves', 'selected_classe_id'));
    }

    public function create(Request $request)
    {
        $parents = \App\Models\ParentEleve::with('user')->get();
        $classes = Classe::visible()->where('active', true)->with('niveau')->orderBy('nom')->get();
        $selected_classe_id = $request->get('classe_id');
        $zones = \App\Models\ZoneTransport::all();
        return view('eleves.create', compact('parents', 'classes', 'selected_classe_id', 'zones'));
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
        $zones = \App\Models\ZoneTransport::all();
        $abonnementCantine = \App\Models\AbonnementCantine::where('eleve_id', $eleve->id)->where('actif', true)->first();
        $abonnementTransport = \App\Models\AbonnementTransport::where('eleve_id', $eleve->id)->where('actif', true)->first();
        return view('eleves.edit', compact('eleve', 'classes', 'parents', 'zones', 'abonnementCantine', 'abonnementTransport'));
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

            // Gestion Cantine
            if ($data['avec_cantine']) {
                \App\Models\AbonnementCantine::firstOrCreate([
                    'eleve_id' => $eleve->id,
                    'date_debut' => now(),
                    'actif' => true,
                ]);
            } else {
                \App\Models\AbonnementCantine::where('eleve_id', $eleve->id)->update(['actif' => false]);
            }
            
            // Gestion Transport
            if ($data['avec_transport'] && $request->has('zone_transport_id')) {
                $abT = \App\Models\AbonnementTransport::where('eleve_id', $eleve->id)->where('actif', true)->first();
                if (!$abT) {
                    \App\Models\AbonnementTransport::create([
                        'eleve_id' => $eleve->id,
                        'zone_transport_id' => $request->zone_transport_id,
                        'vehicule_id' => $request->vehicule_id,
                        'date_debut' => now(),
                        'actif' => true,
                    ]);
                } elseif ($abT->zone_transport_id != $request->zone_transport_id || $abT->vehicule_id != $request->vehicule_id) {
                    $abT->update([
                        'zone_transport_id' => $request->zone_transport_id,
                        'vehicule_id' => $request->vehicule_id
                    ]);
                }
            } else {
                \App\Models\AbonnementTransport::where('eleve_id', $eleve->id)->update(['actif' => false]);
            }
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

    public function downloadTemplate()
    {
        return Excel::download(new ElevesTemplateExport, 'modele_import_eleves.xlsx');
    }

    public function import(Request $request)
    {
        $request->validate([
            'fichier_excel' => 'required|mimes:xlsx,xls,csv|max:10240'
        ]);

        try {
            $import = new ElevesImport($this->eleveService);
            Excel::import($import, $request->file('fichier_excel'));
            
            $msg = $import->importedCount . " élève(s) importé(s) avec succès.";
            if (count($import->errors) > 0) {
                $msg .= " Cependant, il y a eu " . count($import->errors) . " erreur(s).";
                return redirect()->route('eleves.index')->with('warning', $msg)->with('import_errors', $import->errors);
            }

            return redirect()->route('eleves.index')->with('success', $msg);
        } catch (\Exception $e) {
            return back()->with('error', 'Erreur lors de l\'importation : ' . $e->getMessage());
        }
    }
}
