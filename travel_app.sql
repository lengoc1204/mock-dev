-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: travel_app_db
-- ------------------------------------------------------
-- Server version	8.0.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account_emailaddresss`
--

DROP TABLE IF EXISTS `account_emailaddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_emailaddress` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(254) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `account_emailaddress_user_id_2c513194_fk_core_user_id` (`user_id`),
  CONSTRAINT `account_emailaddress_user_id_2c513194_fk_core_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_emailaddress`
--

LOCK TABLES `account_emailaddress` WRITE;
/*!40000 ALTER TABLE `account_emailaddress` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_emailaddress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_emailconfirmation`
--

DROP TABLE IF EXISTS `account_emailconfirmation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_emailconfirmation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `sent` datetime(6) DEFAULT NULL,
  `key` varchar(64) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `email_address_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  KEY `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` (`email_address_id`),
  CONSTRAINT `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` FOREIGN KEY (`email_address_id`) REFERENCES `account_emailaddress` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_emailconfirmation`
--

LOCK TABLES `account_emailconfirmation` WRITE;
/*!40000 ALTER TABLE `account_emailconfirmation` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_emailconfirmation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add application',6,'add_application'),(22,'Can change application',6,'change_application'),(23,'Can delete application',6,'delete_application'),(24,'Can view application',6,'view_application'),(25,'Can add access token',7,'add_accesstoken'),(26,'Can change access token',7,'change_accesstoken'),(27,'Can delete access token',7,'delete_accesstoken'),(28,'Can view access token',7,'view_accesstoken'),(29,'Can add grant',8,'add_grant'),(30,'Can change grant',8,'change_grant'),(31,'Can delete grant',8,'delete_grant'),(32,'Can view grant',8,'view_grant'),(33,'Can add refresh token',9,'add_refreshtoken'),(34,'Can change refresh token',9,'change_refreshtoken'),(35,'Can delete refresh token',9,'delete_refreshtoken'),(36,'Can view refresh token',9,'view_refreshtoken'),(37,'Can add id token',10,'add_idtoken'),(38,'Can change id token',10,'change_idtoken'),(39,'Can delete id token',10,'delete_idtoken'),(40,'Can view id token',10,'view_idtoken'),(41,'Can add user',11,'add_user'),(42,'Can change user',11,'change_user'),(43,'Can delete user',11,'delete_user'),(44,'Can view user',11,'view_user'),(45,'Can add blog',12,'add_blog'),(46,'Can change blog',12,'change_blog'),(47,'Can delete blog',12,'delete_blog'),(48,'Can view blog',12,'view_blog'),(49,'Can add coupon',13,'add_coupon'),(50,'Can change coupon',13,'change_coupon'),(51,'Can delete coupon',13,'delete_coupon'),(52,'Can view coupon',13,'view_coupon'),(53,'Can add departure',14,'add_departure'),(54,'Can change departure',14,'change_departure'),(55,'Can delete departure',14,'delete_departure'),(56,'Can view departure',14,'view_departure'),(57,'Can add destination',15,'add_destination'),(58,'Can change destination',15,'change_destination'),(59,'Can delete destination',15,'delete_destination'),(60,'Can view destination',15,'view_destination'),(61,'Can add hotel',16,'add_hotel'),(62,'Can change hotel',16,'change_hotel'),(63,'Can delete hotel',16,'delete_hotel'),(64,'Can view hotel',16,'view_hotel'),(65,'Can add tag blog',17,'add_tagblog'),(66,'Can change tag blog',17,'change_tagblog'),(67,'Can delete tag blog',17,'delete_tagblog'),(68,'Can view tag blog',17,'view_tagblog'),(69,'Can add tag tour',18,'add_tagtour'),(70,'Can change tag tour',18,'change_tagtour'),(71,'Can delete tag tour',18,'delete_tagtour'),(72,'Can view tag tour',18,'view_tagtour'),(73,'Can add tour',19,'add_tour'),(74,'Can change tour',19,'change_tour'),(75,'Can delete tour',19,'delete_tour'),(76,'Can view tour',19,'view_tour'),(77,'Can add transport',20,'add_transport'),(78,'Can change transport',20,'change_transport'),(79,'Can delete transport',20,'delete_transport'),(80,'Can view transport',20,'view_transport'),(81,'Can add staff',21,'add_staff'),(82,'Can change staff',21,'change_staff'),(83,'Can delete staff',21,'delete_staff'),(84,'Can view staff',21,'view_staff'),(85,'Can add views',22,'add_views'),(86,'Can change views',22,'change_views'),(87,'Can delete views',22,'delete_views'),(88,'Can view views',22,'view_views'),(89,'Can add img tour',23,'add_imgtour'),(90,'Can change img tour',23,'change_imgtour'),(91,'Can delete img tour',23,'delete_imgtour'),(92,'Can view img tour',23,'view_imgtour'),(93,'Can add comment tour',24,'add_commenttour'),(94,'Can change comment tour',24,'change_commenttour'),(95,'Can delete comment tour',24,'delete_commenttour'),(96,'Can view comment tour',24,'view_commenttour'),(97,'Can add comment blog',25,'add_commentblog'),(98,'Can change comment blog',25,'change_commentblog'),(99,'Can delete comment blog',25,'delete_commentblog'),(100,'Can view comment blog',25,'view_commentblog'),(101,'Can add rating',26,'add_rating'),(102,'Can change rating',26,'change_rating'),(103,'Can delete rating',26,'delete_rating'),(104,'Can view rating',26,'view_rating'),(105,'Can add like',27,'add_like'),(106,'Can change like',27,'change_like'),(107,'Can delete like',27,'delete_like'),(108,'Can view like',27,'view_like'),(109,'Can add booking',28,'add_booking'),(110,'Can change booking',28,'change_booking'),(111,'Can delete booking',28,'delete_booking'),(112,'Can view booking',28,'view_booking'),(113,'Can add site',29,'add_site'),(114,'Can change site',29,'change_site'),(115,'Can delete site',29,'delete_site'),(116,'Can view site',29,'view_site'),(117,'Can add email address',30,'add_emailaddress'),(118,'Can change email address',30,'change_emailaddress'),(119,'Can delete email address',30,'delete_emailaddress'),(120,'Can view email address',30,'view_emailaddress'),(121,'Can add email confirmation',31,'add_emailconfirmation'),(122,'Can change email confirmation',31,'change_emailconfirmation'),(123,'Can delete email confirmation',31,'delete_emailconfirmation'),(124,'Can view email confirmation',31,'view_emailconfirmation'),(125,'Can add social account',32,'add_socialaccount'),(126,'Can change social account',32,'change_socialaccount'),(127,'Can delete social account',32,'delete_socialaccount'),(128,'Can view social account',32,'view_socialaccount'),(129,'Can add social application',33,'add_socialapp'),(130,'Can change social application',33,'change_socialapp'),(131,'Can delete social application',33,'delete_socialapp'),(132,'Can view social application',33,'view_socialapp'),(133,'Can add social application token',34,'add_socialtoken'),(134,'Can change social application token',34,'change_socialtoken'),(135,'Can delete social application token',34,'delete_socialtoken'),(136,'Can view social application token',34,'view_socialtoken'),(137,'Can add tour view',35,'add_tourview'),(138,'Can change tour view',35,'change_tourview'),(139,'Can delete tour view',35,'delete_tourview'),(140,'Can view tour view',35,'view_tourview');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_blog`
--

DROP TABLE IF EXISTS `core_blog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_blog` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `image` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_520_ci,
  `description` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_blog`
--

LOCK TABLES `core_blog` WRITE;
/*!40000 ALTER TABLE `core_blog` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_blog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_blog_tag`
--

DROP TABLE IF EXISTS `core_blog_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_blog_tag` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `blog_id` bigint NOT NULL,
  `tagblog_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_blog_tag_blog_id_tagblog_id_9c9383a4_uniq` (`blog_id`,`tagblog_id`),
  KEY `core_blog_tag_tagblog_id_ee80bef3_fk_core_tagblog_id` (`tagblog_id`),
  CONSTRAINT `core_blog_tag_blog_id_20fd213b_fk_core_blog_id` FOREIGN KEY (`blog_id`) REFERENCES `core_blog` (`id`),
  CONSTRAINT `core_blog_tag_tagblog_id_ee80bef3_fk_core_tagblog_id` FOREIGN KEY (`tagblog_id`) REFERENCES `core_tagblog` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_blog_tag`
--

LOCK TABLES `core_blog_tag` WRITE;
/*!40000 ALTER TABLE `core_blog_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_blog_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_booking`
--

DROP TABLE IF EXISTS `core_booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_booking` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `adult` int NOT NULL,
  `children5` int DEFAULT NULL,
  `children11` int DEFAULT NULL,
  `children2` int DEFAULT NULL,
  `status` varchar(1) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `room` int DEFAULT NULL,
  `customer_id` bigint DEFAULT NULL,
  `tour_id` bigint NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `phone_number` varchar(12) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_booking_customer_id_b4948c3d_fk_core_user_id` (`customer_id`),
  KEY `core_booking_tour_id_74c09286` (`tour_id`),
  CONSTRAINT `core_booking_customer_id_b4948c3d_fk_core_user_id` FOREIGN KEY (`customer_id`) REFERENCES `core_user` (`id`),
  CONSTRAINT `core_booking_tour_id_74c09286_fk_core_tour_id` FOREIGN KEY (`tour_id`) REFERENCES `core_tour` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_booking`
--

LOCK TABLES `core_booking` WRITE;
/*!40000 ALTER TABLE `core_booking` DISABLE KEYS */;
INSERT INTO `core_booking` VALUES (1,1,2,0,0,'p','2023-05-28 08:55:26.496762',0,1,1,'hhh',NULL,'0933880597'),(6,10,1,1,1,'p','2023-05-30 10:17:02.525363',1,1,1,'187 dien bien phu, p.dakao, quan 1, tp.hcm','vui long xac nhan thong tin','0933880597'),(7,10,1,1,1,'p','2023-05-30 10:18:14.967832',1,1,1,'187 dien bien phu, p.dakao, quan 1, tp.hcm','vui long xac nhan thong tin','0933880597'),(8,10,1,1,1,'p','2023-05-30 10:18:38.617355',1,1,1,'187 dien bien phu, p.dakao, quan 1, tp.hcm','vui long xac nhan thong tin','0933880597'),(9,10,1,1,1,'p','2023-05-30 10:19:12.182016',1,1,1,'187 dien bien phu, p.dakao, quan 1, tp.hcm','vui long xac nhan thong tin','0933880597'),(10,10,1,1,1,'p','2023-05-30 10:19:32.605939',1,1,1,'187 dien bien phu, p.dakao, quan 1, tp.hcm','vui long xac nhan thong tin','0933880597'),(11,3,NULL,NULL,NULL,'p','2023-06-02 14:16:34.196604',NULL,3,1,'hhh',NULL,'0933880597'),(12,3,0,0,0,'p','2023-06-02 14:24:15.264733',0,3,1,'hhh',NULL,'0933880597');
/*!40000 ALTER TABLE `core_booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_commentblog`
--

DROP TABLE IF EXISTS `core_commentblog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_commentblog` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `comment` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `update_date` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `blog_id` bigint NOT NULL,
  `customer_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `core_commentblog_blog_id_b7c22a73_fk_core_blog_id` (`blog_id`),
  KEY `core_commentblog_customer_id_8ad8d66c_fk_core_user_id` (`customer_id`),
  CONSTRAINT `core_commentblog_blog_id_b7c22a73_fk_core_blog_id` FOREIGN KEY (`blog_id`) REFERENCES `core_blog` (`id`),
  CONSTRAINT `core_commentblog_customer_id_8ad8d66c_fk_core_user_id` FOREIGN KEY (`customer_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_commentblog`
--

LOCK TABLES `core_commentblog` WRITE;
/*!40000 ALTER TABLE `core_commentblog` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_commentblog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_commenttour`
--

DROP TABLE IF EXISTS `core_commenttour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_commenttour` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `comment` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `update_date` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `customer_id` bigint DEFAULT NULL,
  `tour_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_commenttour_customer_id_8a0e0d4b_fk_core_user_id` (`customer_id`),
  KEY `core_commenttour_tour_id_9d7d8975_fk_core_tour_id` (`tour_id`),
  CONSTRAINT `core_commenttour_customer_id_8a0e0d4b_fk_core_user_id` FOREIGN KEY (`customer_id`) REFERENCES `core_user` (`id`),
  CONSTRAINT `core_commenttour_tour_id_9d7d8975_fk_core_tour_id` FOREIGN KEY (`tour_id`) REFERENCES `core_tour` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_commenttour`
--

LOCK TABLES `core_commenttour` WRITE;
/*!40000 ALTER TABLE `core_commenttour` DISABLE KEYS */;
INSERT INTO `core_commenttour` VALUES (1,'phuong tin gi','2023-05-27 08:58:00.034229','2023-05-27 08:58:00.034229',1,1,1),(2,'phuong tien the nao','2023-05-29 10:04:58.403647','2023-05-29 10:04:58.403647',1,1,1),(3,'hhhhhhhhhh','2023-05-30 09:54:52.099892','2023-05-30 09:54:52.099892',1,1,1);
/*!40000 ALTER TABLE `core_commenttour` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_coupon`
--

DROP TABLE IF EXISTS `core_coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_coupon` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(15) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `amount` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_coupon`
--

LOCK TABLES `core_coupon` WRITE;
/*!40000 ALTER TABLE `core_coupon` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_coupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_departure`
--

DROP TABLE IF EXISTS `core_departure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_departure` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `image` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_departure_name_active_bcb45a08_uniq` (`name`,`active`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_departure`
--

LOCK TABLES `core_departure` WRITE;
/*!40000 ALTER TABLE `core_departure` DISABLE KEYS */;
INSERT INTO `core_departure` VALUES (1,'Ho Chi Minh','2023-05-27 04:14:22.429338','2023-05-27 04:14:22.429338',1,'departures/cat.png','hhh'),(2,'Ha Noi','2023-06-03 07:16:45.666317','2023-06-03 07:16:45.667257',1,'departures/pexels-beyzaa-yurtkuran-15435631.jpg','Ha Noi'),(3,'Quang Ninh','2023-06-03 07:17:08.487355','2023-06-03 07:17:08.487355',1,'departures/pexels-beyzaa-yurtkuran-15435631_t5cPpin.jpg','Quang Ninh'),(4,'Quang Nam','2023-06-03 07:18:25.125542','2023-06-03 07:18:25.125542',1,'departures/departure.png','Quang Nam');
/*!40000 ALTER TABLE `core_departure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_destination`
--

DROP TABLE IF EXISTS `core_destination`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_destination` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `image` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_520_ci,
  `hotel_id_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_destination_name_active_90a616ee_uniq` (`name`,`active`),
  KEY `core_destination_hotel_id_id_1e7c68f0_fk_core_hotel_id` (`hotel_id_id`),
  CONSTRAINT `core_destination_hotel_id_id_1e7c68f0_fk_core_hotel_id` FOREIGN KEY (`hotel_id_id`) REFERENCES `core_hotel` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_destination`
--

LOCK TABLES `core_destination` WRITE;
/*!40000 ALTER TABLE `core_destination` DISABLE KEYS */;
INSERT INTO `core_destination` VALUES (1,'Phu Quoc','2023-05-27 04:15:32.174500','2023-05-27 04:15:32.174500',1,'destinations/pexels-beyzaa-yurtkuran-15435631.jpg','Phu Quoc',NULL),(2,'Phu Quy','2023-06-03 08:03:34.730875','2023-06-03 08:03:34.730875',1,'destinations/phquoc.jpg','Phu Quy',NULL),(3,'Ha Giang','2023-06-03 08:06:57.760568','2023-06-03 08:06:57.760568',1,'destinations/hagiang.jpg','Ha Giang',NULL);
/*!40000 ALTER TABLE `core_destination` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_hotel`
--

DROP TABLE IF EXISTS `core_hotel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_hotel` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `image` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `address` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `phone` varchar(12) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `price` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_hotel`
--

LOCK TABLES `core_hotel` WRITE;
/*!40000 ALTER TABLE `core_hotel` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_hotel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_imgtour`
--

DROP TABLE IF EXISTS `core_imgtour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_imgtour` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `image` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `tour_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_imgtour_tour_id_ed2837ca_fk_core_tour_id` (`tour_id`),
  CONSTRAINT `core_imgtour_tour_id_ed2837ca_fk_core_tour_id` FOREIGN KEY (`tour_id`) REFERENCES `core_tour` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_imgtour`
--

LOCK TABLES `core_imgtour` WRITE;
/*!40000 ALTER TABLE `core_imgtour` DISABLE KEYS */;
INSERT INTO `core_imgtour` VALUES (1,'tours/pexels-beyzaa-yurtkuran-15435631_yG0pSws.jpg','h',1),(2,'tours/hagiang_tVZr7li.jpg','Ho Chi Minh - Ha Giang',4),(3,'tours/hagiang_EJteoPm.jpg','Ho Chi Minh - Ha Giang',4),(4,'tours/hagiang_Vo7mZdh.jpg','Ho Chi Minh - Ha Giang',4),(5,'tours/hagiang_CxoT79Q.jpg','Ho Chi Minh - Ha Giang',4),(6,'tours/hagiang_ESqPECE.jpg','Ho Chi Minh - Ha Giang',4);
/*!40000 ALTER TABLE `core_imgtour` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_like`
--

DROP TABLE IF EXISTS `core_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_like` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` smallint unsigned NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `update_date` datetime(6) NOT NULL,
  `blog_id` bigint NOT NULL,
  `customer_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_like_blog_id_customer_id_1e516122_uniq` (`blog_id`,`customer_id`),
  KEY `core_like_customer_id_6230ef8c_fk_core_user_id` (`customer_id`),
  CONSTRAINT `core_like_blog_id_0b1d6548_fk_core_blog_id` FOREIGN KEY (`blog_id`) REFERENCES `core_blog` (`id`),
  CONSTRAINT `core_like_customer_id_6230ef8c_fk_core_user_id` FOREIGN KEY (`customer_id`) REFERENCES `core_user` (`id`),
  CONSTRAINT `core_like_chk_1` CHECK ((`type` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_like`
--

LOCK TABLES `core_like` WRITE;
/*!40000 ALTER TABLE `core_like` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_rating`
--

DROP TABLE IF EXISTS `core_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_rating` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `update_date` datetime(6) NOT NULL,
  `rate` smallint unsigned NOT NULL,
  `customer_id` bigint NOT NULL,
  `tour_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_rating_tour_id_customer_id_5c07eeb3_uniq` (`tour_id`,`customer_id`),
  KEY `core_rating_customer_id_0208e4df_fk_core_user_id` (`customer_id`),
  CONSTRAINT `core_rating_customer_id_0208e4df_fk_core_user_id` FOREIGN KEY (`customer_id`) REFERENCES `core_user` (`id`),
  CONSTRAINT `core_rating_tour_id_bf0f2ac0_fk_core_tour_id` FOREIGN KEY (`tour_id`) REFERENCES `core_tour` (`id`),
  CONSTRAINT `core_rating_chk_1` CHECK ((`rate` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_rating`
--

LOCK TABLES `core_rating` WRITE;
/*!40000 ALTER TABLE `core_rating` DISABLE KEYS */;
INSERT INTO `core_rating` VALUES (1,'2023-05-30 08:28:26.293291','2023-05-30 09:56:08.953990',3,1,1);
/*!40000 ALTER TABLE `core_rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_staff`
--

DROP TABLE IF EXISTS `core_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_staff` (
  `user_id` bigint NOT NULL,
  `activeStaff` tinyint(1) NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `core_staff_user_id_3295e7b7_fk_core_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_staff`
--

LOCK TABLES `core_staff` WRITE;
/*!40000 ALTER TABLE `core_staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_tagblog`
--

DROP TABLE IF EXISTS `core_tagblog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_tagblog` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_tagblog`
--

LOCK TABLES `core_tagblog` WRITE;
/*!40000 ALTER TABLE `core_tagblog` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_tagblog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_tagtour`
--

DROP TABLE IF EXISTS `core_tagtour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_tagtour` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_tagtour`
--

LOCK TABLES `core_tagtour` WRITE;
/*!40000 ALTER TABLE `core_tagtour` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_tagtour` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_tour`
--

DROP TABLE IF EXISTS `core_tour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_tour` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `image` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `slot` int NOT NULL,
  `time_start` datetime(6) DEFAULT NULL,
  `duration` int NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_520_ci,
  `single_room` int NOT NULL,
  `price` int DEFAULT NULL,
  `discount` int DEFAULT NULL,
  `departure_id` bigint NOT NULL,
  `destination_id` bigint NOT NULL,
  `children11_price` int NOT NULL,
  `children2_price` int NOT NULL,
  `children5_price` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_tour_name_departure_id_5ad2b17f_uniq` (`name`,`departure_id`),
  KEY `core_tour_departure_id_f66380c0_fk_core_departure_id` (`departure_id`),
  KEY `core_tour_destination_id_73753b20_fk_core_destination_id` (`destination_id`),
  CONSTRAINT `core_tour_departure_id_f66380c0_fk_core_departure_id` FOREIGN KEY (`departure_id`) REFERENCES `core_departure` (`id`),
  CONSTRAINT `core_tour_destination_id_73753b20_fk_core_destination_id` FOREIGN KEY (`destination_id`) REFERENCES `core_destination` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_tour`
--

LOCK TABLES `core_tour` WRITE;
/*!40000 ALTER TABLE `core_tour` DISABLE KEYS */;
INSERT INTO `core_tour` VALUES (1,'Ho Chi Minh - Phu Quoc','2023-05-27 04:15:32.184465','2023-05-29 09:23:13.138498',1,'tours/pexels-beyzaa-yurtkuran-15435631.jpg',40,'2023-05-31 04:15:03.000000',3,'hhhhhhh',0,3000000,10,1,1,1100000,700000,900000),(2,'Quang Ninh - Phu Quy','2023-06-03 08:03:34.826696','2023-06-03 08:03:34.826696',1,'tours/phquoc.jpg',40,'2023-06-30 18:00:00.000000',4,'Quang Ninh - Phu Quy',1200000,3000000,0,3,2,900000,500000,700000),(3,'Quang Nam - Phu Quy','2023-06-03 08:03:34.926355','2023-06-03 08:03:34.926355',1,'tours/phquoc_aJ41fKS.jpg',40,'2023-06-24 06:00:00.000000',4,'Quang Nam - Phu Quy',1500000,3000000,10,3,2,1100000,300000,600000),(4,'Ho Chi Minh - Ha Giang','2023-06-03 08:07:56.789026','2023-06-03 08:07:56.789026',1,'tours/hagiang.jpg',40,'2023-06-26 18:00:00.000000',4,'Ho Chi Minh - Ha Giang',2000000,3000000,10,1,3,1200000,500000,800000);
/*!40000 ALTER TABLE `core_tour` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_tour_tag`
--

DROP TABLE IF EXISTS `core_tour_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_tour_tag` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tour_id` bigint NOT NULL,
  `tagtour_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_tour_tag_tour_id_tagtour_id_82254e38_uniq` (`tour_id`,`tagtour_id`),
  KEY `core_tour_tag_tagtour_id_a8545683_fk_core_tagtour_id` (`tagtour_id`),
  CONSTRAINT `core_tour_tag_tagtour_id_a8545683_fk_core_tagtour_id` FOREIGN KEY (`tagtour_id`) REFERENCES `core_tagtour` (`id`),
  CONSTRAINT `core_tour_tag_tour_id_977a0d61_fk_core_tour_id` FOREIGN KEY (`tour_id`) REFERENCES `core_tour` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_tour_tag`
--

LOCK TABLES `core_tour_tag` WRITE;
/*!40000 ALTER TABLE `core_tour_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_tour_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_tour_transport`
--

DROP TABLE IF EXISTS `core_tour_transport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_tour_transport` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tour_id` bigint NOT NULL,
  `transport_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_tour_transport_tour_id_transport_id_425cd01a_uniq` (`tour_id`,`transport_id`),
  KEY `core_tour_transport_transport_id_8b884a6f_fk_core_transport_id` (`transport_id`),
  CONSTRAINT `core_tour_transport_tour_id_f5819873_fk_core_tour_id` FOREIGN KEY (`tour_id`) REFERENCES `core_tour` (`id`),
  CONSTRAINT `core_tour_transport_transport_id_8b884a6f_fk_core_transport_id` FOREIGN KEY (`transport_id`) REFERENCES `core_transport` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_tour_transport`
--

LOCK TABLES `core_tour_transport` WRITE;
/*!40000 ALTER TABLE `core_tour_transport` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_tour_transport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_tourview`
--

DROP TABLE IF EXISTS `core_tourview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_tourview` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) DEFAULT NULL,
  `update_date` datetime(6) NOT NULL,
  `views` int NOT NULL,
  `tour_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tour_id` (`tour_id`),
  CONSTRAINT `core_tourview_tour_id_127dd3b8_fk_core_tour_id` FOREIGN KEY (`tour_id`) REFERENCES `core_tour` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_tourview`
--

LOCK TABLES `core_tourview` WRITE;
/*!40000 ALTER TABLE `core_tourview` DISABLE KEYS */;
INSERT INTO `core_tourview` VALUES (1,NULL,'2023-06-03 09:06:07.845341',3,2),(2,NULL,'2023-06-03 09:04:03.078697',4,1),(3,NULL,'2023-06-03 09:38:40.711182',34,3);
/*!40000 ALTER TABLE `core_tourview` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_transport`
--

DROP TABLE IF EXISTS `core_transport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_transport` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_transport`
--

LOCK TABLES `core_transport` WRITE;
/*!40000 ALTER TABLE `core_transport` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_transport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_user`
--

DROP TABLE IF EXISTS `core_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `phone_number` varchar(11) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `avatar` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_user`
--

LOCK TABLES `core_user` WRITE;
/*!40000 ALTER TABLE `core_user` DISABLE KEYS */;
INSERT INTO `core_user` VALUES (1,'pbkdf2_sha256$600000$lXc8iWUY2XfIWNXul5EPwg$H9giLAnFhoPVwx7ih7HTF2YZctKPvow5obdH8MPQXmw=','2023-05-29 10:03:03.170625',1,'admin','Ngoc','Le','',1,1,'2023-05-27 04:12:42.200652',NULL,NULL,''),(2,'pbkdf2_sha256$600000$eeW9CBmLG4SGOp00wZqOgS$5uVJliwJ8T7SDcmRzd04SUSZHYEEn7wMVTdcvs/NtHo=',NULL,0,'','','','tgngoc1204@gmail.com',0,1,'2023-05-29 10:02:40.436905',NULL,NULL,''),(3,'pbkdf2_sha256$600000$CSzx9mijRPs4C0ZSy2OR1E$y4a7Su4sln2ycP4CyREgiZOi4NLlvM/SIqtAK9m0hBs=','2023-06-03 07:16:17.329201',1,'nhiennguyen','Nhien','Nguyen','',1,1,'2023-06-02 14:12:46.794053',NULL,NULL,'');
/*!40000 ALTER TABLE `core_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_user_groups`
--

DROP TABLE IF EXISTS `core_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_user_groups_user_id_group_id_c82fcad1_uniq` (`user_id`,`group_id`),
  KEY `core_user_groups_group_id_fe8c697f_fk_auth_group_id` (`group_id`),
  CONSTRAINT `core_user_groups_group_id_fe8c697f_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `core_user_groups_user_id_70b4d9b8_fk_core_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_user_groups`
--

LOCK TABLES `core_user_groups` WRITE;
/*!40000 ALTER TABLE `core_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_user_user_permissions`
--

DROP TABLE IF EXISTS `core_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_user_user_permissions_user_id_permission_id_73ea0daa_uniq` (`user_id`,`permission_id`),
  KEY `core_user_user_permi_permission_id_35ccf601_fk_auth_perm` (`permission_id`),
  CONSTRAINT `core_user_user_permi_permission_id_35ccf601_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `core_user_user_permissions_user_id_085123d3_fk_core_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_user_user_permissions`
--

LOCK TABLES `core_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `core_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_520_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_core_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_core_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2023-05-27 04:14:22.434347','1','Ho Chi Minh',1,'[{\"added\": {}}]',14,1),(2,'2023-05-27 04:15:32.207407','1','Phu Quoc',1,'[{\"added\": {}}, {\"added\": {\"name\": \"tour\", \"object\": \"Ho Chi Minh - Phu Quoc\"}}]',15,1),(3,'2023-05-27 04:16:01.489560','1','Ho Chi Minh - Phu Quoc',2,'[{\"added\": {\"name\": \"img tour\", \"object\": \"h\"}}]',19,1),(4,'2023-05-28 08:55:26.561584','1','Booking object (1)',1,'[{\"added\": {}}]',28,1),(5,'2023-05-29 09:22:32.733707','1','Booking object (1)',2,'[{\"changed\": {\"fields\": [\"Children5\"]}}]',28,1),(6,'2023-05-29 09:23:13.174490','1','Ho Chi Minh - Phu Quoc',2,'[{\"changed\": {\"fields\": [\"Children2 price\", \"Children5 price\", \"Children11 price\"]}}]',19,1),(7,'2023-05-29 10:02:41.572160','2',' ',1,'[{\"added\": {}}]',11,1),(8,'2023-06-03 07:16:45.676271','2','Ha Noi',1,'[{\"added\": {}}]',14,3),(9,'2023-06-03 07:17:08.492345','3','Quang Ninh',1,'[{\"added\": {}}]',14,3),(10,'2023-06-03 07:18:25.128481','4','Quang Nam',1,'[{\"added\": {}}]',14,3),(11,'2023-06-03 08:03:34.941432','2','Phu Quy',1,'[{\"added\": {}}, {\"added\": {\"name\": \"tour\", \"object\": \"Quang Ninh - Phu Quy\"}}, {\"added\": {\"name\": \"tour\", \"object\": \"Quang Nam - Phu Quy\"}}]',15,3),(12,'2023-06-03 08:06:57.809417','3','Ha Giang',1,'[{\"added\": {}}]',15,3),(13,'2023-06-03 08:07:56.880632','4','Ho Chi Minh - Ha Giang',1,'[{\"added\": {}}, {\"added\": {\"name\": \"img tour\", \"object\": \"Ho Chi Minh - Ha Giang\"}}, {\"added\": {\"name\": \"img tour\", \"object\": \"Ho Chi Minh - Ha Giang\"}}, {\"added\": {\"name\": \"img tour\", \"object\": \"Ho Chi Minh - Ha Giang\"}}, {\"added\": {\"name\": \"img tour\", \"object\": \"Ho Chi Minh - Ha Giang\"}}, {\"added\": {\"name\": \"img tour\", \"object\": \"Ho Chi Minh - Ha Giang\"}}]',19,3),(14,'2023-06-03 08:23:31.679622','1','Views object (1)',1,'[{\"added\": {}}]',22,3);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (30,'account','emailaddress'),(31,'account','emailconfirmation'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(12,'core','blog'),(28,'core','booking'),(25,'core','commentblog'),(24,'core','commenttour'),(13,'core','coupon'),(14,'core','departure'),(15,'core','destination'),(16,'core','hotel'),(23,'core','imgtour'),(27,'core','like'),(26,'core','rating'),(21,'core','staff'),(17,'core','tagblog'),(18,'core','tagtour'),(19,'core','tour'),(35,'core','tourview'),(20,'core','transport'),(11,'core','user'),(22,'core','views'),(7,'oauth2_provider','accesstoken'),(6,'oauth2_provider','application'),(8,'oauth2_provider','grant'),(10,'oauth2_provider','idtoken'),(9,'oauth2_provider','refreshtoken'),(5,'sessions','session'),(29,'sites','site'),(32,'socialaccount','socialaccount'),(33,'socialaccount','socialapp'),(34,'socialaccount','socialtoken');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-05-27 04:12:08.499154'),(2,'contenttypes','0002_remove_content_type_name','2023-05-27 04:12:08.827369'),(3,'auth','0001_initial','2023-05-27 04:12:09.448176'),(4,'auth','0002_alter_permission_name_max_length','2023-05-27 04:12:09.587813'),(5,'auth','0003_alter_user_email_max_length','2023-05-27 04:12:09.600779'),(6,'auth','0004_alter_user_username_opts','2023-05-27 04:12:09.614742'),(7,'auth','0005_alter_user_last_login_null','2023-05-27 04:12:09.628752'),(8,'auth','0006_require_contenttypes_0002','2023-05-27 04:12:09.637682'),(9,'auth','0007_alter_validators_add_error_messages','2023-05-27 04:12:09.650648'),(10,'auth','0008_alter_user_username_max_length','2023-05-27 04:12:09.667606'),(11,'auth','0009_alter_user_last_name_max_length','2023-05-27 04:12:09.688551'),(12,'auth','0010_alter_group_name_max_length','2023-05-27 04:12:09.770439'),(13,'auth','0011_update_proxy_permissions','2023-05-27 04:12:09.807554'),(14,'auth','0012_alter_user_first_name_max_length','2023-05-27 04:12:09.842462'),(15,'core','0001_initial','2023-05-27 04:12:17.861253'),(16,'admin','0001_initial','2023-05-27 04:12:18.417859'),(17,'admin','0002_logentry_remove_auto_add','2023-05-27 04:12:18.436810'),(18,'admin','0003_logentry_add_action_flag_choices','2023-05-27 04:12:18.458752'),(19,'oauth2_provider','0001_initial','2023-05-27 04:12:21.283651'),(20,'oauth2_provider','0002_auto_20190406_1805','2023-05-27 04:12:21.585639'),(21,'oauth2_provider','0003_auto_20201211_1314','2023-05-27 04:12:21.804144'),(22,'oauth2_provider','0004_auto_20200902_2022','2023-05-27 04:12:23.664631'),(23,'oauth2_provider','0005_auto_20211222_2352','2023-05-27 04:12:23.849149'),(24,'oauth2_provider','0006_alter_application_client_secret','2023-05-27 04:12:23.899008'),(25,'sessions','0001_initial','2023-05-27 04:12:24.028674'),(26,'core','0002_remove_booking_price11_remove_booking_price2_and_more','2023-05-29 09:19:15.594201'),(27,'core','0003_booking_address_booking_note_booking_phone_number','2023-05-30 07:54:49.797314'),(28,'core','0004_remove_booking_coupon','2023-05-30 08:12:16.436460'),(29,'core','0005_alter_booking_children11_alter_booking_children2_and_more','2023-05-30 10:03:10.403517'),(30,'core','0006_alter_booking_room','2023-05-30 10:03:52.528004'),(31,'core','0007_alter_booking_unique_together','2023-05-30 10:16:51.868085'),(32,'account','0001_initial','2023-06-03 07:15:33.256367'),(33,'account','0002_email_max_length','2023-06-03 07:15:33.319241'),(34,'sites','0001_initial','2023-06-03 07:15:33.371707'),(35,'sites','0002_alter_domain_unique','2023-06-03 07:15:33.423639'),(36,'socialaccount','0001_initial','2023-06-03 07:15:34.628945'),(37,'socialaccount','0002_token_max_lengths','2023-06-03 07:15:34.745979'),(38,'socialaccount','0003_extra_data_default_dict','2023-06-03 07:15:34.767977'),(39,'core','0008_tourview_delete_views','2023-06-03 08:51:42.371660');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('m8oqrjxxctezvo1801xv2vdb2177gs20','.eJxVjDsOwjAQBe_iGlmJvfGHkj5nsNa7Ng4gR4qTCnF3EikFtDPz3lsE3NYStpaWMLG4Ci0uvywiPVM9BD-w3mdJc12XKcojkadtcpw5vW5n-3dQsJV93RvQYKzuMmrtWJE12g2YkvcOQIHpBqU4EvXRMrBPFi1Q9rgzJsji8wW-LjgO:1q5LUn:LNV29Z5cNTM1iUrASwbYA4i-ENbLfPE1hDbrG5lfvUk','2023-06-17 07:16:17.353136');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_site` (
  `id` int NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_accesstoken`
--

DROP TABLE IF EXISTS `oauth2_provider_accesstoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_accesstoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `expires` datetime(6) NOT NULL,
  `scope` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `application_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `source_refresh_token_id` bigint DEFAULT NULL,
  `id_token_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  UNIQUE KEY `source_refresh_token_id` (`source_refresh_token_id`),
  UNIQUE KEY `id_token_id` (`id_token_id`),
  KEY `oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_accesstoken_user_id_6e4c9a65_fk_core_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_acce_id_token_id_85db651b_fk_oauth2_pr` FOREIGN KEY (`id_token_id`) REFERENCES `oauth2_provider_idtoken` (`id`),
  CONSTRAINT `oauth2_provider_acce_source_refresh_token_e66fbc72_fk_oauth2_pr` FOREIGN KEY (`source_refresh_token_id`) REFERENCES `oauth2_provider_refreshtoken` (`id`),
  CONSTRAINT `oauth2_provider_accesstoken_user_id_6e4c9a65_fk_core_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_accesstoken`
--

LOCK TABLES `oauth2_provider_accesstoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_accesstoken` DISABLE KEYS */;
INSERT INTO `oauth2_provider_accesstoken` VALUES (1,'66pNDWFre091AA80ebgbb9ejylCQBh','2023-05-27 18:52:54.570664','read write',1,1,'2023-05-27 08:52:54.589822','2023-05-27 08:52:54.589822',NULL,NULL),(2,'LuPaMQxksWXysWKKpoybUmXdcKRrfY','2023-05-28 17:35:52.413700','read write',1,1,'2023-05-28 07:35:52.429061','2023-05-28 07:35:52.429061',NULL,NULL),(3,'ErMZTnug0Vk3ygwnZOWdEQSvi2FrKY','2023-05-28 18:37:21.446699','read write',1,1,'2023-05-28 08:37:21.449697','2023-05-28 08:37:21.449697',NULL,NULL),(4,'qBoldt6B0L9ZgedljUU7mzguCDaHAJ','2023-05-29 19:24:49.013155','read write',1,1,'2023-05-29 09:24:49.015660','2023-05-29 09:24:49.015660',NULL,NULL),(5,'Co5o5WxMlb0JWPtNzwqJESgE8ITdog','2023-05-29 19:57:25.501142','read write',1,1,'2023-05-29 09:57:25.522469','2023-05-29 09:57:25.522469',NULL,NULL),(6,'no1zQZRLo66n1rJsUM6GiTPy8nKW8Q','2023-05-30 18:13:38.953922','read write',1,1,'2023-05-30 08:13:38.957910','2023-05-30 08:13:38.957910',NULL,NULL),(7,'0dN3mYT4nEcKS1lgfvcRKLcc2lP8do','2023-05-30 18:28:15.460516','read write',1,1,'2023-05-30 08:28:15.469552','2023-05-30 08:28:15.469552',NULL,NULL),(8,'FiMskGcyfKYm379O1j9dYhYUEiWqLE','2023-05-30 19:51:44.829453','read write',1,1,'2023-05-30 09:51:44.846358','2023-05-30 09:51:44.846358',NULL,NULL),(9,'LfncEPMOBFheFrYD8rYWCJtjKYiPUG','2023-05-30 19:54:01.398184','read write',1,1,'2023-05-30 09:54:01.402174','2023-05-30 09:54:01.402174',NULL,NULL),(10,'qYw2Ckjowi6efMojDDPGgmL3OOGJDl','2023-05-30 20:03:22.437476','read write',1,1,'2023-05-30 10:03:22.438467','2023-05-30 10:03:22.438467',NULL,NULL),(11,'CjVEn56c5rAZL5mPddGPoc89tkkY7k','2023-06-02 21:51:15.967619','read write',1,1,'2023-06-02 11:51:15.980585','2023-06-02 11:51:15.980585',NULL,NULL),(12,'9gTKHpmBcCWmJ9b4omZI1mY6kTl2Z5','2023-06-02 22:06:36.729313','read write',1,1,'2023-06-02 12:06:36.731308','2023-06-02 12:06:36.731308',NULL,NULL),(13,'leDjPsAbAFBaSw1Alrkr1q66aUBWI2','2023-06-03 00:04:24.273559','read write',1,1,'2023-06-02 14:04:24.293544','2023-06-02 14:04:24.293544',NULL,NULL),(14,'bbpZ8ugGYDX4ki9kCcIi84uL0FVYng','2023-06-03 00:13:22.485849','read write',1,3,'2023-06-02 14:13:22.492847','2023-06-02 14:13:22.492847',NULL,NULL),(15,'uC8ocozEhgulBVHtYdDrTo7yscstYB','2023-06-03 16:37:41.144405','read write',1,3,'2023-06-03 06:37:41.151365','2023-06-03 06:37:41.151365',NULL,NULL);
/*!40000 ALTER TABLE `oauth2_provider_accesstoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_application`
--

DROP TABLE IF EXISTS `oauth2_provider_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_application` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `client_id` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `redirect_uris` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `client_type` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `authorization_grant_type` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `client_secret` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `skip_authorization` tinyint(1) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `algorithm` varchar(5) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_id` (`client_id`),
  KEY `oauth2_provider_application_user_id_79829054_fk_core_user_id` (`user_id`),
  KEY `oauth2_provider_application_client_secret_53133678` (`client_secret`),
  CONSTRAINT `oauth2_provider_application_user_id_79829054_fk_core_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_application`
--

LOCK TABLES `oauth2_provider_application` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_application` DISABLE KEYS */;
INSERT INTO `oauth2_provider_application` VALUES (1,'1IQRKKilMUgQSSnLUK2YeyNR2VrRFlVAN88Ydvh6','','confidential','password','pbkdf2_sha256$600000$kiqEt4MXomLC7QAKu2krXs$ouJKDkKFXeiqKoeL8+y0263IRj4RmHe8zkcfHXEmvpI=','Travel App',1,0,'2023-05-27 04:13:57.100757','2023-05-27 04:13:57.100757','');
/*!40000 ALTER TABLE `oauth2_provider_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_grant`
--

DROP TABLE IF EXISTS `oauth2_provider_grant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_grant` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `expires` datetime(6) NOT NULL,
  `redirect_uri` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `scope` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `application_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `code_challenge` varchar(128) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `code_challenge_method` varchar(10) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `nonce` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `claims` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT (_utf8mb3''),
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `oauth2_provider_gran_application_id_81923564_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_grant_user_id_e8f62af8_fk_core_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_gran_application_id_81923564_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_grant_user_id_e8f62af8_fk_core_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_grant`
--

LOCK TABLES `oauth2_provider_grant` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_grant` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_provider_grant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_idtoken`
--

DROP TABLE IF EXISTS `oauth2_provider_idtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_idtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `jti` char(32) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `expires` datetime(6) NOT NULL,
  `scope` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `application_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `jti` (`jti`),
  KEY `oauth2_provider_idto_application_id_08c5ff4f_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_idtoken_user_id_dd512b59_fk_core_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_idto_application_id_08c5ff4f_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_idtoken_user_id_dd512b59_fk_core_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_idtoken`
--

LOCK TABLES `oauth2_provider_idtoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_idtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_provider_idtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_refreshtoken`
--

DROP TABLE IF EXISTS `oauth2_provider_refreshtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_refreshtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `access_token_id` bigint DEFAULT NULL,
  `application_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `revoked` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `access_token_id` (`access_token_id`),
  UNIQUE KEY `oauth2_provider_refreshtoken_token_revoked_af8a5134_uniq` (`token`,`revoked`),
  KEY `oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_refreshtoken_user_id_da837fce_fk_core_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_refr_access_token_id_775e84e8_fk_oauth2_pr` FOREIGN KEY (`access_token_id`) REFERENCES `oauth2_provider_accesstoken` (`id`),
  CONSTRAINT `oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_refreshtoken_user_id_da837fce_fk_core_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_refreshtoken`
--

LOCK TABLES `oauth2_provider_refreshtoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_refreshtoken` DISABLE KEYS */;
INSERT INTO `oauth2_provider_refreshtoken` VALUES (1,'GDJPpLXX2dpdCZT5GLUGzi49dks0qS',1,1,1,'2023-05-27 08:52:54.844852','2023-05-27 08:52:54.844852',NULL),(2,'tk0xXsOEnfzfZTBp9gyWEl784DNsDl',2,1,1,'2023-05-28 07:35:52.545061','2023-05-28 07:35:52.545061',NULL),(3,'onnTA8Ssenoi1rXjn73ZbioyyLRU2q',3,1,1,'2023-05-28 08:37:21.521497','2023-05-28 08:37:21.521497',NULL),(4,'pZ0NSr5DcHvNw4Xkqv8P8OrfglJVge',4,1,1,'2023-05-29 09:24:49.059718','2023-05-29 09:24:49.060771',NULL),(5,'X0ZtbFdrZ4Q66CLCs01jZolvdxL2xb',5,1,1,'2023-05-29 09:57:25.759851','2023-05-29 09:57:25.759851',NULL),(6,'pYqOdWwceF50jLampPfVbiypzvVCYF',6,1,1,'2023-05-30 08:13:39.031547','2023-05-30 08:13:39.031547',NULL),(7,'ekquJtw9VJEVoU2XVG6sDS9S7ZYNCz',7,1,1,'2023-05-30 08:28:15.547701','2023-05-30 08:28:15.547701',NULL),(8,'OXdih5AWpIVnbkyMJxECG7Py6WestZ',8,1,1,'2023-05-30 09:51:44.901208','2023-05-30 09:51:44.901208',NULL),(9,'csywGXN0HQKHOXvLQdltiU3MyrmbRl',9,1,1,'2023-05-30 09:54:01.425112','2023-05-30 09:54:01.425112',NULL),(10,'zRTYgdCGA9RVtIQZTpT7FLN7sleuZu',10,1,1,'2023-05-30 10:03:22.451441','2023-05-30 10:03:22.451441',NULL),(11,'ZRs2bbb7JOMs8XbkkSM3d6MB1BnDtC',11,1,1,'2023-06-02 11:51:16.084306','2023-06-02 11:51:16.084306',NULL),(12,'GBBEnDPyrrP0OEI5Gogu9s2CUVWO1Q',12,1,1,'2023-06-02 12:06:36.874931','2023-06-02 12:06:36.874931',NULL),(13,'OjKVuPzUOBBjIEFBKXpZoHuh3wd7t3',13,1,1,'2023-06-02 14:04:24.375362','2023-06-02 14:04:24.375362',NULL),(14,'MUrPu9192UVNMjiDUuosskcfpCEhdY',14,1,3,'2023-06-02 14:13:22.591076','2023-06-02 14:13:22.591076',NULL),(15,'BcHAfWXXpJ3WGKULp2hhSmPL3I0TGG',15,1,3,'2023-06-03 06:37:41.276395','2023-06-03 06:37:41.276395',NULL);
/*!40000 ALTER TABLE `oauth2_provider_refreshtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialaccount`
--

DROP TABLE IF EXISTS `socialaccount_socialaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialaccount` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider` varchar(30) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `uid` varchar(191) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `last_login` datetime(6) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `extra_data` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialaccount_provider_uid_fc810c6e_uniq` (`provider`,`uid`),
  KEY `socialaccount_socialaccount_user_id_8146e70c_fk_core_user_id` (`user_id`),
  CONSTRAINT `socialaccount_socialaccount_user_id_8146e70c_fk_core_user_id` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialaccount`
--

LOCK TABLES `socialaccount_socialaccount` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialaccount` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialaccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialapp`
--

DROP TABLE IF EXISTS `socialaccount_socialapp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialapp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider` varchar(30) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `client_id` varchar(191) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `secret` varchar(191) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `key` varchar(191) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialapp`
--

LOCK TABLES `socialaccount_socialapp` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialapp` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialapp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialapp_sites`
--

DROP TABLE IF EXISTS `socialaccount_socialapp_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialapp_sites` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `socialapp_id` int NOT NULL,
  `site_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialapp_sites_socialapp_id_site_id_71a9a768_uniq` (`socialapp_id`,`site_id`),
  KEY `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` (`site_id`),
  CONSTRAINT `socialaccount_social_socialapp_id_97fb6e7d_fk_socialacc` FOREIGN KEY (`socialapp_id`) REFERENCES `socialaccount_socialapp` (`id`),
  CONSTRAINT `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialapp_sites`
--

LOCK TABLES `socialaccount_socialapp_sites` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialapp_sites` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialapp_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialtoken`
--

DROP TABLE IF EXISTS `socialaccount_socialtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialtoken` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `token_secret` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `expires_at` datetime(6) DEFAULT NULL,
  `account_id` int NOT NULL,
  `app_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq` (`app_id`,`account_id`),
  KEY `socialaccount_social_account_id_951f210e_fk_socialacc` (`account_id`),
  CONSTRAINT `socialaccount_social_account_id_951f210e_fk_socialacc` FOREIGN KEY (`account_id`) REFERENCES `socialaccount_socialaccount` (`id`),
  CONSTRAINT `socialaccount_social_app_id_636a42d7_fk_socialacc` FOREIGN KEY (`app_id`) REFERENCES `socialaccount_socialapp` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialtoken`
--

LOCK TABLES `socialaccount_socialtoken` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialtoken` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-03 16:44:55
