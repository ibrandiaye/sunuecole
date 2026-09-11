-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 09 sep. 2026 à 18:05
-- Version du serveur :  10.4.16-MariaDB
-- Version de PHP : 7.3.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `sunuecole`
--

-- --------------------------------------------------------

--
-- Structure de la table `absences`
--

CREATE TABLE `absences` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `eleve_id` bigint(20) UNSIGNED NOT NULL,
  `classe_id` bigint(20) UNSIGNED NOT NULL,
  `annee_scolaire_id` bigint(20) UNSIGNED NOT NULL,
  `enseignant_id` bigint(20) UNSIGNED DEFAULT NULL,
  `matiere_id` bigint(20) UNSIGNED DEFAULT NULL,
  `date_absence` date NOT NULL,
  `heure_debut` time DEFAULT NULL,
  `heure_fin` time DEFAULT NULL,
  `periode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'absence',
  `justifie` tinyint(1) NOT NULL DEFAULT 0,
  `commentaire` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notifie_parent` tinyint(1) NOT NULL DEFAULT 0,
  `notifie_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `cahier_texte_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `absences`
--

INSERT INTO `absences` (`id`, `eleve_id`, `classe_id`, `annee_scolaire_id`, `enseignant_id`, `matiere_id`, `date_absence`, `heure_debut`, `heure_fin`, `periode`, `type`, `justifie`, `commentaire`, `notifie_parent`, `notifie_at`, `created_at`, `updated_at`, `cahier_texte_id`) VALUES
(1, 4, 1, 1, NULL, NULL, '2026-04-25', NULL, NULL, 'journée', 'absent', 0, NULL, 0, NULL, '2026-04-25 17:38:49', '2026-04-25 17:38:49', NULL),
(2, 5, 1, 1, NULL, NULL, '2026-04-25', NULL, NULL, 'journée', 'retard', 0, NULL, 0, NULL, '2026-04-25 17:38:49', '2026-04-25 17:38:49', NULL),
(3, 71, 6, 1, NULL, 10, '2026-07-13', '10:00:00', '12:00:00', NULL, 'absent', 0, NULL, 0, NULL, '2026-07-13 11:08:31', '2026-07-13 11:08:31', 1),
(4, 1, 1, 1, 1, 1, '2026-07-13', '08:00:00', '10:00:00', NULL, 'absence', 0, NULL, 0, NULL, '2026-07-13 16:53:48', '2026-07-13 16:53:48', NULL),
(5, 3, 1, 1, 1, 1, '2026-07-13', '08:00:00', '10:00:00', NULL, 'absence', 0, NULL, 0, NULL, '2026-07-13 16:53:48', '2026-07-13 16:53:48', NULL),
(6, 3, 1, 1, 1, 1, '2026-08-31', '08:00:00', '10:00:00', NULL, 'absence', 0, NULL, 0, NULL, '2026-08-31 16:29:37', '2026-08-31 16:29:37', NULL),
(7, 5, 1, 1, 1, 1, '2026-09-03', '08:00:00', '10:00:00', NULL, 'absent', 0, NULL, 0, NULL, '2026-09-03 09:40:46', '2026-09-03 09:40:46', 2);

-- --------------------------------------------------------

--
-- Structure de la table `annee_scolaires`
--

CREATE TABLE `annee_scolaires` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `libelle` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `annee_scolaires`
--

INSERT INTO `annee_scolaires` (`id`, `libelle`, `date_debut`, `date_fin`, `active`, `created_at`, `updated_at`) VALUES
(1, '2025-2026', '2025-10-01', '2026-06-30', 1, '2026-04-25 12:58:51', '2026-09-09 12:48:26'),
(2, '2023-2024', '2023-10-05', '2024-07-31', 0, '2026-07-12 12:41:05', '2026-09-09 12:48:26');

-- --------------------------------------------------------

--
-- Structure de la table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ancien_valeur` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`ancien_valeur`)),
  `nouveau_valeur` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`nouveau_valeur`)),
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `bulletins`
--

CREATE TABLE `bulletins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `eleve_id` bigint(20) UNSIGNED NOT NULL,
  `classe_id` bigint(20) UNSIGNED NOT NULL,
  `annee_scolaire_id` bigint(20) UNSIGNED NOT NULL,
  `trimestre` tinyint(4) NOT NULL,
  `moyenne_generale` decimal(5,2) DEFAULT NULL,
  `rang` int(11) DEFAULT NULL,
  `effectif_classe` int(11) DEFAULT NULL,
  `moyenne_classe` decimal(5,2) DEFAULT NULL,
  `moyenne_max` decimal(5,2) DEFAULT NULL,
  `moyenne_min` decimal(5,2) DEFAULT NULL,
  `mention` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `appreciation_generale` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qr_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pdf_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token_verification` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `publie` tinyint(1) NOT NULL DEFAULT 0,
  `date_publication` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `bulletins`
--

INSERT INTO `bulletins` (`id`, `eleve_id`, `classe_id`, `annee_scolaire_id`, `trimestre`, `moyenne_generale`, `rang`, `effectif_classe`, `moyenne_classe`, `moyenne_max`, `moyenne_min`, `mention`, `appreciation_generale`, `qr_code`, `pdf_path`, `token_verification`, `publie`, `date_publication`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1, '12.92', 4, 5, NULL, NULL, NULL, NULL, NULL, NULL, 'bulletins/bulletin_1_58a708513277b1d99ccf79d5b11e7c2f.pdf', '58a708513277b1d99ccf79d5b11e7c2f', 1, '2026-07-01 10:44:02', '2026-04-26 13:37:26', '2026-07-01 10:44:02'),
(2, 1, 1, 1, 2, '0.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'bulletins/bulletin_1_8d37614beb5114dda9f774a8fe3c9de6.pdf', '8d37614beb5114dda9f774a8fe3c9de6', 1, '2026-04-26 13:38:09', '2026-04-26 13:38:09', '2026-04-26 13:38:09'),
(3, 16, 4, 1, 1, '16.00', 2, 5, NULL, NULL, NULL, NULL, NULL, NULL, 'bulletins/bulletin_16_146a1a72d5df297a890c48ac7a53583e.pdf', '146a1a72d5df297a890c48ac7a53583e', 1, '2026-06-26 13:18:51', '2026-06-26 13:18:51', '2026-06-26 13:18:51'),
(4, 71, 6, 2, 1, '10.50', 41, 50, NULL, NULL, NULL, NULL, NULL, NULL, 'bulletins/bulletin_71_d8d74ab5c473f0db80e1ffac190a0b5a.pdf', 'd8d74ab5c473f0db80e1ffac190a0b5a', 1, '2026-07-12 12:49:44', '2026-07-12 12:49:44', '2026-07-12 12:49:44'),
(5, 21, 5, 2, 1, '12.25', 40, 50, NULL, NULL, NULL, NULL, NULL, NULL, 'bulletins/bulletin_21_1eb7d588985fff17ebe9644b9dfa5fe9.pdf', '1eb7d588985fff17ebe9644b9dfa5fe9', 1, '2026-09-08 16:36:56', '2026-07-12 13:55:13', '2026-09-08 16:36:56'),
(6, 14, 3, 1, 1, '14.00', 3, 5, NULL, NULL, NULL, NULL, NULL, NULL, 'bulletins/bulletin_14_25920ceaecf4ded6925683b012f9181f.pdf', '25920ceaecf4ded6925683b012f9181f', 1, '2026-09-09 15:42:09', '2026-09-09 15:42:09', '2026-09-09 15:42:09');

-- --------------------------------------------------------

--
-- Structure de la table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cahier_textes`
--

CREATE TABLE `cahier_textes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `classe_id` bigint(20) UNSIGNED NOT NULL,
  `matiere_id` bigint(20) UNSIGNED NOT NULL,
  `enseignant_id` bigint(20) UNSIGNED DEFAULT NULL,
  `annee_scolaire_id` bigint(20) UNSIGNED NOT NULL,
  `date_cours` date NOT NULL,
  `heure_debut` time DEFAULT NULL,
  `heure_fin` time DEFAULT NULL,
  `periode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `titre_lecon` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contenu_lecon` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cahier_textes`
--

INSERT INTO `cahier_textes` (`id`, `classe_id`, `matiere_id`, `enseignant_id`, `annee_scolaire_id`, `date_cours`, `heure_debut`, `heure_fin`, `periode`, `titre_lecon`, `contenu_lecon`, `created_at`, `updated_at`) VALUES
(1, 6, 10, NULL, 1, '2026-07-13', '10:00:00', '12:00:00', NULL, 'lnkjbkjbkb', 'kjnkjnkj', '2026-07-13 11:08:31', '2026-07-13 11:08:31'),
(2, 1, 1, 1, 1, '2026-09-03', '08:00:00', '10:00:00', NULL, 'Cours 1', NULL, '2026-09-03 09:40:46', '2026-09-03 09:40:46');

-- --------------------------------------------------------

--
-- Structure de la table `classes`
--

CREATE TABLE `classes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cycle_id` bigint(20) UNSIGNED DEFAULT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `niveau_id` bigint(20) UNSIGNED NOT NULL,
  `serie_id` bigint(20) UNSIGNED DEFAULT NULL,
  `annee_scolaire_id` bigint(20) UNSIGNED NOT NULL,
  `salle_id` bigint(20) UNSIGNED DEFAULT NULL,
  `professeur_principal_id` bigint(20) UNSIGNED DEFAULT NULL,
  `effectif_max` int(11) NOT NULL DEFAULT 50,
  `montant_inscription` decimal(12,2) DEFAULT NULL,
  `montant_mensualite` decimal(12,2) DEFAULT NULL,
  `montant_cantine` decimal(12,2) DEFAULT NULL,
  `montant_transport` decimal(12,2) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `classes`
--

INSERT INTO `classes` (`id`, `cycle_id`, `nom`, `niveau_id`, `serie_id`, `annee_scolaire_id`, `salle_id`, `professeur_principal_id`, `effectif_max`, `montant_inscription`, `montant_mensualite`, `montant_cantine`, `montant_transport`, `active`, `created_at`, `updated_at`) VALUES
(1, 2, 'Sixième A', 1, NULL, 1, 1, NULL, 50, '40000.00', '10000.00', NULL, NULL, 1, '2026-04-25 12:58:52', '2026-04-25 12:58:52'),
(2, 2, 'Troisième A', 2, NULL, 1, 2, NULL, 50, '20000.00', '5000.00', NULL, NULL, 1, '2026-04-25 12:58:52', '2026-04-25 12:58:52'),
(3, 3, 'Seconde S A', 3, NULL, 1, 3, NULL, 50, '60000.00', '30000.00', NULL, NULL, 1, '2026-04-25 12:58:52', '2026-04-25 12:58:52'),
(4, 3, 'Terminale S2 A', 4, NULL, 1, 1, NULL, 50, '45000.00', '15000.00', NULL, NULL, 1, '2026-04-25 12:58:52', '2026-04-25 12:58:52'),
(5, 2, '6ème A', 1, NULL, 2, 1, NULL, 60, '50000.00', '30000.00', NULL, NULL, 1, '2026-07-12 12:41:05', '2026-09-08 11:19:18'),
(6, 3, '1ère L2A', 5, 4, 2, 5, NULL, 50, '50000.00', '25000.00', NULL, NULL, 1, '2026-07-12 12:41:05', '2026-07-12 12:41:05');

-- --------------------------------------------------------

--
-- Structure de la table `classe_matiere`
--

CREATE TABLE `classe_matiere` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `classe_id` bigint(20) UNSIGNED NOT NULL,
  `matiere_id` bigint(20) UNSIGNED NOT NULL,
  `enseignant_id` bigint(20) UNSIGNED DEFAULT NULL,
  `coefficient_override` decimal(4,1) DEFAULT NULL,
  `heures_semaine` int(11) NOT NULL DEFAULT 2,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `classe_matiere`
--

INSERT INTO `classe_matiere` (`id`, `classe_id`, `matiere_id`, `enseignant_id`, `coefficient_override`, `heures_semaine`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, '2.0', 6, '2026-07-01 10:36:23', '2026-07-01 10:36:23'),
(2, 1, 2, 2, '4.0', 6, '2026-07-01 10:36:44', '2026-07-01 10:36:44'),
(3, 1, 3, 3, '3.0', 2, '2026-07-01 10:36:57', '2026-07-01 10:36:57'),
(5, 5, 2, NULL, '4.0', 4, '2026-07-12 12:41:05', '2026-07-12 12:44:22'),
(6, 5, 6, NULL, '2.0', 4, '2026-07-12 12:41:05', '2026-07-12 12:44:22'),
(7, 5, 7, NULL, '2.0', 4, '2026-07-12 12:41:05', '2026-07-12 12:44:22'),
(8, 5, 3, NULL, '2.0', 4, '2026-07-12 12:41:05', '2026-07-12 12:44:22'),
(9, 5, 8, NULL, '2.0', 4, '2026-07-12 12:41:05', '2026-07-12 12:44:22'),
(10, 5, 9, NULL, '2.0', 4, '2026-07-12 12:41:05', '2026-07-12 12:44:22'),
(11, 6, 10, NULL, '4.0', 4, '2026-07-12 12:41:05', '2026-07-12 12:44:22'),
(12, 6, 5, NULL, '2.0', 4, '2026-07-12 12:41:05', '2026-07-12 12:44:22'),
(13, 6, 11, NULL, '4.0', 4, '2026-07-12 12:41:05', '2026-07-12 12:44:22'),
(14, 6, 12, NULL, '3.0', 4, '2026-07-12 12:41:05', '2026-07-12 12:44:22'),
(15, 6, 13, NULL, '3.0', 4, '2026-07-12 12:41:05', '2026-07-12 12:44:22'),
(16, 6, 14, NULL, '2.0', 4, '2026-07-12 12:41:05', '2026-07-12 12:44:22'),
(17, 6, 15, NULL, '2.0', 4, '2026-07-12 12:41:05', '2026-07-12 12:44:22');

-- --------------------------------------------------------

--
-- Structure de la table `convocations`
--

CREATE TABLE `convocations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `eleve_id` bigint(20) UNSIGNED NOT NULL,
  `motif` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_convocation` date NOT NULL,
  `parent_informe` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `convocations`
--

INSERT INTO `convocations` (`id`, `eleve_id`, `motif`, `description`, `date_convocation`, `parent_informe`, `created_at`, `updated_at`) VALUES
(1, 1, 'Absence non justifé', 'qsdsqdqsd', '2026-09-03', 1, '2026-09-03 12:37:51', '2026-09-03 12:37:51');

-- --------------------------------------------------------

--
-- Structure de la table `cycles`
--

CREATE TABLE `cycles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cycles`
--

INSERT INTO `cycles` (`id`, `nom`, `code`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Elémentaire', 'ELEM', 'Cycle primaire du CI au CM2', '2026-04-25 12:58:50', '2026-04-25 12:58:50'),
(2, 'Moyen', 'MOY', 'Cycle collège de la 6ème à la 3ème', '2026-04-25 12:58:50', '2026-04-25 12:58:50'),
(3, 'Secondaire', 'SEC', 'Cycle lycée de la seconde à la terminale', '2026-04-25 12:58:50', '2026-04-25 12:58:50');

-- --------------------------------------------------------

--
-- Structure de la table `depenses`
--

CREATE TABLE `depenses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `libelle` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `categorie` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'autre',
  `montant` decimal(12,2) NOT NULL,
  `mode_paiement` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'especes',
  `date_depense` date NOT NULL,
  `annee_scolaire_id` bigint(20) UNSIGNED NOT NULL,
  `enregistre_par` bigint(20) UNSIGNED DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `depenses`
--

INSERT INTO `depenses` (`id`, `reference`, `libelle`, `categorie`, `montant`, `mode_paiement`, `date_depense`, `annee_scolaire_id`, `enregistre_par`, `notes`, `created_at`, `updated_at`) VALUES
(1, 'DEP-6AA036D3A28AE', 'Salaires du personnel permanent', 'salaires', '50000.00', 'especes', '2026-09-08', 1, 1, 'ssd', '2026-09-08 16:24:51', '2026-09-08 16:24:51');

-- --------------------------------------------------------

--
-- Structure de la table `eleves`
--

CREATE TABLE `eleves` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `matricule` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_naissance` date NOT NULL,
  `lieu_naissance` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sexe` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nationalite` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Sénégalaise',
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `groupe_sanguin` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `allergies` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maladies_chroniques` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `medecin_traitant` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `nom_tuteur` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tel_tuteur` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_tuteur` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `relation_tuteur` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `classe_id` bigint(20) UNSIGNED DEFAULT NULL,
  `annee_scolaire_id` bigint(20) UNSIGNED DEFAULT NULL,
  `statut` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'actif',
  `date_inscription` date DEFAULT NULL,
  `date_sortie` date DEFAULT NULL,
  `motif_sortie` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `eleves`
--

INSERT INTO `eleves` (`id`, `user_id`, `matricule`, `nom`, `prenom`, `date_naissance`, `lieu_naissance`, `sexe`, `nationalite`, `photo`, `groupe_sanguin`, `allergies`, `maladies_chroniques`, `medecin_traitant`, `parent_id`, `nom_tuteur`, `tel_tuteur`, `email_tuteur`, `relation_tuteur`, `classe_id`, `annee_scolaire_id`, `statut`, `date_inscription`, `date_sortie`, `motif_sortie`, `created_at`, `updated_at`) VALUES
(1, 6, 'MAT-2026-11', 'NOM-11', 'Prenom-11', '2010-05-15', NULL, 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, 1, 1, 'actif', NULL, NULL, NULL, '2026-04-25 12:58:53', '2026-04-25 12:58:53'),
(2, 8, 'MAT-2026-12', 'NOM-12', 'Prenom-12', '2010-05-15', NULL, 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, 1, 1, 'actif', NULL, NULL, NULL, '2026-04-25 12:58:53', '2026-04-25 12:58:53'),
(3, 10, 'MAT-2026-13', 'NOM-13', 'Prenom-13', '2010-05-15', NULL, 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, 1, 1, 'actif', NULL, NULL, NULL, '2026-04-25 12:58:54', '2026-04-25 12:58:54'),
(4, 12, 'MAT-2026-14', 'NOM-14', 'Prenom-14', '2010-05-15', NULL, 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, 1, 1, 'actif', NULL, NULL, NULL, '2026-04-25 12:58:54', '2026-04-25 12:58:54'),
(5, 14, 'MAT-2026-15', 'NOM-15', 'Prenom-15', '2010-05-15', NULL, 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL, 1, 1, 'actif', NULL, NULL, NULL, '2026-04-25 12:58:55', '2026-04-25 12:58:55'),
(6, 16, 'MAT-2026-21', 'NOM-21', 'Prenom-21', '2010-05-15', NULL, 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, 6, NULL, NULL, NULL, NULL, 2, 1, 'actif', NULL, NULL, NULL, '2026-04-25 12:58:55', '2026-04-25 12:58:55'),
(7, 18, 'MAT-2026-22', 'NOM-22', 'Prenom-22', '2010-05-15', NULL, 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, 7, NULL, NULL, NULL, NULL, 2, 1, 'actif', NULL, NULL, NULL, '2026-04-25 12:58:56', '2026-04-25 12:58:56'),
(8, 20, 'MAT-2026-23', 'NOM-23', 'Prenom-23', '2010-05-15', NULL, 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, 8, NULL, NULL, NULL, NULL, 2, 1, 'actif', NULL, NULL, NULL, '2026-04-25 12:58:56', '2026-04-25 12:58:56'),
(9, 22, 'MAT-2026-24', 'NOM-24', 'Prenom-24', '2010-05-15', NULL, 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, 9, NULL, NULL, NULL, NULL, 2, 1, 'actif', NULL, NULL, NULL, '2026-04-25 12:58:57', '2026-04-25 12:58:57'),
(10, 24, 'MAT-2026-25', 'NOM-25', 'Prenom-25', '2010-05-15', NULL, 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, 2, 1, 'actif', NULL, NULL, NULL, '2026-04-25 12:58:57', '2026-04-25 12:58:57'),
(11, 26, 'MAT-2026-31', 'NOM-31', 'Prenom-31', '2010-05-15', NULL, 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, 11, NULL, NULL, NULL, NULL, 3, 1, 'actif', NULL, NULL, NULL, '2026-04-25 12:58:58', '2026-04-25 12:58:58'),
(12, 28, 'MAT-2026-32', 'NOM-32', 'Prenom-32', '2010-05-15', NULL, 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, 12, NULL, NULL, NULL, NULL, 3, 1, 'actif', NULL, NULL, NULL, '2026-04-25 12:58:58', '2026-04-25 12:58:58'),
(13, 30, 'MAT-2026-33', 'NOM-33', 'Prenom-33', '2010-05-15', NULL, 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, 13, NULL, NULL, NULL, NULL, 3, 1, 'actif', NULL, NULL, NULL, '2026-04-25 12:58:59', '2026-04-25 12:58:59'),
(14, 32, 'MAT-2026-34', 'NOM-34', 'Prenom-34', '2010-05-15', NULL, 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, 14, NULL, NULL, NULL, NULL, 3, 1, 'actif', NULL, NULL, NULL, '2026-04-25 12:58:59', '2026-04-25 12:58:59'),
(15, 34, 'MAT-2026-35', 'NOM-35', 'Prenom-35', '2010-05-15', NULL, 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, 15, NULL, NULL, NULL, NULL, 3, 1, 'actif', NULL, NULL, NULL, '2026-04-25 12:59:00', '2026-04-25 12:59:00'),
(16, 36, 'MAT-2026-41', 'NOM-41', 'Prenom-41', '2010-05-15', NULL, 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, 16, NULL, NULL, NULL, NULL, 4, 1, 'actif', NULL, NULL, NULL, '2026-04-25 12:59:00', '2026-04-25 12:59:00'),
(17, 38, 'MAT-2026-42', 'NOM-42', 'Prenom-42', '2010-05-15', NULL, 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, 17, NULL, NULL, NULL, NULL, 4, 1, 'actif', NULL, NULL, NULL, '2026-04-25 12:59:01', '2026-04-25 12:59:01'),
(18, 40, 'MAT-2026-43', 'NOM-43', 'Prenom-43', '2010-05-15', NULL, 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, 18, NULL, NULL, NULL, NULL, 4, 1, 'actif', NULL, NULL, NULL, '2026-04-25 12:59:01', '2026-04-25 12:59:01'),
(19, 42, 'MAT-2026-44', 'NOM-44', 'Prenom-44', '2010-05-15', NULL, 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, 19, NULL, NULL, NULL, NULL, 4, 1, 'actif', NULL, NULL, NULL, '2026-04-25 12:59:02', '2026-04-25 12:59:02'),
(20, 44, 'MAT-2026-45', 'NOM-45', 'Prenom-45', '2010-05-15', NULL, 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, 20, NULL, NULL, NULL, NULL, 4, 1, 'actif', NULL, NULL, NULL, '2026-04-25 12:59:02', '2026-04-25 12:59:02'),
(21, NULL, '6E001A', 'Rey', 'Manon', '2013-09-27', 'Toussaint', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Nathalie Moreau', '0310558009', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(22, NULL, '6E002A', 'Hamel', 'Arnaude', '2013-08-21', 'Merle', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Zacharie Rousseau-Maurice', '0102416979', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(23, NULL, '6E003A', 'Dumont', 'Xavier', '2015-02-21', 'Leroux', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Nathalie Clement', '+33 (0)5 69 55 82 14', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(24, NULL, '6E004A', 'Gilles', 'Édouard', '2013-09-13', 'Gay', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Sophie Ollivier', '03 90 70 26 34', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(25, NULL, '6E005A', 'Raymond', 'Monique', '2015-02-28', 'Klein', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Audrey Gay', '0149204084', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(26, NULL, '6E006A', 'Pereira', 'Jean', '2015-05-05', 'Dumas', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Margaret Masson', '+33 5 24 85 28 81', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(27, NULL, '6E007A', 'Chevallier', 'Monique', '2013-12-30', 'Texier-les-Bains', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'François Barthelemy', '+33 9 47 15 25 10', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(28, NULL, '6E008A', 'Henry', 'Raymond', '2013-08-10', 'Blanc', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Aimé De Oliveira', '0138140156', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(29, NULL, '6E009A', 'Barbe', 'Nicole', '2014-06-18', 'HernandezVille', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Capucine Barbe', '+33 2 72 26 12 99', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(30, NULL, '6E010A', 'Allard', 'Éric', '2013-07-13', 'Daniel', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Roland Camus', '+33 (0)4 34 90 64 12', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(31, NULL, '6E011A', 'Guilbert', 'Martine', '2015-02-02', 'Wagner', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Adèle Le Gall', '+33 (0)7 58 38 42 91', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(32, NULL, '6E012A', 'Marin', 'Céline', '2013-08-30', 'Marty', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Marc Bodin', '0367077856', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(33, NULL, '6E013A', 'Vaillant', 'Michèle', '2014-02-14', 'Goncalves', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Arthur Le Laroche', '+33 (0)3 93 01 77 84', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(34, NULL, '6E014A', 'Collin', 'Maurice', '2013-08-14', 'Torres', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Marianne-Anne Rocher', '03 69 89 74 24', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(35, NULL, '6E015A', 'Hamel', 'Arnaude', '2014-10-21', 'Becker-sur-Mer', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Victor Lambert-Louis', '+33 (0)4 25 46 04 78', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(36, NULL, '6E016A', 'Loiseau', 'Théophile', '2015-04-26', 'Da Costa', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Richard Bertin', '+33 (0)6 95 07 66 04', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(37, NULL, '6E017A', 'Pascal', 'Julien', '2014-08-16', 'Muller-sur-Mer', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Émilie Marchand', '+33 (0)9 36 89 03 73', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(38, NULL, '6E018A', 'Diallo', 'Grégoire', '2014-12-07', 'Lemaireboeuf', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Chantal Benoit-Laurent', '05 58 11 02 93', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(39, NULL, '6E019A', 'Deschamps', 'Laurent', '2014-03-12', 'LabbeVille', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Odette Becker', '+33 (0)9 71 76 58 37', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(40, NULL, '6E020A', 'Lacroix', 'Roger', '2015-03-05', 'Guillou-sur-Mer', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Julie de Prevost', '+33 3 58 66 95 87', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(41, NULL, '6E021A', 'Morin', 'Édouard', '2013-11-26', 'Descamps', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Théodore Diaz', '+33 (0)1 13 78 17 00', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(42, NULL, '6E022A', 'Weber', 'Alain', '2015-02-01', 'Schneider', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Lucas Merle', '+33 9 73 37 60 44', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(43, NULL, '6E023A', 'Dumont', 'Eugène', '2015-06-22', 'Bazinboeuf', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Isaac Rolland', '0761824255', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(44, NULL, '6E024A', 'Levy', 'Nicolas', '2014-05-19', 'Barre-la-Forêt', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Pierre Gay', '0769042777', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(45, NULL, '6E025A', 'Guerin', 'Inès', '2015-06-11', 'MarechalBourg', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Constance Jourdan', '03 64 08 52 31', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(46, NULL, '6E026A', 'Guichard', 'Monique', '2015-03-07', 'Regnier', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Adrien Lamy', '08 92 47 72 67', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(47, NULL, '6E027A', 'Pages', 'Lucie', '2014-10-11', 'Henry', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Théodore-Marcel Costa', '+33 9 39 03 28 29', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(48, NULL, '6E028A', 'Blin', 'Marcelle', '2014-03-27', 'Gillet', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Maryse Prevost', '+33 2 60 15 33 62', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(49, NULL, '6E029A', 'Joly', 'Daniel', '2014-05-20', 'Simonnec', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Louis de Guerin', '08 91 79 34 04', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(50, NULL, '6E030A', 'Carre', 'Gabrielle', '2014-03-29', 'Guillon-sur-Gay', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Gabrielle Le Gall', '+33 (0)1 56 52 59 47', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(51, NULL, '6E031A', 'Begue', 'Thérèse', '2014-07-03', 'Lemoine', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Josette Toussaint', '0742751345', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(52, NULL, '6E032A', 'Delorme', 'Yves', '2015-03-12', 'Boutin', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'William-Eugène Blin', '01 26 03 15 35', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(53, NULL, '6E033A', 'Guichard', 'Bernadette', '2015-04-12', 'Bernier', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Amélie Gilbert', '04 95 14 74 27', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(54, NULL, '6E034A', 'Grenier', 'Aurélie', '2014-03-06', 'Henry-sur-Bazin', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'René Richard', '+33 9 73 93 42 36', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(55, NULL, '6E035A', 'Gaudin', 'Sabine', '2015-06-29', 'Menard-les-Bains', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Manon Bouvet', '01 28 82 06 79', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(56, NULL, '6E036A', 'Robert', 'Victoire', '2013-11-10', 'Richard', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Gilbert Allard', '+33 (0)1 44 52 23 18', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(57, NULL, '6E037A', 'Prevost', 'Aurélie', '2014-11-14', 'Jacob-sur-Barre', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Maggie Pasquier-Lebon', '+33 (0)9 79 54 69 30', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(58, NULL, '6E038A', 'Cohen', 'Julie', '2013-08-25', 'Besson', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Alfred-Tristan Baudry', '0584460150', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(59, NULL, '6E039A', 'Traore', 'Mathilde', '2013-10-14', 'HerveBourg', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Émile Louis', '+33 (0)2 06 48 80 75', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(60, NULL, '6E040A', 'Allard', 'Roland', '2014-05-14', 'Besson-la-Forêt', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Isabelle Leconte', '0146814218', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(61, NULL, '6E041A', 'Schneider', 'Yves', '2014-10-11', 'Lopez', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Pénélope Le Da Silva', '+33 (0)3 76 98 36 81', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(62, NULL, '6E042A', 'Chevalier', 'Élodie', '2013-09-08', 'Collin-sur-Mer', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Stéphanie Merle', '09 54 80 12 37', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(63, NULL, '6E043A', 'Chauvin', 'Lucas', '2014-10-23', 'Tanguy', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Laurence-Alix Leduc', '+33 (0)6 95 77 98 90', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(64, NULL, '6E044A', 'Devaux', 'William', '2014-01-27', 'Laineboeuf', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Jérôme Georges-Vasseur', '0698263546', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(65, NULL, '6E045A', 'Masson', 'Guy', '2013-10-09', 'Bodin-la-Forêt', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Julien Lesage', '+33 8 00 00 46 68', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(66, NULL, '6E046A', 'Laporte', 'Arthur', '2014-10-17', 'Jean', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Aurore Lecoq', '0428529892', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(67, NULL, '6E047A', 'Levy', 'Julie', '2014-04-20', 'Weberboeuf', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Pierre Etienne', '0153162186', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(68, NULL, '6E048A', 'Labbe', 'Rémy', '2014-10-11', 'LemonnierVille', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Élise Gomes', '0744493760', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(69, NULL, '6E049A', 'Fernandes', 'Joséphine', '2013-10-23', 'GonzalezBourg', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Julien Carlier', '+33 9 95 65 89 91', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(70, NULL, '6E050A', 'Torres', 'Jacqueline', '2014-10-12', 'Boucher-sur-Benard', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Rémy Guyon', '0985504204', NULL, NULL, 5, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(71, NULL, '1L2001A', 'Gauthier', 'Renée', '2010-06-06', 'Lemaitre', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Victoire Roux', '+33 (0)8 28 78 23 10', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(72, NULL, '1L2002A', 'Rodriguez', 'Astrid', '2009-09-28', 'Bessonnec', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Valentine Masson', '0126522748', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(73, NULL, '1L2003A', 'Pascal', 'Lucas', '2009-12-25', 'Launay', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Paul Marty', '01 91 67 64 31', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(74, NULL, '1L2004A', 'Perrin', 'William', '2010-05-08', 'Pierre', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Claudine Bouvier', '01 31 25 88 25', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(75, NULL, '1L2005A', 'Bazin', 'Édith', '2009-08-12', 'BoyerBourg', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Olivie Mace', '0220318929', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(76, NULL, '1L2006A', 'Albert', 'Dorothée', '2009-05-26', 'Berthelot', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Océane Roux', '0296846595', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(77, NULL, '1L2007A', 'Lagarde', 'Alphonse', '2009-05-31', 'Parent', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'William Gay', '0964761202', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(78, NULL, '1L2008A', 'Maillet', 'Xavier', '2009-12-02', 'AugerVille', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Marcelle Blanc-Da Silva', '0190191604', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(79, NULL, '1L2009A', 'Perrot', 'Zacharie', '2010-03-30', 'Valentin', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Vincent Leduc', '06 89 03 80 48', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(80, NULL, '1L2010A', 'Denis', 'Emmanuel', '2009-05-30', 'Texier', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Martin Reynaud', '+33 6 27 07 62 28', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(81, NULL, '1L2011A', 'Berthelot', 'Michelle', '2010-06-04', 'Godard', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Véronique Blanc', '07 48 47 75 29', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(82, NULL, '1L2012A', 'Gomez', 'Diane', '2010-04-05', 'Colas', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Élisabeth de la Ollivier', '+33 (0)8 91 47 55 90', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(83, NULL, '1L2013A', 'Schneider', 'Aurélie', '2010-02-21', 'Gaillard', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Adèle-Agathe Dumont', '0980907056', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(84, NULL, '1L2014A', 'Courtois', 'Alexandria', '2010-04-03', 'Foucherboeuf', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Nathalie de la Vidal', '07 37 16 48 10', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(85, NULL, '1L2015A', 'Leblanc', 'Raymond', '2008-07-15', 'Julien', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Luce Hubert', '+33 (0)4 27 83 65 54', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(86, NULL, '1L2016A', 'Denis', 'Thomas', '2010-03-05', 'Martin-sur-Techer', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Rémy du Raymond', '+33 3 87 49 42 85', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(87, NULL, '1L2017A', 'Blot', 'Jacques', '2009-04-25', 'Fernandez', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Gabrielle Humbert', '03 28 05 66 81', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(88, NULL, '1L2018A', 'Humbert', 'Lucas', '2008-10-21', 'Prevost', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Thomas du Maury', '+33 (0)6 99 35 80 15', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(89, NULL, '1L2019A', 'Schneider', 'Jacques', '2009-07-05', 'Gosselin', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Patrick Bouchet', '01 31 44 41 45', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(90, NULL, '1L2020A', 'Gilbert', 'Léon', '2009-05-06', 'Massonboeuf', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Benoît Delattre', '+33 4 48 08 88 44', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(91, NULL, '1L2021A', 'Delaunay', 'William', '2009-09-19', 'Guyot-sur-Humbert', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Auguste Guichard-Lecomte', '+33 1 47 29 42 52', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(92, NULL, '1L2022A', 'Petitjean', 'Gabriel', '2008-11-29', 'GuillotVille', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Paulette Costa', '01 38 89 54 26', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(93, NULL, '1L2023A', 'Durand', 'Grégoire', '2009-09-06', 'MalletVille', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Benoît Aubry', '02 90 64 96 63', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(94, NULL, '1L2024A', 'Guerin', 'Capucine', '2009-07-26', 'Gillet', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Auguste-Benoît Gillet', '01 78 66 56 22', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(95, NULL, '1L2025A', 'Leduc', 'Paul', '2009-03-21', 'Roux', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Laurence Dias', '+33 (0)7 65 23 67 44', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(96, NULL, '1L2026A', 'Texier', 'Simone', '2010-05-11', 'Ledoux-sur-Durand', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Matthieu Etienne', '0770372940', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(97, NULL, '1L2027A', 'Perez', 'Gilbert', '2008-07-20', 'Dufour', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Margaud Riviere', '+33 (0)1 82 81 21 69', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(98, NULL, '1L2028A', 'Evrard', 'Édouard', '2010-06-21', 'Huet', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Maurice Dupuy', '0940758823', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(99, NULL, '1L2029A', 'Sauvage', 'Sophie', '2009-08-13', 'PiresBourg', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Élise Blondel', '0423555317', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(100, NULL, '1L2030A', 'Peltier', 'Gilles', '2009-07-19', 'Chevallier-sur-Hoarau', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Bernard Collin', '0671299850', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(101, NULL, '1L2031A', 'Techer', 'Capucine', '2010-04-01', 'Adam', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Xavier Gallet-Maillot', '07 77 32 31 14', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(102, NULL, '1L2032A', 'Delattre', 'Gérard', '2010-01-10', 'Brunel', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Gilbert-Jean Martineau', '+33 1 35 83 04 07', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(103, NULL, '1L2033A', 'Ruiz', 'Émile', '2009-04-01', 'CourtoisBourg', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Arthur Reynaud', '01 69 99 02 03', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(104, NULL, '1L2034A', 'Andre', 'Luc', '2010-01-28', 'Blanchetdan', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Christophe Paris-Dupuis', '0808442591', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(105, NULL, '1L2035A', 'Guillon', 'Patricia', '2008-10-01', 'Sanchez', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Daniel Gallet', '08 02 37 15 01', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(106, NULL, '1L2036A', 'Boulay', 'Nicolas', '2010-04-25', 'Tessierboeuf', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Raymond du Barre', '+33 8 92 75 38 99', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(107, NULL, '1L2037A', 'Toussaint', 'Maurice', '2008-11-23', 'Goncalves-sur-Mer', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Gilbert du Lacroix', '0630027066', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(108, NULL, '1L2038A', 'Klein', 'Jeanne', '2009-07-15', 'Bonnet', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Isaac de la Tanguy', '+33 3 97 01 26 22', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(109, NULL, '1L2039A', 'Antoine', 'Éléonore', '2010-02-16', 'Fouquet', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Zoé Hoarau', '+33 (0)1 71 88 02 47', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(110, NULL, '1L2040A', 'Bonnet', 'Bertrand', '2008-09-23', 'Bonnet', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Alexandre Leger-Pruvost', '+33 9 77 46 46 17', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(111, NULL, '1L2041A', 'Jacquet', 'Hugues', '2009-09-29', 'Bazin', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Adélaïde Pruvost', '+33 (0)9 48 49 96 43', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(112, NULL, '1L2042A', 'Couturier', 'Matthieu', '2009-05-16', 'RenardVille', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Françoise Foucher', '01 46 64 03 89', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(113, NULL, '1L2043A', 'Leleu', 'Suzanne', '2009-01-06', 'Robert-sur-Labbe', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Laurent Bonneau', '05 38 71 95 78', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(114, NULL, '1L2044A', 'Collet', 'Margaret', '2008-11-05', 'Vasseur', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Corinne Mary', '07 48 78 33 85', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(115, NULL, '1L2045A', 'Hamon', 'Alphonse', '2010-03-04', 'Albert-les-Bains', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Dorothée Bertrand', '08 99 86 79 57', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(116, NULL, '1L2046A', 'Bailly', 'Claude', '2010-03-15', 'Marques-sur-Brunet', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Henriette Gilbert', '+33 (0)9 16 80 09 53', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(117, NULL, '1L2047A', 'Lefebvre', 'Victor', '2010-03-15', 'CourtoisBourg', 'F', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Nathalie Guillon-Gillet', '+33 8 25 07 02 65', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(118, NULL, '1L2048A', 'Bonneau', 'Alphonse', '2009-09-21', 'Torres', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Jacques Fouquet', '0789183804', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(119, NULL, '1L2049A', 'Huet', 'Christophe', '2008-08-16', 'Gros', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Aurélie Marin', '0404894110', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22'),
(120, NULL, '1L2050A', 'Collin', 'Benjamin', '2009-10-17', 'Coste', 'M', 'Sénégalaise', NULL, NULL, NULL, NULL, NULL, NULL, 'Emmanuelle Hernandez', '+33 (0)3 39 81 85 98', NULL, NULL, 6, 2, 'actif', NULL, NULL, NULL, '2026-07-12 12:44:22', '2026-07-12 12:44:22');

-- --------------------------------------------------------

--
-- Structure de la table `emplois_du_temps`
--

CREATE TABLE `emplois_du_temps` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `classe_id` bigint(20) UNSIGNED NOT NULL,
  `matiere_id` bigint(20) UNSIGNED NOT NULL,
  `enseignant_id` bigint(20) UNSIGNED NOT NULL,
  `salle_id` bigint(20) UNSIGNED DEFAULT NULL,
  `annee_scolaire_id` bigint(20) UNSIGNED NOT NULL,
  `jour` tinyint(4) NOT NULL,
  `heure_debut` time NOT NULL,
  `heure_fin` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `emplois_du_temps`
--

INSERT INTO `emplois_du_temps` (`id`, `classe_id`, `matiere_id`, `enseignant_id`, `salle_id`, `annee_scolaire_id`, `jour`, `heure_debut`, `heure_fin`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1, 1, 1, '08:00:00', '10:00:00', '2026-04-25 12:59:02', '2026-04-25 12:59:02'),
(2, 2, 1, 1, 2, 1, 1, '08:00:00', '10:00:00', '2026-04-25 12:59:02', '2026-04-25 12:59:02'),
(3, 3, 1, 1, 3, 1, 1, '08:00:00', '10:00:00', '2026-04-25 12:59:02', '2026-04-25 12:59:02'),
(4, 4, 1, 1, 1, 1, 1, '08:00:00', '10:00:00', '2026-04-25 12:59:02', '2026-04-25 12:59:02');

-- --------------------------------------------------------

--
-- Structure de la table `enseignants`
--

CREATE TABLE `enseignants` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `matricule` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `specialite` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_perso` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adresse` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sexe` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_naissance` date DEFAULT NULL,
  `lieu_naissance` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nationalite` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Sénégalaise',
  `diplome` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `statut` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `signature` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `heure_service` int(11) NOT NULL DEFAULT 0,
  `date_embauche` date DEFAULT NULL,
  `actif` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `enseignants`
--

INSERT INTO `enseignants` (`id`, `user_id`, `matricule`, `specialite`, `telephone`, `email_perso`, `adresse`, `sexe`, `date_naissance`, `lieu_naissance`, `nationalite`, `diplome`, `statut`, `signature`, `photo`, `heure_service`, `date_embauche`, `actif`, `created_at`, `updated_at`) VALUES
(1, 2, 'PF-2026-001', 'Français', NULL, NULL, NULL, NULL, NULL, NULL, 'Sénégalaise', NULL, 'permanent', NULL, NULL, 0, NULL, 1, '2026-04-25 12:58:52', '2026-04-26 20:17:10'),
(2, 3, 'PF-2026-002', 'Mathématiques', NULL, NULL, NULL, NULL, NULL, NULL, 'Sénégalaise', NULL, NULL, NULL, NULL, 0, NULL, 1, '2026-04-25 12:58:52', '2026-04-25 12:58:52'),
(3, 4, 'PF-2026-003', 'Français', NULL, NULL, NULL, NULL, NULL, NULL, 'Sénégalaise', NULL, NULL, NULL, NULL, 0, NULL, 1, '2026-04-25 12:58:52', '2026-04-25 12:58:52');

-- --------------------------------------------------------

--
-- Structure de la table `enseignant_matiere`
--

CREATE TABLE `enseignant_matiere` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `enseignant_id` bigint(20) UNSIGNED NOT NULL,
  `matiere_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `enseignant_matiere`
--

INSERT INTO `enseignant_matiere` (`id`, `enseignant_id`, `matiere_id`, `created_at`, `updated_at`) VALUES
(1, 1, 2, NULL, NULL),
(2, 1, 5, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `etablissements`
--

CREATE TABLE `etablissements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'prive',
  `cycle` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'mixte',
  `formule_bulletin` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '(M+C)/2',
  `adresse` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ville` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Dakar',
  `telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `directeur_nom` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `academie` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `inspection` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `etablissements`
--

INSERT INTO `etablissements` (`id`, `nom`, `code`, `type`, `cycle`, `formule_bulletin`, `adresse`, `ville`, `telephone`, `email`, `logo`, `directeur_nom`, `academie`, `inspection`, `description`, `created_at`, `updated_at`) VALUES
(1, 'SunuEcole Digital Academy', 'SE-2026', 'prive', 'mixte', '(M+C)/2', 'Dakar, Plateau', 'Dakar', '+221 33 000 00 00', 'contact@sunuecole.sn', NULL, 'Ibrahima Diallo', NULL, NULL, 'Établissement d\'excellence pour la formation numérique.', '2026-04-26 16:46:41', '2026-04-26 16:46:41');

-- --------------------------------------------------------

--
-- Structure de la table `evaluations`
--

CREATE TABLE `evaluations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `classe_id` bigint(20) UNSIGNED NOT NULL,
  `matiere_id` bigint(20) UNSIGNED NOT NULL,
  `enseignant_id` bigint(20) UNSIGNED NOT NULL,
  `annee_scolaire_id` bigint(20) UNSIGNED DEFAULT NULL,
  `titre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_evaluation` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Devoir',
  `date_evaluation` date NOT NULL,
  `coefficient` decimal(5,2) NOT NULL DEFAULT 1.00,
  `semestre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `evaluations`
--

INSERT INTO `evaluations` (`id`, `classe_id`, `matiere_id`, `enseignant_id`, `annee_scolaire_id`, `titre`, `type_evaluation`, `date_evaluation`, `coefficient`, `semestre`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1, 'devoir 1', 'Devoir', '2026-08-12', '1.00', '1', '2026-07-13 16:29:11', '2026-07-13 16:29:11'),
(2, 1, 1, 1, 1, 'Devoir 2', 'Devoir', '2026-01-01', '1.00', '1', '2026-09-02 11:40:02', '2026-09-02 11:40:02'),
(6, 1, 1, 1, 1, 'devoir 3', 'devoir', '2026-09-02', '2.00', 'Premier Semestre', '2026-09-02 13:10:11', '2026-09-02 13:10:11');

-- --------------------------------------------------------

--
-- Structure de la table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `historiques_scolaires`
--

CREATE TABLE `historiques_scolaires` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `eleve_id` bigint(20) UNSIGNED NOT NULL,
  `classe_id` bigint(20) UNSIGNED NOT NULL,
  `annee_scolaire_id` bigint(20) UNSIGNED NOT NULL,
  `moyenne_annuelle` decimal(5,2) DEFAULT NULL,
  `rang_annuel` int(11) DEFAULT NULL,
  `decision` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observations` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `inscriptions`
--

CREATE TABLE `inscriptions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `eleve_id` bigint(20) UNSIGNED NOT NULL,
  `classe_id` bigint(20) UNSIGNED NOT NULL,
  `annee_scolaire_id` bigint(20) UNSIGNED NOT NULL,
  `date_inscription` date NOT NULL,
  `statut` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'actif',
  `avec_cantine` tinyint(1) NOT NULL DEFAULT 0,
  `avec_transport` tinyint(1) NOT NULL DEFAULT 0,
  `remise_inscription` decimal(10,2) NOT NULL DEFAULT 0.00,
  `remise_mensualite` decimal(10,2) NOT NULL DEFAULT 0.00,
  `notes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `inscriptions`
--

INSERT INTO `inscriptions` (`id`, `eleve_id`, `classe_id`, `annee_scolaire_id`, `date_inscription`, `statut`, `avec_cantine`, `avec_transport`, `remise_inscription`, `remise_mensualite`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, '2026-04-25', 'actif', 0, 0, '0.00', '0.00', NULL, '2026-04-25 12:58:53', '2026-04-25 12:58:53'),
(2, 2, 1, 1, '2026-04-25', 'actif', 0, 0, '0.00', '0.00', NULL, '2026-04-25 12:58:53', '2026-04-25 12:58:53'),
(3, 3, 1, 1, '2026-04-25', 'actif', 0, 0, '0.00', '0.00', NULL, '2026-04-25 12:58:54', '2026-04-25 12:58:54'),
(4, 4, 1, 1, '2026-04-25', 'actif', 0, 0, '0.00', '0.00', NULL, '2026-04-25 12:58:54', '2026-04-25 12:58:54'),
(5, 5, 1, 1, '2026-04-25', 'actif', 0, 0, '0.00', '0.00', NULL, '2026-04-25 12:58:55', '2026-04-25 12:58:55'),
(6, 6, 2, 1, '2026-04-25', 'actif', 0, 0, '0.00', '0.00', NULL, '2026-04-25 12:58:55', '2026-04-25 12:58:55'),
(7, 7, 2, 1, '2026-04-25', 'actif', 0, 0, '0.00', '0.00', NULL, '2026-04-25 12:58:56', '2026-04-25 12:58:56'),
(8, 8, 2, 1, '2026-04-25', 'actif', 0, 0, '0.00', '0.00', NULL, '2026-04-25 12:58:56', '2026-04-25 12:58:56'),
(9, 9, 2, 1, '2026-04-25', 'actif', 0, 0, '0.00', '0.00', NULL, '2026-04-25 12:58:57', '2026-04-25 12:58:57'),
(10, 10, 2, 1, '2026-04-25', 'actif', 0, 0, '0.00', '0.00', NULL, '2026-04-25 12:58:57', '2026-04-25 12:58:57'),
(11, 11, 3, 1, '2026-04-25', 'actif', 0, 0, '0.00', '0.00', NULL, '2026-04-25 12:58:58', '2026-04-25 12:58:58'),
(12, 12, 3, 1, '2026-04-25', 'actif', 0, 0, '0.00', '0.00', NULL, '2026-04-25 12:58:58', '2026-04-25 12:58:58'),
(13, 13, 3, 1, '2026-04-25', 'actif', 0, 0, '0.00', '0.00', NULL, '2026-04-25 12:58:59', '2026-04-25 12:58:59'),
(14, 14, 3, 1, '2026-04-25', 'actif', 0, 0, '0.00', '0.00', NULL, '2026-04-25 12:58:59', '2026-04-25 12:58:59'),
(15, 15, 3, 1, '2026-04-25', 'actif', 0, 0, '0.00', '0.00', NULL, '2026-04-25 12:59:00', '2026-04-25 12:59:00'),
(16, 16, 4, 1, '2026-04-25', 'actif', 0, 0, '0.00', '0.00', NULL, '2026-04-25 12:59:00', '2026-04-25 12:59:00'),
(17, 17, 4, 1, '2026-04-25', 'actif', 0, 0, '0.00', '0.00', NULL, '2026-04-25 12:59:01', '2026-04-25 12:59:01'),
(18, 18, 4, 1, '2026-04-25', 'actif', 0, 0, '0.00', '0.00', NULL, '2026-04-25 12:59:01', '2026-04-25 12:59:01'),
(19, 19, 4, 1, '2026-04-25', 'actif', 0, 0, '0.00', '0.00', NULL, '2026-04-25 12:59:02', '2026-04-25 12:59:02'),
(20, 20, 4, 1, '2026-04-25', 'actif', 0, 0, '0.00', '0.00', NULL, '2026-04-25 12:59:02', '2026-04-25 12:59:02');

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `justifications`
--

CREATE TABLE `justifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `absence_id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `valide_par` bigint(20) UNSIGNED DEFAULT NULL,
  `motif` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `statut` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'soumise',
  `commentaire_admin` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `matieres`
--

CREATE TABLE `matieres` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cycle_id` bigint(20) UNSIGNED DEFAULT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `coefficient` decimal(4,1) NOT NULL DEFAULT 1.0,
  `niveau_id` bigint(20) UNSIGNED DEFAULT NULL,
  `serie_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'obligatoire',
  `groupe` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `matieres`
--

INSERT INTO `matieres` (`id`, `cycle_id`, `nom`, `code`, `coefficient`, `niveau_id`, `serie_id`, `type`, `groupe`, `active`, `created_at`, `updated_at`) VALUES
(1, 2, 'Mathématiques', 'MATH', '1.0', NULL, NULL, 'obligatoire', NULL, 1, '2026-04-25 12:58:52', '2026-04-25 12:58:52'),
(2, 2, 'Français', 'FR', '1.0', NULL, NULL, 'obligatoire', NULL, 1, '2026-04-25 12:58:52', '2026-04-25 12:58:52'),
(3, 2, 'SVT', 'SVT', '1.0', NULL, NULL, 'obligatoire', NULL, 1, '2026-04-25 12:58:52', '2026-04-25 12:58:52'),
(4, 3, 'Physique-Chimie', 'PC', '1.0', NULL, NULL, 'obligatoire', NULL, 1, '2026-04-25 12:58:52', '2026-04-25 12:58:52'),
(5, 3, 'Philosophie', 'PHILO', '1.0', NULL, NULL, 'obligatoire', NULL, 1, '2026-04-25 12:58:52', '2026-04-25 12:58:52'),
(6, 2, 'Histoire-Géographie', 'HG', '2.0', NULL, NULL, 'obligatoire', NULL, 1, '2026-07-12 12:41:05', '2026-07-12 12:41:05'),
(7, 2, 'Anglais', 'ANG', '2.0', NULL, NULL, 'obligatoire', NULL, 1, '2026-07-12 12:41:05', '2026-07-12 12:41:05'),
(8, 2, 'Education Physique', 'EPS', '2.0', NULL, NULL, 'obligatoire', NULL, 1, '2026-07-12 12:41:05', '2026-07-12 12:41:05'),
(9, 2, 'Arabe', 'ARA', '2.0', NULL, NULL, 'optionnel', NULL, 1, '2026-07-12 12:41:05', '2026-07-12 12:41:05'),
(10, 3, 'Français', 'FR_L2', '4.0', NULL, NULL, 'obligatoire', NULL, 1, '2026-07-12 12:41:05', '2026-07-12 12:41:05'),
(11, 3, 'Histoire-Géographie', 'HG_L2', '4.0', NULL, NULL, 'obligatoire', NULL, 1, '2026-07-12 12:41:05', '2026-07-12 12:41:05'),
(12, 3, 'Anglais', 'ANG_L2', '3.0', NULL, NULL, 'obligatoire', NULL, 1, '2026-07-12 12:41:05', '2026-07-12 12:41:05'),
(13, 3, 'Espagnol', 'LV2_ESP', '3.0', NULL, NULL, 'obligatoire', NULL, 1, '2026-07-12 12:41:05', '2026-07-12 12:41:05'),
(14, 3, 'Mathématiques', 'MATH_L2', '2.0', NULL, NULL, 'obligatoire', NULL, 1, '2026-07-12 12:41:05', '2026-07-12 12:41:05'),
(15, 3, 'Education Physique', 'EPS_L2', '2.0', NULL, NULL, 'obligatoire', NULL, 1, '2026-07-12 12:41:05', '2026-07-12 12:41:05');

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_04_24_114254_create_permission_tables', 1),
(5, '2026_04_24_114342_create_annee_scolaires_table', 1),
(6, '2026_04_24_114343_create_etablissements_table', 1),
(7, '2026_04_24_114343_create_niveaux_table', 1),
(8, '2026_04_24_114344_create_salles_table', 1),
(9, '2026_04_24_114344_create_series_table', 1),
(10, '2026_04_24_114345_create_classes_table', 1),
(11, '2026_04_24_114346_create_matieres_table', 1),
(12, '2026_04_24_114348_create_parents_table', 1),
(13, '2026_04_24_114349_create_enseignants_table', 1),
(14, '2026_04_24_114350_create_eleves_table', 1),
(15, '2026_04_24_114351_create_classe_matiere_table', 1),
(16, '2026_04_24_114352_create_emplois_du_temps_table', 1),
(17, '2026_04_24_114357_create_notes_table', 1),
(18, '2026_04_24_114358_create_bulletins_table', 1),
(19, '2026_04_24_114358_create_historiques_scolaires_table', 1),
(20, '2026_04_24_114359_create_absences_table', 1),
(21, '2026_04_24_114359_create_justifications_table', 1),
(22, '2026_04_24_114399_create_types_paiements_table', 1),
(23, '2026_04_24_114400_create_paiements_table', 1),
(24, '2026_04_24_114401_create_audit_logs_table', 1),
(25, '2026_04_24_114401_create_recus_table', 1),
(26, '2026_04_24_114402_create_notifications_table', 1),
(27, '2026_04_24_133009_create_personal_access_tokens_table', 1),
(28, '2026_04_24_165745_create_inscriptions_table', 1),
(29, '2026_04_25_125623_create_cycles_table', 1),
(30, '2026_04_25_125652_add_cycle_id_to_classes_and_users_tables', 1),
(31, '2026_04_25_125737_add_cycle_id_to_niveaux_and_matieres_tables', 1),
(32, '2026_04_25_173717_adjust_absences_table_columns_for_controller', 2),
(33, '2026_04_25_174755_add_remises_to_inscriptions_table', 3),
(34, '2026_04_25_174755_create_tarifs_table', 3),
(35, '2026_04_26_200648_create_enseignant_matiere_table', 4),
(36, '2026_06_30_233240_add_numero_devoir_to_notes_table', 5),
(37, '2026_07_01_001026_add_formule_bulletin_to_etablissements_table', 6),
(38, '2026_07_12_134958_create_cahier_textes_table', 7),
(39, '2026_07_12_135107_add_cahier_texte_id_to_absences_table', 7),
(40, '2026_07_13_110510_add_heures_to_cahier_textes_table', 8),
(41, '2026_07_13_155537_create_evaluations_table', 9),
(42, '2026_07_13_155649_add_evaluation_id_to_notes_table', 9),
(43, '2026_09_02_125918_make_enseignant_id_nullable_in_evaluations_table', 10),
(44, '2026_09_02_130020_change_semestre_to_string_in_evaluations_table', 11),
(45, '2026_09_02_130820_revert_enseignant_id_nullable_in_evaluations', 12),
(46, '2026_09_03_122148_create_convocations_table', 13),
(47, '2026_09_07_164715_add_financial_fields_to_classes_and_inscriptions', 14),
(48, '2026_09_08_155636_create_depenses_table', 15);

-- --------------------------------------------------------

--
-- Structure de la table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(5, 'App\\Models\\User', 2),
(5, 'App\\Models\\User', 3),
(5, 'App\\Models\\User', 4),
(6, 'App\\Models\\User', 5),
(6, 'App\\Models\\User', 7),
(6, 'App\\Models\\User', 9),
(6, 'App\\Models\\User', 11),
(6, 'App\\Models\\User', 13),
(6, 'App\\Models\\User', 15),
(6, 'App\\Models\\User', 17),
(6, 'App\\Models\\User', 19),
(6, 'App\\Models\\User', 21),
(6, 'App\\Models\\User', 23),
(6, 'App\\Models\\User', 25),
(6, 'App\\Models\\User', 27),
(6, 'App\\Models\\User', 29),
(6, 'App\\Models\\User', 31),
(6, 'App\\Models\\User', 33),
(6, 'App\\Models\\User', 35),
(6, 'App\\Models\\User', 37),
(6, 'App\\Models\\User', 39),
(6, 'App\\Models\\User', 41),
(6, 'App\\Models\\User', 43),
(7, 'App\\Models\\User', 6),
(7, 'App\\Models\\User', 8),
(7, 'App\\Models\\User', 10),
(7, 'App\\Models\\User', 12),
(7, 'App\\Models\\User', 14),
(7, 'App\\Models\\User', 16),
(7, 'App\\Models\\User', 18),
(7, 'App\\Models\\User', 20),
(7, 'App\\Models\\User', 22),
(7, 'App\\Models\\User', 24),
(7, 'App\\Models\\User', 26),
(7, 'App\\Models\\User', 28),
(7, 'App\\Models\\User', 30),
(7, 'App\\Models\\User', 32),
(7, 'App\\Models\\User', 34),
(7, 'App\\Models\\User', 36),
(7, 'App\\Models\\User', 38),
(7, 'App\\Models\\User', 40),
(7, 'App\\Models\\User', 42),
(7, 'App\\Models\\User', 44);

-- --------------------------------------------------------

--
-- Structure de la table `niveaux`
--

CREATE TABLE `niveaux` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cycle_id` bigint(20) UNSIGNED DEFAULT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ordre` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `niveaux`
--

INSERT INTO `niveaux` (`id`, `cycle_id`, `nom`, `code`, `ordre`, `created_at`, `updated_at`) VALUES
(1, 2, 'Sixième', '6EME', 1, '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(2, 2, 'Troisième', '3EME', 1, '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(3, 3, 'Seconde S', '2S', 1, '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(4, 3, 'Terminale S2', 'TS2', 1, '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(5, 3, '1ère', '1ERE', 1, '2026-07-12 12:41:05', '2026-07-12 12:41:05');

-- --------------------------------------------------------

--
-- Structure de la table `notes`
--

CREATE TABLE `notes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `eleve_id` bigint(20) UNSIGNED NOT NULL,
  `matiere_id` bigint(20) UNSIGNED NOT NULL,
  `classe_id` bigint(20) UNSIGNED NOT NULL,
  `annee_scolaire_id` bigint(20) UNSIGNED DEFAULT NULL,
  `enseignant_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type_evaluation` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero_devoir` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `periode` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `valeur` decimal(5,2) NOT NULL,
  `coefficient` decimal(4,1) NOT NULL DEFAULT 1.0,
  `date_evaluation` date NOT NULL,
  `commentaire` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `verrouille` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `evaluation_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `notes`
--

INSERT INTO `notes` (`id`, `eleve_id`, `matiere_id`, `classe_id`, `annee_scolaire_id`, `enseignant_id`, `type_evaluation`, `numero_devoir`, `periode`, `valeur`, `coefficient`, `date_evaluation`, `commentaire`, `verrouille`, `created_at`, `updated_at`, `evaluation_id`) VALUES
(6, 6, 1, 2, 1, NULL, 'devoir', 1, 'Premier Semestre', '17.00', '1.0', '2026-04-25', NULL, 0, '2026-04-25 12:58:55', '2026-04-25 12:58:55', NULL),
(7, 7, 1, 2, 1, NULL, 'devoir', 1, 'Premier Semestre', '14.00', '1.0', '2026-04-25', NULL, 0, '2026-04-25 12:58:56', '2026-04-25 12:58:56', NULL),
(8, 8, 1, 2, 1, NULL, 'devoir', 1, 'Premier Semestre', '11.00', '1.0', '2026-04-25', NULL, 0, '2026-04-25 12:58:56', '2026-04-25 12:58:56', NULL),
(9, 9, 1, 2, 1, NULL, 'devoir', 1, 'Premier Semestre', '17.00', '1.0', '2026-04-25', NULL, 0, '2026-04-25 12:58:57', '2026-04-25 12:58:57', NULL),
(10, 10, 1, 2, 1, NULL, 'devoir', 1, 'Premier Semestre', '15.00', '1.0', '2026-04-25', NULL, 0, '2026-04-25 12:58:57', '2026-04-25 12:58:57', NULL),
(11, 11, 1, 3, 1, NULL, 'devoir', 1, 'Premier Semestre', '10.00', '1.0', '2026-04-25', NULL, 0, '2026-04-25 12:58:58', '2026-04-25 12:58:58', NULL),
(12, 12, 1, 3, 1, NULL, 'devoir', 1, 'Premier Semestre', '16.00', '1.0', '2026-04-25', NULL, 0, '2026-04-25 12:58:58', '2026-04-25 12:58:58', NULL),
(13, 13, 1, 3, 1, NULL, 'devoir', 1, 'Premier Semestre', '11.00', '1.0', '2026-04-25', NULL, 0, '2026-04-25 12:58:59', '2026-04-25 12:58:59', NULL),
(14, 14, 1, 3, 1, NULL, 'devoir', 1, 'Premier Semestre', '14.00', '1.0', '2026-04-25', NULL, 0, '2026-04-25 12:58:59', '2026-04-25 12:58:59', NULL),
(15, 15, 1, 3, 1, NULL, 'devoir', 1, 'Premier Semestre', '17.00', '1.0', '2026-04-25', NULL, 0, '2026-04-25 12:59:00', '2026-04-25 12:59:00', NULL),
(16, 16, 1, 4, 1, NULL, 'devoir', 1, 'Premier Semestre', '16.00', '1.0', '2026-04-25', NULL, 0, '2026-04-25 12:59:00', '2026-04-25 12:59:00', NULL),
(17, 17, 1, 4, 1, NULL, 'devoir', 1, 'Premier Semestre', '16.00', '1.0', '2026-04-25', NULL, 0, '2026-04-25 12:59:01', '2026-04-25 12:59:01', NULL),
(18, 18, 1, 4, 1, NULL, 'devoir', 1, 'Premier Semestre', '10.00', '1.0', '2026-04-25', NULL, 0, '2026-04-25 12:59:01', '2026-04-25 12:59:01', NULL),
(19, 19, 1, 4, 1, NULL, 'devoir', 1, 'Premier Semestre', '11.00', '1.0', '2026-04-25', NULL, 0, '2026-04-25 12:59:02', '2026-04-25 12:59:02', NULL),
(20, 20, 1, 4, 1, NULL, 'devoir', 1, 'Premier Semestre', '17.00', '1.0', '2026-04-25', NULL, 0, '2026-04-25 12:59:02', '2026-04-25 12:59:02', NULL),
(21, 1, 2, 1, 1, NULL, 'devoir', 1, 'Premier Semestre', '10.00', '1.0', '2026-07-01', NULL, 0, '2026-07-01 10:40:28', '2026-07-01 10:40:28', NULL),
(22, 2, 2, 1, 1, NULL, 'devoir', 1, 'Premier Semestre', '15.00', '1.0', '2026-07-01', NULL, 0, '2026-07-01 10:40:28', '2026-07-01 10:40:28', NULL),
(23, 3, 2, 1, 1, NULL, 'devoir', 1, 'Premier Semestre', '9.00', '1.0', '2026-07-01', NULL, 0, '2026-07-01 10:40:28', '2026-07-01 10:40:28', NULL),
(24, 4, 2, 1, 1, NULL, 'devoir', 1, 'Premier Semestre', '18.00', '1.0', '2026-07-01', NULL, 0, '2026-07-01 10:40:28', '2026-07-01 10:40:28', NULL),
(25, 5, 2, 1, 1, NULL, 'devoir', 1, 'Premier Semestre', '13.00', '1.0', '2026-07-01', NULL, 0, '2026-07-01 10:40:28', '2026-07-01 10:40:28', NULL),
(26, 1, 3, 1, 1, NULL, 'devoir', 1, 'Premier Semestre', '12.00', '1.0', '2026-07-01', NULL, 0, '2026-07-01 10:40:57', '2026-07-01 10:40:57', NULL),
(27, 2, 3, 1, 1, NULL, 'devoir', 1, 'Premier Semestre', '15.00', '1.0', '2026-07-01', NULL, 0, '2026-07-01 10:40:57', '2026-07-01 10:40:57', NULL),
(28, 3, 3, 1, 1, NULL, 'devoir', 1, 'Premier Semestre', '10.00', '1.0', '2026-07-01', NULL, 0, '2026-07-01 10:40:57', '2026-07-01 10:40:57', NULL),
(29, 4, 3, 1, 1, NULL, 'devoir', 1, 'Premier Semestre', '17.00', '1.0', '2026-07-01', NULL, 0, '2026-07-01 10:40:57', '2026-07-01 10:40:57', NULL),
(30, 5, 3, 1, 1, NULL, 'devoir', 1, 'Premier Semestre', '11.00', '1.0', '2026-07-01', NULL, 0, '2026-07-01 10:40:57', '2026-07-01 10:40:57', NULL),
(31, 1, 3, 1, 1, NULL, 'devoir', 2, 'Premier Semestre', '11.00', '1.0', '2026-07-01', NULL, 0, '2026-07-01 10:41:45', '2026-07-01 10:41:45', NULL),
(32, 2, 3, 1, 1, NULL, 'devoir', 2, 'Premier Semestre', '18.00', '1.0', '2026-07-01', NULL, 0, '2026-07-01 10:41:45', '2026-07-01 10:41:45', NULL),
(33, 3, 3, 1, 1, NULL, 'devoir', 2, 'Premier Semestre', '15.00', '1.0', '2026-07-01', NULL, 0, '2026-07-01 10:41:45', '2026-07-01 10:41:45', NULL),
(34, 4, 3, 1, 1, NULL, 'devoir', 2, 'Premier Semestre', '10.00', '1.0', '2026-07-01', NULL, 0, '2026-07-01 10:41:45', '2026-07-01 10:41:45', NULL),
(35, 5, 3, 1, 1, NULL, 'devoir', 2, 'Premier Semestre', '13.00', '1.0', '2026-07-01', NULL, 0, '2026-07-01 10:41:45', '2026-07-01 10:41:45', NULL),
(46, 1, 2, 1, 1, NULL, 'composition', 1, 'Premier Semestre', '17.00', '1.0', '2026-07-01', NULL, 0, '2026-07-01 10:43:27', '2026-07-01 10:43:27', NULL),
(47, 2, 2, 1, 1, NULL, 'composition', 1, 'Premier Semestre', '12.00', '1.0', '2026-07-01', NULL, 0, '2026-07-01 10:43:27', '2026-07-01 10:43:27', NULL),
(48, 3, 2, 1, 1, NULL, 'composition', 1, 'Premier Semestre', '14.00', '1.0', '2026-07-01', NULL, 0, '2026-07-01 10:43:27', '2026-07-01 10:43:27', NULL),
(49, 4, 2, 1, 1, NULL, 'composition', 1, 'Premier Semestre', '10.00', '1.0', '2026-07-01', NULL, 0, '2026-07-01 10:43:27', '2026-07-01 10:43:27', NULL),
(50, 5, 2, 1, 1, NULL, 'composition', 1, 'Premier Semestre', '15.00', '1.0', '2026-07-01', NULL, 0, '2026-07-01 10:43:27', '2026-07-01 10:43:27', NULL),
(51, 1, 3, 1, 1, NULL, 'composition', 1, 'Premier Semestre', '10.00', '1.0', '2026-07-01', NULL, 0, '2026-07-01 10:43:51', '2026-07-01 10:43:51', NULL),
(52, 2, 3, 1, 1, NULL, 'composition', 1, 'Premier Semestre', '13.00', '1.0', '2026-07-01', NULL, 0, '2026-07-01 10:43:51', '2026-07-01 10:43:51', NULL),
(53, 3, 3, 1, 1, NULL, 'composition', 1, 'Premier Semestre', '10.00', '1.0', '2026-07-01', NULL, 0, '2026-07-01 10:43:51', '2026-07-01 10:43:51', NULL),
(54, 4, 3, 1, 1, NULL, 'composition', 1, 'Premier Semestre', '15.00', '1.0', '2026-07-01', NULL, 0, '2026-07-01 10:43:51', '2026-07-01 10:43:51', NULL),
(55, 5, 3, 1, 1, NULL, 'composition', 1, 'Premier Semestre', '14.00', '1.0', '2026-07-01', NULL, 0, '2026-07-01 10:43:51', '2026-07-01 10:43:51', NULL),
(56, 21, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.98', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(57, 21, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.27', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(58, 21, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.55', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(59, 21, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.77', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(60, 21, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.39', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(61, 21, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.79', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(62, 21, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.31', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(63, 21, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.36', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(64, 21, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.46', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(65, 21, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.03', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(66, 21, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.01', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(67, 21, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.11', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(68, 21, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.01', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(69, 21, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.08', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(70, 21, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.03', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(71, 21, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.73', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(72, 21, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.80', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(73, 21, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.58', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(74, 21, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.72', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(75, 21, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.25', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(76, 21, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.84', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(77, 21, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '12.74', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(78, 21, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.58', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(79, 21, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.78', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(80, 21, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.40', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(81, 21, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.85', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(82, 21, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.72', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(83, 21, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '6.06', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(84, 21, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.11', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(85, 21, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.66', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(86, 21, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.54', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(87, 21, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.44', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(88, 21, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.09', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(89, 21, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.68', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(90, 21, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.05', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(91, 21, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.87', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(92, 21, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.69', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(93, 21, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.86', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(94, 21, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.83', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(95, 21, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.43', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(96, 21, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '13.32', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(97, 21, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.44', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(98, 22, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.18', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(99, 22, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.89', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(100, 22, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.41', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(101, 22, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.86', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:22', '2026-07-12 12:44:22', NULL),
(102, 22, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.58', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(103, 22, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.25', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(104, 22, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.53', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(105, 22, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.52', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(106, 22, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.87', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(107, 22, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.97', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(108, 22, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.76', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(109, 22, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.16', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(110, 22, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.42', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(111, 22, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.11', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(112, 22, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.82', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(113, 22, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.54', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(114, 22, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.16', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(115, 22, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.11', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(116, 22, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '18.36', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(117, 22, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.37', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(118, 22, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '8.26', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(119, 22, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.76', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(120, 22, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '18.03', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(121, 22, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.33', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(122, 22, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.91', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(123, 22, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.28', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(124, 22, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.56', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(125, 22, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.90', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(126, 22, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.77', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(127, 22, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.31', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(128, 22, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.51', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(129, 22, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '11.71', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(130, 22, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.51', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(131, 22, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.49', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(132, 22, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.60', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(133, 22, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.57', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(134, 22, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '16.47', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(135, 22, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.14', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(136, 22, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '15.99', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(137, 22, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.95', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(138, 22, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '18.28', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(139, 22, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.82', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(140, 23, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.13', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(141, 23, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.72', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(142, 23, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.44', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(143, 23, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.40', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(144, 23, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.78', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(145, 23, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.56', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(146, 23, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.63', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(147, 23, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.45', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(148, 23, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.06', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(149, 23, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.65', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(150, 23, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.13', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(151, 23, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '8.44', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(152, 23, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.14', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(153, 23, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.81', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(154, 23, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.95', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(155, 23, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.87', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(156, 23, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.10', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(157, 23, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.12', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(158, 23, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '18.09', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(159, 23, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.14', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(160, 23, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.34', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(161, 23, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '16.58', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(162, 23, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.88', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(163, 23, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.65', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(164, 23, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.04', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(165, 23, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '14.72', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(166, 23, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.00', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(167, 23, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.57', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(168, 23, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.63', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(169, 23, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.22', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(170, 23, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.18', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(171, 23, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '14.67', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(172, 23, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.03', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(173, 23, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '12.23', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(174, 23, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '14.07', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(175, 23, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.38', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(176, 23, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.48', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(177, 23, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '6.90', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(178, 23, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.60', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(179, 23, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '16.38', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(180, 23, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.96', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(181, 23, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.29', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(182, 24, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.62', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(183, 24, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.32', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(184, 24, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.22', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(185, 24, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.18', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(186, 24, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.97', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(187, 24, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.13', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(188, 24, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.40', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(189, 24, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.85', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(190, 24, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.37', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(191, 24, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.44', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(192, 24, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.98', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(193, 24, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.89', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(194, 24, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.54', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(195, 24, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.92', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(196, 24, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.20', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(197, 24, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.39', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(198, 24, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.06', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(199, 24, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.16', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(200, 24, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.65', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(201, 24, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.81', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(202, 24, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.35', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(203, 24, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '12.43', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(204, 24, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '13.14', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(205, 24, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.21', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(206, 24, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.55', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(207, 24, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '6.74', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(208, 24, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.23', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(209, 24, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '8.85', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(210, 24, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '13.05', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(211, 24, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.66', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(212, 24, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '8.34', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(213, 24, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.60', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(214, 24, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.05', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(215, 24, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '6.83', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(216, 24, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.07', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(217, 24, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.98', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(218, 24, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '16.12', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(219, 24, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '7.21', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(220, 24, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.92', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(221, 24, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.87', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(222, 24, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '18.13', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(223, 24, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.13', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(224, 25, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '18.13', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(225, 25, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.06', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(226, 25, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.18', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(227, 25, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.70', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(228, 25, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.37', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(229, 25, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.29', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(230, 25, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.11', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(231, 25, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.55', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(232, 25, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.82', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(233, 25, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.01', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(234, 25, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.53', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(235, 25, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.19', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(236, 25, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.90', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(237, 25, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.17', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(238, 25, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.38', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(239, 25, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.22', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(240, 25, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.40', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(241, 25, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.24', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(242, 25, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.47', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(243, 25, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.34', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(244, 25, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.40', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(245, 25, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '17.95', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(246, 25, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '11.83', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(247, 25, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.20', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(248, 25, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '17.53', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(249, 25, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.25', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(250, 25, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.54', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(251, 25, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.39', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(252, 25, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '6.82', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(253, 25, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.27', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(254, 25, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '11.09', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(255, 25, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '11.05', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(256, 25, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.10', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(257, 25, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.79', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(258, 25, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.97', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(259, 25, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.91', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(260, 25, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '8.63', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(261, 25, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '18.64', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(262, 25, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.76', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(263, 25, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.74', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(264, 25, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.89', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(265, 25, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.20', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(266, 26, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.44', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(267, 26, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.16', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(268, 26, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.62', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(269, 26, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.33', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(270, 26, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.32', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(271, 26, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.92', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(272, 26, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.89', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(273, 26, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.82', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(274, 26, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.93', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(275, 26, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.68', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(276, 26, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.35', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(277, 26, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.98', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(278, 26, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.44', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(279, 26, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.95', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(280, 26, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.73', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(281, 26, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.60', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(282, 26, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.64', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(283, 26, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.73', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(284, 26, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.83', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(285, 26, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.06', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(286, 26, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.78', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(287, 26, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.21', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(288, 26, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.57', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(289, 26, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.11', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(290, 26, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.95', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(291, 26, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.45', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(292, 26, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.49', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(293, 26, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.29', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(294, 26, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '6.65', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(295, 26, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.62', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(296, 26, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '17.57', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(297, 26, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '13.92', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(298, 26, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.60', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(299, 26, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '6.34', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(300, 26, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.09', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(301, 26, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.28', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(302, 26, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.72', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(303, 26, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.72', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(304, 26, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.89', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(305, 26, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '10.69', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(306, 26, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '18.02', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(307, 26, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.90', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(308, 27, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.47', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(309, 27, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.48', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(310, 27, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.56', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(311, 27, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.02', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(312, 27, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.00', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(313, 27, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.87', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(314, 27, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.94', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(315, 27, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.81', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(316, 27, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.98', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(317, 27, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.97', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(318, 27, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.12', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(319, 27, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.38', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(320, 27, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '18.07', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(321, 27, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.77', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(322, 27, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.81', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(323, 27, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.88', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(324, 27, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.94', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(325, 27, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.95', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(326, 27, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.86', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(327, 27, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.13', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(328, 27, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.22', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(329, 27, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '12.94', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(330, 27, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.68', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(331, 27, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.72', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(332, 27, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.73', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(333, 27, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.57', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(334, 27, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.71', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(335, 27, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '6.39', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(336, 27, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.11', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(337, 27, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.88', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(338, 27, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '6.84', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(339, 27, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '6.37', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(340, 27, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.00', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(341, 27, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.64', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(342, 27, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '7.70', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(343, 27, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.22', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(344, 27, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.58', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(345, 27, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '6.33', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(346, 27, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.56', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(347, 27, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '12.32', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(348, 27, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.23', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(349, 27, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.80', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL);
INSERT INTO `notes` (`id`, `eleve_id`, `matiere_id`, `classe_id`, `annee_scolaire_id`, `enseignant_id`, `type_evaluation`, `numero_devoir`, `periode`, `valeur`, `coefficient`, `date_evaluation`, `commentaire`, `verrouille`, `created_at`, `updated_at`, `evaluation_id`) VALUES
(350, 28, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.68', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(351, 28, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.35', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(352, 28, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.83', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(353, 28, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.61', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(354, 28, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.65', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(355, 28, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.29', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(356, 28, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.08', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(357, 28, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.06', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(358, 28, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.05', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(359, 28, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.38', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(360, 28, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.91', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(361, 28, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.47', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(362, 28, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.43', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(363, 28, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.03', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(364, 28, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.49', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(365, 28, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.39', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(366, 28, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.08', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(367, 28, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.44', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(368, 28, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.97', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(369, 28, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.30', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(370, 28, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.04', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(371, 28, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '8.06', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(372, 28, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.91', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(373, 28, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.99', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(374, 28, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '16.64', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(375, 28, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '6.61', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(376, 28, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.74', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(377, 28, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '8.07', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(378, 28, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.73', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(379, 28, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.01', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(380, 28, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '16.12', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(381, 28, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '18.57', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(382, 28, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.58', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(383, 28, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.25', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(384, 28, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.10', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(385, 28, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.15', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(386, 28, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.37', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(387, 28, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.99', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(388, 28, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.36', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(389, 28, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.33', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(390, 28, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.11', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(391, 28, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.69', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(392, 29, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.16', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(393, 29, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.78', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(394, 29, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.09', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(395, 29, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.03', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(396, 29, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.47', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(397, 29, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.36', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(398, 29, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.67', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(399, 29, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.78', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(400, 29, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.58', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(401, 29, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.40', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(402, 29, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.53', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(403, 29, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.01', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(404, 29, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.01', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(405, 29, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.27', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(406, 29, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.04', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(407, 29, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.64', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(408, 29, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.10', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(409, 29, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.32', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(410, 29, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.70', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(411, 29, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.15', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(412, 29, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.77', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(413, 29, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.27', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(414, 29, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '13.54', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(415, 29, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '15.62', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(416, 29, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '16.70', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(417, 29, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '14.97', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(418, 29, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.11', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(419, 29, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '11.69', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(420, 29, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '13.07', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(421, 29, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.97', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(422, 29, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '11.49', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(423, 29, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '18.74', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(424, 29, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.41', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(425, 29, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '10.48', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(426, 29, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '11.52', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(427, 29, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.15', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(428, 29, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.79', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(429, 29, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '6.48', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(430, 29, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.26', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(431, 29, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.47', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(432, 29, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '18.10', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(433, 29, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.53', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(434, 30, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.47', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(435, 30, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.43', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(436, 30, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.73', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(437, 30, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.73', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(438, 30, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.51', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(439, 30, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.70', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(440, 30, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.69', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(441, 30, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.90', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(442, 30, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.07', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(443, 30, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.99', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(444, 30, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.07', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(445, 30, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.56', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(446, 30, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.42', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(447, 30, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.01', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(448, 30, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.81', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(449, 30, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.78', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(450, 30, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.74', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(451, 30, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.76', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(452, 30, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.41', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(453, 30, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.59', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(454, 30, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.11', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(455, 30, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '6.54', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(456, 30, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '12.66', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(457, 30, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.35', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(458, 30, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '6.48', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(459, 30, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.09', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(460, 30, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.70', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(461, 30, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '17.11', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(462, 30, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '13.67', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(463, 30, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.76', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(464, 30, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.41', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(465, 30, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.67', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(466, 30, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.55', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(467, 30, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '11.07', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(468, 30, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.90', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(469, 30, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '15.62', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(470, 30, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '6.08', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(471, 30, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.53', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(472, 30, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.02', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(473, 30, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.31', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(474, 30, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.56', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(475, 30, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.00', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(476, 31, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.09', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(477, 31, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.63', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(478, 31, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.35', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(479, 31, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.19', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(480, 31, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.32', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(481, 31, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.77', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(482, 31, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.62', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(483, 31, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.91', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(484, 31, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.36', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(485, 31, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '18.49', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(486, 31, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.10', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:23', '2026-07-12 12:44:23', NULL),
(487, 31, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.25', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(488, 31, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.59', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(489, 31, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.89', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(490, 31, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.36', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(491, 31, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.40', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(492, 31, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.40', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(493, 31, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.72', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(494, 31, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.98', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(495, 31, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.52', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(496, 31, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.55', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(497, 31, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '12.75', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(498, 31, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.87', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(499, 31, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.35', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(500, 31, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '10.69', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(501, 31, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.76', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(502, 31, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.12', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(503, 31, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.23', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(504, 31, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '7.63', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(505, 31, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.76', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(506, 31, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '17.17', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(507, 31, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '11.30', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(508, 31, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.24', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(509, 31, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.34', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(510, 31, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.12', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(511, 31, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.44', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(512, 31, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '11.77', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(513, 31, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '13.55', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(514, 31, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.99', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(515, 31, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '17.44', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(516, 31, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '13.71', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(517, 31, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.33', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(518, 32, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.39', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(519, 32, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.23', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(520, 32, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.10', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(521, 32, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.06', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(522, 32, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.60', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(523, 32, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.94', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(524, 32, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.94', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(525, 32, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.34', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(526, 32, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '8.76', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(527, 32, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.30', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(528, 32, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.28', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(529, 32, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.03', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(530, 32, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.48', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(531, 32, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.55', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(532, 32, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.04', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(533, 32, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.92', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(534, 32, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.89', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(535, 32, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.73', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(536, 32, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.81', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(537, 32, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.66', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(538, 32, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '8.50', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(539, 32, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.34', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(540, 32, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.91', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(541, 32, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.79', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(542, 32, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.26', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(543, 32, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '7.60', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(544, 32, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.90', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(545, 32, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.34', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(546, 32, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.26', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(547, 32, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.48', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(548, 32, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '6.01', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(549, 32, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.08', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(550, 32, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.58', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(551, 32, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.47', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(552, 32, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '6.89', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(553, 32, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.81', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(554, 32, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.06', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(555, 32, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.22', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(556, 32, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.58', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(557, 32, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.55', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(558, 32, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '11.41', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(559, 32, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.24', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(560, 33, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.70', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(561, 33, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.62', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(562, 33, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.57', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(563, 33, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.90', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(564, 33, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.43', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(565, 33, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '8.78', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(566, 33, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.89', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(567, 33, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.63', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(568, 33, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.92', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(569, 33, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.57', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(570, 33, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.60', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(571, 33, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.90', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(572, 33, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.14', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(573, 33, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.59', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(574, 33, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.93', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(575, 33, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.37', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(576, 33, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.02', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(577, 33, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.23', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(578, 33, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.99', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(579, 33, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.18', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(580, 33, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.48', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(581, 33, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.12', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(582, 33, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.54', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(583, 33, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.67', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(584, 33, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '16.99', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(585, 33, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '13.59', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(586, 33, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.49', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(587, 33, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.87', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(588, 33, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.29', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(589, 33, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.64', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(590, 33, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '12.94', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(591, 33, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '13.59', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(592, 33, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '15.76', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(593, 33, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.24', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(594, 33, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '7.88', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(595, 33, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.57', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(596, 33, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.63', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(597, 33, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '11.17', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(598, 33, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.43', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(599, 33, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.93', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(600, 33, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '13.06', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(601, 33, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.44', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(602, 34, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.34', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(603, 34, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.66', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(604, 34, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.43', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(605, 34, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.59', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(606, 34, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.65', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(607, 34, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.23', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(608, 34, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.30', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(609, 34, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.58', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(610, 34, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.83', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(611, 34, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.36', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(612, 34, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.53', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(613, 34, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '8.16', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(614, 34, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.31', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(615, 34, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.57', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(616, 34, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.14', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(617, 34, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.23', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(618, 34, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.41', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(619, 34, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.54', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(620, 34, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.23', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(621, 34, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.49', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(622, 34, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.71', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(623, 34, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '10.75', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(624, 34, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.70', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(625, 34, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.99', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(626, 34, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.88', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(627, 34, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '6.85', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(628, 34, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.09', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(629, 34, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.68', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(630, 34, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.64', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(631, 34, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.62', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(632, 34, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.80', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(633, 34, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.85', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(634, 34, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.11', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(635, 34, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '11.09', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(636, 34, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '11.74', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(637, 34, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.18', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(638, 34, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '8.88', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(639, 34, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '7.45', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(640, 34, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.67', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(641, 34, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.28', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(642, 34, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.26', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(643, 34, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.16', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(644, 35, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.66', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(645, 35, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.19', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(646, 35, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.36', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(647, 35, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.23', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(648, 35, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.42', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(649, 35, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.36', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(650, 35, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.64', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(651, 35, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.16', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(652, 35, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.87', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(653, 35, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.75', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(654, 35, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.86', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(655, 35, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.58', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(656, 35, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.54', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(657, 35, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.24', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(658, 35, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.17', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(659, 35, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.15', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(660, 35, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.63', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(661, 35, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.76', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(662, 35, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.59', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(663, 35, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.44', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(664, 35, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.64', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(665, 35, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '17.71', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(666, 35, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '12.75', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(667, 35, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.14', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(668, 35, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '11.33', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(669, 35, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.92', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(670, 35, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.51', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(671, 35, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.77', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(672, 35, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.10', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(673, 35, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.52', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(674, 35, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '10.01', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(675, 35, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.06', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(676, 35, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.05', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(677, 35, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '6.09', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(678, 35, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '18.90', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(679, 35, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.59', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(680, 35, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.77', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(681, 35, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '7.56', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(682, 35, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.72', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(683, 35, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.87', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL);
INSERT INTO `notes` (`id`, `eleve_id`, `matiere_id`, `classe_id`, `annee_scolaire_id`, `enseignant_id`, `type_evaluation`, `numero_devoir`, `periode`, `valeur`, `coefficient`, `date_evaluation`, `commentaire`, `verrouille`, `created_at`, `updated_at`, `evaluation_id`) VALUES
(684, 35, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '18.98', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(685, 35, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.17', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(686, 36, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.10', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(687, 36, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.99', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(688, 36, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.12', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(689, 36, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.49', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(690, 36, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.51', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(691, 36, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.72', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(692, 36, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.25', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(693, 36, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.82', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(694, 36, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.32', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(695, 36, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.47', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(696, 36, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.49', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(697, 36, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.86', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(698, 36, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.64', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(699, 36, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.05', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(700, 36, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '8.06', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(701, 36, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.97', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(702, 36, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.50', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(703, 36, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.28', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(704, 36, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.38', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(705, 36, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.43', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(706, 36, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.46', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(707, 36, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '6.49', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(708, 36, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '14.87', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(709, 36, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.02', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(710, 36, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.90', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(711, 36, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.75', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(712, 36, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '15.60', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(713, 36, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '8.99', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(714, 36, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.60', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(715, 36, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.02', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(716, 36, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.00', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(717, 36, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.16', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(718, 36, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.37', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(719, 36, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '6.32', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(720, 36, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '12.73', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(721, 36, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.77', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(722, 36, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '17.94', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(723, 36, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '7.56', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(724, 36, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.86', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(725, 36, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '11.98', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(726, 36, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '7.82', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(727, 36, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.86', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(728, 37, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '18.04', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(729, 37, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.78', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(730, 37, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.01', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(731, 37, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.21', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(732, 37, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.68', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(733, 37, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.02', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(734, 37, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '18.84', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(735, 37, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.79', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(736, 37, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.16', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(737, 37, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '18.57', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(738, 37, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.57', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(739, 37, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.63', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(740, 37, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.13', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(741, 37, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.53', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(742, 37, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.17', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(743, 37, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.89', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(744, 37, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.05', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(745, 37, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.92', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(746, 37, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.49', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(747, 37, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.35', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(748, 37, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.95', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(749, 37, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.14', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(750, 37, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.76', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(751, 37, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.44', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(752, 37, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.38', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(753, 37, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.70', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(754, 37, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.11', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(755, 37, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '17.81', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(756, 37, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.41', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(757, 37, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.83', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(758, 37, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '6.37', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(759, 37, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.42', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(760, 37, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.74', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(761, 37, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.71', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(762, 37, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.72', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(763, 37, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.37', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(764, 37, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.74', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(765, 37, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '7.22', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(766, 37, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.05', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(767, 37, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.86', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(768, 37, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.88', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(769, 37, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.53', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(770, 38, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.61', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(771, 38, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.65', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(772, 38, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.05', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(773, 38, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.23', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(774, 38, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.59', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(775, 38, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.42', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(776, 38, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.37', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(777, 38, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.11', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(778, 38, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.91', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(779, 38, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.67', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(780, 38, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.55', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(781, 38, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.43', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(782, 38, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.92', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(783, 38, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.07', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(784, 38, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.98', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(785, 38, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.12', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(786, 38, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.18', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(787, 38, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.50', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(788, 38, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.74', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(789, 38, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.67', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(790, 38, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.60', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(791, 38, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '8.68', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(792, 38, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.14', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(793, 38, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.54', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(794, 38, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '10.54', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(795, 38, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.18', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(796, 38, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.17', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(797, 38, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.13', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(798, 38, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.26', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(799, 38, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '15.94', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(800, 38, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.92', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(801, 38, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '6.61', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(802, 38, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.21', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(803, 38, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '6.44', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(804, 38, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '11.81', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(805, 38, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.41', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(806, 38, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '10.98', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(807, 38, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '11.76', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(808, 38, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.00', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(809, 38, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '16.97', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(810, 38, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.88', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(811, 38, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.29', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(812, 39, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.11', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(813, 39, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.95', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(814, 39, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.57', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(815, 39, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.00', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(816, 39, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.78', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(817, 39, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.16', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(818, 39, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.62', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(819, 39, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.34', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(820, 39, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.44', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(821, 39, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.48', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(822, 39, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.52', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(823, 39, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '8.37', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(824, 39, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.67', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(825, 39, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.93', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(826, 39, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.06', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(827, 39, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.02', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(828, 39, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.70', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(829, 39, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '8.52', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(830, 39, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.69', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(831, 39, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.86', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(832, 39, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.21', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(833, 39, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '16.95', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(834, 39, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.39', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(835, 39, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.38', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(836, 39, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.50', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(837, 39, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.59', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(838, 39, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.80', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(839, 39, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '11.28', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(840, 39, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '18.42', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(841, 39, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.22', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(842, 39, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.48', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(843, 39, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '7.31', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(844, 39, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.55', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(845, 39, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.95', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(846, 39, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.70', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(847, 39, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.99', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:24', '2026-07-12 12:44:24', NULL),
(848, 39, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.59', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(849, 39, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.37', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(850, 39, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.57', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(851, 39, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.87', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(852, 39, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.51', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(853, 39, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.33', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(854, 40, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.04', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(855, 40, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.99', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(856, 40, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.00', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(857, 40, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.29', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(858, 40, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.75', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(859, 40, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.35', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(860, 40, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.99', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(861, 40, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.75', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(862, 40, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.03', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(863, 40, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.52', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(864, 40, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.24', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(865, 40, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.76', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(866, 40, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.82', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(867, 40, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.71', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(868, 40, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.79', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(869, 40, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.78', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(870, 40, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.89', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(871, 40, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.23', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(872, 40, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.18', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(873, 40, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.72', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(874, 40, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.44', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(875, 40, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '8.61', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(876, 40, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '18.71', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(877, 40, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.80', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(878, 40, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.62', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(879, 40, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.70', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(880, 40, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.68', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(881, 40, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '11.98', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(882, 40, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '18.15', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(883, 40, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.21', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(884, 40, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.17', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(885, 40, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '7.58', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(886, 40, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.00', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(887, 40, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.28', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(888, 40, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '7.72', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(889, 40, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.23', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(890, 40, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '12.94', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(891, 40, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '14.70', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(892, 40, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.02', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(893, 40, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.67', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(894, 40, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '12.03', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(895, 40, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.48', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(896, 41, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.22', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(897, 41, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.78', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(898, 41, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.38', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(899, 41, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.94', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(900, 41, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.68', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(901, 41, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.98', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(902, 41, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.49', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(903, 41, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.23', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(904, 41, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.31', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(905, 41, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.64', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(906, 41, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.32', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(907, 41, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '8.87', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(908, 41, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.07', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(909, 41, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.71', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(910, 41, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.23', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(911, 41, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '18.82', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(912, 41, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.21', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(913, 41, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.06', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(914, 41, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.23', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(915, 41, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.70', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(916, 41, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '8.15', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(917, 41, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '12.83', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(918, 41, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '7.15', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(919, 41, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.57', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(920, 41, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.82', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(921, 41, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '7.38', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(922, 41, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.99', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(923, 41, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '10.72', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(924, 41, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.22', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(925, 41, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.28', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(926, 41, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.27', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(927, 41, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.30', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(928, 41, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.33', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(929, 41, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '11.40', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(930, 41, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.07', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(931, 41, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.24', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(932, 41, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '6.46', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(933, 41, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '11.83', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(934, 41, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.45', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(935, 41, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.59', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(936, 41, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '11.53', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(937, 41, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.36', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(938, 42, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '18.21', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(939, 42, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.35', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(940, 42, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.22', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(941, 42, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.12', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(942, 42, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.31', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(943, 42, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.99', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(944, 42, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '18.78', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(945, 42, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.34', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(946, 42, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.74', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(947, 42, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.77', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(948, 42, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.31', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(949, 42, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.17', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(950, 42, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.28', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(951, 42, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.75', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(952, 42, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.80', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(953, 42, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.63', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(954, 42, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.33', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(955, 42, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.13', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(956, 42, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.39', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(957, 42, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.46', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(958, 42, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.00', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(959, 42, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.25', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(960, 42, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '14.98', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(961, 42, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.28', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(962, 42, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.20', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(963, 42, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.68', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(964, 42, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.19', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(965, 42, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.30', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(966, 42, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '13.00', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(967, 42, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.04', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(968, 42, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.30', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(969, 42, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.82', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(970, 42, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.67', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(971, 42, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.96', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(972, 42, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.13', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(973, 42, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.95', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(974, 42, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '11.14', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(975, 42, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.32', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(976, 42, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.48', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(977, 42, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.09', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(978, 42, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.83', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(979, 42, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.40', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(980, 43, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.01', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(981, 43, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.28', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(982, 43, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.99', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(983, 43, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.21', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(984, 43, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.75', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(985, 43, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.59', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(986, 43, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.36', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(987, 43, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.32', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(988, 43, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.01', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(989, 43, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.22', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(990, 43, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.29', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(991, 43, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.31', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(992, 43, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.21', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(993, 43, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.76', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(994, 43, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.53', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(995, 43, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.67', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(996, 43, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.30', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(997, 43, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.16', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(998, 43, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.80', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(999, 43, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.73', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1000, 43, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.02', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1001, 43, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '11.00', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1002, 43, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.27', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1003, 43, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '15.44', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1004, 43, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '6.82', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1005, 43, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.00', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1006, 43, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.16', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1007, 43, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.53', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1008, 43, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '14.41', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1009, 43, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.79', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1010, 43, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '17.26', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1011, 43, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.14', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1012, 43, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.26', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1013, 43, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.70', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1014, 43, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.64', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1015, 43, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.44', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1016, 43, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.27', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL);
INSERT INTO `notes` (`id`, `eleve_id`, `matiere_id`, `classe_id`, `annee_scolaire_id`, `enseignant_id`, `type_evaluation`, `numero_devoir`, `periode`, `valeur`, `coefficient`, `date_evaluation`, `commentaire`, `verrouille`, `created_at`, `updated_at`, `evaluation_id`) VALUES
(1017, 43, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '18.17', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1018, 43, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.68', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1019, 43, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.77', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1020, 43, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.93', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1021, 43, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.69', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1022, 44, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.75', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1023, 44, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.65', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1024, 44, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.85', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1025, 44, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.19', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1026, 44, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.56', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1027, 44, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.08', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1028, 44, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.87', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1029, 44, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.75', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1030, 44, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.82', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1031, 44, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.21', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1032, 44, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.33', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1033, 44, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.00', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1034, 44, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.67', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1035, 44, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.77', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1036, 44, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.65', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1037, 44, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.78', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1038, 44, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.95', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1039, 44, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.03', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1040, 44, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.38', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1041, 44, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.19', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1042, 44, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '8.83', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1043, 44, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '12.75', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1044, 44, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '13.28', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1045, 44, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '15.83', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1046, 44, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '11.46', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1047, 44, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.77', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1048, 44, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.72', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1049, 44, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '17.86', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1050, 44, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.96', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1051, 44, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.10', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1052, 44, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.04', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1053, 44, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '7.68', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1054, 44, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.46', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1055, 44, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.08', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1056, 44, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.43', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1057, 44, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.55', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1058, 44, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '6.39', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1059, 44, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '18.42', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1060, 44, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.81', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1061, 44, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.62', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1062, 44, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.56', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1063, 44, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.12', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1064, 45, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.97', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1065, 45, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.09', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1066, 45, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.87', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1067, 45, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.41', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1068, 45, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.15', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1069, 45, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.84', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1070, 45, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.55', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1071, 45, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.61', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1072, 45, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.45', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1073, 45, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.09', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1074, 45, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.12', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1075, 45, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.70', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1076, 45, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.77', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1077, 45, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.08', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1078, 45, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.75', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1079, 45, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.07', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1080, 45, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.58', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1081, 45, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.42', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1082, 45, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.51', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1083, 45, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.80', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1084, 45, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.57', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1085, 45, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.27', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1086, 45, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '6.51', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1087, 45, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.44', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1088, 45, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '17.09', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1089, 45, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.95', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1090, 45, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.92', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1091, 45, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.93', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1092, 45, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '12.48', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1093, 45, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.71', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1094, 45, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '8.29', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1095, 45, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '12.02', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1096, 45, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.21', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1097, 45, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '12.72', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1098, 45, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.39', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1099, 45, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.78', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1100, 45, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.73', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1101, 45, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.75', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1102, 45, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.32', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1103, 45, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '8.05', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1104, 45, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.21', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1105, 45, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '15.32', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1106, 46, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.65', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1107, 46, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.16', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1108, 46, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.45', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1109, 46, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.73', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1110, 46, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.43', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1111, 46, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.94', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1112, 46, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.95', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1113, 46, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.16', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1114, 46, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.09', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1115, 46, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.58', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1116, 46, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.50', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1117, 46, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.18', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1118, 46, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.32', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1119, 46, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.12', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1120, 46, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.98', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1121, 46, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '18.34', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1122, 46, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.99', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1123, 46, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.26', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1124, 46, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.58', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1125, 46, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.22', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1126, 46, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.73', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1127, 46, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.41', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1128, 46, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '18.20', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1129, 46, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.23', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1130, 46, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.25', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1131, 46, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.16', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1132, 46, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.88', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1133, 46, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '12.10', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1134, 46, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.62', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1135, 46, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.66', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1136, 46, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.74', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1137, 46, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '14.15', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1138, 46, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '15.83', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1139, 46, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '10.21', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1140, 46, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.78', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1141, 46, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '15.39', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1142, 46, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.67', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1143, 46, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.27', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1144, 46, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.56', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1145, 46, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.48', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1146, 46, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.85', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1147, 46, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.72', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1148, 47, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.55', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1149, 47, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.90', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1150, 47, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.49', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1151, 47, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.41', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1152, 47, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.32', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1153, 47, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.56', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1154, 47, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.37', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1155, 47, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.79', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1156, 47, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.90', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1157, 47, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.47', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1158, 47, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.90', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1159, 47, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.14', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1160, 47, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.44', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1161, 47, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.99', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1162, 47, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '8.40', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1163, 47, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '18.29', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1164, 47, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.13', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1165, 47, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.10', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1166, 47, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.73', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1167, 47, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.45', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1168, 47, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.17', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1169, 47, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '11.60', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1170, 47, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '12.39', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1171, 47, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.90', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1172, 47, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '12.21', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1173, 47, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.37', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1174, 47, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.04', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1175, 47, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '8.11', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1176, 47, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.84', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1177, 47, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.89', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1178, 47, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '11.92', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1179, 47, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.51', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1180, 47, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.10', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1181, 47, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '17.34', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1182, 47, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '6.21', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1183, 47, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.55', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1184, 47, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '12.19', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1185, 47, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.26', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1186, 47, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.99', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1187, 47, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.41', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1188, 47, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '11.46', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1189, 47, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.18', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1190, 48, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.98', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1191, 48, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.84', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1192, 48, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.89', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1193, 48, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.64', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1194, 48, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.29', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1195, 48, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.26', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1196, 48, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.17', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1197, 48, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.67', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1198, 48, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.06', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1199, 48, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.61', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1200, 48, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.01', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1201, 48, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.72', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1202, 48, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.59', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1203, 48, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.62', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1204, 48, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.20', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1205, 48, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.74', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1206, 48, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.06', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1207, 48, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.25', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1208, 48, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.45', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1209, 48, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.65', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1210, 48, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.30', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1211, 48, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.15', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1212, 48, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '6.06', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1213, 48, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.38', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1214, 48, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '11.27', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1215, 48, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '14.21', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1216, 48, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.29', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1217, 48, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.73', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1218, 48, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.06', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1219, 48, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '15.69', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1220, 48, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '6.98', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:25', '2026-07-12 12:44:25', NULL),
(1221, 48, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '11.07', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1222, 48, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '15.58', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1223, 48, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '12.31', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1224, 48, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.96', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1225, 48, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.68', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1226, 48, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '17.00', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1227, 48, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.69', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1228, 48, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.88', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1229, 48, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '17.70', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1230, 48, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.34', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1231, 48, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.20', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1232, 49, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.75', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1233, 49, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.51', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1234, 49, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.45', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1235, 49, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.57', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1236, 49, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.88', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1237, 49, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.79', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1238, 49, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.12', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1239, 49, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.29', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1240, 49, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.39', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1241, 49, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.99', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1242, 49, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.04', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1243, 49, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.90', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1244, 49, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.96', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1245, 49, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.59', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1246, 49, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.03', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1247, 49, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.22', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1248, 49, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.38', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1249, 49, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.72', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1250, 49, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.10', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1251, 49, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.92', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1252, 49, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.65', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1253, 49, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.88', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1254, 49, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.75', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1255, 49, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.45', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1256, 49, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.19', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1257, 49, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.66', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1258, 49, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.27', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1259, 49, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '11.54', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1260, 49, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.70', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1261, 49, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.83', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1262, 49, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '17.02', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1263, 49, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '14.82', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1264, 49, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.66', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1265, 49, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '16.73', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1266, 49, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '13.93', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1267, 49, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.71', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1268, 49, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.11', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1269, 49, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.50', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1270, 49, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.38', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1271, 49, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.25', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1272, 49, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '13.56', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1273, 49, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.44', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1274, 50, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '18.50', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1275, 50, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.04', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1276, 50, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.80', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1277, 50, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.93', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1278, 50, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.37', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1279, 50, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.40', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1280, 50, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.18', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1281, 50, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.56', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1282, 50, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.21', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1283, 50, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.43', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1284, 50, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.19', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1285, 50, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.93', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1286, 50, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.82', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1287, 50, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.40', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1288, 50, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.27', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1289, 50, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.97', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1290, 50, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.10', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1291, 50, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.42', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1292, 50, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.82', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1293, 50, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.54', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1294, 50, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.27', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1295, 50, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.81', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1296, 50, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '6.90', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1297, 50, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.48', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1298, 50, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.12', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1299, 50, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '6.65', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1300, 50, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.96', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1301, 50, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.16', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1302, 50, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '11.19', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1303, 50, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.67', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1304, 50, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.50', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1305, 50, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '12.28', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1306, 50, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.80', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1307, 50, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.21', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1308, 50, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.74', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1309, 50, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.49', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1310, 50, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '10.92', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1311, 50, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '13.71', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1312, 50, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '15.23', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1313, 50, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.90', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1314, 50, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '6.33', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1315, 50, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.66', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1316, 51, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.23', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1317, 51, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.79', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1318, 51, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.78', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1319, 51, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '18.47', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1320, 51, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.81', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1321, 51, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.51', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1322, 51, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.08', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1323, 51, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.70', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1324, 51, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.36', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1325, 51, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.13', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1326, 51, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.97', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1327, 51, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.85', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1328, 51, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.76', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1329, 51, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.44', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1330, 51, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.49', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1331, 51, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.02', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1332, 51, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.16', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1333, 51, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.48', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1334, 51, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.39', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1335, 51, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.58', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1336, 51, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.29', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1337, 51, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '8.39', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1338, 51, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.58', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1339, 51, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.83', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1340, 51, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.27', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1341, 51, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.03', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1342, 51, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.69', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1343, 51, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.35', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1344, 51, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.49', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1345, 51, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.15', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1346, 51, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.32', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1347, 51, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.83', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL);
INSERT INTO `notes` (`id`, `eleve_id`, `matiere_id`, `classe_id`, `annee_scolaire_id`, `enseignant_id`, `type_evaluation`, `numero_devoir`, `periode`, `valeur`, `coefficient`, `date_evaluation`, `commentaire`, `verrouille`, `created_at`, `updated_at`, `evaluation_id`) VALUES
(1348, 51, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.93', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1349, 51, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '11.23', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1350, 51, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.02', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1351, 51, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.61', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1352, 51, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '12.91', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1353, 51, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.09', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1354, 51, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.18', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1355, 51, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.00', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1356, 51, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.72', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1357, 51, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.54', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1358, 52, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.79', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1359, 52, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.26', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1360, 52, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.08', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1361, 52, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.94', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1362, 52, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.61', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1363, 52, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.56', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1364, 52, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.33', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1365, 52, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.50', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1366, 52, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.29', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1367, 52, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.26', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1368, 52, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.50', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1369, 52, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.39', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1370, 52, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.67', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1371, 52, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.88', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1372, 52, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.65', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1373, 52, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.84', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1374, 52, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.30', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1375, 52, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.23', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1376, 52, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.62', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1377, 52, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.11', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1378, 52, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.36', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1379, 52, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.60', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1380, 52, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '18.81', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1381, 52, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.65', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1382, 52, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.33', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1383, 52, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.62', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1384, 52, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '15.95', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1385, 52, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '16.12', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1386, 52, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.47', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1387, 52, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.30', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1388, 52, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '10.28', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1389, 52, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.11', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1390, 52, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.91', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1391, 52, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.71', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1392, 52, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.87', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1393, 52, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.31', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1394, 52, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '16.64', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1395, 52, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '14.22', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1396, 52, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.93', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1397, 52, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '8.28', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1398, 52, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '13.04', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1399, 52, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.16', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1400, 53, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.25', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1401, 53, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.39', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1402, 53, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.40', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1403, 53, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.81', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1404, 53, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.34', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1405, 53, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.60', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1406, 53, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.00', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1407, 53, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.17', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1408, 53, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.59', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1409, 53, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.91', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1410, 53, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.03', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1411, 53, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.43', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1412, 53, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.67', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1413, 53, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.02', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1414, 53, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.16', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1415, 53, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.16', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1416, 53, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.27', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1417, 53, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.62', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1418, 53, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '18.66', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1419, 53, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.23', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1420, 53, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.06', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1421, 53, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.99', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1422, 53, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.18', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1423, 53, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.00', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1424, 53, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.59', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1425, 53, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.65', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1426, 53, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.29', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1427, 53, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.69', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1428, 53, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '13.81', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1429, 53, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.74', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1430, 53, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '16.88', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1431, 53, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.80', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1432, 53, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.66', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1433, 53, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '6.86', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1434, 53, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.68', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1435, 53, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.84', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1436, 53, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '11.67', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1437, 53, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '7.24', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1438, 53, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.39', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1439, 53, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '8.16', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1440, 53, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.19', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1441, 53, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.94', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1442, 54, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.81', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1443, 54, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.06', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1444, 54, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.69', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1445, 54, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.38', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1446, 54, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.63', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1447, 54, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.23', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1448, 54, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.25', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1449, 54, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.42', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1450, 54, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.44', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1451, 54, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.73', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1452, 54, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.29', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1453, 54, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.82', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1454, 54, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.05', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1455, 54, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.65', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1456, 54, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.40', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1457, 54, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.98', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1458, 54, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.51', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1459, 54, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.44', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1460, 54, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '18.51', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1461, 54, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.87', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1462, 54, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.58', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1463, 54, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.19', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1464, 54, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.27', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1465, 54, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.60', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1466, 54, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.04', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1467, 54, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '11.42', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1468, 54, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.58', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1469, 54, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.34', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1470, 54, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.21', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1471, 54, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.18', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1472, 54, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.49', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1473, 54, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '18.06', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1474, 54, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.64', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1475, 54, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.84', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1476, 54, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '7.18', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1477, 54, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.83', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1478, 54, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.56', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1479, 54, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.57', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1480, 54, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.00', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1481, 54, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '10.65', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1482, 54, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.02', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1483, 54, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.68', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1484, 55, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.53', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1485, 55, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.56', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1486, 55, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.59', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1487, 55, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.73', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1488, 55, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.30', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1489, 55, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.80', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1490, 55, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.47', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1491, 55, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.06', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1492, 55, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.75', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1493, 55, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.08', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1494, 55, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.24', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1495, 55, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.30', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1496, 55, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.29', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1497, 55, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.19', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1498, 55, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.16', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1499, 55, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.92', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1500, 55, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.44', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1501, 55, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.88', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1502, 55, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '18.69', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1503, 55, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.40', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1504, 55, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.71', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1505, 55, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '16.94', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1506, 55, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.49', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1507, 55, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.36', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1508, 55, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.36', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1509, 55, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '6.42', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1510, 55, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.78', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1511, 55, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.42', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1512, 55, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '11.86', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1513, 55, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.29', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1514, 55, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '10.77', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1515, 55, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.83', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1516, 55, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.21', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1517, 55, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.20', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1518, 55, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '18.73', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1519, 55, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.54', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1520, 55, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.03', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1521, 55, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.62', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1522, 55, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.64', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1523, 55, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '10.19', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1524, 55, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '18.74', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1525, 55, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.52', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1526, 56, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.41', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1527, 56, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.23', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1528, 56, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.98', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1529, 56, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.20', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1530, 56, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.29', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1531, 56, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.70', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1532, 56, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.80', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1533, 56, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.96', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1534, 56, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.41', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1535, 56, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.06', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1536, 56, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.50', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1537, 56, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.25', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1538, 56, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.75', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1539, 56, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.57', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1540, 56, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.26', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1541, 56, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.82', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1542, 56, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.59', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1543, 56, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '8.32', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1544, 56, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.03', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1545, 56, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.67', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1546, 56, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.66', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1547, 56, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.71', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1548, 56, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '14.18', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1549, 56, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.34', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1550, 56, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.20', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1551, 56, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.54', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1552, 56, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.24', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1553, 56, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '8.63', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1554, 56, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '11.73', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1555, 56, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '15.48', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1556, 56, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.72', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1557, 56, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.12', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1558, 56, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.46', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1559, 56, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.72', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1560, 56, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.30', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1561, 56, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.39', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1562, 56, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '12.51', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1563, 56, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '14.45', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1564, 56, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.85', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1565, 56, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.26', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1566, 56, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '7.33', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1567, 56, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.32', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1568, 57, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.58', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1569, 57, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.11', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1570, 57, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.66', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1571, 57, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.48', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1572, 57, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.10', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1573, 57, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.86', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1574, 57, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.79', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1575, 57, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.78', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1576, 57, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.54', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1577, 57, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.72', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1578, 57, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.11', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1579, 57, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.00', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1580, 57, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.28', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1581, 57, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.41', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1582, 57, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.91', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1583, 57, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.72', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1584, 57, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.88', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1585, 57, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.47', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1586, 57, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.66', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1587, 57, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.63', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1588, 57, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.56', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1589, 57, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.52', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1590, 57, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '12.85', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1591, 57, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '15.43', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1592, 57, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '11.69', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:26', '2026-07-12 12:44:26', NULL),
(1593, 57, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '11.45', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1594, 57, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '15.26', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1595, 57, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '6.66', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1596, 57, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.89', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1597, 57, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.96', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1598, 57, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.12', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1599, 57, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.01', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1600, 57, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.37', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1601, 57, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '16.55', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1602, 57, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.78', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1603, 57, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.83', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1604, 57, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '16.41', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1605, 57, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '11.87', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1606, 57, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.30', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1607, 57, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '17.58', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1608, 57, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '14.48', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1609, 57, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.05', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1610, 58, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.20', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1611, 58, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.28', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1612, 58, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.68', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1613, 58, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.95', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1614, 58, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.71', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1615, 58, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.00', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1616, 58, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.30', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1617, 58, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.40', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1618, 58, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.40', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1619, 58, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '18.50', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1620, 58, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.51', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1621, 58, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.23', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1622, 58, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.09', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1623, 58, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.28', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1624, 58, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.78', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1625, 58, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.14', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1626, 58, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.32', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1627, 58, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.55', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1628, 58, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.75', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1629, 58, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.31', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1630, 58, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.70', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1631, 58, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.68', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1632, 58, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '7.38', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1633, 58, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.13', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1634, 58, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '8.75', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1635, 58, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '13.90', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1636, 58, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '15.49', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1637, 58, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '12.10', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1638, 58, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.27', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1639, 58, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.14', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1640, 58, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '10.43', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1641, 58, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '7.73', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1642, 58, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.69', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1643, 58, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '16.28', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1644, 58, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '12.92', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1645, 58, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.82', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1646, 58, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '17.58', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1647, 58, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '12.72', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1648, 58, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.88', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1649, 58, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '17.05', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1650, 58, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.76', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1651, 58, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.68', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1652, 59, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.88', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1653, 59, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.76', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1654, 59, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '8.32', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1655, 59, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.46', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1656, 59, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.81', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1657, 59, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.92', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1658, 59, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.69', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1659, 59, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.50', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1660, 59, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.25', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1661, 59, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.71', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1662, 59, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.15', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1663, 59, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.78', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1664, 59, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.58', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1665, 59, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.63', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1666, 59, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.57', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1667, 59, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.49', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1668, 59, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.80', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1669, 59, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.10', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1670, 59, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.38', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1671, 59, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.47', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1672, 59, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.84', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1673, 59, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '12.27', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1674, 59, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.99', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1675, 59, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.29', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1676, 59, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '10.48', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1677, 59, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.90', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1678, 59, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.09', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL);
INSERT INTO `notes` (`id`, `eleve_id`, `matiere_id`, `classe_id`, `annee_scolaire_id`, `enseignant_id`, `type_evaluation`, `numero_devoir`, `periode`, `valeur`, `coefficient`, `date_evaluation`, `commentaire`, `verrouille`, `created_at`, `updated_at`, `evaluation_id`) VALUES
(1679, 59, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.36', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1680, 59, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '6.10', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1681, 59, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.65', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1682, 59, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.01', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1683, 59, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.72', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1684, 59, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.98', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1685, 59, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.83', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1686, 59, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '13.71', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1687, 59, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.04', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1688, 59, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.22', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1689, 59, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.28', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1690, 59, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.60', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1691, 59, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.34', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1692, 59, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.34', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1693, 59, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.02', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1694, 60, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.41', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1695, 60, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.57', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1696, 60, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.39', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1697, 60, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.45', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1698, 60, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.89', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1699, 60, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.16', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1700, 60, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.64', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1701, 60, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.93', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1702, 60, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.83', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1703, 60, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.52', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1704, 60, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.90', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1705, 60, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.86', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1706, 60, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.37', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1707, 60, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.93', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1708, 60, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.70', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1709, 60, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.06', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1710, 60, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.31', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1711, 60, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.44', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1712, 60, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '18.95', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1713, 60, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.93', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1714, 60, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.08', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1715, 60, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '8.17', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1716, 60, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.16', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1717, 60, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.19', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1718, 60, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.18', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1719, 60, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.67', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1720, 60, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.53', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1721, 60, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '16.39', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1722, 60, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.04', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1723, 60, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.86', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1724, 60, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.40', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1725, 60, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.73', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1726, 60, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '15.53', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1727, 60, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.88', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1728, 60, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.84', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1729, 60, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.39', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1730, 60, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.50', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1731, 60, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '14.84', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1732, 60, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.76', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1733, 60, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.57', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1734, 60, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.53', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1735, 60, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.39', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1736, 61, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.73', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1737, 61, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.73', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1738, 61, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.33', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1739, 61, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.29', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1740, 61, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.94', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1741, 61, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.52', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1742, 61, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.19', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1743, 61, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.83', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1744, 61, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.84', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1745, 61, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.86', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1746, 61, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.01', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1747, 61, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.55', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1748, 61, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.44', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1749, 61, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.32', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1750, 61, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '8.47', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1751, 61, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.01', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1752, 61, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.54', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1753, 61, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.06', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1754, 61, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.48', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1755, 61, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.72', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1756, 61, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.52', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1757, 61, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '17.52', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1758, 61, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.66', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1759, 61, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.98', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1760, 61, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '17.81', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1761, 61, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.29', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1762, 61, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.84', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1763, 61, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.26', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1764, 61, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.13', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1765, 61, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.13', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1766, 61, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.59', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1767, 61, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.96', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1768, 61, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.09', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1769, 61, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.52', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1770, 61, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '7.63', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1771, 61, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.61', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1772, 61, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '12.30', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1773, 61, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '6.52', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1774, 61, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.61', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1775, 61, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.53', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1776, 61, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.15', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1777, 61, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.91', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1778, 62, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.15', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1779, 62, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.14', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1780, 62, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.88', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1781, 62, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.87', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1782, 62, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.02', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1783, 62, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.57', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1784, 62, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.76', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1785, 62, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.21', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1786, 62, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.83', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1787, 62, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.04', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1788, 62, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.69', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1789, 62, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.00', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1790, 62, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.69', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1791, 62, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.53', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1792, 62, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.76', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1793, 62, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.31', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1794, 62, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.27', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1795, 62, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.45', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1796, 62, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.80', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1797, 62, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.03', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1798, 62, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.97', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1799, 62, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '8.09', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1800, 62, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '6.22', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1801, 62, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '15.18', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1802, 62, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '16.27', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1803, 62, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.23', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1804, 62, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.25', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1805, 62, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.54', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1806, 62, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.72', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1807, 62, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.79', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1808, 62, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '6.26', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1809, 62, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '6.17', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1810, 62, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.68', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1811, 62, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '16.86', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1812, 62, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '12.95', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1813, 62, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.53', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1814, 62, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '12.72', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1815, 62, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '11.35', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1816, 62, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.36', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1817, 62, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.21', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1818, 62, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.72', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1819, 62, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.30', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1820, 63, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.35', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1821, 63, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.55', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1822, 63, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.84', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1823, 63, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.81', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1824, 63, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.95', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1825, 63, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '8.59', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1826, 63, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.20', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1827, 63, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.19', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1828, 63, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.51', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1829, 63, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.33', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1830, 63, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.42', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1831, 63, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.98', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1832, 63, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.88', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1833, 63, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.57', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1834, 63, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '9.15', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1835, 63, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.43', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1836, 63, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.23', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1837, 63, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.35', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1838, 63, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.19', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1839, 63, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.79', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1840, 63, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.21', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1841, 63, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.05', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1842, 63, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.19', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1843, 63, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.48', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1844, 63, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '10.56', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1845, 63, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.89', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1846, 63, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.91', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1847, 63, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.65', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1848, 63, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.62', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1849, 63, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.44', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1850, 63, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '12.76', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1851, 63, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '18.93', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1852, 63, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.44', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1853, 63, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '11.25', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1854, 63, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.32', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1855, 63, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.30', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1856, 63, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.76', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1857, 63, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '12.94', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1858, 63, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.70', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1859, 63, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.55', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1860, 63, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.24', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1861, 63, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '15.11', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1862, 64, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.90', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1863, 64, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.04', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1864, 64, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.51', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1865, 64, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.54', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1866, 64, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.09', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1867, 64, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.73', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1868, 64, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.44', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1869, 64, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.84', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1870, 64, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '12.43', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1871, 64, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.01', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1872, 64, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.85', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1873, 64, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.76', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1874, 64, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.57', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1875, 64, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.88', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1876, 64, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.06', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1877, 64, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.70', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1878, 64, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.49', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1879, 64, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.76', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1880, 64, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '18.62', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1881, 64, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.19', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1882, 64, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.06', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1883, 64, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.86', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1884, 64, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.17', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1885, 64, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.11', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1886, 64, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '6.31', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1887, 64, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '14.85', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1888, 64, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.61', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1889, 64, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.73', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1890, 64, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.39', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1891, 64, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.33', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1892, 64, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '11.97', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1893, 64, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.63', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1894, 64, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.32', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1895, 64, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '17.49', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1896, 64, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.04', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1897, 64, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.89', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1898, 64, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.92', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1899, 64, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.02', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1900, 64, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.62', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1901, 64, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.30', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1902, 64, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '7.78', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1903, 64, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.16', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1904, 65, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.86', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1905, 65, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.81', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1906, 65, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.78', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1907, 65, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.44', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1908, 65, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.12', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1909, 65, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.44', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1910, 65, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.17', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1911, 65, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.69', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1912, 65, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.87', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1913, 65, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.19', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1914, 65, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.76', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1915, 65, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.04', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1916, 65, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.37', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1917, 65, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.85', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1918, 65, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.58', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1919, 65, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '18.87', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1920, 65, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.77', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1921, 65, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.11', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1922, 65, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.87', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1923, 65, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.09', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1924, 65, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.00', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1925, 65, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.61', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1926, 65, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '18.58', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1927, 65, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.28', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1928, 65, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.36', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1929, 65, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.33', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1930, 65, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.23', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1931, 65, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.59', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1932, 65, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '10.37', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1933, 65, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.78', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1934, 65, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.44', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1935, 65, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '9.97', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1936, 65, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.39', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1937, 65, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '10.25', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1938, 65, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '11.54', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1939, 65, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.63', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1940, 65, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.91', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1941, 65, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.00', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1942, 65, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.26', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1943, 65, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.27', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1944, 65, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '18.45', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1945, 65, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '13.46', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1946, 66, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.82', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1947, 66, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.88', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1948, 66, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.66', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1949, 66, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.04', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1950, 66, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.34', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1951, 66, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.52', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1952, 66, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.00', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1953, 66, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.94', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1954, 66, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.90', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1955, 66, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.91', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1956, 66, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.86', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1957, 66, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.87', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1958, 66, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.72', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1959, 66, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.07', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1960, 66, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '8.26', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1961, 66, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.40', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1962, 66, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.61', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1963, 66, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.93', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1964, 66, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.86', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:27', '2026-07-12 12:44:27', NULL),
(1965, 66, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.42', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1966, 66, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.10', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1967, 66, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '17.68', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1968, 66, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '11.16', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1969, 66, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.52', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1970, 66, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.59', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1971, 66, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.79', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1972, 66, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.97', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1973, 66, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.74', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1974, 66, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.08', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1975, 66, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.52', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1976, 66, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.75', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1977, 66, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.98', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1978, 66, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.53', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1979, 66, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.93', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1980, 66, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '6.52', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1981, 66, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.72', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1982, 66, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '10.77', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1983, 66, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '14.91', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1984, 66, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.14', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1985, 66, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.19', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1986, 66, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.74', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1987, 66, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.62', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1988, 67, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.30', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1989, 67, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.62', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1990, 67, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.65', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1991, 67, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.28', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1992, 67, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.91', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1993, 67, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.01', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1994, 67, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.27', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1995, 67, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.04', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1996, 67, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.37', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1997, 67, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.29', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1998, 67, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.53', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(1999, 67, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.50', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2000, 67, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.54', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2001, 67, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.68', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2002, 67, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.36', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2003, 67, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.26', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2004, 67, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.25', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2005, 67, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '8.16', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2006, 67, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.62', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2007, 67, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.46', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2008, 67, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '8.57', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2009, 67, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '6.50', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL);
INSERT INTO `notes` (`id`, `eleve_id`, `matiere_id`, `classe_id`, `annee_scolaire_id`, `enseignant_id`, `type_evaluation`, `numero_devoir`, `periode`, `valeur`, `coefficient`, `date_evaluation`, `commentaire`, `verrouille`, `created_at`, `updated_at`, `evaluation_id`) VALUES
(2010, 67, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '13.09', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2011, 67, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.35', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2012, 67, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.10', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2013, 67, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '8.43', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2014, 67, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '15.15', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2015, 67, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '10.30', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2016, 67, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '12.74', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2017, 67, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.25', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2018, 67, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '11.80', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2019, 67, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '11.00', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2020, 67, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.66', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2021, 67, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '17.04', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2022, 67, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.50', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2023, 67, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.53', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2024, 67, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '13.56', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2025, 67, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.35', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2026, 67, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.24', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2027, 67, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.44', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2028, 67, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '6.97', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2029, 67, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.65', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2030, 68, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.43', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2031, 68, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.36', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2032, 68, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.92', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2033, 68, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.57', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2034, 68, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.30', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2035, 68, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.90', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2036, 68, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.50', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2037, 68, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.44', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2038, 68, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.84', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2039, 68, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.57', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2040, 68, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.37', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2041, 68, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.21', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2042, 68, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.99', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2043, 68, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.46', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2044, 68, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.90', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2045, 68, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.46', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2046, 68, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.20', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2047, 68, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '16.89', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2048, 68, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.68', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2049, 68, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.65', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2050, 68, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '10.22', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2051, 68, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.59', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2052, 68, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '7.04', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2053, 68, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.31', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2054, 68, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.14', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2055, 68, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '12.08', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2056, 68, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.19', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2057, 68, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '8.32', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2058, 68, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '6.18', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2059, 68, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '10.72', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2060, 68, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '7.79', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2061, 68, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '7.04', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2062, 68, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.64', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2063, 68, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.78', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2064, 68, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '12.99', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2065, 68, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.63', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2066, 68, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '8.81', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2067, 68, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.60', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2068, 68, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.57', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2069, 68, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '6.36', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2070, 68, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '11.99', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2071, 68, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.18', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2072, 69, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.22', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2073, 69, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.74', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2074, 69, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.72', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2075, 69, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.78', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2076, 69, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.03', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2077, 69, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.12', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2078, 69, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.72', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2079, 69, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.42', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2080, 69, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.68', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2081, 69, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.04', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2082, 69, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.85', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2083, 69, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '7.54', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2084, 69, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.09', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2085, 69, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.77', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2086, 69, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.49', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2087, 69, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.99', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2088, 69, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.01', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2089, 69, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.19', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2090, 69, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.88', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2091, 69, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.93', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2092, 69, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '8.97', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2093, 69, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '16.10', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2094, 69, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '16.93', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2095, 69, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '9.34', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2096, 69, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.25', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2097, 69, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '7.56', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2098, 69, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '12.03', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2099, 69, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '18.59', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2100, 69, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '13.44', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2101, 69, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.96', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2102, 69, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '15.95', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2103, 69, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.28', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2104, 69, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.62', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2105, 69, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '8.75', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2106, 69, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.89', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2107, 69, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.96', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2108, 69, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '6.89', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2109, 69, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.49', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2110, 69, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '16.13', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2111, 69, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '10.29', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2112, 69, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '11.76', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2113, 69, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '7.14', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2114, 70, 1, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.78', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2115, 70, 1, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.89', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2116, 70, 1, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '17.66', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2117, 70, 2, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '18.44', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2118, 70, 2, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.34', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2119, 70, 2, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '8.11', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2120, 70, 6, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.37', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2121, 70, 6, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '18.26', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2122, 70, 6, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.68', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2123, 70, 7, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.61', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2124, 70, 7, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.04', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2125, 70, 7, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '13.71', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2126, 70, 3, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.64', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2127, 70, 3, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.15', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2128, 70, 3, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '14.62', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2129, 70, 8, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.49', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2130, 70, 8, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.21', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2131, 70, 8, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '15.52', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2132, 70, 9, 5, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.94', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2133, 70, 9, 5, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.17', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2134, 70, 9, 5, 2, NULL, 'composition', 1, 'Premier Semestre', '11.48', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2135, 70, 1, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '12.85', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2136, 70, 1, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '13.91', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2137, 70, 1, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.50', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2138, 70, 2, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '6.05', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2139, 70, 2, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '12.15', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2140, 70, 2, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.03', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2141, 70, 6, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '14.15', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2142, 70, 6, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '12.43', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2143, 70, 6, 5, 2, NULL, 'composition', 1, 'Second Semestre', '11.85', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2144, 70, 7, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '10.18', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2145, 70, 7, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '15.10', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2146, 70, 7, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.43', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2147, 70, 3, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.26', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2148, 70, 3, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '17.69', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2149, 70, 3, 5, 2, NULL, 'composition', 1, 'Second Semestre', '8.98', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2150, 70, 8, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '11.52', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2151, 70, 8, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '12.99', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2152, 70, 8, 5, 2, NULL, 'composition', 1, 'Second Semestre', '14.92', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2153, 70, 9, 5, 2, NULL, 'devoir', 1, 'Second Semestre', '9.35', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2154, 70, 9, 5, 2, NULL, 'devoir', 2, 'Second Semestre', '18.72', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2155, 70, 9, 5, 2, NULL, 'composition', 1, 'Second Semestre', '17.38', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2156, 71, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.73', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2157, 71, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.86', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2158, 71, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.09', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2159, 71, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '5.80', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2160, 71, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.59', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2161, 71, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.65', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2162, 71, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.90', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2163, 71, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.04', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2164, 71, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.13', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2165, 71, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.00', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2166, 71, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.04', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2167, 71, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.23', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2168, 71, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.68', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2169, 71, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.86', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2170, 71, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.12', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2171, 71, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.21', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2172, 71, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.95', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2173, 71, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.97', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2174, 71, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.22', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2175, 71, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.91', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2176, 71, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.84', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2177, 71, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.33', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2178, 71, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '17.62', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2179, 71, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '13.68', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2180, 71, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '8.63', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2181, 71, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.77', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2182, 71, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.39', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2183, 71, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.64', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2184, 71, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '11.72', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2185, 71, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.74', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2186, 71, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '9.64', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2187, 71, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '5.20', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2188, 71, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.69', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2189, 71, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '6.92', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2190, 71, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '17.82', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2191, 71, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.44', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2192, 71, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.40', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2193, 71, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.67', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2194, 71, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.82', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2195, 71, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '6.28', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2196, 71, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '17.60', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2197, 71, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.75', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2198, 72, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.86', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2199, 72, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.26', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2200, 72, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.26', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2201, 72, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.70', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2202, 72, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.55', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2203, 72, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.03', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2204, 72, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.45', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2205, 72, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.02', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2206, 72, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.64', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2207, 72, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.60', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2208, 72, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.28', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2209, 72, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.38', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2210, 72, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.63', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2211, 72, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.12', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2212, 72, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.08', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2213, 72, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.76', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2214, 72, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.06', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2215, 72, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.83', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2216, 72, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.11', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2217, 72, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.24', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2218, 72, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.19', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2219, 72, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.75', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2220, 72, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '17.94', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2221, 72, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.71', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2222, 72, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.82', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2223, 72, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.50', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2224, 72, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '13.33', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2225, 72, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '6.28', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2226, 72, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.96', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2227, 72, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '13.97', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2228, 72, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.63', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2229, 72, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '17.62', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2230, 72, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.04', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2231, 72, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '15.49', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2232, 72, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.31', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2233, 72, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.81', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2234, 72, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '13.67', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2235, 72, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.82', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2236, 72, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '13.88', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2237, 72, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '15.73', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2238, 72, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '5.81', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2239, 72, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.90', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2240, 73, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '5.08', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2241, 73, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.23', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2242, 73, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.69', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2243, 73, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.25', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2244, 73, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.72', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2245, 73, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.35', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2246, 73, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.23', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2247, 73, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.75', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2248, 73, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.64', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2249, 73, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.63', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2250, 73, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.31', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2251, 73, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.63', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2252, 73, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.08', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2253, 73, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.01', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2254, 73, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.76', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2255, 73, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.95', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2256, 73, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.34', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2257, 73, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.87', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2258, 73, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.36', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2259, 73, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.95', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2260, 73, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.89', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2261, 73, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '8.99', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2262, 73, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '17.93', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2263, 73, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.53', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2264, 73, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.28', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2265, 73, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '8.91', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2266, 73, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.89', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2267, 73, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '15.38', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2268, 73, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '7.41', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2269, 73, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.95', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2270, 73, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.82', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2271, 73, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.01', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2272, 73, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.94', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2273, 73, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.13', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2274, 73, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '5.82', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2275, 73, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.51', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2276, 73, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.09', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2277, 73, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '5.94', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2278, 73, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.61', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2279, 73, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '15.69', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2280, 73, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.83', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2281, 73, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.54', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2282, 74, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.10', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2283, 74, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.21', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2284, 74, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.23', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2285, 74, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.78', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2286, 74, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.48', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2287, 74, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.64', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2288, 74, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.68', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2289, 74, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.49', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2290, 74, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.14', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2291, 74, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.95', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2292, 74, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.69', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2293, 74, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '13.22', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2294, 74, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.10', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2295, 74, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.57', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2296, 74, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.71', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2297, 74, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.77', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2298, 74, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.64', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2299, 74, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.20', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2300, 74, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.17', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2301, 74, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.73', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2302, 74, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.74', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2303, 74, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '15.77', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2304, 74, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '8.21', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2305, 74, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.99', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2306, 74, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '13.55', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2307, 74, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '6.33', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2308, 74, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '13.95', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2309, 74, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '6.30', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2310, 74, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.58', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2311, 74, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.53', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2312, 74, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.27', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2313, 74, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '6.31', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2314, 74, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.47', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2315, 74, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.94', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2316, 74, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '6.88', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2317, 74, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.30', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2318, 74, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '15.10', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2319, 74, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.97', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2320, 74, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.88', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2321, 74, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '9.57', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2322, 74, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.21', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2323, 74, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.77', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2324, 75, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.86', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2325, 75, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.83', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2326, 75, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.67', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2327, 75, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.37', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2328, 75, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.16', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2329, 75, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.49', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2330, 75, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.91', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2331, 75, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.91', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2332, 75, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.76', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2333, 75, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.82', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2334, 75, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.18', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2335, 75, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.60', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:28', '2026-07-12 12:44:28', NULL),
(2336, 75, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.31', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2337, 75, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.01', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2338, 75, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '13.54', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2339, 75, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.97', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL);
INSERT INTO `notes` (`id`, `eleve_id`, `matiere_id`, `classe_id`, `annee_scolaire_id`, `enseignant_id`, `type_evaluation`, `numero_devoir`, `periode`, `valeur`, `coefficient`, `date_evaluation`, `commentaire`, `verrouille`, `created_at`, `updated_at`, `evaluation_id`) VALUES
(2340, 75, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.43', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2341, 75, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.08', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2342, 75, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.12', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2343, 75, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.49', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2344, 75, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.17', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2345, 75, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.97', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2346, 75, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '5.33', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2347, 75, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '13.89', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2348, 75, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '13.68', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2349, 75, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '5.71', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2350, 75, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.84', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2351, 75, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.18', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2352, 75, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.67', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2353, 75, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.65', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2354, 75, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.15', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2355, 75, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.23', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2356, 75, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.95', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2357, 75, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.91', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2358, 75, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.06', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2359, 75, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '13.94', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2360, 75, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '8.42', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2361, 75, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '10.40', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2362, 75, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.01', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2363, 75, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.19', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2364, 75, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.87', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2365, 75, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.00', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2366, 76, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.45', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2367, 76, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.76', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2368, 76, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.30', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2369, 76, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.11', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2370, 76, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.95', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2371, 76, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.19', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2372, 76, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.23', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2373, 76, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.33', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2374, 76, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '13.21', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2375, 76, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.64', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2376, 76, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.88', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2377, 76, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.31', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2378, 76, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.22', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2379, 76, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.66', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2380, 76, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.63', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2381, 76, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.47', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2382, 76, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.41', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2383, 76, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.19', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2384, 76, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.62', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2385, 76, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.12', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2386, 76, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.46', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2387, 76, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '15.35', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2388, 76, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.02', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2389, 76, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.40', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2390, 76, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.49', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2391, 76, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '7.89', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2392, 76, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.13', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2393, 76, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '9.24', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2394, 76, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '10.90', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2395, 76, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.74', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2396, 76, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.12', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2397, 76, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.49', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2398, 76, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.57', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2399, 76, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '5.16', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2400, 76, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.44', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2401, 76, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.17', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2402, 76, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.29', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2403, 76, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.66', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2404, 76, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.00', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2405, 76, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '6.33', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2406, 76, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.89', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2407, 76, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.36', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2408, 77, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.11', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2409, 77, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.85', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2410, 77, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.16', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2411, 77, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.26', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2412, 77, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.28', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2413, 77, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.77', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2414, 77, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.62', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2415, 77, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.64', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2416, 77, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.25', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2417, 77, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '5.43', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2418, 77, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.70', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2419, 77, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.54', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2420, 77, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.88', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2421, 77, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.39', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2422, 77, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.71', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2423, 77, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.45', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2424, 77, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.86', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2425, 77, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.52', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2426, 77, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.57', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2427, 77, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.56', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2428, 77, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.91', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2429, 77, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '13.51', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2430, 77, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.26', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2431, 77, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.63', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2432, 77, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '5.50', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2433, 77, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '11.38', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2434, 77, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.13', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2435, 77, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.05', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2436, 77, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.90', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2437, 77, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.92', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2438, 77, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '9.56', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2439, 77, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '11.83', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2440, 77, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.56', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2441, 77, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.92', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2442, 77, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.43', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2443, 77, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.53', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2444, 77, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.83', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2445, 77, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '6.54', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2446, 77, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.12', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2447, 77, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '6.86', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2448, 77, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.81', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2449, 77, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '13.03', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2450, 78, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.88', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2451, 78, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.19', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2452, 78, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.85', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2453, 78, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.02', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2454, 78, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.11', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2455, 78, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.91', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2456, 78, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.79', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2457, 78, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.06', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2458, 78, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.18', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2459, 78, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.10', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2460, 78, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.36', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2461, 78, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.73', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2462, 78, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.32', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2463, 78, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.57', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2464, 78, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.36', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2465, 78, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.36', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2466, 78, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.61', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2467, 78, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.45', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2468, 78, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.09', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2469, 78, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.11', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2470, 78, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.73', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2471, 78, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.89', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2472, 78, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.73', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2473, 78, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.46', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2474, 78, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '9.71', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2475, 78, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '7.76', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2476, 78, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.79', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2477, 78, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '16.57', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2478, 78, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '17.04', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2479, 78, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.48', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2480, 78, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.97', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2481, 78, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '17.32', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2482, 78, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.32', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2483, 78, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '5.78', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2484, 78, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '11.89', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2485, 78, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.02', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2486, 78, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.79', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2487, 78, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.04', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2488, 78, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.92', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2489, 78, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.57', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2490, 78, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.16', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2491, 78, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.91', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2492, 79, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.61', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2493, 79, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.63', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2494, 79, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.69', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2495, 79, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.77', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2496, 79, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.45', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2497, 79, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.78', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2498, 79, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.67', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2499, 79, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.80', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2500, 79, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.97', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2501, 79, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.21', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2502, 79, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.05', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2503, 79, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.22', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2504, 79, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.67', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2505, 79, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.02', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2506, 79, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.81', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2507, 79, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.83', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2508, 79, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.99', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2509, 79, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.28', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2510, 79, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.91', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2511, 79, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.07', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2512, 79, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '13.02', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2513, 79, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.86', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2514, 79, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.40', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2515, 79, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.77', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2516, 79, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.55', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2517, 79, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '6.50', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2518, 79, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.51', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2519, 79, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '6.85', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2520, 79, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.26', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2521, 79, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.86', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2522, 79, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.74', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2523, 79, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '7.08', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2524, 79, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.87', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2525, 79, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '8.22', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2526, 79, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '7.57', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2527, 79, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.34', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2528, 79, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '13.85', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2529, 79, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.45', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2530, 79, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.86', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2531, 79, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '15.78', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2532, 79, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '6.72', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2533, 79, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.72', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2534, 80, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.30', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2535, 80, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.65', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2536, 80, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.80', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2537, 80, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.49', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2538, 80, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.76', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2539, 80, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.24', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2540, 80, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.81', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2541, 80, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.65', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2542, 80, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.67', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2543, 80, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.09', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2544, 80, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.56', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2545, 80, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.34', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2546, 80, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.10', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2547, 80, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.94', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2548, 80, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.55', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2549, 80, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.31', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2550, 80, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.00', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2551, 80, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.11', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2552, 80, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.76', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2553, 80, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.86', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2554, 80, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.20', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2555, 80, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.02', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2556, 80, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.02', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2557, 80, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.65', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2558, 80, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.47', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2559, 80, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.11', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2560, 80, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.32', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2561, 80, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.73', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2562, 80, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.07', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2563, 80, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.20', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2564, 80, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.40', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2565, 80, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.83', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2566, 80, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.67', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2567, 80, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.20', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2568, 80, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '7.85', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2569, 80, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.24', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2570, 80, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.12', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2571, 80, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '17.87', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2572, 80, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.03', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2573, 80, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.36', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2574, 80, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.81', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2575, 80, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.68', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2576, 81, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.90', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2577, 81, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.40', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2578, 81, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.49', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2579, 81, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.07', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2580, 81, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.03', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2581, 81, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.88', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2582, 81, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.05', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2583, 81, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.82', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2584, 81, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.07', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2585, 81, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.57', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2586, 81, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.16', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2587, 81, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.52', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2588, 81, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.63', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2589, 81, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.24', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2590, 81, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.88', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2591, 81, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.31', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2592, 81, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.24', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2593, 81, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.96', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2594, 81, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.91', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2595, 81, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.26', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2596, 81, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '13.83', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2597, 81, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '16.54', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2598, 81, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '8.98', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2599, 81, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.39', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2600, 81, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '6.33', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2601, 81, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '11.60', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2602, 81, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.90', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2603, 81, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '5.58', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2604, 81, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '10.90', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2605, 81, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.77', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2606, 81, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.57', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2607, 81, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.37', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2608, 81, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.32', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2609, 81, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.72', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2610, 81, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.55', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2611, 81, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '13.84', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2612, 81, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.65', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2613, 81, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '6.88', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2614, 81, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.53', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2615, 81, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.08', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2616, 81, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '6.32', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2617, 81, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.00', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2618, 82, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.65', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2619, 82, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.72', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2620, 82, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.55', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2621, 82, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.48', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2622, 82, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.72', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2623, 82, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.13', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2624, 82, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.22', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2625, 82, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.38', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2626, 82, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.75', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2627, 82, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.65', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2628, 82, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.81', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2629, 82, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.11', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2630, 82, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.13', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2631, 82, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.54', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2632, 82, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '13.93', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2633, 82, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '5.52', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2634, 82, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.88', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2635, 82, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.16', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2636, 82, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.83', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2637, 82, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.81', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2638, 82, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.74', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2639, 82, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.02', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2640, 82, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '10.84', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2641, 82, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.66', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2642, 82, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '9.27', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2643, 82, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '17.69', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2644, 82, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.86', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2645, 82, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.92', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2646, 82, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '7.52', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2647, 82, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.71', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2648, 82, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.52', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2649, 82, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.67', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2650, 82, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '13.20', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2651, 82, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '6.62', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2652, 82, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '5.80', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2653, 82, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.41', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2654, 82, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.83', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2655, 82, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '11.50', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2656, 82, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.53', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2657, 82, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '6.80', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2658, 82, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.88', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2659, 82, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.49', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2660, 83, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.03', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2661, 83, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.22', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2662, 83, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.27', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2663, 83, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.21', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2664, 83, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.22', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2665, 83, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.13', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2666, 83, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.10', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2667, 83, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.74', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2668, 83, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.83', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2669, 83, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.60', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL);
INSERT INTO `notes` (`id`, `eleve_id`, `matiere_id`, `classe_id`, `annee_scolaire_id`, `enseignant_id`, `type_evaluation`, `numero_devoir`, `periode`, `valeur`, `coefficient`, `date_evaluation`, `commentaire`, `verrouille`, `created_at`, `updated_at`, `evaluation_id`) VALUES
(2670, 83, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.98', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2671, 83, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.39', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2672, 83, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.76', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2673, 83, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.04', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2674, 83, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.97', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2675, 83, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.36', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2676, 83, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.35', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2677, 83, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.20', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2678, 83, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.69', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2679, 83, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.90', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2680, 83, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.47', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2681, 83, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.00', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2682, 83, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.55', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2683, 83, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.61', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2684, 83, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.99', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2685, 83, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.63', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2686, 83, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '13.04', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2687, 83, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.40', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2688, 83, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.25', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2689, 83, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.23', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2690, 83, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.44', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2691, 83, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.91', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2692, 83, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.62', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2693, 83, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '8.25', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2694, 83, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.21', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2695, 83, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.05', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2696, 83, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.69', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2697, 83, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '10.06', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2698, 83, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.61', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2699, 83, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '8.37', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2700, 83, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.52', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:29', '2026-07-12 12:44:29', NULL),
(2701, 83, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.86', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2702, 84, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.92', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2703, 84, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.55', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2704, 84, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.00', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2705, 84, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.82', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2706, 84, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.29', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2707, 84, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.89', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2708, 84, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.42', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2709, 84, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.35', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2710, 84, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.36', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2711, 84, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.45', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2712, 84, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.01', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2713, 84, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.71', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2714, 84, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.27', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2715, 84, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.90', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2716, 84, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.15', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2717, 84, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '5.93', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2718, 84, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.30', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2719, 84, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.77', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2720, 84, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '5.33', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2721, 84, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.87', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2722, 84, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.82', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2723, 84, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '5.17', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2724, 84, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '11.10', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2725, 84, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.18', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2726, 84, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '9.52', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2727, 84, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.27', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2728, 84, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.14', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2729, 84, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.79', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2730, 84, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '10.41', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2731, 84, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.24', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2732, 84, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '13.56', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2733, 84, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.66', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2734, 84, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.40', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2735, 84, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '9.54', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2736, 84, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '7.97', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2737, 84, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.78', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2738, 84, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.57', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2739, 84, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '10.81', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2740, 84, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.96', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2741, 84, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.55', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2742, 84, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '6.09', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2743, 84, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.99', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2744, 85, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.35', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2745, 85, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.60', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2746, 85, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.70', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2747, 85, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.08', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2748, 85, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.95', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2749, 85, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '13.81', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2750, 85, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '5.53', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2751, 85, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.58', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2752, 85, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.48', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2753, 85, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.60', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2754, 85, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.37', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2755, 85, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.11', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2756, 85, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.06', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2757, 85, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.02', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2758, 85, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.23', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2759, 85, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.51', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2760, 85, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.60', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2761, 85, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '13.10', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2762, 85, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.13', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2763, 85, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.15', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2764, 85, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.20', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2765, 85, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '15.99', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2766, 85, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '10.50', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2767, 85, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.25', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2768, 85, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '6.59', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2769, 85, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.47', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2770, 85, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.70', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2771, 85, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.75', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2772, 85, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.57', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2773, 85, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.07', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2774, 85, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.93', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2775, 85, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.12', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2776, 85, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.20', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2777, 85, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '6.66', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2778, 85, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.17', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2779, 85, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.64', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2780, 85, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '5.89', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2781, 85, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.65', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2782, 85, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.04', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2783, 85, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '16.51', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2784, 85, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.24', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2785, 85, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.54', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2786, 86, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.05', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2787, 86, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.04', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2788, 86, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.60', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2789, 86, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.06', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2790, 86, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.80', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2791, 86, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.58', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2792, 86, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.45', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2793, 86, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.23', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2794, 86, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.79', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2795, 86, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.14', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2796, 86, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.33', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2797, 86, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.84', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2798, 86, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.50', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2799, 86, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.58', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2800, 86, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.39', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2801, 86, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '5.32', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2802, 86, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.86', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2803, 86, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.24', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2804, 86, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.09', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2805, 86, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.63', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2806, 86, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.28', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2807, 86, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '16.18', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2808, 86, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '7.98', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2809, 86, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.05', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2810, 86, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.01', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2811, 86, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '10.44', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2812, 86, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '13.13', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2813, 86, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.32', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2814, 86, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.77', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2815, 86, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.14', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2816, 86, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.83', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2817, 86, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '11.57', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2818, 86, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.57', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2819, 86, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '8.97', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2820, 86, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '7.89', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2821, 86, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.95', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2822, 86, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.76', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2823, 86, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '6.22', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2824, 86, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.29', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2825, 86, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '6.21', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2826, 86, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '10.82', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2827, 86, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.73', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2828, 87, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.70', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2829, 87, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.96', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2830, 87, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.15', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2831, 87, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.13', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2832, 87, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.44', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2833, 87, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.06', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2834, 87, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.43', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2835, 87, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.68', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2836, 87, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.80', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2837, 87, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.65', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2838, 87, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.88', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2839, 87, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.05', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2840, 87, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.98', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2841, 87, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.16', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2842, 87, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.75', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2843, 87, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.04', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2844, 87, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.84', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2845, 87, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.93', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2846, 87, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '5.53', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2847, 87, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.23', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2848, 87, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.29', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2849, 87, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '16.73', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2850, 87, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '8.97', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2851, 87, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.16', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2852, 87, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.40', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2853, 87, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.82', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2854, 87, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.80', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2855, 87, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.87', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2856, 87, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '7.06', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2857, 87, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.62', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2858, 87, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '9.28', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2859, 87, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.14', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2860, 87, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.52', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2861, 87, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '9.93', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2862, 87, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '10.42', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2863, 87, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.10', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2864, 87, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '5.27', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2865, 87, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.02', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2866, 87, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.36', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2867, 87, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.97', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2868, 87, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '17.76', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2869, 87, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.26', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2870, 88, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.98', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2871, 88, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.43', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2872, 88, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.50', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2873, 88, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.39', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2874, 88, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.07', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2875, 88, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.48', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2876, 88, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.21', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2877, 88, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.71', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2878, 88, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.83', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2879, 88, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.90', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2880, 88, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.43', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2881, 88, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '13.49', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2882, 88, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.94', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2883, 88, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.31', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2884, 88, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.93', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2885, 88, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.37', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2886, 88, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.81', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2887, 88, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.57', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2888, 88, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.83', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2889, 88, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.68', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2890, 88, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.33', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2891, 88, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '16.65', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2892, 88, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.83', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2893, 88, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.79', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2894, 88, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.54', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2895, 88, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.61', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2896, 88, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.19', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2897, 88, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '15.49', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2898, 88, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '7.09', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2899, 88, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.39', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2900, 88, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.50', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2901, 88, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '8.49', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2902, 88, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.37', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2903, 88, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.80', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2904, 88, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.75', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2905, 88, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.14', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2906, 88, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.69', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2907, 88, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '5.68', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2908, 88, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.83', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2909, 88, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.63', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2910, 88, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '6.26', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2911, 88, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.12', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2912, 89, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.21', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2913, 89, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.86', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2914, 89, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.46', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2915, 89, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.68', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2916, 89, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.14', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2917, 89, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.85', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2918, 89, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.84', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2919, 89, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.36', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2920, 89, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.47', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2921, 89, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.10', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2922, 89, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.51', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2923, 89, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.77', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2924, 89, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.71', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2925, 89, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.39', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2926, 89, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.85', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2927, 89, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.16', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2928, 89, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.19', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2929, 89, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.69', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2930, 89, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.98', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2931, 89, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.18', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2932, 89, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.94', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2933, 89, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '9.69', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2934, 89, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '17.68', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2935, 89, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.99', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2936, 89, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '15.19', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2937, 89, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.22', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2938, 89, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.66', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2939, 89, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.70', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2940, 89, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '6.28', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2941, 89, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.23', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2942, 89, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '13.51', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2943, 89, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.20', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2944, 89, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.71', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2945, 89, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.50', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2946, 89, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '10.27', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2947, 89, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.50', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2948, 89, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '8.60', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2949, 89, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.85', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2950, 89, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.27', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2951, 89, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '8.31', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2952, 89, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.78', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2953, 89, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.30', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2954, 90, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '5.63', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2955, 90, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.12', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2956, 90, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.76', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2957, 90, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.50', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2958, 90, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.28', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2959, 90, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '13.43', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2960, 90, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.20', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2961, 90, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.20', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2962, 90, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.32', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2963, 90, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.70', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2964, 90, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.17', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2965, 90, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.39', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2966, 90, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.91', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2967, 90, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.17', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2968, 90, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.43', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2969, 90, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.43', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2970, 90, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.67', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2971, 90, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.90', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2972, 90, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.72', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2973, 90, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.31', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2974, 90, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.61', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2975, 90, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.40', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2976, 90, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.15', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2977, 90, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.64', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2978, 90, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.21', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2979, 90, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.04', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2980, 90, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.94', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2981, 90, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '5.75', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2982, 90, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '11.86', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2983, 90, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.05', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2984, 90, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '8.48', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2985, 90, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.89', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2986, 90, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.69', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2987, 90, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.60', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2988, 90, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '7.32', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2989, 90, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '13.06', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2990, 90, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.50', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2991, 90, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.15', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2992, 90, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.35', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2993, 90, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.51', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2994, 90, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '8.37', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2995, 90, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.73', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2996, 91, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.25', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2997, 91, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.76', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2998, 91, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '13.10', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(2999, 91, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.55', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL);
INSERT INTO `notes` (`id`, `eleve_id`, `matiere_id`, `classe_id`, `annee_scolaire_id`, `enseignant_id`, `type_evaluation`, `numero_devoir`, `periode`, `valeur`, `coefficient`, `date_evaluation`, `commentaire`, `verrouille`, `created_at`, `updated_at`, `evaluation_id`) VALUES
(3000, 91, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.84', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3001, 91, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '13.81', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3002, 91, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.50', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3003, 91, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.14', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3004, 91, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.32', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3005, 91, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.72', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3006, 91, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.66', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3007, 91, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.54', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3008, 91, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.52', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3009, 91, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.85', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3010, 91, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.85', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3011, 91, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.42', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3012, 91, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.30', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3013, 91, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.04', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3014, 91, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.96', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3015, 91, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.88', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3016, 91, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.91', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3017, 91, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.88', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3018, 91, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '8.52', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3019, 91, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.67', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3020, 91, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.49', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3021, 91, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '6.78', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3022, 91, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.20', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3023, 91, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.69', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3024, 91, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.68', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3025, 91, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.55', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3026, 91, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '13.16', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3027, 91, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '17.61', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3028, 91, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.90', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3029, 91, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '5.31', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3030, 91, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.87', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3031, 91, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.52', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3032, 91, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '9.16', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3033, 91, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '11.69', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3034, 91, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.53', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3035, 91, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '6.78', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3036, 91, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '7.48', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3037, 91, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.82', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3038, 92, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.02', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3039, 92, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.22', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3040, 92, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.14', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3041, 92, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.30', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3042, 92, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.50', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3043, 92, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.55', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3044, 92, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.97', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3045, 92, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.41', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3046, 92, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.88', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3047, 92, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.31', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3048, 92, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.05', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3049, 92, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.85', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3050, 92, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.83', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3051, 92, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.45', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3052, 92, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.22', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3053, 92, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.35', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3054, 92, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.88', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3055, 92, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.16', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3056, 92, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.04', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3057, 92, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.72', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3058, 92, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.00', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3059, 92, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.46', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3060, 92, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.90', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3061, 92, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.32', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3062, 92, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '8.35', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3063, 92, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.16', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3064, 92, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.48', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3065, 92, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.06', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:30', '2026-07-12 12:44:30', NULL),
(3066, 92, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '8.05', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3067, 92, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.78', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3068, 92, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.73', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3069, 92, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.17', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3070, 92, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.47', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3071, 92, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.78', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3072, 92, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.78', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3073, 92, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.62', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3074, 92, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '6.05', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3075, 92, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.91', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3076, 92, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.71', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3077, 92, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.09', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3078, 92, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.09', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3079, 92, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.20', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3080, 93, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.24', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3081, 93, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.39', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3082, 93, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.52', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3083, 93, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.91', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3084, 93, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.95', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3085, 93, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.01', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3086, 93, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.73', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3087, 93, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.37', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3088, 93, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.61', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3089, 93, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.23', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3090, 93, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.43', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3091, 93, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.39', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3092, 93, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.29', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3093, 93, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.78', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3094, 93, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.54', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3095, 93, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.52', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3096, 93, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.16', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3097, 93, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.66', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3098, 93, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.56', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3099, 93, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.92', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3100, 93, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.73', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3101, 93, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.36', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3102, 93, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.30', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3103, 93, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.93', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3104, 93, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.26', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3105, 93, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.08', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3106, 93, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.59', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3107, 93, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.80', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3108, 93, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '7.55', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3109, 93, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '13.93', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3110, 93, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '8.58', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3111, 93, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '11.05', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3112, 93, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.85', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3113, 93, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.19', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3114, 93, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.08', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3115, 93, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.69', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3116, 93, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.63', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3117, 93, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.21', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3118, 93, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.11', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3119, 93, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '15.81', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3120, 93, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.35', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3121, 93, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.05', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3122, 94, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.16', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3123, 94, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.98', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3124, 94, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.14', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3125, 94, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.31', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3126, 94, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.56', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3127, 94, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.28', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3128, 94, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.88', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3129, 94, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.13', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3130, 94, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.81', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3131, 94, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '5.47', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3132, 94, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.62', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3133, 94, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '13.82', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3134, 94, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '5.87', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3135, 94, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.11', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3136, 94, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.91', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3137, 94, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.16', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3138, 94, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.84', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3139, 94, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '13.91', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3140, 94, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.92', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3141, 94, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.65', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3142, 94, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.19', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3143, 94, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '9.71', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3144, 94, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.42', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3145, 94, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.95', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3146, 94, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.86', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3147, 94, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '17.95', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3148, 94, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.00', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3149, 94, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.87', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3150, 94, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.50', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3151, 94, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.97', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3152, 94, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '5.10', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3153, 94, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '17.16', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3154, 94, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.65', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3155, 94, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.78', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3156, 94, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.62', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3157, 94, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.42', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3158, 94, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.51', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3159, 94, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '11.94', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3160, 94, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '13.29', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3161, 94, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.98', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3162, 94, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '8.73', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3163, 94, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.95', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3164, 95, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.81', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3165, 95, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.74', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3166, 95, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.27', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3167, 95, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '5.07', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3168, 95, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.00', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3169, 95, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.92', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3170, 95, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.47', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3171, 95, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.52', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3172, 95, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.07', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3173, 95, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.83', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3174, 95, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.12', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3175, 95, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.07', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3176, 95, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.63', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3177, 95, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.58', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3178, 95, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.31', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3179, 95, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.76', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3180, 95, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.23', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3181, 95, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.73', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3182, 95, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.89', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3183, 95, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.40', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3184, 95, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.01', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3185, 95, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.71', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3186, 95, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '8.82', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3187, 95, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '13.91', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3188, 95, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '13.04', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3189, 95, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '10.85', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3190, 95, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.34', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3191, 95, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.31', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3192, 95, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.92', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3193, 95, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.73', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3194, 95, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.67', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3195, 95, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.29', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3196, 95, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.47', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3197, 95, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.12', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3198, 95, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.42', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3199, 95, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '13.03', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3200, 95, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.86', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3201, 95, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '7.13', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3202, 95, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.44', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3203, 95, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.53', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3204, 95, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '17.53', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3205, 95, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.34', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3206, 96, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.27', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3207, 96, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.31', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3208, 96, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.37', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3209, 96, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.89', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3210, 96, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.27', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3211, 96, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.91', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3212, 96, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.05', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3213, 96, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.92', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3214, 96, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.69', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3215, 96, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.96', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3216, 96, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.36', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3217, 96, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.06', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3218, 96, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.90', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3219, 96, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.52', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3220, 96, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.18', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3221, 96, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.70', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3222, 96, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.29', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3223, 96, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '13.77', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3224, 96, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.82', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3225, 96, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.95', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3226, 96, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.78', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3227, 96, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '8.88', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3228, 96, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.46', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3229, 96, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.07', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3230, 96, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.97', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3231, 96, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.26', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3232, 96, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.16', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3233, 96, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.55', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3234, 96, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.51', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3235, 96, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.04', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3236, 96, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.12', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3237, 96, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '10.75', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3238, 96, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.39', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3239, 96, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '15.76', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3240, 96, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '11.47', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3241, 96, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.50', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3242, 96, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.40', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3243, 96, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '10.55', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3244, 96, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.38', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3245, 96, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '9.09', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3246, 96, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '6.10', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3247, 96, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.05', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3248, 97, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.31', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3249, 97, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.43', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3250, 97, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.65', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3251, 97, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.17', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3252, 97, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.27', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3253, 97, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.00', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3254, 97, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.25', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3255, 97, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.47', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3256, 97, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.59', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3257, 97, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.62', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3258, 97, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.09', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3259, 97, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.47', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3260, 97, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '5.03', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3261, 97, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.03', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3262, 97, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.96', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3263, 97, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '5.53', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3264, 97, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.29', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3265, 97, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.94', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3266, 97, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.63', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3267, 97, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.30', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3268, 97, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.80', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3269, 97, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '8.76', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3270, 97, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.61', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3271, 97, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.54', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3272, 97, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.48', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3273, 97, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.21', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3274, 97, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.48', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3275, 97, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.95', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3276, 97, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '5.12', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3277, 97, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.64', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3278, 97, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '15.53', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3279, 97, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.73', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3280, 97, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.95', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3281, 97, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '15.23', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3282, 97, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '6.39', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3283, 97, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.50', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3284, 97, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '8.43', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3285, 97, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '5.01', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3286, 97, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.86', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3287, 97, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '9.74', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3288, 97, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.38', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3289, 97, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.14', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3290, 98, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.16', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3291, 98, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.79', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3292, 98, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.65', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3293, 98, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.25', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3294, 98, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.06', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3295, 98, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.74', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3296, 98, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.47', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3297, 98, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.55', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3298, 98, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.50', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3299, 98, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.71', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3300, 98, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.94', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3301, 98, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.78', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3302, 98, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.25', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3303, 98, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.67', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3304, 98, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '13.07', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3305, 98, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.39', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3306, 98, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.70', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3307, 98, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.39', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3308, 98, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.70', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3309, 98, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.89', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3310, 98, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.49', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3311, 98, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '16.68', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3312, 98, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '8.78', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3313, 98, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.92', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3314, 98, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '13.23', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3315, 98, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.64', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3316, 98, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.43', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3317, 98, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '9.10', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3318, 98, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '5.18', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3319, 98, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.86', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3320, 98, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '13.60', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3321, 98, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.71', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3322, 98, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.75', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3323, 98, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '5.25', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3324, 98, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '5.65', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3325, 98, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.66', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3326, 98, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '13.34', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3327, 98, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.12', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3328, 98, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.52', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL);
INSERT INTO `notes` (`id`, `eleve_id`, `matiere_id`, `classe_id`, `annee_scolaire_id`, `enseignant_id`, `type_evaluation`, `numero_devoir`, `periode`, `valeur`, `coefficient`, `date_evaluation`, `commentaire`, `verrouille`, `created_at`, `updated_at`, `evaluation_id`) VALUES
(3329, 98, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.16', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3330, 98, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.84', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3331, 98, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '13.17', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3332, 99, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.25', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3333, 99, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.64', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3334, 99, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.78', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3335, 99, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '5.99', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3336, 99, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.17', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3337, 99, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.49', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3338, 99, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.48', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3339, 99, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.69', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3340, 99, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.42', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3341, 99, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.11', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3342, 99, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.41', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3343, 99, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.18', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3344, 99, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.45', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3345, 99, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.35', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3346, 99, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.35', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3347, 99, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.52', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3348, 99, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.52', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3349, 99, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.95', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3350, 99, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.59', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3351, 99, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.99', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3352, 99, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.81', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3353, 99, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.73', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3354, 99, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '10.25', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3355, 99, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.01', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3356, 99, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '16.76', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3357, 99, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '8.66', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3358, 99, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '13.10', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3359, 99, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '9.30', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3360, 99, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.79', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3361, 99, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.98', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3362, 99, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '6.99', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3363, 99, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '11.60', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3364, 99, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.36', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3365, 99, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '8.75', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3366, 99, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.10', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3367, 99, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.30', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3368, 99, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.72', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3369, 99, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '8.70', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3370, 99, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.91', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3371, 99, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '8.87', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3372, 99, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '17.16', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3373, 99, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.89', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3374, 100, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.06', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3375, 100, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.69', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3376, 100, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.40', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3377, 100, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.02', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3378, 100, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.83', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3379, 100, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.74', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3380, 100, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.91', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3381, 100, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.86', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3382, 100, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.49', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3383, 100, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.62', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3384, 100, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.64', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3385, 100, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.75', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3386, 100, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.23', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3387, 100, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.95', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3388, 100, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.90', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3389, 100, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.55', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3390, 100, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.40', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3391, 100, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.99', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3392, 100, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.88', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3393, 100, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.33', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3394, 100, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.90', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3395, 100, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.70', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3396, 100, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '8.90', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3397, 100, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.75', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3398, 100, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '5.93', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3399, 100, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '5.45', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3400, 100, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.57', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3401, 100, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '9.99', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3402, 100, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.29', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3403, 100, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.82', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3404, 100, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.79', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3405, 100, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.25', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3406, 100, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.41', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3407, 100, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.29', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3408, 100, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.32', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3409, 100, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.85', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3410, 100, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '5.78', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3411, 100, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '5.08', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3412, 100, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '13.05', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3413, 100, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.00', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3414, 100, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '17.18', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3415, 100, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.25', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3416, 101, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '5.85', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3417, 101, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.54', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3418, 101, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.32', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3419, 101, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.42', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3420, 101, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.39', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3421, 101, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.05', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3422, 101, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.38', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3423, 101, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.48', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3424, 101, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.29', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:31', '2026-07-12 12:44:31', NULL),
(3425, 101, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '5.57', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3426, 101, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.51', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3427, 101, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.81', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3428, 101, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.53', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3429, 101, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.55', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3430, 101, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.12', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3431, 101, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.64', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3432, 101, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.46', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3433, 101, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '13.31', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3434, 101, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.78', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3435, 101, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.76', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3436, 101, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.48', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3437, 101, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.88', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3438, 101, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '17.15', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3439, 101, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.09', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3440, 101, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.03', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3441, 101, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '10.94', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3442, 101, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.15', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3443, 101, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.02', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3444, 101, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.97', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3445, 101, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.42', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3446, 101, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.01', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3447, 101, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.49', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3448, 101, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.33', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3449, 101, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.32', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3450, 101, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.69', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3451, 101, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.28', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3452, 101, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.53', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3453, 101, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.10', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3454, 101, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.96', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3455, 101, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '6.99', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3456, 101, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.38', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3457, 101, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.87', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3458, 102, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.32', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3459, 102, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.12', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3460, 102, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.20', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3461, 102, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.52', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3462, 102, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.05', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3463, 102, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.15', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3464, 102, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.24', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3465, 102, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.86', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3466, 102, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.32', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3467, 102, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.66', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3468, 102, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.20', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3469, 102, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.98', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3470, 102, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.30', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3471, 102, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.82', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3472, 102, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.43', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3473, 102, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.59', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3474, 102, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.45', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3475, 102, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.90', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3476, 102, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.44', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3477, 102, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.10', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3478, 102, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.04', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3479, 102, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.29', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3480, 102, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.17', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3481, 102, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.80', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3482, 102, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '16.00', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3483, 102, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.70', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3484, 102, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.83', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3485, 102, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.53', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3486, 102, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.09', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3487, 102, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.55', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3488, 102, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '5.48', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3489, 102, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.91', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3490, 102, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.55', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3491, 102, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.16', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3492, 102, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.26', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3493, 102, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.29', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3494, 102, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '5.41', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3495, 102, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '7.46', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3496, 102, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.01', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3497, 102, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.92', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3498, 102, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '10.79', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3499, 102, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '13.59', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3500, 103, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.11', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3501, 103, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.32', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3502, 103, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.53', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3503, 103, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.57', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3504, 103, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.76', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3505, 103, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.85', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3506, 103, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.88', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3507, 103, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.68', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3508, 103, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.03', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3509, 103, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.04', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3510, 103, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.33', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3511, 103, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.06', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3512, 103, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.68', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3513, 103, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.06', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3514, 103, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '13.77', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3515, 103, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '5.24', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3516, 103, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.74', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3517, 103, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.44', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3518, 103, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.36', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3519, 103, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.09', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3520, 103, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.07', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3521, 103, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '9.33', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3522, 103, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.47', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3523, 103, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.33', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3524, 103, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '16.20', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3525, 103, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.80', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3526, 103, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.03', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3527, 103, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.44', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3528, 103, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.64', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3529, 103, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.54', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3530, 103, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '9.73', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3531, 103, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '7.12', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3532, 103, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.76', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3533, 103, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '13.90', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3534, 103, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '5.14', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3535, 103, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.25', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3536, 103, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.06', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3537, 103, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '7.57', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3538, 103, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.29', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3539, 103, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.29', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3540, 103, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.16', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3541, 103, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.60', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3542, 104, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.45', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3543, 104, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.12', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3544, 104, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.47', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3545, 104, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '5.66', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3546, 104, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.28', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3547, 104, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.12', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3548, 104, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.42', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3549, 104, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.84', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3550, 104, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '13.08', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3551, 104, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.87', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3552, 104, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.17', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3553, 104, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.88', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3554, 104, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.29', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3555, 104, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.76', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3556, 104, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.44', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3557, 104, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.96', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3558, 104, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.62', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3559, 104, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.44', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3560, 104, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.84', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3561, 104, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.27', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3562, 104, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.31', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3563, 104, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.26', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3564, 104, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.70', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3565, 104, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.04', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3566, 104, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '8.95', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3567, 104, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '8.68', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3568, 104, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.69', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3569, 104, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.44', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3570, 104, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '10.02', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3571, 104, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.35', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3572, 104, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '8.45', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3573, 104, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.87', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3574, 104, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.44', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3575, 104, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.56', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3576, 104, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.39', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3577, 104, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.94', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3578, 104, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.43', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3579, 104, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.86', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3580, 104, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.97', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3581, 104, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.06', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3582, 104, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.39', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3583, 104, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.27', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3584, 105, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.75', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3585, 105, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.12', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3586, 105, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.34', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3587, 105, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.22', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3588, 105, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.66', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3589, 105, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.37', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3590, 105, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.54', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3591, 105, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.99', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3592, 105, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '13.25', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3593, 105, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.70', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3594, 105, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.46', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3595, 105, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.59', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3596, 105, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.54', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3597, 105, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.47', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3598, 105, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.75', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3599, 105, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.02', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3600, 105, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.95', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3601, 105, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.52', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3602, 105, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.35', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3603, 105, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.26', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3604, 105, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '13.48', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3605, 105, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '13.43', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3606, 105, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.35', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3607, 105, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.77', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3608, 105, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '15.28', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3609, 105, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '8.85', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3610, 105, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.75', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3611, 105, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.04', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3612, 105, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '11.08', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3613, 105, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.34', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3614, 105, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '5.26', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3615, 105, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.76', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3616, 105, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.21', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3617, 105, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.71', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3618, 105, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.60', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3619, 105, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.06', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3620, 105, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.90', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3621, 105, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '7.62', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3622, 105, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.61', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3623, 105, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.68', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3624, 105, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.75', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3625, 105, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.90', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3626, 106, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.45', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3627, 106, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.92', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3628, 106, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.91', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3629, 106, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.56', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3630, 106, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.45', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3631, 106, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.63', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3632, 106, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.04', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3633, 106, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.43', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3634, 106, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.95', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3635, 106, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.49', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3636, 106, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.25', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3637, 106, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.52', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3638, 106, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.27', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3639, 106, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.39', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3640, 106, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '13.26', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3641, 106, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.57', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3642, 106, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.28', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3643, 106, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.32', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3644, 106, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.05', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3645, 106, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.17', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3646, 106, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.75', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3647, 106, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.22', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3648, 106, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '10.58', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3649, 106, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.63', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3650, 106, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.69', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3651, 106, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '6.51', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3652, 106, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.27', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3653, 106, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.17', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3654, 106, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '8.61', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3655, 106, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.44', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3656, 106, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.25', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL);
INSERT INTO `notes` (`id`, `eleve_id`, `matiere_id`, `classe_id`, `annee_scolaire_id`, `enseignant_id`, `type_evaluation`, `numero_devoir`, `periode`, `valeur`, `coefficient`, `date_evaluation`, `commentaire`, `verrouille`, `created_at`, `updated_at`, `evaluation_id`) VALUES
(3657, 106, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '8.33', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3658, 106, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.76', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3659, 106, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '6.67', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3660, 106, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.62', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3661, 106, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.45', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3662, 106, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.51', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3663, 106, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.07', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3664, 106, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.41', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3665, 106, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.61', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3666, 106, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '11.84', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3667, 106, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.86', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3668, 107, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.92', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3669, 107, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.33', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3670, 107, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.62', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3671, 107, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.12', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3672, 107, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.10', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3673, 107, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.37', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3674, 107, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.57', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3675, 107, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.65', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3676, 107, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.57', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3677, 107, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.15', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3678, 107, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.16', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3679, 107, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.12', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3680, 107, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.15', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3681, 107, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.62', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3682, 107, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.64', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3683, 107, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.03', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3684, 107, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.77', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3685, 107, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.49', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3686, 107, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.63', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3687, 107, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.93', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3688, 107, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.49', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3689, 107, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '15.15', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3690, 107, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.85', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3691, 107, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.99', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3692, 107, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '9.61', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3693, 107, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '10.56', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3694, 107, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '13.09', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3695, 107, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '16.34', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3696, 107, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.07', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3697, 107, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.99', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3698, 107, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '6.91', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3699, 107, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '7.27', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3700, 107, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.84', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3701, 107, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '9.16', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3702, 107, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '6.54', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3703, 107, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '13.69', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3704, 107, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.73', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3705, 107, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.16', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3706, 107, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.94', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3707, 107, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '5.46', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3708, 107, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '10.30', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3709, 107, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.72', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3710, 108, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.54', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3711, 108, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.86', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3712, 108, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.93', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3713, 108, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.36', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3714, 108, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.57', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3715, 108, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.01', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3716, 108, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.43', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3717, 108, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.73', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3718, 108, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.71', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3719, 108, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.77', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3720, 108, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.76', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3721, 108, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.66', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3722, 108, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.06', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3723, 108, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.03', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3724, 108, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '13.43', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3725, 108, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.32', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3726, 108, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.28', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3727, 108, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.94', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3728, 108, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.77', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3729, 108, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.54', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3730, 108, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.00', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3731, 108, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '8.62', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3732, 108, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '11.95', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3733, 108, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.20', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3734, 108, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '16.08', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3735, 108, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '17.09', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3736, 108, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.89', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3737, 108, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.06', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3738, 108, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '10.95', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3739, 108, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.27', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3740, 108, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '5.90', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3741, 108, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.03', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3742, 108, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.06', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3743, 108, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.08', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3744, 108, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '8.25', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3745, 108, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.39', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3746, 108, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.01', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3747, 108, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.32', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3748, 108, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.61', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3749, 108, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.08', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3750, 108, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.17', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3751, 108, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.25', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3752, 109, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.36', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3753, 109, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.57', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3754, 109, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.55', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3755, 109, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.24', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3756, 109, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.99', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3757, 109, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.33', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3758, 109, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.40', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3759, 109, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.69', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3760, 109, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.32', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3761, 109, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.19', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3762, 109, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.14', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3763, 109, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.11', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3764, 109, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.14', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3765, 109, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.28', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3766, 109, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.07', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3767, 109, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.65', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3768, 109, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.88', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3769, 109, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.09', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3770, 109, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.77', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3771, 109, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.36', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3772, 109, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.45', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3773, 109, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '5.14', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3774, 109, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '7.38', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3775, 109, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.71', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3776, 109, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.57', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3777, 109, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '8.87', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3778, 109, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.57', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3779, 109, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '5.02', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3780, 109, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.40', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3781, 109, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.93', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3782, 109, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '8.52', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3783, 109, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.37', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3784, 109, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.52', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3785, 109, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '16.91', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3786, 109, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '17.53', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3787, 109, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.20', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3788, 109, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.95', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3789, 109, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.49', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3790, 109, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.38', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3791, 109, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.30', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3792, 109, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.40', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3793, 109, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.11', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3794, 110, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.78', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3795, 110, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.60', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3796, 110, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.62', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3797, 110, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.10', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:32', '2026-07-12 12:44:32', NULL),
(3798, 110, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.27', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3799, 110, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.66', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3800, 110, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.18', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3801, 110, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.40', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3802, 110, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.69', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3803, 110, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.45', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3804, 110, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.86', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3805, 110, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.25', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3806, 110, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.23', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3807, 110, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.07', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3808, 110, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.04', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3809, 110, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.30', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3810, 110, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.53', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3811, 110, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.52', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3812, 110, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.64', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3813, 110, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.88', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3814, 110, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.61', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3815, 110, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '8.92', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3816, 110, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '11.64', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3817, 110, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.63', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3818, 110, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '5.62', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3819, 110, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.63', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3820, 110, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.48', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3821, 110, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '5.72', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3822, 110, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '8.61', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3823, 110, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.29', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3824, 110, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.29', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3825, 110, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '5.19', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3826, 110, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '6.02', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3827, 110, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.70', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3828, 110, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.57', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3829, 110, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.34', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3830, 110, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '6.87', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3831, 110, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '7.00', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3832, 110, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.81', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3833, 110, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '9.77', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3834, 110, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.83', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3835, 110, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.88', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3836, 111, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.52', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3837, 111, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.19', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3838, 111, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.94', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3839, 111, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.57', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3840, 111, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.37', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3841, 111, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.26', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3842, 111, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.29', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3843, 111, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.79', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3844, 111, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.08', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3845, 111, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.83', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3846, 111, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.56', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3847, 111, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.19', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3848, 111, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.84', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3849, 111, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.06', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3850, 111, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.13', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3851, 111, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '5.68', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3852, 111, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.53', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3853, 111, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.16', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3854, 111, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.90', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3855, 111, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.81', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3856, 111, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.60', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3857, 111, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.69', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3858, 111, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.98', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3859, 111, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.21', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3860, 111, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '6.72', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3861, 111, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.07', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3862, 111, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.82', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3863, 111, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.62', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3864, 111, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.26', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3865, 111, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.03', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3866, 111, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '17.11', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3867, 111, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '7.03', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3868, 111, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.38', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3869, 111, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '6.54', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3870, 111, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '8.72', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3871, 111, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.15', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3872, 111, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '8.32', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3873, 111, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.87', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3874, 111, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.89', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3875, 111, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '15.56', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3876, 111, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.38', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3877, 111, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.33', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3878, 112, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.35', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3879, 112, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.58', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3880, 112, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.82', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3881, 112, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.34', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3882, 112, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.27', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3883, 112, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.22', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3884, 112, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.48', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3885, 112, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.93', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3886, 112, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.85', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3887, 112, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.94', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3888, 112, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.88', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3889, 112, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.79', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3890, 112, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '5.18', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3891, 112, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.34', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3892, 112, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.57', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3893, 112, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.76', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3894, 112, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.37', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3895, 112, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.77', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3896, 112, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.23', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3897, 112, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.05', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3898, 112, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.00', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3899, 112, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.41', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3900, 112, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.53', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3901, 112, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.80', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3902, 112, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.85', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3903, 112, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.07', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3904, 112, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.92', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3905, 112, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '8.69', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3906, 112, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.13', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3907, 112, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.68', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3908, 112, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '5.30', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3909, 112, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '17.45', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3910, 112, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.41', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3911, 112, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.08', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3912, 112, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.27', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3913, 112, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.65', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3914, 112, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.44', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3915, 112, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.58', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3916, 112, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.49', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3917, 112, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '15.17', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3918, 112, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.98', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3919, 112, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.02', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3920, 113, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.00', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3921, 113, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.74', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3922, 113, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.38', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3923, 113, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.15', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3924, 113, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.18', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3925, 113, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.61', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3926, 113, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.46', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3927, 113, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.64', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3928, 113, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.83', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3929, 113, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.64', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3930, 113, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.62', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3931, 113, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.84', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3932, 113, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.40', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3933, 113, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.11', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3934, 113, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.00', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3935, 113, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.73', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3936, 113, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.00', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3937, 113, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '13.65', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3938, 113, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.65', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3939, 113, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.97', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3940, 113, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.72', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3941, 113, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.00', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3942, 113, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '6.81', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3943, 113, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.29', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3944, 113, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '6.19', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3945, 113, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '17.40', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3946, 113, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.67', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3947, 113, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.72', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3948, 113, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.80', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3949, 113, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.58', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3950, 113, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '8.71', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3951, 113, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.79', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3952, 113, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.42', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3953, 113, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '13.83', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3954, 113, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '6.15', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3955, 113, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.25', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3956, 113, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '13.66', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3957, 113, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.11', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3958, 113, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.77', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3959, 113, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.08', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3960, 113, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '6.44', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3961, 113, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.11', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3962, 114, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.53', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3963, 114, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.85', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3964, 114, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.05', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3965, 114, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.93', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3966, 114, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.99', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3967, 114, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.91', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3968, 114, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.27', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3969, 114, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.65', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3970, 114, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.75', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3971, 114, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.37', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3972, 114, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.36', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3973, 114, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.98', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3974, 114, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '10.69', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3975, 114, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.66', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3976, 114, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.79', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3977, 114, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.15', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3978, 114, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.96', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3979, 114, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.82', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3980, 114, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.26', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3981, 114, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.60', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3982, 114, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.20', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3983, 114, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '13.89', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL);
INSERT INTO `notes` (`id`, `eleve_id`, `matiere_id`, `classe_id`, `annee_scolaire_id`, `enseignant_id`, `type_evaluation`, `numero_devoir`, `periode`, `valeur`, `coefficient`, `date_evaluation`, `commentaire`, `verrouille`, `created_at`, `updated_at`, `evaluation_id`) VALUES
(3984, 114, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '10.75', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3985, 114, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.89', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3986, 114, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.13', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3987, 114, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '17.29', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3988, 114, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.34', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3989, 114, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '16.09', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3990, 114, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.70', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3991, 114, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.06', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3992, 114, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '6.88', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3993, 114, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.17', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3994, 114, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.66', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3995, 114, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.52', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3996, 114, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '5.82', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3997, 114, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.16', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3998, 114, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '16.00', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(3999, 114, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.27', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4000, 114, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.57', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4001, 114, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '13.12', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4002, 114, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '8.00', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4003, 114, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.47', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4004, 115, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.29', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4005, 115, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.40', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4006, 115, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.23', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4007, 115, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.46', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4008, 115, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.16', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4009, 115, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.54', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4010, 115, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.74', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4011, 115, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.20', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4012, 115, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.32', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4013, 115, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.92', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4014, 115, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.06', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4015, 115, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.66', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4016, 115, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.26', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4017, 115, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.87', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4018, 115, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.40', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4019, 115, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.34', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4020, 115, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.22', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4021, 115, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.92', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4022, 115, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '5.82', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4023, 115, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.53', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4024, 115, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.16', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4025, 115, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.34', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4026, 115, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '5.69', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4027, 115, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.87', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4028, 115, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '13.93', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4029, 115, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '6.35', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4030, 115, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.97', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4031, 115, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '15.78', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4032, 115, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.47', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4033, 115, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.17', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4034, 115, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.28', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4035, 115, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.75', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4036, 115, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.35', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4037, 115, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.66', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4038, 115, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.18', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4039, 115, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.97', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4040, 115, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.99', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4041, 115, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '10.59', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4042, 115, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.83', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4043, 115, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '8.07', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4044, 115, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.43', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4045, 115, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.77', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4046, 116, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.23', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4047, 116, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.46', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4048, 116, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.63', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4049, 116, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.06', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4050, 116, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.65', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4051, 116, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.67', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4052, 116, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.84', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4053, 116, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.04', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4054, 116, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.99', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4055, 116, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.55', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4056, 116, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.70', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4057, 116, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.55', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4058, 116, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '5.34', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4059, 116, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.36', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4060, 116, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '11.47', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4061, 116, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.20', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4062, 116, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.16', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4063, 116, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.78', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4064, 116, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.33', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4065, 116, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.23', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4066, 116, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.22', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4067, 116, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '16.61', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4068, 116, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.35', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4069, 116, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.68', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4070, 116, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '9.47', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4071, 116, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '5.61', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4072, 116, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.98', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4073, 116, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '9.00', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4074, 116, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '10.10', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4075, 116, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.26', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4076, 116, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.85', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4077, 116, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.89', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4078, 116, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.08', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4079, 116, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '13.17', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4080, 116, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '17.28', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4081, 116, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.57', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4082, 116, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.91', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4083, 116, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '9.61', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4084, 116, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.54', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4085, 116, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.92', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4086, 116, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.31', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4087, 116, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '13.65', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4088, 117, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.02', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4089, 117, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.72', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4090, 117, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.92', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4091, 117, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.48', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4092, 117, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '5.88', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4093, 117, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.41', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4094, 117, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.88', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4095, 117, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.80', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4096, 117, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.91', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4097, 117, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.35', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4098, 117, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.72', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4099, 117, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.52', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4100, 117, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.22', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4101, 117, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.71', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4102, 117, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.53', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4103, 117, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.43', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4104, 117, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.38', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4105, 117, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.48', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4106, 117, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.51', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4107, 117, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.07', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4108, 117, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.58', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4109, 117, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.77', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4110, 117, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.57', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4111, 117, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.98', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4112, 117, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '16.88', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4113, 117, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '7.55', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4114, 117, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.26', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4115, 117, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.20', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4116, 117, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.00', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4117, 117, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '15.92', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4118, 117, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.92', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4119, 117, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '8.74', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4120, 117, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.51', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4121, 117, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '9.85', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4122, 117, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.55', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4123, 117, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.00', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4124, 117, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '5.98', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4125, 117, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.47', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4126, 117, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.22', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4127, 117, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.15', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4128, 117, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.48', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4129, 117, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.32', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4130, 118, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.80', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4131, 118, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.74', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4132, 118, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.10', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4133, 118, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '16.96', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4134, 118, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '16.33', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4135, 118, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '8.58', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4136, 118, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.07', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4137, 118, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.74', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4138, 118, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.42', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4139, 118, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.39', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4140, 118, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.32', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4141, 118, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '6.80', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4142, 118, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.72', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4143, 118, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.93', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4144, 118, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '16.91', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4145, 118, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.55', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4146, 118, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '13.70', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4147, 118, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.76', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4148, 118, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.88', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4149, 118, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.29', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4150, 118, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.44', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4151, 118, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '5.25', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4152, 118, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.17', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4153, 118, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '12.77', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4154, 118, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.35', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4155, 118, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '5.68', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:33', '2026-07-12 12:44:33', NULL),
(4156, 118, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.38', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4157, 118, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.35', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4158, 118, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.45', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4159, 118, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.67', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4160, 118, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '13.22', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4161, 118, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.91', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4162, 118, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.84', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4163, 118, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.59', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4164, 118, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '5.80', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4165, 118, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.40', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4166, 118, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '12.03', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4167, 118, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.71', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4168, 118, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.43', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4169, 118, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.43', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4170, 118, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '5.85', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4171, 118, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.06', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4172, 119, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.20', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4173, 119, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '7.68', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4174, 119, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.01', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4175, 119, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '7.45', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4176, 119, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '11.85', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4177, 119, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.83', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4178, 119, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '6.65', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4179, 119, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.12', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4180, 119, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '7.56', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4181, 119, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '8.88', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4182, 119, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.26', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4183, 119, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.10', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4184, 119, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '11.55', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4185, 119, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '10.62', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4186, 119, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '9.45', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4187, 119, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.38', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4188, 119, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '14.60', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4189, 119, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.21', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4190, 119, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '9.32', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4191, 119, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '15.13', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4192, 119, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '10.70', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4193, 119, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.38', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4194, 119, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '16.33', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4195, 119, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.98', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4196, 119, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '15.19', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4197, 119, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '5.24', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4198, 119, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.33', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4199, 119, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.12', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4200, 119, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '15.02', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4201, 119, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.33', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4202, 119, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '15.30', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4203, 119, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.99', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4204, 119, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.92', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4205, 119, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '13.39', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4206, 119, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '12.93', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4207, 119, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.54', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4208, 119, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '13.64', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4209, 119, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '5.62', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4210, 119, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '14.58', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4211, 119, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.70', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4212, 119, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '11.21', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4213, 119, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '9.40', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4214, 120, 10, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '17.63', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4215, 120, 10, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.96', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4216, 120, 10, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.09', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4217, 120, 5, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '12.36', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4218, 120, 5, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '17.94', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4219, 120, 5, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '13.51', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4220, 120, 11, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.90', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4221, 120, 11, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.98', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4222, 120, 11, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '12.94', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4223, 120, 12, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '13.77', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4224, 120, 12, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '9.77', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4225, 120, 12, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.19', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4226, 120, 13, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '14.41', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4227, 120, 13, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '6.13', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4228, 120, 13, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '15.88', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4229, 120, 14, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.06', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4230, 120, 14, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '8.69', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4231, 120, 14, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '14.93', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4232, 120, 15, 6, 2, NULL, 'devoir', 1, 'Premier Semestre', '15.53', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4233, 120, 15, 6, 2, NULL, 'devoir', 2, 'Premier Semestre', '12.81', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4234, 120, 15, 6, 2, NULL, 'composition', 1, 'Premier Semestre', '13.71', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4235, 120, 10, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '10.44', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4236, 120, 10, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '5.95', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4237, 120, 10, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.70', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4238, 120, 5, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '13.95', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4239, 120, 5, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '17.53', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4240, 120, 5, 6, 2, NULL, 'composition', 1, 'Second Semestre', '10.47', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4241, 120, 11, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '14.78', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4242, 120, 11, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.08', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4243, 120, 11, 6, 2, NULL, 'composition', 1, 'Second Semestre', '7.45', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4244, 120, 12, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '15.57', '1.0', '2026-06-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4245, 120, 12, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '7.75', '1.0', '2026-05-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4246, 120, 12, 6, 2, NULL, 'composition', 1, 'Second Semestre', '16.11', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4247, 120, 13, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '7.76', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4248, 120, 13, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '14.26', '1.0', '2026-04-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4249, 120, 13, 6, 2, NULL, 'composition', 1, 'Second Semestre', '11.42', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4250, 120, 14, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '11.90', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4251, 120, 14, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '8.56', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4252, 120, 14, 6, 2, NULL, 'composition', 1, 'Second Semestre', '8.87', '1.0', '2026-01-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4253, 120, 15, 6, 2, NULL, 'devoir', 1, 'Second Semestre', '16.82', '1.0', '2026-02-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4254, 120, 15, 6, 2, NULL, 'devoir', 2, 'Second Semestre', '13.41', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4255, 120, 15, 6, 2, NULL, 'composition', 1, 'Second Semestre', '13.92', '1.0', '2026-03-12', NULL, 0, '2026-07-12 12:44:34', '2026-07-12 12:44:34', NULL),
(4256, 1, 1, 1, NULL, 1, 'Devoir', 1, 'Semestre 1', '15.00', '1.0', '2026-08-12', NULL, 0, '2026-07-13 16:56:30', '2026-09-02 11:27:59', 1),
(4257, 2, 1, 1, NULL, 1, 'devoir', 1, 'Premier Semestre', '14.00', '1.0', '2026-08-12', NULL, 0, '2026-07-13 16:56:30', '2026-08-31 15:59:52', 1),
(4258, 3, 1, 1, NULL, 1, 'devoir', 1, 'Premier Semestre', '15.00', '1.0', '2026-08-12', NULL, 0, '2026-07-13 16:56:30', '2026-08-31 15:59:52', 1),
(4259, 4, 1, 1, NULL, 1, 'devoir', 1, 'Premier Semestre', '9.00', '1.0', '2026-08-12', NULL, 0, '2026-07-13 16:56:30', '2026-08-31 15:59:52', 1),
(4260, 5, 1, 1, NULL, 1, 'devoir', 1, 'Premier Semestre', '10.00', '1.0', '2026-08-12', NULL, 0, '2026-07-13 16:56:30', '2026-08-31 15:59:52', 1),
(4261, 1, 1, 1, NULL, 1, 'Devoir', 1, '1', '14.00', '1.0', '2026-01-01', NULL, 0, '2026-09-02 12:38:50', '2026-09-02 12:38:50', 2),
(4262, 2, 1, 1, NULL, 1, 'Devoir', 1, '1', '10.00', '1.0', '2026-01-01', NULL, 0, '2026-09-02 12:38:50', '2026-09-02 12:38:50', 2),
(4263, 3, 1, 1, NULL, 1, 'Devoir', 1, '1', '12.00', '1.0', '2026-01-01', NULL, 0, '2026-09-02 12:38:50', '2026-09-02 12:38:50', 2),
(4264, 4, 1, 1, NULL, 1, 'Devoir', 1, '1', '17.00', '1.0', '2026-01-01', NULL, 0, '2026-09-02 12:38:50', '2026-09-02 12:38:50', 2),
(4265, 5, 1, 1, NULL, 1, 'Devoir', 1, '1', '10.00', '1.0', '2026-01-01', NULL, 0, '2026-09-02 12:38:50', '2026-09-02 12:38:50', 2);

-- --------------------------------------------------------

--
-- Structure de la table `notifications_push`
--

CREATE TABLE `notifications_push` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `titre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`data`)),
  `lu` tinyint(1) NOT NULL DEFAULT 0,
  `lu_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `paiements`
--

CREATE TABLE `paiements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `eleve_id` bigint(20) UNSIGNED NOT NULL,
  `type_paiement_id` bigint(20) UNSIGNED NOT NULL,
  `encaisse_par` bigint(20) UNSIGNED DEFAULT NULL,
  `annee_scolaire_id` bigint(20) UNSIGNED NOT NULL,
  `montant_du` decimal(12,2) NOT NULL,
  `montant_paye` decimal(12,2) NOT NULL,
  `reste_a_payer` decimal(12,2) NOT NULL DEFAULT 0.00,
  `mois` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mode_paiement` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'especes',
  `statut` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'partiel',
  `notes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_paiement` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `paiements`
--

INSERT INTO `paiements` (`id`, `reference`, `eleve_id`, `type_paiement_id`, `encaisse_par`, `annee_scolaire_id`, `montant_du`, `montant_paye`, `reste_a_payer`, `mois`, `mode_paiement`, `statut`, `notes`, `date_paiement`, `created_at`, `updated_at`) VALUES
(1, 'PAY-1777121933-11', 1, 1, NULL, 1, '25000.00', '25000.00', '0.00', NULL, 'especes', 'paye', NULL, '2026-04-25 12:58:53', '2026-04-25 12:58:53', '2026-04-25 12:58:53'),
(2, 'PAY-1777121933-12', 2, 1, NULL, 1, '25000.00', '25000.00', '0.00', NULL, 'especes', 'paye', NULL, '2026-04-25 12:58:53', '2026-04-25 12:58:53', '2026-04-25 12:58:53'),
(3, 'PAY-1777121934-13', 3, 1, NULL, 1, '25000.00', '25000.00', '0.00', NULL, 'especes', 'paye', NULL, '2026-04-25 12:58:54', '2026-04-25 12:58:54', '2026-04-25 12:58:54'),
(4, 'PAY-1777121934-14', 4, 1, NULL, 1, '25000.00', '25000.00', '0.00', NULL, 'especes', 'paye', NULL, '2026-04-25 12:58:54', '2026-04-25 12:58:54', '2026-04-25 12:58:54'),
(5, 'PAY-1777121935-15', 5, 1, NULL, 1, '25000.00', '25000.00', '0.00', NULL, 'especes', 'paye', NULL, '2026-04-25 12:58:55', '2026-04-25 12:58:55', '2026-04-25 12:58:55'),
(6, 'PAY-1777121935-21', 6, 1, NULL, 1, '25000.00', '25000.00', '0.00', NULL, 'especes', 'paye', NULL, '2026-04-25 12:58:55', '2026-04-25 12:58:55', '2026-04-25 12:58:55'),
(7, 'PAY-1777121936-22', 7, 1, NULL, 1, '25000.00', '25000.00', '0.00', NULL, 'especes', 'paye', NULL, '2026-04-25 12:58:56', '2026-04-25 12:58:56', '2026-04-25 12:58:56'),
(8, 'PAY-1777121936-23', 8, 1, NULL, 1, '25000.00', '25000.00', '0.00', NULL, 'especes', 'paye', NULL, '2026-04-25 12:58:56', '2026-04-25 12:58:56', '2026-04-25 12:58:56'),
(9, 'PAY-1777121937-24', 9, 1, NULL, 1, '25000.00', '25000.00', '0.00', NULL, 'especes', 'paye', NULL, '2026-04-25 12:58:57', '2026-04-25 12:58:57', '2026-04-25 12:58:57'),
(10, 'PAY-1777121937-25', 10, 1, NULL, 1, '25000.00', '25000.00', '0.00', NULL, 'especes', 'paye', NULL, '2026-04-25 12:58:57', '2026-04-25 12:58:57', '2026-04-25 12:58:57'),
(11, 'PAY-1777121938-31', 11, 1, NULL, 1, '25000.00', '25000.00', '0.00', NULL, 'especes', 'paye', NULL, '2026-04-25 12:58:58', '2026-04-25 12:58:58', '2026-04-25 12:58:58'),
(12, 'PAY-1777121938-32', 12, 1, NULL, 1, '25000.00', '25000.00', '0.00', NULL, 'especes', 'paye', NULL, '2026-04-25 12:58:58', '2026-04-25 12:58:58', '2026-04-25 12:58:58'),
(13, 'PAY-1777121939-33', 13, 1, NULL, 1, '25000.00', '25000.00', '0.00', NULL, 'especes', 'paye', NULL, '2026-04-25 12:58:59', '2026-04-25 12:58:59', '2026-04-25 12:58:59'),
(14, 'PAY-1777121939-34', 14, 1, NULL, 1, '25000.00', '25000.00', '0.00', NULL, 'especes', 'paye', NULL, '2026-04-25 12:58:59', '2026-04-25 12:58:59', '2026-04-25 12:58:59'),
(15, 'PAY-1777121940-35', 15, 1, NULL, 1, '25000.00', '25000.00', '0.00', NULL, 'especes', 'paye', NULL, '2026-04-25 12:59:00', '2026-04-25 12:59:00', '2026-04-25 12:59:00'),
(16, 'PAY-1777121940-41', 16, 1, NULL, 1, '25000.00', '25000.00', '0.00', NULL, 'especes', 'paye', NULL, '2026-04-25 12:59:00', '2026-04-25 12:59:00', '2026-04-25 12:59:00'),
(17, 'PAY-1777121941-42', 17, 1, NULL, 1, '25000.00', '25000.00', '0.00', NULL, 'especes', 'paye', NULL, '2026-04-25 12:59:01', '2026-04-25 12:59:01', '2026-04-25 12:59:01'),
(18, 'PAY-1777121941-43', 18, 1, NULL, 1, '25000.00', '25000.00', '0.00', NULL, 'especes', 'paye', NULL, '2026-04-25 12:59:01', '2026-04-25 12:59:01', '2026-04-25 12:59:01'),
(19, 'PAY-1777121942-44', 19, 1, NULL, 1, '25000.00', '25000.00', '0.00', NULL, 'especes', 'paye', NULL, '2026-04-25 12:59:02', '2026-04-25 12:59:02', '2026-04-25 12:59:02'),
(20, 'PAY-1777121942-45', 20, 1, NULL, 1, '25000.00', '25000.00', '0.00', NULL, 'especes', 'paye', NULL, '2026-04-25 12:59:02', '2026-04-25 12:59:02', '2026-04-25 12:59:02'),
(21, 'PAY-69ED0A3DB2B5B', 1, 2, 1, 1, '15000.00', '14999.00', '1.00', '10/2026', 'espèces', 'partiel', NULL, '2026-04-25 00:00:00', '2026-04-25 18:38:53', '2026-04-25 18:38:53'),
(22, 'PAY-6A53954D7C3D5', 1, 2, 1, 1, '15000.00', '15000.00', '0.00', '07/2026', 'espèces', 'paye', NULL, '2026-07-12 00:00:00', '2026-07-12 13:23:25', '2026-07-12 13:23:25'),
(23, 'PAY-6AA155F02994C', 76, 2, 1, 1, '25000.00', '25000.00', '0.00', '04/2026', 'espèces', 'paye', NULL, '2026-09-09 00:00:00', '2026-09-09 12:49:52', '2026-09-09 12:49:52');

-- --------------------------------------------------------

--
-- Structure de la table `parents`
--

CREATE TABLE `parents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `profession` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adresse` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `relation` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'parent',
  `nin` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actif` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `parents`
--

INSERT INTO `parents` (`id`, `user_id`, `telephone`, `profession`, `adresse`, `relation`, `nin`, `photo`, `actif`, `created_at`, `updated_at`) VALUES
(1, 5, '780000011', NULL, NULL, 'parent', NULL, NULL, 1, '2026-04-25 12:58:52', '2026-04-25 12:58:52'),
(2, 7, '780000012', NULL, NULL, 'parent', NULL, NULL, 1, '2026-04-25 12:58:53', '2026-04-25 12:58:53'),
(3, 9, '780000013', NULL, NULL, 'parent', NULL, NULL, 1, '2026-04-25 12:58:53', '2026-04-25 12:58:53'),
(4, 11, '780000014', NULL, NULL, 'parent', NULL, NULL, 1, '2026-04-25 12:58:54', '2026-04-25 12:58:54'),
(5, 13, '780000015', NULL, NULL, 'parent', NULL, NULL, 1, '2026-04-25 12:58:54', '2026-04-25 12:58:54'),
(6, 15, '780000021', NULL, NULL, 'parent', NULL, NULL, 1, '2026-04-25 12:58:55', '2026-04-25 12:58:55'),
(7, 17, '780000022', NULL, NULL, 'parent', NULL, NULL, 1, '2026-04-25 12:58:55', '2026-04-25 12:58:55'),
(8, 19, '780000023', NULL, NULL, 'parent', NULL, NULL, 1, '2026-04-25 12:58:56', '2026-04-25 12:58:56'),
(9, 21, '780000024', NULL, NULL, 'parent', NULL, NULL, 1, '2026-04-25 12:58:56', '2026-04-25 12:58:56'),
(10, 23, '780000025', NULL, NULL, 'parent', NULL, NULL, 1, '2026-04-25 12:58:57', '2026-04-25 12:58:57'),
(11, 25, '780000031', NULL, NULL, 'parent', NULL, NULL, 1, '2026-04-25 12:58:57', '2026-04-25 12:58:57'),
(12, 27, '780000032', NULL, NULL, 'parent', NULL, NULL, 1, '2026-04-25 12:58:58', '2026-04-25 12:58:58'),
(13, 29, '780000033', NULL, NULL, 'parent', NULL, NULL, 1, '2026-04-25 12:58:58', '2026-04-25 12:58:58'),
(14, 31, '780000034', NULL, NULL, 'parent', NULL, NULL, 1, '2026-04-25 12:58:59', '2026-04-25 12:58:59'),
(15, 33, '780000035', NULL, NULL, 'parent', NULL, NULL, 1, '2026-04-25 12:58:59', '2026-04-25 12:58:59'),
(16, 35, '780000041', NULL, NULL, 'parent', NULL, NULL, 1, '2026-04-25 12:59:00', '2026-04-25 12:59:00'),
(17, 37, '780000042', NULL, NULL, 'parent', NULL, NULL, 1, '2026-04-25 12:59:00', '2026-04-25 12:59:00'),
(18, 39, '780000043', NULL, NULL, 'parent', NULL, NULL, 1, '2026-04-25 12:59:01', '2026-04-25 12:59:01'),
(19, 41, '780000044', NULL, NULL, 'parent', NULL, NULL, 1, '2026-04-25 12:59:01', '2026-04-25 12:59:01'),
(20, 43, '780000045', NULL, NULL, 'parent', NULL, NULL, 1, '2026-04-25 12:59:02', '2026-04-25 12:59:02');

-- --------------------------------------------------------

--
-- Structure de la table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'eleves.view', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(2, 'eleves.create', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(3, 'eleves.edit', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(4, 'eleves.delete', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(5, 'enseignants.view', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(6, 'enseignants.create', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(7, 'enseignants.edit', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(8, 'enseignants.delete', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(9, 'classes.view', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(10, 'classes.create', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(11, 'classes.edit', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(12, 'classes.delete', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(13, 'notes.view', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(14, 'notes.saisir', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(15, 'notes.valider', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(16, 'bulletins.view', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(17, 'bulletins.generer', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(18, 'bulletins.publier', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(19, 'absences.view', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(20, 'absences.marquer', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(21, 'absences.justifier', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(22, 'paiements.view', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(23, 'paiements.encaisser', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(24, 'paiements.stats', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(25, 'parametres.view', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(26, 'parametres.edit', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(27, 'emplois.view', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(28, 'emplois.edit', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51');

-- --------------------------------------------------------

--
-- Structure de la table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `recus`
--

CREATE TABLE `recus` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `numero` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paiement_id` bigint(20) UNSIGNED NOT NULL,
  `emis_par` bigint(20) UNSIGNED DEFAULT NULL,
  `pdf_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qr_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `envoye_email` tinyint(1) NOT NULL DEFAULT 0,
  `date_emission` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'super_admin', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(2, 'directeur', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(3, 'comptable', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(4, 'surveillant', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(5, 'enseignant', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(6, 'parent', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(7, 'eleve', 'web', '2026-04-25 12:58:51', '2026-04-25 12:58:51');

-- --------------------------------------------------------

--
-- Structure de la table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(2, 1),
(2, 2),
(3, 1),
(3, 2),
(4, 1),
(5, 1),
(5, 2),
(6, 1),
(6, 2),
(7, 1),
(7, 2),
(8, 1),
(9, 1),
(9, 2),
(10, 1),
(10, 2),
(11, 1),
(11, 2),
(12, 1),
(13, 1),
(13, 2),
(13, 5),
(13, 6),
(13, 7),
(14, 1),
(14, 5),
(15, 1),
(16, 1),
(16, 2),
(16, 6),
(16, 7),
(17, 1),
(18, 1),
(18, 2),
(19, 1),
(19, 2),
(19, 4),
(19, 6),
(19, 7),
(20, 1),
(20, 4),
(20, 5),
(21, 1),
(21, 4),
(22, 1),
(22, 3),
(22, 6),
(23, 1),
(23, 3),
(24, 1),
(24, 2),
(24, 3),
(25, 1),
(26, 1),
(27, 1),
(27, 2),
(27, 4),
(27, 5),
(27, 6),
(27, 7),
(28, 1);

-- --------------------------------------------------------

--
-- Structure de la table `salles`
--

CREATE TABLE `salles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `capacite` int(11) NOT NULL DEFAULT 40,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'classe',
  `disponible` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `salles`
--

INSERT INTO `salles` (`id`, `nom`, `code`, `capacite`, `type`, `disponible`, `created_at`, `updated_at`) VALUES
(1, 'Salle 101', NULL, 45, 'classe', 1, '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(2, 'Salle 102', NULL, 45, 'classe', 1, '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(3, 'Labo SVT', NULL, 30, 'laboratoire', 1, '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(5, 'Salle 201', NULL, 50, 'classe', 1, '2026-07-12 12:41:05', '2026-07-12 12:41:05');

-- --------------------------------------------------------

--
-- Structure de la table `series`
--

CREATE TABLE `series` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cycle` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'secondaire',
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `series`
--

INSERT INTO `series` (`id`, `nom`, `code`, `cycle`, `description`, `created_at`, `updated_at`) VALUES
(1, 'S1', 'S1', 'secondaire', NULL, '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(2, 'S2', 'S2', 'secondaire', NULL, '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(3, 'L1', 'L1', 'secondaire', NULL, '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(4, 'Littéraire L2', 'L2', 'secondaire', 'Langues et Civilisations', '2026-07-12 12:41:05', '2026-07-12 12:41:05');

-- --------------------------------------------------------

--
-- Structure de la table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('OmkVtJ0LGSUn2Aaw5bgXnYA6n8m36uDR3BDfASIV', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiaFE5d0hsTnEySUJNU1ppc2haQXl2d1BEZnlqc3dLVU9aQUJ1SGFzaiI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjI5OiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvY2xhc3NlcyI7czo1OiJyb3V0ZSI7czoxMzoiY2xhc3Nlcy5pbmRleCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7fQ==', 1788968644);

-- --------------------------------------------------------

--
-- Structure de la table `tarifs`
--

CREATE TABLE `tarifs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `annee_scolaire_id` bigint(20) UNSIGNED NOT NULL,
  `niveau_id` bigint(20) UNSIGNED NOT NULL,
  `type_paiement_id` bigint(20) UNSIGNED NOT NULL,
  `montant` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `types_paiements`
--

CREATE TABLE `types_paiements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `montant_defaut` decimal(12,2) NOT NULL DEFAULT 0.00,
  `periodicite` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unique',
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `types_paiements`
--

INSERT INTO `types_paiements` (`id`, `nom`, `code`, `montant_defaut`, `periodicite`, `active`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Inscription', 'INSCR', '25000.00', 'unique', 1, NULL, '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(2, 'Mensualité', 'MENS', '15000.00', 'mensuel', 1, NULL, '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(3, 'Cantine', 'CANT', '10000.00', 'mensuel', 1, NULL, '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(4, 'Transport', 'TRANSP', '12000.00', 'mensuel', 1, NULL, '2026-04-25 12:58:51', '2026-04-25 12:58:51');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cycle_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actif` tinyint(1) NOT NULL DEFAULT 1,
  `fcm_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `cycle_id`, `name`, `email`, `telephone`, `photo`, `actif`, `fcm_token`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Admin SunuEcole', 'admin@sunuecole.sn', '770000000', NULL, 1, NULL, NULL, '$2y$12$esc1amDZVml7lUrLZWqLueISeVZVKxMVX9Fxp1oy3boNtvEoiowPK', NULL, '2026-04-25 12:58:51', '2026-04-25 12:58:51'),
(2, NULL, 'Professeur 1', 'prof1@sunuecole.sn', '770000001', NULL, 1, NULL, NULL, '$2y$12$0F65euJ89UBesjW2R.CtVOeD.2b8hpOs7msbbwkPsvjFLUm1pf702', NULL, '2026-04-25 12:58:52', '2026-04-25 12:58:52'),
(3, NULL, 'Professeur 2', 'prof2@sunuecole.sn', '770000002', NULL, 1, NULL, NULL, '$2y$12$HfJGlyvEEo5TL0o8olzVvOeSpe2pN/rnIY3hkcCjyAMA0fGCH0DIy', NULL, '2026-04-25 12:58:52', '2026-04-25 12:58:52'),
(4, NULL, 'Professeur 3', 'prof3@sunuecole.sn', '770000003', NULL, 1, NULL, NULL, '$2y$12$TdHLtk6.lGxS6lP6XjSxEOf6cJid0RyVB7a20d6sJLqUu9l0eg4/G', NULL, '2026-04-25 12:58:52', '2026-04-25 12:58:52'),
(5, NULL, 'Parent Eleve 11', 'parent11@gmail.com', NULL, NULL, 1, NULL, NULL, '$2y$12$NAv8ZbUadVA.0T7lummVEeeW1F83sVyCYwrEsO2VQrmZDlFAn10bO', NULL, '2026-04-25 12:58:52', '2026-04-25 12:58:52'),
(6, NULL, 'Prenom-11 NOM-11', 'eleve11@sunuecole.sn', NULL, NULL, 1, NULL, NULL, '$2y$12$Yhvidcdzkt62wm0iMa/ZluHzNbvG8r.KoSfyQTVIj.J7uG22BMZMy', NULL, '2026-04-25 12:58:53', '2026-04-25 12:58:53'),
(7, NULL, 'Parent Eleve 12', 'parent12@gmail.com', NULL, NULL, 1, NULL, NULL, '$2y$12$LxiQX/W/XDdKXfAZuFxfGuZphVBhM0Eo.TuW84zDQLBTCr/pciz2S', NULL, '2026-04-25 12:58:53', '2026-04-25 12:58:53'),
(8, NULL, 'Prenom-12 NOM-12', 'eleve12@sunuecole.sn', NULL, NULL, 1, NULL, NULL, '$2y$12$QsW5eTdK8S8WiRagM.b7xe3/lNFDKqNutQXUmYYbLvE3446CHdVIa', NULL, '2026-04-25 12:58:53', '2026-04-25 12:58:53'),
(9, NULL, 'Parent Eleve 13', 'parent13@gmail.com', NULL, NULL, 1, NULL, NULL, '$2y$12$qfZSfRD21IBl/cYBOzZkv..y6CAP5tsU2uIgu8maEe9smRBijuir6', NULL, '2026-04-25 12:58:53', '2026-04-25 12:58:53'),
(10, NULL, 'Prenom-13 NOM-13', 'eleve13@sunuecole.sn', NULL, NULL, 1, NULL, NULL, '$2y$12$UdAd8RFFbUsUivc/g6wuA.0AqNiay3Kvf5n40ee.nCfCTfmOwQJ8K', NULL, '2026-04-25 12:58:54', '2026-04-25 12:58:54'),
(11, NULL, 'Parent Eleve 14', 'parent14@gmail.com', NULL, NULL, 1, NULL, NULL, '$2y$12$qJUPjjua3.UtDLgvfouqSO22Qn.g10j1PoJ4FRcQRg500cvNXlM2O', NULL, '2026-04-25 12:58:54', '2026-04-25 12:58:54'),
(12, NULL, 'Prenom-14 NOM-14', 'eleve14@sunuecole.sn', NULL, NULL, 1, NULL, NULL, '$2y$12$8Le3k74Jw0AcE9MHMxwVE.idPxsG9SJOQhT2m5XmIa2n7Bmbet2aS', NULL, '2026-04-25 12:58:54', '2026-04-25 12:58:54'),
(13, NULL, 'Parent Eleve 15', 'parent15@gmail.com', NULL, NULL, 1, NULL, NULL, '$2y$12$LUb57eLt9kVV2sP0k49DmufB4I2OPVy8ZLMx9oul.UBt9Tf9tXuB.', NULL, '2026-04-25 12:58:54', '2026-04-25 12:58:54'),
(14, NULL, 'Prenom-15 NOM-15', 'eleve15@sunuecole.sn', NULL, NULL, 1, NULL, NULL, '$2y$12$c3VNYMEtaVVqBKOx2WxINeo3vRkYAzUN7BfmInTdO3dMcVx/6jdG6', NULL, '2026-04-25 12:58:55', '2026-04-25 12:58:55'),
(15, NULL, 'Parent Eleve 21', 'parent21@gmail.com', NULL, NULL, 1, NULL, NULL, '$2y$12$quyhpw7Mu3du2Dohc0/.Du8wRIYfH4p8EMy2Ez0DCrEVx2fRtlpl.', NULL, '2026-04-25 12:58:55', '2026-04-25 12:58:55'),
(16, NULL, 'Prenom-21 NOM-21', 'eleve21@sunuecole.sn', NULL, NULL, 1, NULL, NULL, '$2y$12$s87VyD2Kcj2WhNTPF/1rHus3G7EtOORlJya5mCx8bxCr3mA2NUbha', NULL, '2026-04-25 12:58:55', '2026-04-25 12:58:55'),
(17, NULL, 'Parent Eleve 22', 'parent22@gmail.com', NULL, NULL, 1, NULL, NULL, '$2y$12$urCw5ERcPYvxk2HZB7HKs.l89hAVlTRaGPsKBdeAoiSnj99sY9mqG', NULL, '2026-04-25 12:58:55', '2026-04-25 12:58:55'),
(18, NULL, 'Prenom-22 NOM-22', 'eleve22@sunuecole.sn', NULL, NULL, 1, NULL, NULL, '$2y$12$G7.nObIdO6AzsaeqdOEowOePc.ZPD8UOg7hYlhutDaUeewYn.ruxe', NULL, '2026-04-25 12:58:56', '2026-04-25 12:58:56'),
(19, NULL, 'Parent Eleve 23', 'parent23@gmail.com', NULL, NULL, 1, NULL, NULL, '$2y$12$8gmtAllG6diq0eXpnUnXGOmpUEVDSLNlNg7uCmGvidgSAaHqnTNka', NULL, '2026-04-25 12:58:56', '2026-04-25 12:58:56'),
(20, NULL, 'Prenom-23 NOM-23', 'eleve23@sunuecole.sn', NULL, NULL, 1, NULL, NULL, '$2y$12$Jy4PmusHwwYsmzukTchGWOF.3ztiZAURqnfHL7POiupmSWQtlwQ3.', NULL, '2026-04-25 12:58:56', '2026-04-25 12:58:56'),
(21, NULL, 'Parent Eleve 24', 'parent24@gmail.com', NULL, NULL, 1, NULL, NULL, '$2y$12$v2BoHQ.1U4LIH3o7F.pc3eUQMQ62bXHBX22Oxiuq1Kr80rGvQHk9C', NULL, '2026-04-25 12:58:56', '2026-04-25 12:58:56'),
(22, NULL, 'Prenom-24 NOM-24', 'eleve24@sunuecole.sn', NULL, NULL, 1, NULL, NULL, '$2y$12$d0wLSFgSKGwqJ3zkLZVkA.Kl27xIwSPf0d3cpEtykPUdjwPv6FWUS', NULL, '2026-04-25 12:58:57', '2026-04-25 12:58:57'),
(23, NULL, 'Parent Eleve 25', 'parent25@gmail.com', NULL, NULL, 1, NULL, NULL, '$2y$12$FLy2BhD0o3GwATSWi.gkm.tbtgVr9SJidj3bAznBj0sgvUpzFM5Z6', NULL, '2026-04-25 12:58:57', '2026-04-25 12:58:57'),
(24, NULL, 'Prenom-25 NOM-25', 'eleve25@sunuecole.sn', NULL, NULL, 1, NULL, NULL, '$2y$12$Kf6Y1qrCVSntBv6jKiv8Ee9paYUU0q4pluO3kS0Xr.folOEZhlN1u', NULL, '2026-04-25 12:58:57', '2026-04-25 12:58:57'),
(25, NULL, 'Parent Eleve 31', 'parent31@gmail.com', NULL, NULL, 1, NULL, NULL, '$2y$12$kfIv52MixAM/V/fCypfeiu8fCALEA3kTJK9UHFvSzr4YZRQDNvpge', NULL, '2026-04-25 12:58:57', '2026-04-25 12:58:57'),
(26, NULL, 'Prenom-31 NOM-31', 'eleve31@sunuecole.sn', NULL, NULL, 1, NULL, NULL, '$2y$12$kHIjpdlnDkaE8STiRR.UGuCk3k9hk4k7xKIEt1kb0BJ/Os/sDP39G', NULL, '2026-04-25 12:58:58', '2026-04-25 12:58:58'),
(27, NULL, 'Parent Eleve 32', 'parent32@gmail.com', NULL, NULL, 1, NULL, NULL, '$2y$12$0keFbqifJ9M4JyXSxbs6KeAYQpFaSiokSICwnBqdtvgpNpvsmb9Va', NULL, '2026-04-25 12:58:58', '2026-04-25 12:58:58'),
(28, NULL, 'Prenom-32 NOM-32', 'eleve32@sunuecole.sn', NULL, NULL, 1, NULL, NULL, '$2y$12$bUnKhtlLDMfmnPllexXvy.qsPBEEyf/LU/PHbAaTDm..TsJTGJCxW', NULL, '2026-04-25 12:58:58', '2026-04-25 12:58:58'),
(29, NULL, 'Parent Eleve 33', 'parent33@gmail.com', NULL, NULL, 1, NULL, NULL, '$2y$12$jvXfNhOfMhemE3A9RVGs4uOOzcyzp9NP/RSKNduQkssGx5A7BDwje', NULL, '2026-04-25 12:58:58', '2026-04-25 12:58:58'),
(30, NULL, 'Prenom-33 NOM-33', 'eleve33@sunuecole.sn', NULL, NULL, 1, NULL, NULL, '$2y$12$0LB2I3qfnKvxOPt9liXPe.CWNq5DkBHCaLMp5S.sWu.48ChgzY./q', NULL, '2026-04-25 12:58:59', '2026-04-25 12:58:59'),
(31, NULL, 'Parent Eleve 34', 'parent34@gmail.com', NULL, NULL, 1, NULL, NULL, '$2y$12$zf3WvM5tPAhYLM.P/Xy.WOa..mjP.UPG.j35mg/THSr7wZ8ecyrde', NULL, '2026-04-25 12:58:59', '2026-04-25 12:58:59'),
(32, NULL, 'Prenom-34 NOM-34', 'eleve34@sunuecole.sn', NULL, NULL, 1, NULL, NULL, '$2y$12$/HZPJAltHKz41shZnQkvf.CyqXogewie9LuM/ycCNgQXKspn/w64m', NULL, '2026-04-25 12:58:59', '2026-04-25 12:58:59'),
(33, NULL, 'Parent Eleve 35', 'parent35@gmail.com', NULL, NULL, 1, NULL, NULL, '$2y$12$S1Mo9evflGtJy/Y7Ohwa6.oaLkgsmp8RX0DZLCqMfaX2UnV318bmK', NULL, '2026-04-25 12:58:59', '2026-04-25 12:58:59'),
(34, NULL, 'Prenom-35 NOM-35', 'eleve35@sunuecole.sn', NULL, NULL, 1, NULL, NULL, '$2y$12$ZSsf2nZyak2Y3hbJWd7q7eKoFw6tty7Ew9WkjOHH6ufqF8UBwZ/tK', NULL, '2026-04-25 12:59:00', '2026-04-25 12:59:00'),
(35, NULL, 'Parent Eleve 41', 'parent41@gmail.com', NULL, NULL, 1, NULL, NULL, '$2y$12$6PBR1K5iYXBvb83m8nDfD.FzvNaLKK76AwpiQKX4yV1OiIkdV2sYy', NULL, '2026-04-25 12:59:00', '2026-04-25 12:59:00'),
(36, NULL, 'Prenom-41 NOM-41', 'eleve41@sunuecole.sn', NULL, NULL, 1, NULL, NULL, '$2y$12$pgTvy.MSpmMCkwg7cjnPrOAvMFaFvNctzJ64pZ9cZ012KcgTYlgXu', NULL, '2026-04-25 12:59:00', '2026-04-25 12:59:00'),
(37, NULL, 'Parent Eleve 42', 'parent42@gmail.com', NULL, NULL, 1, NULL, NULL, '$2y$12$Gm6TRBPBXNdoVl1F.iCxsebXPqem7lrezgIWOzCWEiDlNtyDLot72', NULL, '2026-04-25 12:59:00', '2026-04-25 12:59:00'),
(38, NULL, 'Prenom-42 NOM-42', 'eleve42@sunuecole.sn', NULL, NULL, 1, NULL, NULL, '$2y$12$ByqaU05gkt3HL11prN36XuqDIqo.Vnr7Hl.s6iN9xv5BxdCQMKKVS', NULL, '2026-04-25 12:59:01', '2026-04-25 12:59:01'),
(39, NULL, 'Parent Eleve 43', 'parent43@gmail.com', NULL, NULL, 1, NULL, NULL, '$2y$12$fuB56aXssIJ4D2vYELAx5.3v34qivLb71QaGHzGnHDZOe6l9Z8Jke', NULL, '2026-04-25 12:59:01', '2026-04-25 12:59:01'),
(40, NULL, 'Prenom-43 NOM-43', 'eleve43@sunuecole.sn', NULL, NULL, 1, NULL, NULL, '$2y$12$MfNvlvDlE22/G6b2wINWh.3yqRxFbzEhnjZzfFWWt3bdvhWKf7YzK', NULL, '2026-04-25 12:59:01', '2026-04-25 12:59:01'),
(41, NULL, 'Parent Eleve 44', 'parent44@gmail.com', NULL, NULL, 1, NULL, NULL, '$2y$12$eewgCgyhXsh0/sYb8ovpJ.Mlpuq71M98JU/MD..GcWySN2qfelHlO', NULL, '2026-04-25 12:59:01', '2026-04-25 12:59:01'),
(42, NULL, 'Prenom-44 NOM-44', 'eleve44@sunuecole.sn', NULL, NULL, 1, NULL, NULL, '$2y$12$LfjEN6ROupqUVElArkY/A.KF48246yBtr9PTv/JOorfyeUpvPyXoe', NULL, '2026-04-25 12:59:02', '2026-04-25 12:59:02'),
(43, NULL, 'Parent Eleve 45', 'parent45@gmail.com', NULL, NULL, 1, NULL, NULL, '$2y$12$tXCvF7iB9ew7l2iVV/OL9urMRlZ5dXahKoHwgqU4SNzrJWH6ZhVBS', NULL, '2026-04-25 12:59:02', '2026-04-25 12:59:02'),
(44, NULL, 'Prenom-45 NOM-45', 'eleve45@sunuecole.sn', NULL, NULL, 1, NULL, NULL, '$2y$12$ekQxzED.THRqS7YLOj.GVu2UZvQIP45gwP5qY58A0zi4VhPcV7Fh.', NULL, '2026-04-25 12:59:02', '2026-04-25 12:59:02');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `absences`
--
ALTER TABLE `absences`
  ADD PRIMARY KEY (`id`),
  ADD KEY `absences_eleve_id_foreign` (`eleve_id`),
  ADD KEY `absences_classe_id_foreign` (`classe_id`),
  ADD KEY `absences_annee_scolaire_id_foreign` (`annee_scolaire_id`),
  ADD KEY `absences_enseignant_id_foreign` (`enseignant_id`),
  ADD KEY `absences_matiere_id_foreign` (`matiere_id`),
  ADD KEY `absences_cahier_texte_id_foreign` (`cahier_texte_id`);

--
-- Index pour la table `annee_scolaires`
--
ALTER TABLE `annee_scolaires`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `audit_logs_user_id_action_created_at_index` (`user_id`,`action`,`created_at`);

--
-- Index pour la table `bulletins`
--
ALTER TABLE `bulletins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bulletins_eleve_id_trimestre_annee_scolaire_id_unique` (`eleve_id`,`trimestre`,`annee_scolaire_id`),
  ADD UNIQUE KEY `bulletins_token_verification_unique` (`token_verification`),
  ADD KEY `bulletins_classe_id_foreign` (`classe_id`),
  ADD KEY `bulletins_annee_scolaire_id_foreign` (`annee_scolaire_id`);

--
-- Index pour la table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Index pour la table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Index pour la table `cahier_textes`
--
ALTER TABLE `cahier_textes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cahier_textes_classe_id_foreign` (`classe_id`),
  ADD KEY `cahier_textes_matiere_id_foreign` (`matiere_id`),
  ADD KEY `cahier_textes_enseignant_id_foreign` (`enseignant_id`),
  ADD KEY `cahier_textes_annee_scolaire_id_foreign` (`annee_scolaire_id`);

--
-- Index pour la table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `classes_niveau_id_foreign` (`niveau_id`),
  ADD KEY `classes_serie_id_foreign` (`serie_id`),
  ADD KEY `classes_annee_scolaire_id_foreign` (`annee_scolaire_id`),
  ADD KEY `classes_salle_id_foreign` (`salle_id`),
  ADD KEY `classes_professeur_principal_id_foreign` (`professeur_principal_id`),
  ADD KEY `classes_cycle_id_foreign` (`cycle_id`);

--
-- Index pour la table `classe_matiere`
--
ALTER TABLE `classe_matiere`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `classe_matiere_classe_id_matiere_id_unique` (`classe_id`,`matiere_id`),
  ADD KEY `classe_matiere_matiere_id_foreign` (`matiere_id`),
  ADD KEY `classe_matiere_enseignant_id_foreign` (`enseignant_id`);

--
-- Index pour la table `convocations`
--
ALTER TABLE `convocations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `convocations_eleve_id_foreign` (`eleve_id`);

--
-- Index pour la table `cycles`
--
ALTER TABLE `cycles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cycles_nom_unique` (`nom`),
  ADD UNIQUE KEY `cycles_code_unique` (`code`);

--
-- Index pour la table `depenses`
--
ALTER TABLE `depenses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `depenses_reference_unique` (`reference`),
  ADD KEY `depenses_annee_scolaire_id_foreign` (`annee_scolaire_id`),
  ADD KEY `depenses_enregistre_par_foreign` (`enregistre_par`);

--
-- Index pour la table `eleves`
--
ALTER TABLE `eleves`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `eleves_matricule_unique` (`matricule`),
  ADD KEY `eleves_user_id_foreign` (`user_id`),
  ADD KEY `eleves_parent_id_foreign` (`parent_id`),
  ADD KEY `eleves_classe_id_foreign` (`classe_id`),
  ADD KEY `eleves_annee_scolaire_id_foreign` (`annee_scolaire_id`);

--
-- Index pour la table `emplois_du_temps`
--
ALTER TABLE `emplois_du_temps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `emplois_du_temps_classe_id_foreign` (`classe_id`),
  ADD KEY `emplois_du_temps_matiere_id_foreign` (`matiere_id`),
  ADD KEY `emplois_du_temps_enseignant_id_foreign` (`enseignant_id`),
  ADD KEY `emplois_du_temps_salle_id_foreign` (`salle_id`),
  ADD KEY `emplois_du_temps_annee_scolaire_id_foreign` (`annee_scolaire_id`),
  ADD KEY `emplois_du_temps_jour_heure_debut_heure_fin_index` (`jour`,`heure_debut`,`heure_fin`);

--
-- Index pour la table `enseignants`
--
ALTER TABLE `enseignants`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `enseignants_matricule_unique` (`matricule`),
  ADD KEY `enseignants_user_id_foreign` (`user_id`);

--
-- Index pour la table `enseignant_matiere`
--
ALTER TABLE `enseignant_matiere`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `enseignant_matiere_enseignant_id_matiere_id_unique` (`enseignant_id`,`matiere_id`),
  ADD KEY `enseignant_matiere_matiere_id_foreign` (`matiere_id`);

--
-- Index pour la table `etablissements`
--
ALTER TABLE `etablissements`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `etablissements_code_unique` (`code`);

--
-- Index pour la table `evaluations`
--
ALTER TABLE `evaluations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `evaluations_classe_id_foreign` (`classe_id`),
  ADD KEY `evaluations_matiere_id_foreign` (`matiere_id`),
  ADD KEY `evaluations_enseignant_id_foreign` (`enseignant_id`),
  ADD KEY `evaluations_annee_scolaire_id_foreign` (`annee_scolaire_id`);

--
-- Index pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Index pour la table `historiques_scolaires`
--
ALTER TABLE `historiques_scolaires`
  ADD PRIMARY KEY (`id`),
  ADD KEY `historiques_scolaires_eleve_id_foreign` (`eleve_id`),
  ADD KEY `historiques_scolaires_classe_id_foreign` (`classe_id`),
  ADD KEY `historiques_scolaires_annee_scolaire_id_foreign` (`annee_scolaire_id`);

--
-- Index pour la table `inscriptions`
--
ALTER TABLE `inscriptions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `inscriptions_eleve_id_annee_scolaire_id_unique` (`eleve_id`,`annee_scolaire_id`),
  ADD KEY `inscriptions_classe_id_foreign` (`classe_id`),
  ADD KEY `inscriptions_annee_scolaire_id_foreign` (`annee_scolaire_id`);

--
-- Index pour la table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Index pour la table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `justifications`
--
ALTER TABLE `justifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `justifications_absence_id_foreign` (`absence_id`),
  ADD KEY `justifications_parent_id_foreign` (`parent_id`),
  ADD KEY `justifications_valide_par_foreign` (`valide_par`);

--
-- Index pour la table `matieres`
--
ALTER TABLE `matieres`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `matieres_code_unique` (`code`),
  ADD KEY `matieres_niveau_id_foreign` (`niveau_id`),
  ADD KEY `matieres_serie_id_foreign` (`serie_id`),
  ADD KEY `matieres_cycle_id_foreign` (`cycle_id`);

--
-- Index pour la table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Index pour la table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Index pour la table `niveaux`
--
ALTER TABLE `niveaux`
  ADD PRIMARY KEY (`id`),
  ADD KEY `niveaux_cycle_id_foreign` (`cycle_id`);

--
-- Index pour la table `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notes_eleve_id_foreign` (`eleve_id`),
  ADD KEY `notes_matiere_id_foreign` (`matiere_id`),
  ADD KEY `notes_classe_id_foreign` (`classe_id`),
  ADD KEY `notes_annee_scolaire_id_foreign` (`annee_scolaire_id`),
  ADD KEY `notes_enseignant_id_foreign` (`enseignant_id`),
  ADD KEY `notes_evaluation_id_foreign` (`evaluation_id`);

--
-- Index pour la table `notifications_push`
--
ALTER TABLE `notifications_push`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_push_user_id_lu_created_at_index` (`user_id`,`lu`,`created_at`);

--
-- Index pour la table `paiements`
--
ALTER TABLE `paiements`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `paiements_reference_unique` (`reference`),
  ADD KEY `paiements_type_paiement_id_foreign` (`type_paiement_id`),
  ADD KEY `paiements_encaisse_par_foreign` (`encaisse_par`),
  ADD KEY `paiements_annee_scolaire_id_foreign` (`annee_scolaire_id`),
  ADD KEY `paiements_eleve_id_type_paiement_id_statut_index` (`eleve_id`,`type_paiement_id`,`statut`);

--
-- Index pour la table `parents`
--
ALTER TABLE `parents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parents_user_id_foreign` (`user_id`);

--
-- Index pour la table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Index pour la table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Index pour la table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Index pour la table `recus`
--
ALTER TABLE `recus`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `recus_numero_unique` (`numero`),
  ADD KEY `recus_paiement_id_foreign` (`paiement_id`),
  ADD KEY `recus_emis_par_foreign` (`emis_par`);

--
-- Index pour la table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Index pour la table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Index pour la table `salles`
--
ALTER TABLE `salles`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `series`
--
ALTER TABLE `series`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Index pour la table `tarifs`
--
ALTER TABLE `tarifs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_tarif_annee_niveau_type` (`annee_scolaire_id`,`niveau_id`,`type_paiement_id`),
  ADD KEY `tarifs_niveau_id_foreign` (`niveau_id`),
  ADD KEY `tarifs_type_paiement_id_foreign` (`type_paiement_id`);

--
-- Index pour la table `types_paiements`
--
ALTER TABLE `types_paiements`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `types_paiements_code_unique` (`code`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_telephone_unique` (`telephone`),
  ADD KEY `users_cycle_id_foreign` (`cycle_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `absences`
--
ALTER TABLE `absences`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `annee_scolaires`
--
ALTER TABLE `annee_scolaires`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `bulletins`
--
ALTER TABLE `bulletins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `cahier_textes`
--
ALTER TABLE `cahier_textes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `classes`
--
ALTER TABLE `classes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `classe_matiere`
--
ALTER TABLE `classe_matiere`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT pour la table `convocations`
--
ALTER TABLE `convocations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `cycles`
--
ALTER TABLE `cycles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `depenses`
--
ALTER TABLE `depenses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `eleves`
--
ALTER TABLE `eleves`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT pour la table `emplois_du_temps`
--
ALTER TABLE `emplois_du_temps`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `enseignants`
--
ALTER TABLE `enseignants`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `enseignant_matiere`
--
ALTER TABLE `enseignant_matiere`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `etablissements`
--
ALTER TABLE `etablissements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `evaluations`
--
ALTER TABLE `evaluations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `historiques_scolaires`
--
ALTER TABLE `historiques_scolaires`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `inscriptions`
--
ALTER TABLE `inscriptions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT pour la table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `justifications`
--
ALTER TABLE `justifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `matieres`
--
ALTER TABLE `matieres`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT pour la table `niveaux`
--
ALTER TABLE `niveaux`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `notes`
--
ALTER TABLE `notes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4266;

--
-- AUTO_INCREMENT pour la table `notifications_push`
--
ALTER TABLE `notifications_push`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `paiements`
--
ALTER TABLE `paiements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT pour la table `parents`
--
ALTER TABLE `parents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT pour la table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT pour la table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `recus`
--
ALTER TABLE `recus`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `salles`
--
ALTER TABLE `salles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `series`
--
ALTER TABLE `series`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `tarifs`
--
ALTER TABLE `tarifs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `types_paiements`
--
ALTER TABLE `types_paiements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `absences`
--
ALTER TABLE `absences`
  ADD CONSTRAINT `absences_annee_scolaire_id_foreign` FOREIGN KEY (`annee_scolaire_id`) REFERENCES `annee_scolaires` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `absences_cahier_texte_id_foreign` FOREIGN KEY (`cahier_texte_id`) REFERENCES `cahier_textes` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `absences_classe_id_foreign` FOREIGN KEY (`classe_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `absences_eleve_id_foreign` FOREIGN KEY (`eleve_id`) REFERENCES `eleves` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `absences_enseignant_id_foreign` FOREIGN KEY (`enseignant_id`) REFERENCES `enseignants` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `absences_matiere_id_foreign` FOREIGN KEY (`matiere_id`) REFERENCES `matieres` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `bulletins`
--
ALTER TABLE `bulletins`
  ADD CONSTRAINT `bulletins_annee_scolaire_id_foreign` FOREIGN KEY (`annee_scolaire_id`) REFERENCES `annee_scolaires` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bulletins_classe_id_foreign` FOREIGN KEY (`classe_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bulletins_eleve_id_foreign` FOREIGN KEY (`eleve_id`) REFERENCES `eleves` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `cahier_textes`
--
ALTER TABLE `cahier_textes`
  ADD CONSTRAINT `cahier_textes_annee_scolaire_id_foreign` FOREIGN KEY (`annee_scolaire_id`) REFERENCES `annee_scolaires` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cahier_textes_classe_id_foreign` FOREIGN KEY (`classe_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cahier_textes_enseignant_id_foreign` FOREIGN KEY (`enseignant_id`) REFERENCES `enseignants` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `cahier_textes_matiere_id_foreign` FOREIGN KEY (`matiere_id`) REFERENCES `matieres` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `classes`
--
ALTER TABLE `classes`
  ADD CONSTRAINT `classes_annee_scolaire_id_foreign` FOREIGN KEY (`annee_scolaire_id`) REFERENCES `annee_scolaires` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `classes_cycle_id_foreign` FOREIGN KEY (`cycle_id`) REFERENCES `cycles` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `classes_niveau_id_foreign` FOREIGN KEY (`niveau_id`) REFERENCES `niveaux` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `classes_professeur_principal_id_foreign` FOREIGN KEY (`professeur_principal_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `classes_salle_id_foreign` FOREIGN KEY (`salle_id`) REFERENCES `salles` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `classes_serie_id_foreign` FOREIGN KEY (`serie_id`) REFERENCES `series` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `classe_matiere`
--
ALTER TABLE `classe_matiere`
  ADD CONSTRAINT `classe_matiere_classe_id_foreign` FOREIGN KEY (`classe_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `classe_matiere_enseignant_id_foreign` FOREIGN KEY (`enseignant_id`) REFERENCES `enseignants` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `classe_matiere_matiere_id_foreign` FOREIGN KEY (`matiere_id`) REFERENCES `matieres` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `convocations`
--
ALTER TABLE `convocations`
  ADD CONSTRAINT `convocations_eleve_id_foreign` FOREIGN KEY (`eleve_id`) REFERENCES `eleves` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `depenses`
--
ALTER TABLE `depenses`
  ADD CONSTRAINT `depenses_annee_scolaire_id_foreign` FOREIGN KEY (`annee_scolaire_id`) REFERENCES `annee_scolaires` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `depenses_enregistre_par_foreign` FOREIGN KEY (`enregistre_par`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `eleves`
--
ALTER TABLE `eleves`
  ADD CONSTRAINT `eleves_annee_scolaire_id_foreign` FOREIGN KEY (`annee_scolaire_id`) REFERENCES `annee_scolaires` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `eleves_classe_id_foreign` FOREIGN KEY (`classe_id`) REFERENCES `classes` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `eleves_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `parents` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `eleves_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `emplois_du_temps`
--
ALTER TABLE `emplois_du_temps`
  ADD CONSTRAINT `emplois_du_temps_annee_scolaire_id_foreign` FOREIGN KEY (`annee_scolaire_id`) REFERENCES `annee_scolaires` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `emplois_du_temps_classe_id_foreign` FOREIGN KEY (`classe_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `emplois_du_temps_enseignant_id_foreign` FOREIGN KEY (`enseignant_id`) REFERENCES `enseignants` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `emplois_du_temps_matiere_id_foreign` FOREIGN KEY (`matiere_id`) REFERENCES `matieres` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `emplois_du_temps_salle_id_foreign` FOREIGN KEY (`salle_id`) REFERENCES `salles` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `enseignants`
--
ALTER TABLE `enseignants`
  ADD CONSTRAINT `enseignants_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `enseignant_matiere`
--
ALTER TABLE `enseignant_matiere`
  ADD CONSTRAINT `enseignant_matiere_enseignant_id_foreign` FOREIGN KEY (`enseignant_id`) REFERENCES `enseignants` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `enseignant_matiere_matiere_id_foreign` FOREIGN KEY (`matiere_id`) REFERENCES `matieres` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `evaluations`
--
ALTER TABLE `evaluations`
  ADD CONSTRAINT `evaluations_annee_scolaire_id_foreign` FOREIGN KEY (`annee_scolaire_id`) REFERENCES `annee_scolaires` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `evaluations_classe_id_foreign` FOREIGN KEY (`classe_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `evaluations_enseignant_id_foreign` FOREIGN KEY (`enseignant_id`) REFERENCES `enseignants` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `evaluations_matiere_id_foreign` FOREIGN KEY (`matiere_id`) REFERENCES `matieres` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `historiques_scolaires`
--
ALTER TABLE `historiques_scolaires`
  ADD CONSTRAINT `historiques_scolaires_annee_scolaire_id_foreign` FOREIGN KEY (`annee_scolaire_id`) REFERENCES `annee_scolaires` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `historiques_scolaires_classe_id_foreign` FOREIGN KEY (`classe_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `historiques_scolaires_eleve_id_foreign` FOREIGN KEY (`eleve_id`) REFERENCES `eleves` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `inscriptions`
--
ALTER TABLE `inscriptions`
  ADD CONSTRAINT `inscriptions_annee_scolaire_id_foreign` FOREIGN KEY (`annee_scolaire_id`) REFERENCES `annee_scolaires` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inscriptions_classe_id_foreign` FOREIGN KEY (`classe_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inscriptions_eleve_id_foreign` FOREIGN KEY (`eleve_id`) REFERENCES `eleves` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `justifications`
--
ALTER TABLE `justifications`
  ADD CONSTRAINT `justifications_absence_id_foreign` FOREIGN KEY (`absence_id`) REFERENCES `absences` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `justifications_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `parents` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `justifications_valide_par_foreign` FOREIGN KEY (`valide_par`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `matieres`
--
ALTER TABLE `matieres`
  ADD CONSTRAINT `matieres_cycle_id_foreign` FOREIGN KEY (`cycle_id`) REFERENCES `cycles` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `matieres_niveau_id_foreign` FOREIGN KEY (`niveau_id`) REFERENCES `niveaux` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `matieres_serie_id_foreign` FOREIGN KEY (`serie_id`) REFERENCES `series` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `niveaux`
--
ALTER TABLE `niveaux`
  ADD CONSTRAINT `niveaux_cycle_id_foreign` FOREIGN KEY (`cycle_id`) REFERENCES `cycles` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `notes`
--
ALTER TABLE `notes`
  ADD CONSTRAINT `notes_annee_scolaire_id_foreign` FOREIGN KEY (`annee_scolaire_id`) REFERENCES `annee_scolaires` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notes_classe_id_foreign` FOREIGN KEY (`classe_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notes_eleve_id_foreign` FOREIGN KEY (`eleve_id`) REFERENCES `eleves` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notes_enseignant_id_foreign` FOREIGN KEY (`enseignant_id`) REFERENCES `enseignants` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `notes_evaluation_id_foreign` FOREIGN KEY (`evaluation_id`) REFERENCES `evaluations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notes_matiere_id_foreign` FOREIGN KEY (`matiere_id`) REFERENCES `matieres` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `notifications_push`
--
ALTER TABLE `notifications_push`
  ADD CONSTRAINT `notifications_push_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `paiements`
--
ALTER TABLE `paiements`
  ADD CONSTRAINT `paiements_annee_scolaire_id_foreign` FOREIGN KEY (`annee_scolaire_id`) REFERENCES `annee_scolaires` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `paiements_eleve_id_foreign` FOREIGN KEY (`eleve_id`) REFERENCES `eleves` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `paiements_encaisse_par_foreign` FOREIGN KEY (`encaisse_par`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `paiements_type_paiement_id_foreign` FOREIGN KEY (`type_paiement_id`) REFERENCES `types_paiements` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `parents`
--
ALTER TABLE `parents`
  ADD CONSTRAINT `parents_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `recus`
--
ALTER TABLE `recus`
  ADD CONSTRAINT `recus_emis_par_foreign` FOREIGN KEY (`emis_par`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `recus_paiement_id_foreign` FOREIGN KEY (`paiement_id`) REFERENCES `paiements` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `tarifs`
--
ALTER TABLE `tarifs`
  ADD CONSTRAINT `tarifs_annee_scolaire_id_foreign` FOREIGN KEY (`annee_scolaire_id`) REFERENCES `annee_scolaires` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tarifs_niveau_id_foreign` FOREIGN KEY (`niveau_id`) REFERENCES `niveaux` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tarifs_type_paiement_id_foreign` FOREIGN KEY (`type_paiement_id`) REFERENCES `types_paiements` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_cycle_id_foreign` FOREIGN KEY (`cycle_id`) REFERENCES `cycles` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
