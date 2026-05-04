-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 15 jan. 2025 à 11:07
-- Version du serveur : 9.1.0
-- Version de PHP : 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `mova`
--

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client` (
  `id` int NOT NULL,
  `nomClient` varchar(255) NOT NULL,
  `prenomClient` varchar(255) NOT NULL,
  `mailClient` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`id`, `nomClient`, `prenomClient`, `mailClient`) VALUES
(1, 'Dupont', 'Jean', 'jean.dupont@example.com'),
(2, 'Martin', 'Sophie', 'sophie.martin@example.com'),
(3, 'Lemoine', 'Claire', 'claire.lemoine@example.com');

-- --------------------------------------------------------

--
-- Structure de la table `location`
--

DROP TABLE IF EXISTS `location`;
CREATE TABLE IF NOT EXISTS `location` (
  `id` int NOT NULL,
  `idVehicule` int NOT NULL,
  `idClient` int NOT NULL,
  `dateDebut` date NOT NULL,
  `dateFin` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idVehicule` (`idVehicule`),
  KEY `idClient` (`idClient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `location`
--

INSERT INTO `location` (`id`, `idVehicule`, `idClient`, `dateDebut`, `dateFin`) VALUES
(1, 1, 1, '2025-01-10', '2025-01-15'),
(2, 3, 2, '2025-01-12', '2025-01-20'),
(3, 5, 3, '2025-01-08', '2025-01-14');

-- --------------------------------------------------------

--
-- Structure de la table `marque`
--

DROP TABLE IF EXISTS `marque`;
CREATE TABLE IF NOT EXISTS `marque` (
  `id` int NOT NULL,
  `libelleMarque` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `marque`
--

INSERT INTO `marque` (`id`, `libelleMarque`) VALUES
(1, 'Tesla'),
(2, 'Toyota'),
(3, 'Hyundai'),
(4, 'Renault');

-- --------------------------------------------------------

--
-- Structure de la table `modele`
--

DROP TABLE IF EXISTS `modele`;
CREATE TABLE IF NOT EXISTS `modele` (
  `id` int NOT NULL,
  `libelleModele` varchar(255) NOT NULL,
  `idMarque` int NOT NULL,
  `idType` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idMarque` (`idMarque`),
  KEY `idType` (`idType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `modele`
--

INSERT INTO `modele` (`id`, `libelleModele`, `idMarque`, `idType`) VALUES
(1, 'Model 3', 1, 2),
(2, 'Model Y', 1, 1),
(3, 'Prius', 2, 2),
(4, 'Ioniq 5', 3, 1),
(5, 'Zoé', 4, 4),
(6, 'Kangoo ZE', 4, 3);

-- --------------------------------------------------------

--
-- Structure de la table `type`
--

DROP TABLE IF EXISTS `type`;
CREATE TABLE IF NOT EXISTS `type` (
  `id` int NOT NULL,
  `libelleType` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `type`
--

INSERT INTO `type` (`id`, `libelleType`) VALUES
(1, 'SUV'),
(2, 'Berline'),
(3, 'Utilitaire'),
(4, 'Compacte');

-- --------------------------------------------------------

--
-- Structure de la table `vehicule`
--

DROP TABLE IF EXISTS `vehicule`;
CREATE TABLE IF NOT EXISTS `vehicule` (
  `id` int NOT NULL,
  `idModele` int NOT NULL,
  `tarifJour` decimal(10,2) NOT NULL,
  `disponibilite` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idModele` (`idModele`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `vehicule`
--

INSERT INTO `vehicule` (`id`, `idModele`, `tarifJour`, `disponibilite`) VALUES
(1, 1, 120.00, 1),
(2, 2, 140.00, 1),
(3, 3, 80.00, 1),
(4, 4, 130.00, 0),
(5, 5, 70.00, 1),
(6, 6, 75.00, 1);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `location`
--
ALTER TABLE `location`
  ADD CONSTRAINT `location_ibfk_1` FOREIGN KEY (`idVehicule`) REFERENCES `vehicule` (`id`),
  ADD CONSTRAINT `location_ibfk_2` FOREIGN KEY (`idClient`) REFERENCES `client` (`id`);

--
-- Contraintes pour la table `modele`
--
ALTER TABLE `modele`
  ADD CONSTRAINT `modele_ibfk_1` FOREIGN KEY (`idMarque`) REFERENCES `marque` (`id`),
  ADD CONSTRAINT `modele_ibfk_2` FOREIGN KEY (`idType`) REFERENCES `type` (`id`);

--
-- Contraintes pour la table `vehicule`
--
ALTER TABLE `vehicule`
  ADD CONSTRAINT `vehicule_ibfk_1` FOREIGN KEY (`idModele`) REFERENCES `modele` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;