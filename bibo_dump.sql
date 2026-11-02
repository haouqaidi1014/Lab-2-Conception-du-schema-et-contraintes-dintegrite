-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: bibliotheque
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `abonne`
--

DROP TABLE IF EXISTS `abonne`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abonne` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_inscription` date NOT NULL DEFAULT (curdate()),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `abonne_chk_1` CHECK ((`email` like _utf8mb4'%@%._%'))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abonne`
--

LOCK TABLES `abonne` WRITE;
/*!40000 ALTER TABLE `abonne` DISABLE KEYS */;
INSERT INTO `abonne` VALUES (1,'Martin','Luc','luc.martin@example.com','2026-11-02');
/*!40000 ALTER TABLE `abonne` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auteur`
--

DROP TABLE IF EXISTS `auteur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auteur` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_naissance` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `chk_auteur_nom` CHECK ((length(`nom`) > 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auteur`
--

LOCK TABLES `auteur` WRITE;
/*!40000 ALTER TABLE `auteur` DISABLE KEYS */;
INSERT INTO `auteur` VALUES (1,'Dupont','Marie','1975-04-12'),(2,'Dupont','Marie','1975-04-12'),(3,'Dupont','Marie','1975-04-12'),(4,'Dupont','Marie','1975-04-12'),(5,'Dupont','Marie','1975-04-12');
/*!40000 ALTER TABLE `auteur` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emprunt`
--

DROP TABLE IF EXISTS `emprunt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emprunt` (
  `ouvrage_id` int NOT NULL,
  `abonne_id` int NOT NULL,
  `date_debut` date NOT NULL DEFAULT (curdate()),
  `date_fin` date DEFAULT NULL,
  PRIMARY KEY (`ouvrage_id`,`abonne_id`,`date_debut`),
  KEY `fk_emprunt_abonne` (`abonne_id`),
  KEY `idx_emprunt_date_fin` (`date_fin`),
  CONSTRAINT `fk_emprunt_abonne` FOREIGN KEY (`abonne_id`) REFERENCES `abonne` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_emprunt_ouvrage` FOREIGN KEY (`ouvrage_id`) REFERENCES `ouvrage` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_dates` CHECK (((`date_fin` is null) or (`date_fin` >= `date_debut`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emprunt`
--

LOCK TABLES `emprunt` WRITE;
/*!40000 ALTER TABLE `emprunt` DISABLE KEYS */;
INSERT INTO `emprunt` VALUES (1,1,'2026-11-02',NULL);
/*!40000 ALTER TABLE `emprunt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ouvrage`
--

DROP TABLE IF EXISTS `ouvrage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ouvrage` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titre` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isbn` char(13) COLLATE utf8mb4_unicode_ci NOT NULL,
  `disponible` tinyint(1) NOT NULL DEFAULT '1',
  `auteur_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `isbn` (`isbn`),
  KEY `fk_ouvrage_auteur` (`auteur_id`),
  KEY `idx_ouvrage_disponible` (`disponible`),
  CONSTRAINT `fk_ouvrage_auteur` FOREIGN KEY (`auteur_id`) REFERENCES `auteur` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_isbn` CHECK (regexp_like(`isbn`,_utf8mb4'^[0-9]{13}$'))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ouvrage`
--

LOCK TABLES `ouvrage` WRITE;
/*!40000 ALTER TABLE `ouvrage` DISABLE KEYS */;
INSERT INTO `ouvrage` VALUES (1,'Les Misérables','1234567890123',1,1);
/*!40000 ALTER TABLE `ouvrage` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-02 23:38:19
