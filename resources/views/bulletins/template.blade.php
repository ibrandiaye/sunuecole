@php
    $nb = count($results);
    if ($nb <= 9) {
        $baseFontSize   = '9pt';
        $tableFontSize  = '8.5pt';
        $headerFontSize = '14pt';
        $tdPadding      = '4px 6px';
        $thPadding      = '5px 6px';
        $marginBlock    = '6px';
        $infoPadding    = '5px 8px';
        $qrSize         = 62;
    } elseif ($nb <= 14) {
        $baseFontSize   = '8pt';
        $tableFontSize  = '7.5pt';
        $headerFontSize = '12pt';
        $tdPadding      = '2.5px 5px';
        $thPadding      = '3.5px 5px';
        $marginBlock    = '4px';
        $infoPadding    = '3px 6px';
        $qrSize         = 52;
    } elseif ($nb <= 18) {
        $baseFontSize   = '7.5pt';
        $tableFontSize  = '7pt';
        $headerFontSize = '11pt';
        $tdPadding      = '1.5px 4px';
        $thPadding      = '2.5px 4px';
        $marginBlock    = '2px';
        $infoPadding    = '2px 5px';
        $qrSize         = 45;
    } else {
        $baseFontSize   = '6.8pt';
        $tableFontSize  = '6.5pt';
        $headerFontSize = '10pt';
        $tdPadding      = '1px 3px';
        $thPadding      = '2px 3px';
        $marginBlock    = '1.5px';
        $infoPadding    = '2px 4px';
        $qrSize         = 40;
    }
@endphp
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Bulletin - {{ $eleve->prenom }} {{ $eleve->nom }}</title>
    <style type="text/css">
        @page {
            margin: 6mm 8mm 6mm 8mm;
            size: a4 portrait;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Helvetica', 'Arial', sans-serif;
            font-size: {{ $baseFontSize }};
            color: #222222;
            width: 100%;
            line-height: 1.25;
        }

        .header {
            text-align: center;
            border-bottom: 2px solid #1a56db;
            padding-bottom: {{ $marginBlock }};
            margin-bottom: {{ $marginBlock }};
            width: 100%;
        }
        .school-name {
            font-size: {{ $headerFontSize }};
            font-weight: bold;
            color: #1a56db;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .bulletin-title {
            font-size: {{ $baseFontSize }};
            font-weight: bold;
            margin-top: 2px;
            text-transform: uppercase;
            color: #333333;
        }
        .header-sub {
            font-size: {{ $baseFontSize }};
            color: #666666;
            margin-top: 1px;
        }

        table.student-section {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: {{ $marginBlock }};
        }
        table.student-section td {
            vertical-align: middle;
            padding: 0;
        }
        .info-box {
            border: 1px solid #93c5fd;
            background-color: #f0f7ff;
            padding: {{ $infoPadding }};
        }
        .info-box table {
            width: 100%;
            border-collapse: collapse;
        }
        .info-box td {
            font-size: {{ $baseFontSize }};
            padding: 1px 0;
            color: #222222;
        }
        .label-bold {
            font-weight: bold;
            color: #1e40af;
        }

        table.marks {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: {{ $marginBlock }};
        }
        table.marks th {
            background-color: #1a56db;
            color: #ffffff;
            font-size: {{ $tableFontSize }};
            font-weight: bold;
            padding: {{ $thPadding }};
            text-align: center;
            text-transform: uppercase;
            border: 1px solid #1a56db;
        }
        table.marks td {
            border: 1px solid #cccccc;
            padding: {{ $tdPadding }};
            text-align: center;
            font-size: {{ $tableFontSize }};
            color: #222222;
        }
        table.marks td.col-matiere {
            text-align: left;
            font-weight: bold;
        }
        table.marks tr.even td {
            background-color: #f9f9f9;
        }

        .note-good { color: #15803d; font-weight: bold; }
        .note-avg  { color: #b45309; font-weight: bold; }
        .note-bad  { color: #dc2626; font-weight: bold; }
        .text-bold { font-weight: bold; }

        table.marks tfoot td {
            font-weight: bold;
            background-color: #dbeafe;
            border: 1px solid #93c5fd;
            padding: {{ $tdPadding }};
            font-size: {{ $tableFontSize }};
        }
        table.marks tfoot tr.row-total td {
            background-color: #dbeafe;
        }
        table.marks tfoot tr.row-moyenne td {
            background-color: #bfdbfe;
            color: #1e3a8a;
        }
        table.marks tfoot tr.row-annuel td {
            background-color: #93c5fd;
            color: #1e3a8a;
        }
        table.marks tfoot tr.row-rang td {
            background-color: #eff6ff;
        }

        table.footer-section {
            width: 100%;
            border-collapse: collapse;
            margin-top: {{ $marginBlock }};
        }
        table.footer-section td {
            vertical-align: top;
            padding: 0 2px;
        }
        .obs-box {
            border: 1px solid #93c5fd;
            padding: {{ $infoPadding }};
            background-color: #ffffff;
        }
        .obs-box p {
            font-size: {{ $baseFontSize }};
            color: #222222;
        }
        .signature-box {
            text-align: center;
            padding: 2px;
        }
        .signature-box p {
            font-size: {{ $baseFontSize }};
            margin-bottom: 1px;
        }
        .sig-line {
            border-bottom: 1px solid #333333;
            width: 70px;
            margin: 10px auto 0;
        }
        .legend-box {
            border: 1px solid #cccccc;
            padding: {{ $infoPadding }};
            font-size: {{ $baseFontSize }};
            color: #555555;
            background-color: #fafafa;
        }
        .legend-box p {
            margin: 1px 0;
        }
    </style>
</head>
<body>

    {{-- EN-TETE --}}
    <div class="header">
        <div class="school-name">SUNU ECOLE DIGITAL</div>
        <div class="bulletin-title">BULLETIN DE NOTES - {{ strtoupper($periode) }}</div>
        <div class="header-sub">Ann&eacute;e Scolaire : {{ $eleve->anneeScolaire->libelle ?? '2025-2026' }}</div>
    </div>

    {{-- INFOS ELEVE --}}
    <table class="student-section">
        <tr>
            <td width="72%">
                <div class="info-box">
                    <table>
                        <tr>
                            <td width="55%">
                                <div><span class="label-bold">&Eacute;l&egrave;ve :</span> {{ strtoupper($eleve->nom) }} {{ $eleve->prenom }}</div>
                                <div><span class="label-bold">Matricule :</span> {{ $eleve->matricule }}</div>
                            </td>
                            <td width="45%">
                                <div><span class="label-bold">Classe :</span> {{ $eleve->classe->nom ?? 'N/A' }}</div>
                                <div><span class="label-bold">N&eacute;(e) le :</span> {{ \Carbon\Carbon::parse($eleve->date_naissance)->format('d/m/Y') }}</div>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
            <td width="4%"></td>
            <td width="24%" align="center">
                <img src="data:image/svg+xml;base64,{{ $qrcode }}" width="{{ $qrSize }}" style="display:block; margin:0 auto;" />
                <div style="font-size:6.5pt; color:#666666; margin-top:1px; text-align:center;">Authenticit&eacute;</div>
            </td>
        </tr>
    </table>

    {{-- TABLEAU DES NOTES --}}
    <table class="marks">
        <thead>
            <tr>
                <th style="text-align:left; width:26%;">MATI&Egrave;RE</th>
                <th style="width:12%;">DEVOIRS</th>
                <th style="width:12%;">COMPO</th>
                <th style="width:12%;">MOY/20</th>
                <th style="width:10%;">COEFF</th>
                <th style="width:12%;">TOTAL</th>
                <th style="width:16%;">APPR&Eacute;CIATION</th>
            </tr>
        </thead>
        <tbody>
            @foreach($results as $index => $res)
            @php
                $moy = $res['moyenne'];
                $class = $moy >= 14 ? 'note-good' : ($moy >= 10 ? 'note-avg' : 'note-bad');
                $appre = $moy >= 16 ? 'Tr&egrave;s Bien' : ($moy >= 14 ? 'Bien' : ($moy >= 12 ? 'Assez Bien' : ($moy >= 10 ? 'Passable' : 'Insuffisant')));
            @endphp
            <tr class="{{ $index % 2 == 1 ? 'even' : '' }}">
                <td class="col-matiere">{{ $res['matiere'] }}</td>
                <td>{{ number_format($res['moyenne_devoirs'], 2) }}</td>
                <td>{{ number_format($res['note_composition'], 2) }}</td>
                <td class="{{ $class }}">{{ number_format($res['moyenne'], 2) }}</td>
                <td>{{ $res['coefficient'] }}</td>
                <td class="text-bold">{{ number_format($res['points'], 2) }}</td>
                <td style="color:#333333;">{!! $appre !!}</td>
            </tr>
            @endforeach
        </tbody>
        <tfoot>
            <tr class="row-total">
                <td colspan="4" style="text-align:right; padding-right:4px;">TOTAL COEFFICIENTS &amp; POINTS :</td>
                <td>{{ $results->sum('coefficient') }}</td>
                <td colspan="2">{{ number_format($results->sum('points'), 2) }}</td>
            </tr>
            <tr class="row-moyenne">
                <td colspan="4" style="text-align:right; padding-right:4px;">MOYENNE DU {{ strtoupper($periode) }} :</td>
                <td colspan="3" style="text-align:center; font-size:{{ $nb > 14 ? '8pt' : '9.5pt' }};"><strong>{{ number_format($moyenne_generale, 2) }} / 20</strong></td>
            </tr>
            <tr class="row-rang">
                <td colspan="4" style="text-align:right; padding-right:4px;">RANG :</td>
                <td colspan="3" style="text-align:center;"><strong>{{ $rang }}<sup>{{ $rang == 1 ? 'er' : '&egrave;me' }}</sup> sur {{ $effectif }}</strong></td>
            </tr>
            @if($moyenne_annuelle)
            <tr class="row-annuel">
                <td colspan="4" style="text-align:right; padding-right:4px;">MOYENNE G&Eacute;N&Eacute;RALE ANNUELLE :</td>
                <td colspan="3" style="text-align:center; font-size:{{ $nb > 14 ? '8.5pt' : '10pt' }};"><strong>{{ number_format($moyenne_annuelle, 2) }} / 20</strong></td>
            </tr>
            @endif
        </tfoot>
    </table>

    {{-- PIED DE PAGE --}}
    <table class="footer-section">
        <tr>
            <td width="48%">
                <div class="obs-box">
                    <p><span class="label-bold">Observation du Conseil :</span></p>
                    <p style="margin-top:3px; color:#555555; font-style:italic;">
                        @if($moyenne_generale >= 16) F&eacute;licitations du conseil de classe.
                        @elseif($moyenne_generale >= 14) Tableau d'honneur.
                        @elseif($moyenne_generale >= 12) Encouragements.
                        @elseif($moyenne_generale >= 10) Travail convenable, poursuivre les efforts.
                        @else Doit redoubler d'efforts au prochain terme.
                        @endif
                    </p>
                </div>
            </td>
            <td width="3%"></td>
            <td width="26%">
                <div class="legend-box">
                    <p><span class="label-bold">Mention :</span></p>
                    <p>&gt;= 16 : Tr&egrave;s Bien | 14-16 : Bien</p>
                    <p>12-14 : Assez Bien | 10-12 : Passable</p>
                </div>
            </td>
            <td width="3%"></td>
            <td width="20%" align="center">
                <div class="signature-box">
                    <p>Dakar, le {{ $date }}</p>
                    <p style="margin-top:2px; font-weight:bold;">La Direction</p>
                    <div class="sig-line"></div>
                </div>
            </td>
        </tr>
    </table>

</body>
</html>