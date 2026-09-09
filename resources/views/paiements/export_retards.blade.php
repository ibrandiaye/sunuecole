<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Retards de Paiement - {{ $selected_mois }}</title>
    <style>
        body {
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            color: #333;
            font-size: 12px;
            margin: 0;
            padding: 20px;
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
            border-bottom: 2px solid #2c3e50;
            padding-bottom: 10px;
        }
        .header h1 {
            color: #2c3e50;
            margin: 0 0 5px 0;
            font-size: 24px;
        }
        .header p {
            margin: 0;
            font-size: 14px;
            color: #7f8c8d;
        }
        .summary-box {
            background-color: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
            border: 1px solid #f5c6cb;
        }
        .summary-box h2 {
            margin: 0;
            font-size: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
            color: #333;
            font-weight: bold;
            text-transform: uppercase;
            font-size: 11px;
        }
        .class-header {
            background-color: #2c3e50;
            color: white;
            font-weight: bold;
        }
        .text-right {
            text-align: right;
        }
        .text-center {
            text-align: center;
        }
        .amount {
            font-family: 'Courier New', Courier, monospace;
            font-weight: bold;
        }
        .text-danger {
            color: #e74c3c;
        }
        .footer {
            margin-top: 50px;
            text-align: center;
            font-size: 10px;
            color: #95a5a6;
            border-top: 1px solid #eee;
            padding-top: 10px;
        }
    </style>
</head>
<body>

    <div class="header">
        <h1>Rapport des Impayés de Scolarité</h1>
        <p>Mois concerné : <strong>{{ $selected_mois }}</strong></p>
        <p>Filtre Classe : <strong>{{ $selected_classe_id ? $classes->firstWhere('id', $selected_classe_id)->nom : 'Toutes les classes' }}</strong></p>
        <p>Date d'édition : {{ date('d/m/Y à H:i') }}</p>
    </div>

    <div class="summary-box">
        <p style="margin:0 0 5px 0;">Montant total en souffrance pour cette sélection</p>
        <h2>{{ number_format($totalReste, 0, ',', ' ') }} FCFA</h2>
    </div>

    <table>
        <thead>
            <tr>
                <th>Classe</th>
                <th>Matricule</th>
                <th>Nom de l'élève</th>
                <th>Tuteur (Contact)</th>
                <th class="text-right">Attendu</th>
                <th class="text-right">Payé</th>
                <th class="text-right text-danger">Reste à Payer</th>
            </tr>
        </thead>
        <tbody>
            @php $currentClasse = ''; @endphp
            @foreach($eleves as $eleve)
                @if($currentClasse !== $eleve->classe->nom && !$selected_classe_id)
                    <tr class="class-header">
                        <td colspan="7">{{ $eleve->classe->nom }}</td>
                    </tr>
                    @php $currentClasse = $eleve->classe->nom; @endphp
                @endif
                <tr>
                    <td>{{ $eleve->classe->nom }}</td>
                    <td>{{ $eleve->matricule }}</td>
                    <td><strong>{{ $eleve->prenom }} {{ $eleve->nom }}</strong></td>
                    <td>
                        {{ $eleve->nom_tuteur ?? 'Non renseigné' }}<br>
                        <small style="color:#666">{{ $eleve->tel_tuteur ?? '' }}</small>
                    </td>
                    <td class="text-right amount">{{ number_format($eleve->montant_attendu, 0, ',', ' ') }} F</td>
                    <td class="text-right amount">{{ number_format($eleve->montant_paye, 0, ',', ' ') }} F</td>
                    <td class="text-right amount text-danger">{{ number_format($eleve->reste_a_payer, 0, ',', ' ') }} F</td>
                </tr>
            @endforeach

            @if($eleves->isEmpty())
                <tr>
                    <td colspan="7" class="text-center" style="padding: 30px;">Aucun retard de paiement enregistré pour cette sélection.</td>
                </tr>
            @endif
        </tbody>
    </table>

    <div class="footer">
        Document généré automatiquement par SunuEcole le {{ date('d/m/Y') }}
    </div>

</body>
</html>
