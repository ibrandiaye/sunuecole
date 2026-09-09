<?php

namespace App\Helpers;

class NumberHelper
{
    /**
     * Convertit un nombre en lettres en français
     * Fonctionne avec ou sans l'extension PHP intl (NumberFormatter)
     */
    public static function spellout($number): string
    {
        $number = (int) round($number);

        // Si l'extension intl est disponible
        if (class_exists(\NumberFormatter::class)) {
            try {
                $formatter = new \NumberFormatter('fr_FR', \NumberFormatter::SPELLOUT);
                $result = $formatter->format($number);
                if ($result !== false && !empty($result)) {
                    return $result;
                }
            } catch (\Throwable $e) {
                // Fallback vers l'implémentation native ci-dessous
            }
        }

        // Implémentation native pure PHP
        return self::convertNumberToWords($number);
    }

    private static function convertNumberToWords(int $number): string
    {
        if ($number === 0) {
            return 'zéro';
        }

        if ($number < 0) {
            return 'moins ' . self::convertNumberToWords(abs($number));
        }

        $units = [
            0 => '', 1 => 'un', 2 => 'deux', 3 => 'trois', 4 => 'quatre', 5 => 'cinq',
            6 => 'six', 7 => 'sept', 8 => 'huit', 9 => 'neuf', 10 => 'dix',
            11 => 'onze', 12 => 'douze', 13 => 'treize', 14 => 'quatorze', 15 => 'quinze',
            16 => 'seize', 17 => 'dix-sept', 18 => 'dix-huit', 19 => 'dix-neuf'
        ];

        $tens = [
            2 => 'vingt', 3 => 'trente', 4 => 'quarante', 5 => 'cinquante',
            6 => 'soixante', 7 => 'soixante', 8 => 'quatre-vingt', 9 => 'quatre-vingt'
        ];

        $words = [];

        // Milliards
        if ($number >= 1000000000) {
            $billions = (int) floor($number / 1000000000);
            $words[] = ($billions > 1 ? self::convertNumberToWords($billions) . ' ' : 'un ') . 'milliard' . ($billions > 1 ? 's' : '');
            $number %= 1000000000;
        }

        // Millions
        if ($number >= 1000000) {
            $millions = (int) floor($number / 1000000);
            $words[] = ($millions > 1 ? self::convertNumberToWords($millions) . ' ' : 'un ') . 'million' . ($millions > 1 ? 's' : '');
            $number %= 1000000;
        }

        // Milliers
        if ($number >= 1000) {
            $thousands = (int) floor($number / 1000);
            if ($thousands === 1) {
                $words[] = 'mille';
            } else {
                $words[] = self::convertNumberToWords($thousands) . ' mille';
            }
            $number %= 1000;
        }

        // Centaines
        if ($number >= 100) {
            $hundreds = (int) floor($number / 100);
            $rem = $number % 100;
            if ($hundreds === 1) {
                $words[] = 'cent';
            } else {
                $words[] = $units[$hundreds] . ' cent' . ($rem === 0 ? 's' : '');
            }
            $number = $rem;
        }

        // Dizaines et unités
        if ($number > 0) {
            if ($number < 20) {
                $words[] = $units[$number];
            } else {
                $ten = (int) floor($number / 10);
                $unit = $number % 10;

                if ($ten === 7 || $ten === 9) {
                    $base = $tens[$ten];
                    $extra = $unit + 10;
                    if ($ten === 7 && $unit === 1) {
                        $words[] = $base . ' et onze';
                    } else {
                        $words[] = $base . '-' . $units[$extra];
                    }
                } else {
                    $base = $tens[$ten];
                    if ($unit === 0) {
                        $words[] = ($ten === 8 ? 'quatre-vingts' : $base);
                    } elseif ($unit === 1 && $ten !== 8) {
                        $words[] = $base . ' et un';
                    } else {
                        $words[] = $base . '-' . $units[$unit];
                    }
                }
            }
        }

        return trim(implode(' ', $words));
    }
}