/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.5.29-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: astronomy_db
-- ------------------------------------------------------
-- Server version	10.5.29-MariaDB-0+deb11u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cameras`
--

DROP TABLE IF EXISTS `cameras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cameras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brand` varchar(120) NOT NULL,
  `model` varchar(120) NOT NULL,
  `release_date` date NOT NULL,
  `score` int(11) NOT NULL,
  `category` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cameras`
--

LOCK TABLES `cameras` WRITE;
/*!40000 ALTER TABLE `cameras` DISABLE KEYS */;
INSERT INTO `cameras` VALUES (1,'Canon','EOS Rebel T100','2020-01-01',4,'Amateur','Appareil photo reflex bien abordable','2026-04-17 13:04:15'),(2,'Nikon','D3400','2021-06-15',4,'Amateur','Excellent pour débuter','2026-04-17 13:04:15'),(3,'Sony','A6000','2019-03-20',5,'Amateur sérieux','Hybride très polyvalent','2026-04-17 13:04:15'),(4,'Canon','EOS R5','2020-07-30',5,'Professionnel','Appareil phare pour les professionnels','2026-04-17 13:04:15');
/*!40000 ALTER TABLE `cameras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_posts`
--

DROP TABLE IF EXISTS `forum_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `forum_posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `author_id` int(11) NOT NULL,
  `thread_id` int(11) NOT NULL,
  `likes_count` int(11) DEFAULT NULL,
  `is_solution` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  KEY `thread_id` (`thread_id`),
  CONSTRAINT `forum_posts_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  CONSTRAINT `forum_posts_ibfk_2` FOREIGN KEY (`thread_id`) REFERENCES `forum_threads` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_posts`
--

LOCK TABLES `forum_posts` WRITE;
/*!40000 ALTER TABLE `forum_posts` DISABLE KEYS */;
INSERT INTO `forum_posts` VALUES (1,'Excellente question ! Pour débuter, je recommande d\'investir dans une bonne caméra et un bon télescope. Commencez par observer avec vos yeux puis progressez avec des équipements.',1,1,0,0,'2026-04-17 13:34:49','2026-04-17 13:34:49'),(2,'Je pense que le téléscope Celestron StarPointer est idéal pour débuter.',2,3,0,0,'2026-04-17 14:37:11','2026-04-17 14:37:11'),(3,'Le Canon EOS Rebel T100 est bien abordable',2,2,0,0,'2026-04-17 14:38:24','2026-04-17 14:38:24');
/*!40000 ALTER TABLE `forum_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_threads`
--

DROP TABLE IF EXISTS `forum_threads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `forum_threads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `category` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `author_id` int(11) NOT NULL,
  `is_locked` tinyint(1) DEFAULT NULL,
  `is_pinned` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `forum_threads_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_threads`
--

LOCK TABLES `forum_threads` WRITE;
/*!40000 ALTER TABLE `forum_threads` DISABLE KEYS */;
INSERT INTO `forum_threads` VALUES (1,'Comment débuter l\'astrophotographie ?','Astrophotographie','Je souhaite débuter l\'astrophotographie. Quels sont vos conseils pour un débutant ? Quel équipement recommandez-vous ?',1,0,0,'2026-04-17 13:34:49','2026-04-17 13:34:49'),(2,'Quelle caméra reflex pour débuter ?','Appareil photo','Je cherche une bonne caméra reflex pour débuter la photo en général. Quel est votre avis sur les modèles d\'entrée de gamme Canon et Nikon ?',1,0,0,'2026-04-17 13:34:49','2026-04-17 14:38:24'),(3,'Télescope pour enfants - recommandations','Télescope','Je cherche un télescope pour mon enfant de 10 ans. Quels modèles me recommandez-vous ? Quel est le meilleur rapport qualité-prix ?',1,0,0,'2026-04-17 13:34:49','2026-04-17 14:37:11');
/*!40000 ALTER TABLE `forum_threads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `author_id` int(11) NOT NULL,
  `is_published` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `news_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES (1,'Découverte d\'une nouvelle exoplanète habitable','Les astronomes ont découvert une nouvelle exoplanète dans la zone habitable de son étoile mère. Cette découverte ouvre de nouvelles perspectives sur la recherche de vie extraterrestre.',NULL,1,1,'2026-04-17 13:34:49','2026-04-17 13:34:49'),(2,'La mission Artemis se prépare pour le retour sur la Lune','La NASA annonce les détails de la mission Artemis qui ramènera les astronautes sur la Lune en 2025. Cette mission sera un tremplin vers l\'exploration de Mars.',NULL,1,1,'2026-04-17 13:34:49','2026-04-17 13:34:49'),(3,'Observation spectaculaire de l\'aurore boréale en France','Grâce à une tempête géomagnétique exceptionnelle, l\'aurore boréale a pu être observée depuis le sud de la France. Un phénomène rare et magnifique!',NULL,1,1,'2026-04-17 13:34:49','2026-04-17 13:34:49');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photographs`
--

DROP TABLE IF EXISTS `photographs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `photographs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `image_path` varchar(255) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `photographs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photographs`
--

LOCK TABLES `photographs` WRITE;
/*!40000 ALTER TABLE `photographs` DISABLE KEYS */;
INSERT INTO `photographs` VALUES (1,'La Lune','Photo de la Lune en haute résolution','/static/images/moon.jpg',NULL,'2026-04-17 13:04:15'),(2,'Voie Lactée','Voie Lactée photographiée depuis les Alpes','/static/images/milkyway.jpg',NULL,'2026-04-17 13:04:15');
/*!40000 ALTER TABLE `photographs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telescopes`
--

DROP TABLE IF EXISTS `telescopes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `telescopes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brand` varchar(120) NOT NULL,
  `model` varchar(120) NOT NULL,
  `release_date` date NOT NULL,
  `score` int(11) NOT NULL,
  `category` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telescopes`
--

LOCK TABLES `telescopes` WRITE;
/*!40000 ALTER TABLE `telescopes` DISABLE KEYS */;
INSERT INTO `telescopes` VALUES (1,'Celestron','StarPointer','2019-01-01',4,'Pour enfants','Télescope idéal pour débuter','2026-04-17 13:04:15'),(2,'Meade','EclipseView','2020-05-10',3,'Pour enfants','Parfait pour les enfants','2026-04-17 13:04:15'),(3,'Celestron','Nexstar 8SE','2021-02-20',5,'Automatisés','Télescope automatisé très précis','2026-04-17 13:04:15'),(4,'Meade','LX90','2018-08-15',5,'Complets','Solution complète pour l\'astronomie','2026-04-17 13:04:15');
/*!40000 ALTER TABLE `telescopes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(80) NOT NULL,
  `email` varchar(120) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_users_email` (`email`),
  UNIQUE KEY `ix_users_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'aaaa','abdallah.mennafi7@gmail.com','scrypt:32768:8:1$XwLhgtqcf5xOjRJ7$3eb793bf49ea8db2f94821a92da02574b62dfcb189b42b9a0d7ce7cd69055c5cf96d7fb4ab75a0211d51c2c647466d17846f7ea216e2ff7ab6e7e7be92a5b02a','2026-04-17 13:05:21'),(2,'test','test1234@test.com','scrypt:32768:8:1$7crLP8JtNo4nIM6C$bd74de5dbfef432e576ae8da844daf5594bb35893b6321892825be9a26ba4dc86de67dd94c825267b98ce0d1e964f698a272b517fb12e0a71789b250559fdae6','2026-04-17 13:15:05');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-17 15:26:23
