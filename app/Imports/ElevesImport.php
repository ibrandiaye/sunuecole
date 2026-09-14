<?php
namespace App\Imports;

use App\Services\EleveService;
use App\Models\Classe;
use Illuminate\Support\Collection;
use Maatwebsite\Excel\Concerns\ToCollection;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Illuminate\Support\Facades\Log;

class ElevesImport implements ToCollection, WithHeadingRow
{
    protected $eleveService;
    public $importedCount = 0;
    public $errors = [];

    public function __construct(EleveService $eleveService)
    {
        $this->eleveService = $eleveService;
    }

    public function collection(Collection $rows)
    {
        foreach ($rows as $index => $row) {
            try {
                // Check if row is somewhat valid (Maatwebsite gives lowercase snake_case keys based on headings)
                $nom = $row['nom'] ?? null;
                $prenom = $row['prenom'] ?? null;

                if (empty($nom) || empty($prenom)) {
                    continue; // Skip empty rows
                }

                $classeId = null;
                $nomClasse = $row['nom_de_la_classe'] ?? null;
                if (!empty($nomClasse)) {
                    $classe = Classe::where('nom', trim($nomClasse))->first();
                    if ($classe) {
                        $classeId = $classe->id;
                    }
                }

                $data = [
                    'nom' => trim($nom),
                    'prenom' => trim($prenom),
                    'date_naissance' => !empty($row['date_de_naissance_aaaa_mm_jj']) ? trim($row['date_de_naissance_aaaa_mm_jj']) : null,
                    'lieu_naissance' => !empty($row['lieu_de_naissance']) ? trim($row['lieu_de_naissance']) : null,
                    'sexe' => (strtoupper(trim($row['sexe_mf'] ?? '')) === 'F') ? 'F' : 'M',
                    'nationalite' => !empty($row['nationalite']) ? trim($row['nationalite']) : 'Sénégalaise',
                    'classe_id' => $classeId,
                    
                    'nom_tuteur' => !empty($row['nom_du_tuteur']) ? trim($row['nom_du_tuteur']) : null,
                    'tel_tuteur' => !empty($row['telephone_du_tuteur']) ? trim($row['telephone_du_tuteur']) : null,
                    'relation_tuteur' => !empty($row['relation_peremereautre']) ? trim($row['relation_peremereautre']) : 'parent',
                ];

                $this->eleveService->register($data);
                $this->importedCount++;

            } catch (\Exception $e) {
                Log::error("Erreur import ligne " . ($index + 2) . " : " . $e->getMessage());
                $this->errors[] = "Ligne " . ($index + 2) . " : " . $e->getMessage();
            }
        }
    }
}
