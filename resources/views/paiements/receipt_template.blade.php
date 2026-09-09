<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Reçu - {{ $paiement->reference }}</title>
    <style>
        body { font-family: 'Helvetica', sans-serif; font-size: 13px; color: #333; line-height: 1.6; }
        .receipt-container { width: 100%; border: 2px dashed #444; padding: 30px; margin: 0 auto; background: #fff; }
        .header { text-align: center; margin-bottom: 20px; border-bottom: 1px solid #eee; padding-bottom: 10px; }
        .school-name { font-size: 20px; font-weight: bold; color: #198754; }
        
        .receipt-meta { margin-bottom: 30px; }
        .title { text-align: center; font-size: 18px; font-weight: bold; text-decoration: underline; margin-bottom: 20px; }
        
        .row { margin-bottom: 10px; }
        .label { font-weight: bold; width: 150px; display: inline-block; }
        
        .amount-box { background: #f8f9fa; border: 1px solid #ddd; padding: 15px; text-align: center; font-size: 20px; font-weight: bold; margin-top: 30px; }
        .footer { margin-top: 40px; }
        .sig { float: right; text-align: center; width: 200px; border-top: 1px solid #000; padding-top: 10px; }
    </style>
</head>
<body>

    <div class="receipt-container">
        <div class="header">
            <div class="school-name">SUNUECOLE DIGITAL</div>
            <div>Plateforme de Gestion Scolaire Moderne</div>
            <div style="font-size: 10px;">Dakar, Sénégal | Contact: +221 33 000 00 00</div>
        </div>

        <div class="receipt-meta">
            <div style="float: left;">N° RÉFÉRENCE : <strong>{{ $paiement->reference }}</strong></div>
            <div style="float: right;">Date : <strong>{{ \Carbon\Carbon::parse($paiement->date_paiement)->format('d/m/Y') }}</strong></div>
            <div style="clear: both;"></div>
        </div>

        <div class="title">REÇU DE PAIEMENT</div>

        <div class="row"><span class="label">Reçu de :</span> {{ strtoupper($paiement->eleve->nom) }} {{ $paiement->eleve->prenom }}</div>
        <div class="row"><span class="label">Classe :</span> {{ $paiement->eleve->classe->nom ?? 'Standard' }}</div>
        <div class="row"><span class="label">Motif du paiement :</span> {{ $paiement->typePaiement->nom }} @if($paiement->mois) (Mois de {{ $paiement->mois }}) @endif</div>
        <div class="row"><span class="label">Mode de règlement :</span> {{ ucfirst($paiement->mode_paiement) }}</div>

        <div class="amount-box">
            MONTANT : {{ number_format($paiement->montant_paye, 0, ',', ' ') }} FCFA
        </div>

        <div style="margin-top: 20px; font-style: italic;">
            Arrêté le présent reçu à la somme de : <strong>{{ ucfirst(\App\Helpers\NumberHelper::spellout($paiement->montant_paye)) }} FCFA</strong>.
        </div>

        <div class="footer">
            <div style="float: left; font-size: 10px; color: #777;">
                Ce reçu est généré électroniquement et ne nécessite pas de cachet physique pour être valide dans le système.
            </div>
            <div class="sig">
                Le Comptable
            </div>
            <div style="clear: both;"></div>
        </div>
    </div>

</body>
</html>
