<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Eleve;
use App\Models\Note;
use App\Models\Classe;
use App\Models\Matiere;
use App\Models\AnneeScolaire;
use App\Models\Etablissement;
use Illuminate\Http\Request;
use Barryvdh\DomPDF\Facade\Pdf;
use SimpleSoftwareIO\QrCode\Facades\QrCode;

class BulletinController extends Controller
{
    public function index(Request $request)
    {
        $classes = Classe::where('active', true)->get();
        $selected_classe_id = $request->get('classe_id');
        $periode = $request->get('periode', 'Premier Semestre');

        $eleves = [];
        if ($selected_classe_id) {
            $eleves = Eleve::where('classe_id', $selected_classe_id)->get();
        }

        return view('bulletins.index', compact('classes', 'eleves', 'selected_classe_id', 'periode'));
    }

    public function generate(Eleve $eleve, Request $request)
    {
        $periode = $request->get('periode', 'Premier Semestre');
        $eleve->load(['classe.niveau', 'classe.matieres', 'anneeScolaire']);

        $etablissement = Etablissement::first();
        $formule = $etablissement ? $etablissement->formule_bulletin : '(M+C)/2';
        
        $classeMatieres = $eleve->classe->matieres->keyBy('id');

        // 1. Calculer la moyenne de cet élève
        $notes = Note::where('eleve_id', $eleve->id)
            ->where('periode', $periode)
            ->with('matiere')
            ->get();

        $results = $notes->groupBy('matiere_id')->map(function ($items) use ($formule, $classeMatieres) {
            $matiere_id = $items->first()->matiere_id;
            $matiere = $items->first()->matiere;
            $devoirs = $items->where('type_evaluation', 'devoir');
            $composition = $items->where('type_evaluation', 'composition')->first();

            $moyenne_devoirs = $devoirs->avg('valeur') ?: 0;
            $note_composition = $composition ? $composition->valeur : $moyenne_devoirs;

            if ($formule == '(M+2C)/3') {
                $moyenne_matiere = ($moyenne_devoirs + ($note_composition * 2)) / 3;
            } else {
                $moyenne_matiere = ($moyenne_devoirs + $note_composition) / 2;
            }

            // Récupération du coefficient spécifique à la classe (override)
            $coefficient = $classeMatieres->has($matiere_id) && $classeMatieres[$matiere_id]->pivot->coefficient_override 
                ? $classeMatieres[$matiere_id]->pivot->coefficient_override 
                : $matiere->coefficient;

            $points = $moyenne_matiere * $coefficient;
            $coeff_to_add = $coefficient;

            // Logique des matières facultatives (optionnelles)
            if ($matiere->type == 'optionnel') {
                if ($moyenne_matiere > 10) {
                    $points = ($moyenne_matiere - 10) * $coefficient;
                } else {
                    $points = 0;
                }
                $coeff_to_add = 0; // Ne compte pas dans le diviseur
            }

            return [
                'matiere' => $matiere->nom,
                'code' => $matiere->code,
                'moyenne_devoirs' => round($moyenne_devoirs, 2),
                'note_composition' => round($note_composition, 2),
                'moyenne' => round($moyenne_matiere, 2),
                'coefficient' => $coefficient,
                'coeff_to_add' => $coeff_to_add,
                'points' => round($points, 2),
                'type' => $matiere->type
            ];
        });

        $total_points = $results->sum('points');
        $total_coefficients = $results->sum('coeff_to_add');
        $moyenne_generale = $total_coefficients > 0 ? round($total_points / $total_coefficients, 2) : 0;

        // 2. Calcul du Rang (Comparaison avec tous les élèves de la classe)
        $all_eleves = Eleve::where('classe_id', $eleve->classe_id)->get();
        $class_averages = [];

        foreach ($all_eleves as $e) {
            $e_notes = Note::where('eleve_id', $e->id)->where('periode', $periode)->with('matiere')->get();
            if ($e_notes->count() > 0) {
                $e_results = $e_notes->groupBy('matiere_id')->map(function ($items) use ($formule, $classeMatieres) {
                    $matiere_id = $items->first()->matiere_id;
                    $matiere = $items->first()->matiere;
                    $m_devoirs = $items->where('type_evaluation', 'devoir')->avg('valeur') ?: 0;
                    $m_composition = $items->where('type_evaluation', 'composition')->first()?->valeur ?: $m_devoirs;
                    
                    if ($formule == '(M+2C)/3') {
                        $m_moyenne = ($m_devoirs + ($m_composition * 2)) / 3;
                    } else {
                        $m_moyenne = ($m_devoirs + $m_composition) / 2;
                    }

                    $coefficient = $classeMatieres->has($matiere_id) && $classeMatieres[$matiere_id]->pivot->coefficient_override 
                        ? $classeMatieres[$matiere_id]->pivot->coefficient_override 
                        : $matiere->coefficient;
                        
                    $points = $m_moyenne * $coefficient;
                    $coeff_to_add = $coefficient;

                    if ($matiere->type == 'optionnel') {
                        $points = $m_moyenne > 10 ? ($m_moyenne - 10) * $coefficient : 0;
                        $coeff_to_add = 0;
                    }

                    return ['points' => $points, 'coeff' => $coeff_to_add];
                });
                $e_moyenne_gen = $e_results->sum('coeff') > 0 ? $e_results->sum('points') / $e_results->sum('coeff') : 0;
                $class_averages[$e->id] = round($e_moyenne_gen, 2);
            }
        }
        arsort($class_averages);
        $ranks = array_keys($class_averages);
        $rang = array_search($eleve->id, $ranks) !== false ? array_search($eleve->id, $ranks) + 1 : '-';

        // 3. Calcul Moyenne Annuelle (si 2ème semestre ou 3ème trimestre)
        $moyenne_annuelle = null;
        if ($periode == 'Second Semestre' || $periode == 'Troisième Trimestre') {
            $history = \App\Models\Bulletin::where('eleve_id', $eleve->id)
                ->where('annee_scolaire_id', $eleve->annee_scolaire_id)
                ->pluck('moyenne_generale')
                ->push($moyenne_generale);
            $moyenne_annuelle = round($history->avg(), 2);
        }

        // 4. Générer le QR Code
        $token = bin2hex(random_bytes(16));
        $verificationUrl = route('bulletins.verify', ['token' => $token]);
        $qrcode = base64_encode(QrCode::format('svg')->size(100)->generate($verificationUrl));

        // 5. Préparer les données
        $data = [
            'eleve' => $eleve,
            'periode' => $periode,
            'results' => $results,
            'moyenne_generale' => $moyenne_generale,
            'moyenne_annuelle' => $moyenne_annuelle,
            'rang' => $rang,
            'effectif' => count($class_averages),
            'qrcode' => $qrcode,
            'date' => date('d/m/Y'),
        ];

        $pdf = Pdf::loadView('bulletins.template', $data)->setPaper('a4', 'portrait');
        $filename = "bulletins/bulletin_{$eleve->id}_{$token}.pdf";
        \Illuminate\Support\Facades\Storage::disk('public')->put($filename, $pdf->output());

        // 6. Enregistrer en base
        \App\Models\Bulletin::updateOrCreate(
            ['eleve_id' => $eleve->id, 'trimestre' => ($periode == 'Premier Semestre' ? 1 : ($periode == 'Second Semestre' ? 2 : 3)), 'annee_scolaire_id' => $eleve->annee_scolaire_id],
            [
                'classe_id' => $eleve->classe_id,
                'moyenne_generale' => $moyenne_generale,
                'rang' => (is_numeric($rang) ? $rang : null),
                'effectif_classe' => count($class_averages),
                'pdf_path' => $filename,
                'token_verification' => $token,
                'publie' => true,
                'date_publication' => now()
            ]
        );
        
        return $pdf->download("bulletin_{$eleve->matricule}_{$periode}.pdf");
    }

    /**
     * Génère tous les bulletins des élèves d'une classe en un seul document PDF.
     */
    public function generateClasse(Classe $classe, Request $request)
    {
        ini_set('max_execution_time', 300);
        ini_set('memory_limit', '512M');

        $periode = $request->get('periode', 'Premier Semestre');
        $classe->load(['niveau', 'matieres', 'anneeScolaire']);

        $etablissement = Etablissement::first();
        $formule = $etablissement ? $etablissement->formule_bulletin : '(M+C)/2';
        $classeMatieres = $classe->matieres->keyBy('id');

        $eleves = Eleve::where('classe_id', $classe->id)
            ->with(['anneeScolaire', 'classe.niveau'])
            ->orderBy('nom')
            ->orderBy('prenom')
            ->get();

        if ($eleves->isEmpty()) {
            return back()->with('error', 'Aucun élève trouvé dans cette classe.');
        }

        // Récupérer toutes les notes de la classe pour la période en une seule requête
        $eleveIds = $eleves->pluck('id');
        $allNotes = Note::whereIn('eleve_id', $eleveIds)
            ->where('periode', $periode)
            ->with('matiere')
            ->get()
            ->groupBy('eleve_id');

        // 1. Calculs des moyennes par élève
        $class_averages = [];
        $studentCalculations = [];

        foreach ($eleves as $eleve) {
            $notes = $allNotes->get($eleve->id, collect());

            $results = $notes->groupBy('matiere_id')->map(function ($items) use ($formule, $classeMatieres) {
                $matiere_id = $items->first()->matiere_id;
                $matiere = $items->first()->matiere;
                $devoirs = $items->where('type_evaluation', 'devoir');
                $composition = $items->where('type_evaluation', 'composition')->first();

                $moyenne_devoirs = $devoirs->avg('valeur') ?: 0;
                $note_composition = $composition ? $composition->valeur : $moyenne_devoirs;

                if ($formule == '(M+2C)/3') {
                    $moyenne_matiere = ($moyenne_devoirs + ($note_composition * 2)) / 3;
                } else {
                    $moyenne_matiere = ($moyenne_devoirs + $note_composition) / 2;
                }

                $coefficient = $classeMatieres->has($matiere_id) && $classeMatieres[$matiere_id]->pivot->coefficient_override 
                    ? $classeMatieres[$matiere_id]->pivot->coefficient_override 
                    : ($matiere ? $matiere->coefficient : 1);

                $points = $moyenne_matiere * $coefficient;
                $coeff_to_add = $coefficient;

                if ($matiere && $matiere->type == 'optionnel') {
                    $points = $moyenne_matiere > 10 ? ($moyenne_matiere - 10) * $coefficient : 0;
                    $coeff_to_add = 0;
                }

                return [
                    'matiere' => $matiere ? $matiere->nom : 'Discipline',
                    'code' => $matiere ? $matiere->code : '',
                    'moyenne_devoirs' => round($moyenne_devoirs, 2),
                    'note_composition' => round($note_composition, 2),
                    'moyenne' => round($moyenne_matiere, 2),
                    'coefficient' => $coefficient,
                    'coeff_to_add' => $coeff_to_add,
                    'points' => round($points, 2),
                    'type' => $matiere ? $matiere->type : 'obligatoire'
                ];
            });

            $total_points = $results->sum('points');
            $total_coefficients = $results->sum('coeff_to_add');
            $moyenne_generale = $total_coefficients > 0 ? round($total_points / $total_coefficients, 2) : 0;

            $studentCalculations[$eleve->id] = [
                'results' => $results,
                'moyenne_generale' => $moyenne_generale,
            ];

            if ($notes->isNotEmpty()) {
                $class_averages[$eleve->id] = $moyenne_generale;
            }
        }

        // 2. Classement des élèves
        arsort($class_averages);
        $ranks = array_keys($class_averages);

        // 3. Préparer les données pour chaque bulletin et enregistrer en base
        $bulletinsData = [];
        $trimestreNum = ($periode == 'Premier Semestre' ? 1 : ($periode == 'Second Semestre' ? 2 : 3));

        foreach ($eleves as $eleve) {
            $calc = $studentCalculations[$eleve->id];
            $rang = array_search($eleve->id, $ranks) !== false ? array_search($eleve->id, $ranks) + 1 : '-';

            // Moyenne annuelle si applicable
            $moyenne_annuelle = null;
            if ($periode == 'Second Semestre' || $periode == 'Troisième Trimestre') {
                $history = \App\Models\Bulletin::where('eleve_id', $eleve->id)
                    ->where('annee_scolaire_id', $eleve->annee_scolaire_id)
                    ->pluck('moyenne_generale')
                    ->push($calc['moyenne_generale']);
                $moyenne_annuelle = round($history->avg(), 2);
            }

            // Token & QR Code
            $token = bin2hex(random_bytes(16));
            $verificationUrl = route('bulletins.verify', ['token' => $token]);
            $qrcode = base64_encode(QrCode::format('svg')->size(100)->generate($verificationUrl));

            // Enregistrer ou mettre à jour dans la table bulletins
            \App\Models\Bulletin::updateOrCreate(
                [
                    'eleve_id' => $eleve->id, 
                    'trimestre' => $trimestreNum, 
                    'annee_scolaire_id' => $eleve->annee_scolaire_id
                ],
                [
                    'classe_id' => $eleve->classe_id,
                    'moyenne_generale' => $calc['moyenne_generale'],
                    'rang' => is_numeric($rang) ? $rang : null,
                    'effectif_classe' => count($class_averages),
                    'token_verification' => $token,
                    'publie' => true,
                    'date_publication' => now()
                ]
            );

            $bulletinsData[] = [
                'eleve' => $eleve,
                'periode' => $periode,
                'results' => $calc['results'],
                'moyenne_generale' => $calc['moyenne_generale'],
                'moyenne_annuelle' => $moyenne_annuelle,
                'rang' => $rang,
                'effectif' => count($class_averages),
                'qrcode' => $qrcode,
                'date' => date('d/m/Y'),
            ];
        }

        $nomClasse = \Illuminate\Support\Str::slug($classe->nom, '_');
        $nomPeriode = \Illuminate\Support\Str::slug($periode, '_');
        $filename = "bulletins_{$nomClasse}_{$nomPeriode}.pdf";

        $pdf = Pdf::loadView('bulletins.classe_batch', [
            'bulletins' => $bulletinsData,
            'classe' => $classe,
            'periode' => $periode,
            'etablissement' => $etablissement,
        ])->setPaper('a4', 'portrait');

        return $pdf->download($filename);
    }

    public function verify($token)
    {
        $bulletin = \App\Models\Bulletin::where('token_verification', $token)->with('eleve.classe')->firstOrFail();
        return view('bulletins.verify', compact('bulletin'));
    }
}
