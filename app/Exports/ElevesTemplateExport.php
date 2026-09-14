<?php
namespace App\Exports;

use Maatwebsite\Excel\Concerns\FromArray;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithStyles;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;

class ElevesTemplateExport implements FromArray, WithHeadings, WithStyles
{
    public function headings(): array
    {
        return [
            'Nom',
            'Prenom',
            'Date de Naissance (AAAA-MM-JJ)',
            'Lieu de Naissance',
            'Sexe (M/F)',
            'Nationalite',
            'Nom de la Classe',
            'Nom du Tuteur',
            'Telephone du Tuteur',
            'Relation (pere/mere/autre)'
        ];
    }

    public function array(): array
    {
        return [
            ['DIOP', 'Amadou', '2010-05-14', 'Dakar', 'M', 'Sénégalaise', 'Sixième A', 'Moussa DIOP', '770000000', 'pere'],
            ['NDIAYE', 'Fatou', '2011-02-28', 'Thiès', 'F', 'Sénégalaise', 'Sixième A', 'Awa FALL', '771111111', 'mere'],
        ];
    }

    public function styles(Worksheet $sheet)
    {
        return [
            1 => ['font' => ['bold' => true]],
        ];
    }
}
