-- MySQL dump 10.13  Distrib 8.0.19, for macos10.15 (x86_64)
--
-- Host: localhost    Database: flightProject
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `airport`
--

DROP TABLE IF EXISTS `airport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airport` (
  `airportID` varchar(3) NOT NULL,
  `city` varchar(30) NOT NULL,
  `state` varchar(35) NOT NULL,
  `name` varchar(50) NOT NULL,
  `hasPreCheck` tinyint(1) NOT NULL,
  `hasMobileBoarding` tinyint(1) NOT NULL,
  `numberOfTerminals` int NOT NULL,
  PRIMARY KEY (`airportID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airport`
--

LOCK TABLES `airport` WRITE;
/*!40000 ALTER TABLE `airport` DISABLE KEYS */;
INSERT INTO `airport` VALUES ('CID','Cedar Rapids','Iowa','Eastern Iowa',1,1,1),('LAX','Los Angeles','California','Los Angeles International',1,1,9),('ORD','Chicago','Illinois','OHare',1,1,4);
/*!40000 ALTER TABLE `airport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `bookingID` varchar(36) NOT NULL,
  `tripType` enum('oneWay','roundTrip') NOT NULL,
  `origin` enum('ORD','LAX','CID') NOT NULL,
  `destination` enum('ORD','LAX','CID') NOT NULL,
  `accompanyingNo` int NOT NULL,
  `bookingDate` date NOT NULL,
  `customer_id1` varchar(36) NOT NULL,
  PRIMARY KEY (`bookingID`),
  KEY `fk_customer_id1` (`customer_id1`),
  CONSTRAINT `fk_customer_id1` FOREIGN KEY (`customer_id1`) REFERENCES `customer` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `userID` varchar(36) NOT NULL,
  `firstName` varchar(20) NOT NULL,
  `lastName` varchar(30) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(25) NOT NULL,
  `points` int NOT NULL,
  `dateOfBirth` date NOT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('C01','Anthony','Farino','afarino','password123',0,'1999-08-23');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight` (
  `flightID` varchar(36) NOT NULL,
  `flightDate` date NOT NULL,
  `flightTime` time NOT NULL,
  `passengerNo` int NOT NULL,
  `plane_id` int NOT NULL,
  `origin_airport_id` varchar(3) NOT NULL,
  `destination_airport_id` varchar(3) NOT NULL,
  PRIMARY KEY (`flightID`),
  KEY `fk_plane_id` (`plane_id`),
  KEY `fk_origin_airport_id` (`origin_airport_id`),
  KEY `fk_destination_id` (`destination_airport_id`),
  CONSTRAINT `fk_destination_id` FOREIGN KEY (`destination_airport_id`) REFERENCES `airport` (`airportID`),
  CONSTRAINT `fk_origin_airport_id` FOREIGN KEY (`origin_airport_id`) REFERENCES `airport` (`airportID`),
  CONSTRAINT `fk_plane_id` FOREIGN KEY (`plane_id`) REFERENCES `plane` (`planeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight`
--

LOCK TABLES `flight` WRITE;
/*!40000 ALTER TABLE `flight` DISABLE KEYS */;
INSERT INTO `flight` VALUES ('F001','2020-04-20','04:20:00',0,3,'CID','ORD'),('F002','2020-04-21','04:21:00',0,1,'ORD','LAX'),('F003','2020-04-22','09:22:00',0,4,'CID','ORD'),('F004','2020-04-22','13:00:00',0,4,'CID','ORD');
/*!40000 ALTER TABLE `flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plane`
--

DROP TABLE IF EXISTS `plane`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plane` (
  `planeID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `class` enum('A','B','C','D','E') NOT NULL,
  `seatNo` int NOT NULL,
  `seatPitch` float NOT NULL,
  `seatWidth` float NOT NULL,
  `hasWifi` tinyint(1) NOT NULL,
  `hasEntertainment` tinyint(1) NOT NULL,
  `hasPower` tinyint(1) NOT NULL,
  PRIMARY KEY (`planeID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plane`
--

LOCK TABLES `plane` WRITE;
/*!40000 ALTER TABLE `plane` DISABLE KEYS */;
INSERT INTO `plane` VALUES (1,'Boeing 737-800','A',160,39.5,20.5,1,1,1),(2,'Boeing 757-200','B',176,31.5,16.6,1,1,0),(3,'Airbus A321','C',187,29.8,15.6,0,1,0),(4,'ERJ','D',100,31,16.5,0,1,0),(5,'CRJ','E',50,31,16.75,0,0,0);
/*!40000 ALTER TABLE `plane` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'flightProject'
--
/*!50003 DROP FUNCTION IF EXISTS `extract_schema_from_file_name` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`mysql.sys`@`localhost` FUNCTION `extract_schema_from_file_name`(
        path VARCHAR(512)
    ) RETURNS varchar(64) CHARSET utf8mb4
    NO SQL
    DETERMINISTIC
    SQL SECURITY INVOKER
    COMMENT '\nDescription\n-----------\n\nTakes a raw file path, and attempts to extract the schema name from it.\n\nUseful for when interacting with Performance Schema data \nconcerning IO statistics, for example.\n\nCurrently relies on the fact that a table data file will be within a \nspecified database directory (will not work with partitions or tables\nthat specify an individual DATA_DIRECTORY).\n\nParameters\n-----------\n\npath (VARCHAR(512)):\n  The full file path to a data file to extract the schema name from.\n\nReturns\n-----------\n\nVARCHAR(64)\n\nExample\n-----------\n\nmysql> SELECT sys.extract_schema_from_file_name(''/var/lib/mysql/employees/employee.ibd'');\n+----------------------------------------------------------------------------+\n| sys.extract_schema_from_file_name(''/var/lib/mysql/employees/employee.ibd'') |\n+----------------------------------------------------------------------------+\n| employees                                                                  |\n+----------------------------------------------------------------------------+\n1 row in set (0.00 sec)\n'
BEGIN
    RETURN LEFT(SUBSTRING_INDEX(SUBSTRING_INDEX(REPLACE(path, '\\', '/'), '/', -2), '/', 1), 64);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `extract_table_from_file_name` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`mysql.sys`@`localhost` FUNCTION `extract_table_from_file_name`(
        path VARCHAR(512)
    ) RETURNS varchar(64) CHARSET utf8mb4
    NO SQL
    DETERMINISTIC
    SQL SECURITY INVOKER
    COMMENT '\nDescription\n-----------\n\nTakes a raw file path, and extracts the table name from it.\n\nUseful for when interacting with Performance Schema data \nconcerning IO statistics, for example.\n\nParameters\n-----------\n\npath (VARCHAR(512)):\n  The full file path to a data file to extract the table name from.\n\nReturns\n-----------\n\nVARCHAR(64)\n\nExample\n-----------\n\nmysql> SELECT sys.extract_table_from_file_name(''/var/lib/mysql/employees/employee.ibd'');\n+---------------------------------------------------------------------------+\n| sys.extract_table_from_file_name(''/var/lib/mysql/employees/employee.ibd'') |\n+---------------------------------------------------------------------------+\n| employee                                                                  |\n+---------------------------------------------------------------------------+\n1 row in set (0.02 sec)\n'
BEGIN
    RETURN LEFT(SUBSTRING_INDEX(REPLACE(SUBSTRING_INDEX(REPLACE(path, '\\', '/'), '/', -1), '@0024', '$'), '.', 1), 64);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `format_bytes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`mysql.sys`@`localhost` FUNCTION `format_bytes`(
        -- We feed in and return TEXT here, as aggregates of
        -- bytes can return numbers larger than BIGINT UNSIGNED
        bytes TEXT
    ) RETURNS text CHARSET utf8mb4
    NO SQL
    DETERMINISTIC
    SQL SECURITY INVOKER
    COMMENT '\nDescription\n-----------\n\nTakes a raw bytes value, and converts it to a human readable format.\n\nParameters\n-----------\n\nbytes (TEXT):\n  A raw bytes value.\n\nReturns\n-----------\n\nTEXT\n\nExample\n-----------\n\nmysql> SELECT sys.format_bytes(2348723492723746) AS size;\n+----------+\n| size     |\n+----------+\n| 2.09 PiB |\n+----------+\n1 row in set (0.00 sec)\n\nmysql> SELECT sys.format_bytes(2348723492723) AS size;\n+----------+\n| size     |\n+----------+\n| 2.14 TiB |\n+----------+\n1 row in set (0.00 sec)\n\nmysql> SELECT sys.format_bytes(23487234) AS size;\n+-----------+\n| size      |\n+-----------+\n| 22.40 MiB |\n+-----------+\n1 row in set (0.00 sec)\n'
BEGIN
  IF (bytes IS NULL) THEN
    RETURN NULL;
  ELSE
    RETURN format_bytes(bytes);
  END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `format_path` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`mysql.sys`@`localhost` FUNCTION `format_path`(
        in_path VARCHAR(512)
    ) RETURNS varchar(512) CHARSET utf8mb4
    NO SQL
    DETERMINISTIC
    SQL SECURITY INVOKER
    COMMENT '\nDescription\n-----------\n\nTakes a raw path value, and strips out the datadir or tmpdir\nreplacing with @@datadir and @@tmpdir respectively.\n\nAlso normalizes the paths across operating systems, so backslashes\non Windows are converted to forward slashes\n\nParameters\n-----------\n\npath (VARCHAR(512)):\n  The raw file path value to format.\n\nReturns\n-----------\n\nVARCHAR(512) CHARSET UTF8MB4\n\nExample\n-----------\n\nmysql> select @@datadir;\n+-----------------------------------------------+\n| @@datadir                                     |\n+-----------------------------------------------+\n| /Users/mark/sandboxes/SmallTree/AMaster/data/ |\n+-----------------------------------------------+\n1 row in set (0.06 sec)\n\nmysql> select format_path(''/Users/mark/sandboxes/SmallTree/AMaster/data/mysql/proc.MYD'') AS path;\n+--------------------------+\n| path                     |\n+--------------------------+\n| @@datadir/mysql/proc.MYD |\n+--------------------------+\n1 row in set (0.03 sec)\n'
BEGIN
  DECLARE v_path VARCHAR(512);
  DECLARE v_undo_dir VARCHAR(1024);
  DECLARE path_separator CHAR(1) DEFAULT '/';
  IF @@global.version_compile_os LIKE 'win%' THEN
    SET path_separator = '\\';
  END IF;
  -- OSX hides /private/ in variables, but Performance Schema does not
  IF in_path LIKE '/private/%' THEN
    SET v_path = REPLACE(in_path, '/private', '');
  ELSE
    SET v_path = in_path;
  END IF;
  -- @@global.innodb_undo_directory is only set when separate undo logs are used
  SET v_undo_dir = IFNULL((SELECT VARIABLE_VALUE FROM performance_schema.global_variables WHERE VARIABLE_NAME = 'innodb_undo_directory'), '');
  IF v_path IS NULL THEN
    RETURN NULL;
  ELSEIF v_path LIKE CONCAT(@@global.datadir, IF(SUBSTRING(@@global.datadir, -1) = path_separator, '%', CONCAT(path_separator, '%'))) ESCAPE '|' THEN
    SET v_path = REPLACE(v_path, @@global.datadir, CONCAT('@@datadir', IF(SUBSTRING(@@global.datadir, -1) = path_separator, path_separator, '')));
  ELSEIF v_path LIKE CONCAT(@@global.tmpdir, IF(SUBSTRING(@@global.tmpdir, -1) = path_separator, '%', CONCAT(path_separator, '%'))) ESCAPE '|' THEN
    SET v_path = REPLACE(v_path, @@global.tmpdir, CONCAT('@@tmpdir', IF(SUBSTRING(@@global.tmpdir, -1) = path_separator, path_separator, '')));
  ELSEIF v_path LIKE CONCAT(@@global.slave_load_tmpdir, IF(SUBSTRING(@@global.slave_load_tmpdir, -1) = path_separator, '%', CONCAT(path_separator, '%'))) ESCAPE '|' THEN
    SET v_path = REPLACE(v_path, @@global.slave_load_tmpdir, CONCAT('@@slave_load_tmpdir', IF(SUBSTRING(@@global.slave_load_tmpdir, -1) = path_separator, path_separator, '')));
  ELSEIF v_path LIKE CONCAT(@@global.innodb_data_home_dir, IF(SUBSTRING(@@global.innodb_data_home_dir, -1) = path_separator, '%', CONCAT(path_separator, '%'))) ESCAPE '|' THEN
    SET v_path = REPLACE(v_path, @@global.innodb_data_home_dir, CONCAT('@@innodb_data_home_dir', IF(SUBSTRING(@@global.innodb_data_home_dir, -1) = path_separator, path_separator, '')));
  ELSEIF v_path LIKE CONCAT(@@global.innodb_log_group_home_dir, IF(SUBSTRING(@@global.innodb_log_group_home_dir, -1) = path_separator, '%', CONCAT(path_separator, '%'))) ESCAPE '|' THEN
    SET v_path = REPLACE(v_path, @@global.innodb_log_group_home_dir, CONCAT('@@innodb_log_group_home_dir', IF(SUBSTRING(@@global.innodb_log_group_home_dir, -1) = path_separator, path_separator, '')));
  ELSEIF v_path LIKE CONCAT(v_undo_dir, IF(SUBSTRING(v_undo_dir, -1) = path_separator, '%', CONCAT(path_separator, '%'))) ESCAPE '|' THEN
    SET v_path = REPLACE(v_path, v_undo_dir, CONCAT('@@innodb_undo_directory', IF(SUBSTRING(v_undo_dir, -1) = path_separator, path_separator, '')));
  ELSEIF v_path LIKE CONCAT(@@global.basedir, IF(SUBSTRING(@@global.basedir, -1) = path_separator, '%', CONCAT(path_separator, '%'))) ESCAPE '|' THEN
    SET v_path = REPLACE(v_path, @@global.basedir, CONCAT('@@basedir', IF(SUBSTRING(@@global.basedir, -1) = path_separator, path_separator, '')));
  END IF;
  RETURN v_path;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `format_statement` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`mysql.sys`@`localhost` FUNCTION `format_statement`(
        statement LONGTEXT
    ) RETURNS longtext CHARSET utf8mb4
    NO SQL
    DETERMINISTIC
    SQL SECURITY INVOKER
    COMMENT '\nDescription\n-----------\n\nFormats a normalized statement, truncating it if it is > 64 characters long by default.\n\nTo configure the length to truncate the statement to by default, update the `statement_truncate_len`\nvariable with `sys_config` table to a different value. Alternatively, to change it just for just \nyour particular session, use `SET @sys.statement_truncate_len := <some new value>`.\n\nUseful for printing statement related data from Performance Schema from \nthe command line.\n\nParameters\n-----------\n\nstatement (LONGTEXT): \n  The statement to format.\n\nReturns\n-----------\n\nLONGTEXT\n\nExample\n-----------\n\nmysql> SELECT sys.format_statement(digest_text)\n    ->   FROM performance_schema.events_statements_summary_by_digest\n    ->  ORDER by sum_timer_wait DESC limit 5;\n+-------------------------------------------------------------------+\n| sys.format_statement(digest_text)                                 |\n+-------------------------------------------------------------------+\n| CREATE SQL SECURITY INVOKER VI ... KE ? AND `variable_value` > ?  |\n| CREATE SQL SECURITY INVOKER VI ... ait` IS NOT NULL , `esc` . ... |\n| CREATE SQL SECURITY INVOKER VI ... ait` IS NOT NULL , `sys` . ... |\n| CREATE SQL SECURITY INVOKER VI ...  , `compressed_size` ) ) DESC  |\n| CREATE SQL SECURITY INVOKER VI ... LIKE ? ORDER BY `timer_start`  |\n+-------------------------------------------------------------------+\n5 rows in set (0.00 sec)\n'
BEGIN
  -- Check if we have the configured length, if not, init it
  IF @sys.statement_truncate_len IS NULL THEN
      SET @sys.statement_truncate_len = sys_get_config('statement_truncate_len', 64);
  END IF;
  IF CHAR_LENGTH(statement) > @sys.statement_truncate_len THEN
      RETURN REPLACE(CONCAT(LEFT(statement, (@sys.statement_truncate_len/2)-2), ' ... ', RIGHT(statement, (@sys.statement_truncate_len/2)-2)), '\n', ' ');
  ELSE 
      RETURN REPLACE(statement, '\n', ' ');
  END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `format_time` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`mysql.sys`@`localhost` FUNCTION `format_time`(
-- We feed in and return TEXT here, as aggregates of
-- picoseconds can return numbers larger than BIGINT UNSIGNED
        picoseconds TEXT
    ) RETURNS text CHARSET utf8mb4
    NO SQL
    DETERMINISTIC
    SQL SECURITY INVOKER
    COMMENT '\nDescription\n-----------\n\nTakes a raw picoseconds value, and converts it to a human readable form.\n\nPicoseconds are the precision that all latency values are printed in\nwithin Performance Schema, however are not user friendly when wanting\nto scan output from the command line.\n\nParameters\n-----------\n\npicoseconds (TEXT):\n  The raw picoseconds value to convert.\n\nReturns\n-----------\n\nTEXT CHARSET UTF8MB4\n\nExample\n-----------\n\nmysql> select format_time(342342342342345);\n+------------------------------+\n| format_time(342342342342345) |\n+------------------------------+\n| 00:05:42                     |\n+------------------------------+\n1 row in set (0.00 sec)\n\nmysql> select format_time(342342342);\n+------------------------+\n| format_time(342342342) |\n+------------------------+\n| 342.34 us              |\n+------------------------+\n1 row in set (0.00 sec)\n\nmysql> select format_time(34234);\n+--------------------+\n| format_time(34234) |\n+--------------------+\n| 34.23 ns           |\n+--------------------+\n1 row in set (0.00 sec)\n'
BEGIN
  IF picoseconds IS NULL THEN RETURN NULL;
  ELSEIF picoseconds >= 604800000000000000 THEN RETURN CONCAT(ROUND(picoseconds / 604800000000000000, 2), ' w');
  ELSEIF picoseconds >= 86400000000000000 THEN RETURN CONCAT(ROUND(picoseconds / 86400000000000000, 2), ' d');
  ELSEIF picoseconds >= 3600000000000000 THEN RETURN CONCAT(ROUND(picoseconds / 3600000000000000, 2), ' h');
  ELSEIF picoseconds >= 60000000000000 THEN RETURN CONCAT(ROUND(picoseconds / 60000000000000, 2), ' m');
  ELSEIF picoseconds >= 1000000000000 THEN RETURN CONCAT(ROUND(picoseconds / 1000000000000, 2), ' s');
  ELSEIF picoseconds >= 1000000000 THEN RETURN CONCAT(ROUND(picoseconds / 1000000000, 2), ' ms');
  ELSEIF picoseconds >= 1000000 THEN RETURN CONCAT(ROUND(picoseconds / 1000000, 2), ' us');
  ELSEIF picoseconds >= 1000 THEN RETURN CONCAT(ROUND(picoseconds / 1000, 2), ' ns');
  ELSE RETURN CONCAT(picoseconds, ' ps');
  END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `list_add` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`mysql.sys`@`localhost` FUNCTION `list_add`(
        in_list TEXT,
        in_add_value TEXT
    ) RETURNS text CHARSET utf8mb4
    DETERMINISTIC
    SQL SECURITY INVOKER
    COMMENT '\nDescription\n-----------\n\nTakes a list, and a value to add to the list, and returns the resulting list.\n\nUseful for altering certain session variables, like sql_mode or optimizer_switch for instance.\n\nParameters\n-----------\n\nin_list (TEXT):\n  The comma separated list to add a value to\n\nin_add_value (TEXT):\n  The value to add to the input list\n\nReturns\n-----------\n\nTEXT\n\nExample\n--------\n\nmysql> select @@sql_mode;\n+-----------------------------------------------------------------------------------+\n| @@sql_mode                                                                        |\n+-----------------------------------------------------------------------------------+\n| ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION |\n+-----------------------------------------------------------------------------------+\n1 row in set (0.00 sec)\n\nmysql> set sql_mode = sys.list_add(@@sql_mode, ''ANSI_QUOTES'');\nQuery OK, 0 rows affected (0.06 sec)\n\nmysql> select @@sql_mode;\n+-----------------------------------------------------------------------------------------------+\n| @@sql_mode                                                                                    |\n+-----------------------------------------------------------------------------------------------+\n| ANSI_QUOTES,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION |\n+-----------------------------------------------------------------------------------------------+\n1 row in set (0.00 sec)\n\n'
BEGIN
    IF (in_add_value IS NULL) THEN
        SIGNAL SQLSTATE '02200'
           SET MESSAGE_TEXT = 'Function sys.list_add: in_add_value input variable should not be NULL',
               MYSQL_ERRNO = 1138;
    END IF;
    IF (in_list IS NULL OR LENGTH(in_list) = 0) THEN
        -- return the new value as a single value list
        RETURN in_add_value;
    END IF;
    RETURN (SELECT CONCAT(TRIM(BOTH ',' FROM TRIM(in_list)), ',', in_add_value));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `list_drop` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`mysql.sys`@`localhost` FUNCTION `list_drop`(
        in_list TEXT,
        in_drop_value TEXT
    ) RETURNS text CHARSET utf8mb4
    DETERMINISTIC
    SQL SECURITY INVOKER
    COMMENT '\nDescription\n-----------\n\nTakes a list, and a value to attempt to remove from the list, and returns the resulting list.\n\nUseful for altering certain session variables, like sql_mode or optimizer_switch for instance.\n\nParameters\n-----------\n\nin_list (TEXT):\n  The comma separated list to drop a value from\n\nin_drop_value (TEXT):\n  The value to drop from the input list\n\nReturns\n-----------\n\nTEXT\n\nExample\n--------\n\nmysql> select @@sql_mode;\n+-----------------------------------------------------------------------------------------------+\n| @@sql_mode                                                                                    |\n+-----------------------------------------------------------------------------------------------+\n| ANSI_QUOTES,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION |\n+-----------------------------------------------------------------------------------------------+\n1 row in set (0.00 sec)\n\nmysql> set sql_mode = sys.list_drop(@@sql_mode, ''ONLY_FULL_GROUP_BY'');\nQuery OK, 0 rows affected (0.03 sec)\n\nmysql> select @@sql_mode;\n+----------------------------------------------------------------------------+\n| @@sql_mode                                                                 |\n+----------------------------------------------------------------------------+\n| ANSI_QUOTES,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION |\n+----------------------------------------------------------------------------+\n1 row in set (0.00 sec)\n\n'
BEGIN
    IF (in_drop_value IS NULL) THEN
        SIGNAL SQLSTATE '02200'
           SET MESSAGE_TEXT = 'Function sys.list_drop: in_drop_value input variable should not be NULL',
               MYSQL_ERRNO = 1138;
    END IF;
    IF (in_list IS NULL OR LENGTH(in_list) = 0) THEN
        -- return the list as it was passed in
        RETURN in_list;
    END IF;
    -- ensure that leading / trailing commas are remove, support values with either spaces or not between commas
    RETURN (SELECT TRIM(BOTH ',' FROM REPLACE(REPLACE(CONCAT(',', in_list), CONCAT(',', in_drop_value), ''), CONCAT(', ', in_drop_value), '')));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `ps_is_account_enabled` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`mysql.sys`@`localhost` FUNCTION `ps_is_account_enabled`(
        in_host VARCHAR(255), 
        in_user VARCHAR(32)
    ) RETURNS enum('YES','NO') CHARSET utf8mb4
    READS SQL DATA
    DETERMINISTIC
    SQL SECURITY INVOKER
    COMMENT '\nDescription\n-----------\n\nDetermines whether instrumentation of an account is enabled \nwithin Performance Schema.\n\nParameters\n-----------\n\nin_host VARCHAR(255): \n  The hostname of the account to check.\nin_user VARCHAR(32):\n  The username of the account to check.\n\nReturns\n-----------\n\nENUM(''YES'', ''NO'', ''PARTIAL'')\n\nExample\n-----------\n\nmysql> SELECT sys.ps_is_account_enabled(''localhost'', ''root'');\n+------------------------------------------------+\n| sys.ps_is_account_enabled(''localhost'', ''root'') |\n+------------------------------------------------+\n| YES                                            |\n+------------------------------------------------+\n1 row in set (0.01 sec)\n'
BEGIN
    RETURN IF(EXISTS(SELECT 1
                       FROM performance_schema.setup_actors
                      WHERE (`HOST` = '%' OR in_host LIKE `HOST`)
                        AND (`USER` = '%' OR `USER` = in_user)
                        AND (`ENABLED` = 'YES')
                    ),
              'YES', 'NO'
           );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `ps_is_consumer_enabled` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`mysql.sys`@`localhost` FUNCTION `ps_is_consumer_enabled`(
        in_consumer varchar(64)
   ) RETURNS enum('YES','NO') CHARSET utf8mb4
    READS SQL DATA
    DETERMINISTIC
    SQL SECURITY INVOKER
    COMMENT '\nDescription\n-----------\n\nDetermines whether a consumer is enabled (taking the consumer hierarchy into consideration)\nwithin the Performance Schema.\n\nAn exception with errno 3047 is thrown if an unknown consumer name is passed to the function.\nA consumer name of NULL returns NULL.\n\nParameters\n-----------\n\nin_consumer VARCHAR(64): \n  The name of the consumer to check.\n\nReturns\n-----------\n\nENUM(''YES'', ''NO'')\n\nExample\n-----------\n\nmysql> SELECT sys.ps_is_consumer_enabled(''events_stages_history'');\n+-----------------------------------------------------+\n| sys.ps_is_consumer_enabled(''events_stages_history'') |\n+-----------------------------------------------------+\n| NO                                                  |\n+-----------------------------------------------------+\n1 row in set (0.00 sec)\n'
BEGIN
    DECLARE v_is_enabled ENUM('YES', 'NO') DEFAULT NULL;
    DECLARE v_error_msg VARCHAR(128);
    -- Return NULL for a NULL argument.
    IF (in_consumer IS NULL) THEN
        RETURN NULL;
    END IF;
    SET v_is_enabled = (
        SELECT (CASE
                   WHEN c.NAME = 'global_instrumentation' THEN c.ENABLED
                   WHEN c.NAME = 'thread_instrumentation' THEN IF(cg.ENABLED = 'YES' AND c.ENABLED = 'YES', 'YES', 'NO')
                   WHEN c.NAME LIKE '%\_digest'           THEN IF(cg.ENABLED = 'YES' AND c.ENABLED = 'YES', 'YES', 'NO')
                   WHEN c.NAME LIKE '%\_current'          THEN IF(cg.ENABLED = 'YES' AND ct.ENABLED = 'YES' AND c.ENABLED = 'YES', 'YES', 'NO')
                   ELSE IF(cg.ENABLED = 'YES' AND ct.ENABLED = 'YES' AND c.ENABLED = 'YES'
                           AND ( SELECT cc.ENABLED FROM performance_schema.setup_consumers cc WHERE NAME = CONCAT(SUBSTRING_INDEX(c.NAME, '_', 2), '_current')
                               ) = 'YES', 'YES', 'NO')
                END) AS IsEnabled
          FROM performance_schema.setup_consumers c
               INNER JOIN performance_schema.setup_consumers cg
               INNER JOIN performance_schema.setup_consumers ct
         WHERE cg.NAME       = 'global_instrumentation'
               AND ct.NAME   = 'thread_instrumentation'
               AND c.NAME    = in_consumer
        );
    IF (v_is_enabled IS NOT NULL) THEN
        RETURN v_is_enabled;
    ELSE
        -- A value of NULL here means it is an unknown consumer name that was passed as an argument.
        -- Only an input value of NULL is allowed to return a NULL result value, to throw a signal instead.
        SET v_error_msg = CONCAT('Invalid argument error: ', in_consumer, ' in function sys.ps_is_consumer_enabled.');
        SIGNAL SQLSTATE 'HY000'
           SET MESSAGE_TEXT = v_error_msg,
               MYSQL_ERRNO  = 3047;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `ps_is_instrument_default_enabled` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`mysql.sys`@`localhost` FUNCTION `ps_is_instrument_default_enabled`(
        in_instrument VARCHAR(128)
    ) RETURNS enum('YES','NO') CHARSET utf8mb4
    READS SQL DATA
    DETERMINISTIC
    SQL SECURITY INVOKER
    COMMENT '\nDescription\n-----------\n\nReturns whether an instrument is enabled by default in this version of MySQL.\n\nParameters\n-----------\n\nin_instrument VARCHAR(128): \n  The instrument to check.\n\nReturns\n-----------\n\nENUM(''YES'', ''NO'')\n\nExample\n-----------\n\nmysql> SELECT sys.ps_is_instrument_default_enabled(''statement/sql/select'');\n+--------------------------------------------------------------+\n| sys.ps_is_instrument_default_enabled(''statement/sql/select'') |\n+--------------------------------------------------------------+\n| YES                                                          |\n+--------------------------------------------------------------+\n1 row in set (0.00 sec)\n'
BEGIN
    DECLARE v_enabled ENUM('YES', 'NO');
    -- Currently the same in all versions
    SET v_enabled = IF(in_instrument LIKE 'wait/io/file/%'
                        OR in_instrument LIKE 'wait/io/table/%'
                        OR in_instrument LIKE 'statement/%'
                        OR in_instrument LIKE 'memory/performance_schema/%'
                        OR in_instrument IN ('wait/lock/table/sql/handler', 'idle')
               
                        OR in_instrument LIKE 'stage/innodb/%'
                        OR in_instrument = 'stage/sql/copy to tmp table'
               
                      ,
                       'YES',
                       'NO'
                    );
    RETURN v_enabled;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `ps_is_instrument_default_timed` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`mysql.sys`@`localhost` FUNCTION `ps_is_instrument_default_timed`(
        in_instrument VARCHAR(128)
    ) RETURNS enum('YES','NO') CHARSET utf8mb4
    READS SQL DATA
    DETERMINISTIC
    SQL SECURITY INVOKER
    COMMENT '\nDescription\n-----------\n\nReturns whether an instrument is timed by default in this version of MySQL.\n\nParameters\n-----------\n\nin_instrument VARCHAR(128): \n  The instrument to check.\n\nReturns\n-----------\n\nENUM(''YES'', ''NO'')\n\nExample\n-----------\n\nmysql> SELECT sys.ps_is_instrument_default_timed(''statement/sql/select'');\n+------------------------------------------------------------+\n| sys.ps_is_instrument_default_timed(''statement/sql/select'') |\n+------------------------------------------------------------+\n| YES                                                        |\n+------------------------------------------------------------+\n1 row in set (0.00 sec)\n'
BEGIN
    DECLARE v_timed ENUM('YES', 'NO');
    -- Currently the same in all versions
    SET v_timed = IF(in_instrument LIKE 'wait/io/file/%'
                        OR in_instrument LIKE 'wait/io/table/%'
                        OR in_instrument LIKE 'statement/%'
                        OR in_instrument IN ('wait/lock/table/sql/handler', 'idle')
               
                        OR in_instrument LIKE 'stage/innodb/%'
                        OR in_instrument = 'stage/sql/copy to tmp table'
               
                      ,
                       'YES',
                       'NO'
                    );
    RETURN v_timed;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `ps_is_thread_instrumented` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`mysql.sys`@`localhost` FUNCTION `ps_is_thread_instrumented`(
        in_connection_id BIGINT UNSIGNED
    ) RETURNS enum('YES','NO','UNKNOWN') CHARSET utf8mb4
    READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT '\nDescription\n-----------\n\nChecks whether the provided connection id is instrumented within Performance Schema.\n\nParameters\n-----------\n\nin_connection_id (BIGINT UNSIGNED):\n  The id of the connection to check.\n\nReturns\n-----------\n\nENUM(''YES'', ''NO'', ''UNKNOWN'')\n\nExample\n-----------\n\nmysql> SELECT sys.ps_is_thread_instrumented(CONNECTION_ID());\n+------------------------------------------------+\n| sys.ps_is_thread_instrumented(CONNECTION_ID()) |\n+------------------------------------------------+\n| YES                                            |\n+------------------------------------------------+\n'
BEGIN
    DECLARE v_enabled ENUM('YES', 'NO', 'UNKNOWN');
    IF (in_connection_id IS NULL) THEN
        RETURN NULL;
    END IF;
    SELECT INSTRUMENTED INTO v_enabled
      FROM performance_schema.threads 
     WHERE PROCESSLIST_ID = in_connection_id;
    IF (v_enabled IS NULL) THEN
        RETURN 'UNKNOWN';
    ELSE
        RETURN v_enabled;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `ps_thread_account` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`mysql.sys`@`localhost` FUNCTION `ps_thread_account`(
        in_thread_id BIGINT UNSIGNED
    ) RETURNS text CHARSET utf8mb4
    READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT '\nDescription\n-----------\n\nReturn the user@host account for the given Performance Schema thread id.\n\nParameters\n-----------\n\nin_thread_id (BIGINT UNSIGNED):\n  The id of the thread to return the account for.\n\nExample\n-----------\n\nmysql> select thread_id, processlist_user, processlist_host from performance_schema.threads where type = ''foreground'';\n+-----------+------------------+------------------+\n| thread_id | processlist_user | processlist_host |\n+-----------+------------------+------------------+\n|        23 | NULL             | NULL             |\n|        30 | root             | localhost        |\n|        31 | msandbox         | localhost        |\n|        32 | msandbox         | localhost        |\n+-----------+------------------+------------------+\n4 rows in set (0.00 sec)\n\nmysql> select sys.ps_thread_account(31);\n+---------------------------+\n| sys.ps_thread_account(31) |\n+---------------------------+\n| msandbox@localhost        |\n+---------------------------+\n1 row in set (0.00 sec)\n'
BEGIN
    RETURN (SELECT IF(
                      type = 'FOREGROUND',
                      CONCAT(processlist_user, '@', processlist_host),
                      type
                     ) AS account
              FROM `performance_schema`.`threads`
             WHERE thread_id = in_thread_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `ps_thread_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`mysql.sys`@`localhost` FUNCTION `ps_thread_id`(
        in_connection_id BIGINT UNSIGNED
    ) RETURNS bigint unsigned
    READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT '\nDescription\n-----------\n\nReturn the Performance Schema THREAD_ID for the specified connection ID.\n\nParameters\n-----------\n\nin_connection_id (BIGINT UNSIGNED):\n  The id of the connection to return the thread id for. If NULL, the current\n  connection thread id is returned.\n\nExample\n-----------\n\nmysql> SELECT sys.ps_thread_id(79);\n+----------------------+\n| sys.ps_thread_id(79) |\n+----------------------+\n|                   98 |\n+----------------------+\n1 row in set (0.00 sec)\n\nmysql> SELECT sys.ps_thread_id(CONNECTION_ID());\n+-----------------------------------+\n| sys.ps_thread_id(CONNECTION_ID()) |\n+-----------------------------------+\n|                                98 |\n+-----------------------------------+\n1 row in set (0.00 sec)\n'
BEGIN
  IF (in_connection_id IS NULL) THEN
    RETURN ps_current_thread_id();
  ELSE
    RETURN ps_thread_id(in_connection_id);
  END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `ps_thread_stack` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`mysql.sys`@`localhost` FUNCTION `ps_thread_stack`(
        thd_id BIGINT UNSIGNED,
        debug BOOLEAN
    ) RETURNS longtext CHARSET latin1
    READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT '\nDescription\n-----------\n\nOutputs a JSON formatted stack of all statements, stages and events\nwithin Performance Schema for the specified thread.\n\nParameters\n-----------\n\nthd_id (BIGINT UNSIGNED):\n  The id of the thread to trace. This should match the thread_id\n  column from the performance_schema.threads table.\nin_verbose (BOOLEAN):\n  Include file:lineno information in the events.\n\nExample\n-----------\n\n(line separation added for output)\n\nmysql> SELECT sys.ps_thread_stack(37, FALSE) AS thread_stack\\G\n*************************** 1. row ***************************\nthread_stack: {"rankdir": "LR","nodesep": "0.10","stack_created": "2014-02-19 13:39:03",\n"mysql_version": "5.7.3-m13","mysql_user": "root@localhost","events": \n[{"nesting_event_id": "0", "event_id": "10", "timer_wait": 256.35, "event_info": \n"sql/select", "wait_info": "select @@version_comment limit 1\\nerrors: 0\\nwarnings: 0\\nlock time:\n...\n'
BEGIN
    DECLARE json_objects LONGTEXT;
    
    -- Do not track the current thread, it will kill the stack
    UPDATE performance_schema.threads
       SET instrumented = 'NO'
     WHERE processlist_id = CONNECTION_ID();
    
    SET SESSION group_concat_max_len=@@global.max_allowed_packet;
    -- Select the entire stack of events
    SELECT GROUP_CONCAT(CONCAT( '{'
              , CONCAT_WS( ', '
              , CONCAT('"nesting_event_id": "', IF(nesting_event_id IS NULL, '0', nesting_event_id), '"')
              , CONCAT('"event_id": "', event_id, '"')
              -- Convert from picoseconds to microseconds
              , CONCAT( '"timer_wait": ', ROUND(timer_wait/1000000, 2))  
              , CONCAT( '"event_info": "'
                  , CASE
                        WHEN event_name NOT LIKE 'wait/io%' THEN REPLACE(SUBSTRING_INDEX(event_name, '/', -2), '\\', '\\\\')
                        WHEN event_name NOT LIKE 'wait/io/file%' OR event_name NOT LIKE 'wait/io/socket%' THEN REPLACE(SUBSTRING_INDEX(event_name, '/', -4), '\\', '\\\\')
                        ELSE event_name
                    END
                  , '"'
              )
              -- Always dump the extra wait information gathered for statements
              , CONCAT( '"wait_info": "', IFNULL(wait_info, ''), '"')
              -- If debug is enabled, add the file:lineno information for waits
              , CONCAT( '"source": "', IF(true AND event_name LIKE 'wait%', IFNULL(wait_info, ''), ''), '"')
              -- Depending on the type of event, name it appropriately
              , CASE 
                     WHEN event_name LIKE 'wait/io/file%'      THEN '"event_type": "io/file"'
                     WHEN event_name LIKE 'wait/io/table%'     THEN '"event_type": "io/table"'
                     WHEN event_name LIKE 'wait/io/socket%'    THEN '"event_type": "io/socket"'
                     WHEN event_name LIKE 'wait/synch/mutex%'  THEN '"event_type": "synch/mutex"'
                     WHEN event_name LIKE 'wait/synch/cond%'   THEN '"event_type": "synch/cond"'
                     WHEN event_name LIKE 'wait/synch/rwlock%' THEN '"event_type": "synch/rwlock"'
                     WHEN event_name LIKE 'wait/lock%'         THEN '"event_type": "lock"'
                     WHEN event_name LIKE 'statement/%'        THEN '"event_type": "stmt"'
                     WHEN event_name LIKE 'stage/%'            THEN '"event_type": "stage"'
                     WHEN event_name LIKE '%idle%'             THEN '"event_type": "idle"'
                     ELSE '' 
                END                   
            )
            , '}'
          )
          ORDER BY event_id ASC SEPARATOR ',') event
    INTO json_objects
    FROM (
          
          -- Select all statements, with the extra tracing information available
          (SELECT thread_id, event_id, event_name, timer_wait, timer_start, nesting_event_id, 
                  CONCAT(sql_text, '\\n',
                         'errors: ', errors, '\\n',
                         'warnings: ', warnings, '\\n',
                         'lock time: ', ROUND(lock_time/1000000, 2),'us\\n',
                         'rows affected: ', rows_affected, '\\n',
                         'rows sent: ', rows_sent, '\\n',
                         'rows examined: ', rows_examined, '\\n',
                         'tmp tables: ', created_tmp_tables, '\\n',
                         'tmp disk tables: ', created_tmp_disk_tables, '\\n',
                         'select scan: ', select_scan, '\\n',
                         'select full join: ', select_full_join, '\\n',
                         'select full range join: ', select_full_range_join, '\\n',
                         'select range: ', select_range, '\\n',
                         'select range check: ', select_range_check, '\\n', 
                         'sort merge passes: ', sort_merge_passes, '\\n',
                         'sort rows: ', sort_rows, '\\n',
                         'sort range: ', sort_range, '\\n',
                         'sort scan: ', sort_scan, '\\n',
                         'no index used: ', IF(no_index_used, 'TRUE', 'FALSE'), '\\n',
                         'no good index used: ', IF(no_good_index_used, 'TRUE', 'FALSE'), '\\n'
                         ) AS wait_info
             FROM performance_schema.events_statements_history_long WHERE thread_id = thd_id)
          UNION 
          -- Select all stages
          (SELECT thread_id, event_id, event_name, timer_wait, timer_start, nesting_event_id, null AS wait_info
             FROM performance_schema.events_stages_history_long WHERE thread_id = thd_id) 
          UNION 
          -- Select all events, adding information appropriate to the event
          (SELECT thread_id, event_id, 
                  CONCAT(event_name , 
                         IF(event_name NOT LIKE 'wait/synch/mutex%', IFNULL(CONCAT(' - ', operation), ''), ''), 
                         IF(number_of_bytes IS NOT NULL, CONCAT(' ', number_of_bytes, ' bytes'), ''),
                         IF(event_name LIKE 'wait/io/file%', '\\n', ''),
                         IF(object_schema IS NOT NULL, CONCAT('\\nObject: ', object_schema, '.'), ''), 
                         IF(object_name IS NOT NULL, 
                            IF (event_name LIKE 'wait/io/socket%',
                                -- Print the socket if used, else the IP:port as reported
                                CONCAT(IF (object_name LIKE ':0%', @@socket, object_name)),
                                object_name),
                            ''),
                          IF(index_name IS NOT NULL, CONCAT(' Index: ', index_name), ''), '\\n'
                         ) AS event_name,
                  timer_wait, timer_start, nesting_event_id, source AS wait_info
             FROM performance_schema.events_waits_history_long WHERE thread_id = thd_id)) events 
    ORDER BY event_id;
    RETURN CONCAT('{', 
                  CONCAT_WS(',', 
                            '"rankdir": "LR"',
                            '"nodesep": "0.10"',
                            CONCAT('"stack_created": "', NOW(), '"'),
                            CONCAT('"mysql_version": "', VERSION(), '"'),
                            CONCAT('"mysql_user": "', CURRENT_USER(), '"'),
                            CONCAT('"events": [', IFNULL(json_objects,''), ']')
                           ),
                  '}');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `ps_thread_trx_info` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`mysql.sys`@`localhost` FUNCTION `ps_thread_trx_info`(
        in_thread_id BIGINT UNSIGNED
    ) RETURNS longtext CHARSET utf8mb4
    READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT '\nDescription\n-----------\n\nReturns a JSON object with info on the given threads current transaction, \nand the statements it has already executed, derived from the\nperformance_schema.events_transactions_current and\nperformance_schema.events_statements_history tables (so the consumers \nfor these also have to be enabled within Performance Schema to get full\ndata in the object).\n\nWhen the output exceeds the default truncation length (65535), a JSON error\nobject is returned, such as:\n\n{ "error": "Trx info truncated: Row 6 was cut by GROUP_CONCAT()" }\n\nSimilar error objects are returned for other warnings/and exceptions raised\nwhen calling the function.\n\nThe max length of the output of this function can be controlled with the\nps_thread_trx_info.max_length variable set via sys_config, or the\n@sys.ps_thread_trx_info.max_length user variable, as appropriate.\n\nParameters\n-----------\n\nin_thread_id (BIGINT UNSIGNED):\n  The id of the thread to return the transaction info for.\n\nExample\n-----------\n\nSELECT sys.ps_thread_trx_info(48)\\G\n*************************** 1. row ***************************\nsys.ps_thread_trx_info(48): [\n  {\n    "time": "790.70 us",\n    "state": "COMMITTED",\n    "mode": "READ WRITE",\n    "autocommitted": "NO",\n    "gtid": "AUTOMATIC",\n    "isolation": "REPEATABLE READ",\n    "statements_executed": [\n      {\n        "sql_text": "INSERT INTO info VALUES (1, ''foo'')",\n        "time": "471.02 us",\n        "schema": "trx",\n        "rows_examined": 0,\n        "rows_affected": 1,\n        "rows_sent": 0,\n        "tmp_tables": 0,\n        "tmp_disk_tables": 0,\n        "sort_rows": 0,\n        "sort_merge_passes": 0\n      },\n      {\n        "sql_text": "COMMIT",\n        "time": "254.42 us",\n        "schema": "trx",\n        "rows_examined": 0,\n        "rows_affected": 0,\n        "rows_sent": 0,\n        "tmp_tables": 0,\n        "tmp_disk_tables": 0,\n        "sort_rows": 0,\n        "sort_merge_passes": 0\n      }\n    ]\n  },\n  {\n    "time": "426.20 us",\n    "state": "COMMITTED",\n    "mode": "READ WRITE",\n    "autocommitted": "NO",\n    "gtid": "AUTOMATIC",\n    "isolation": "REPEATABLE READ",\n    "statements_executed": [\n      {\n        "sql_text": "INSERT INTO info VALUES (2, ''bar'')",\n        "time": "107.33 us",\n        "schema": "trx",\n        "rows_examined": 0,\n        "rows_affected": 1,\n        "rows_sent": 0,\n        "tmp_tables": 0,\n        "tmp_disk_tables": 0,\n        "sort_rows": 0,\n        "sort_merge_passes": 0\n      },\n      {\n        "sql_text": "COMMIT",\n        "time": "213.23 us",\n        "schema": "trx",\n        "rows_examined": 0,\n        "rows_affected": 0,\n        "rows_sent": 0,\n        "tmp_tables": 0,\n        "tmp_disk_tables": 0,\n        "sort_rows": 0,\n        "sort_merge_passes": 0\n      }\n    ]\n  }\n]\n1 row in set (0.03 sec)\n'
BEGIN
    DECLARE v_output LONGTEXT DEFAULT '{}';
    DECLARE v_msg_text TEXT DEFAULT '';
    DECLARE v_signal_msg TEXT DEFAULT '';
    DECLARE v_mysql_errno INT;
    DECLARE v_max_output_len BIGINT;
    -- Capture warnings/errors such as group_concat truncation
    -- and report as JSON error objects
    DECLARE EXIT HANDLER FOR SQLWARNING, SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_msg_text = MESSAGE_TEXT,
            v_mysql_errno = MYSQL_ERRNO;
        IF v_mysql_errno = 1260 THEN
            SET v_signal_msg = CONCAT('{ "error": "Trx info truncated: ', v_msg_text, '" }');
        ELSE
            SET v_signal_msg = CONCAT('{ "error": "', v_msg_text, '" }');
        END IF;
        RETURN v_signal_msg;
    END;
    -- Set configuration options
    IF (@sys.ps_thread_trx_info.max_length IS NULL) THEN
        SET @sys.ps_thread_trx_info.max_length = sys.sys_get_config('ps_thread_trx_info.max_length', 65535);
    END IF;
    IF (@sys.ps_thread_trx_info.max_length != @@session.group_concat_max_len) THEN
        SET @old_group_concat_max_len = @@session.group_concat_max_len;
        -- Convert to int value for the SET, and give some surrounding space
        SET v_max_output_len = (@sys.ps_thread_trx_info.max_length - 5);
        SET SESSION group_concat_max_len = v_max_output_len;
    END IF;
    SET v_output = (
        SELECT CONCAT('[', IFNULL(GROUP_CONCAT(trx_info ORDER BY event_id), ''), '\n]') AS trx_info
          FROM (SELECT trxi.thread_id, 
                       trxi.event_id,
                       GROUP_CONCAT(
                         IFNULL(
                           CONCAT('\n  {\n',
                                  '    "time": "', IFNULL(format_pico_time(trxi.timer_wait), ''), '",\n',
                                  '    "state": "', IFNULL(trxi.state, ''), '",\n',
                                  '    "mode": "', IFNULL(trxi.access_mode, ''), '",\n',
                                  '    "autocommitted": "', IFNULL(trxi.autocommit, ''), '",\n',
                                  '    "gtid": "', IFNULL(trxi.gtid, ''), '",\n',
                                  '    "isolation": "', IFNULL(trxi.isolation_level, ''), '",\n',
                                  '    "statements_executed": [', IFNULL(s.stmts, ''), IF(s.stmts IS NULL, ' ]\n', '\n    ]\n'),
                                  '  }'
                           ), 
                           '') 
                         ORDER BY event_id) AS trx_info
                  FROM (
                        (SELECT thread_id, event_id, timer_wait, state,access_mode, autocommit, gtid, isolation_level
                           FROM performance_schema.events_transactions_current
                          WHERE thread_id = in_thread_id
                            AND end_event_id IS NULL)
                        UNION
                        (SELECT thread_id, event_id, timer_wait, state,access_mode, autocommit, gtid, isolation_level
                           FROM performance_schema.events_transactions_history
                          WHERE thread_id = in_thread_id)
                       ) AS trxi
                  LEFT JOIN (SELECT thread_id,
                                    nesting_event_id,
                                    GROUP_CONCAT(
                                      IFNULL(
                                        CONCAT('\n      {\n',
                                               '        "sql_text": "', IFNULL(sys.format_statement(REPLACE(sql_text, '\\', '\\\\')), ''), '",\n',
                                               '        "time": "', IFNULL(format_pico_time(timer_wait), ''), '",\n',
                                               '        "schema": "', IFNULL(current_schema, ''), '",\n',
                                               '        "rows_examined": ', IFNULL(rows_examined, ''), ',\n',
                                               '        "rows_affected": ', IFNULL(rows_affected, ''), ',\n',
                                               '        "rows_sent": ', IFNULL(rows_sent, ''), ',\n',
                                               '        "tmp_tables": ', IFNULL(created_tmp_tables, ''), ',\n',
                                               '        "tmp_disk_tables": ', IFNULL(created_tmp_disk_tables, ''), ',\n',
                                               '        "sort_rows": ', IFNULL(sort_rows, ''), ',\n',
                                               '        "sort_merge_passes": ', IFNULL(sort_merge_passes, ''), '\n',
                                               '      }'), '') ORDER BY event_id) AS stmts
                               FROM performance_schema.events_statements_history
                              WHERE sql_text IS NOT NULL
                                AND thread_id = in_thread_id
                              GROUP BY thread_id, nesting_event_id
                            ) AS s 
                    ON trxi.thread_id = s.thread_id 
                   AND trxi.event_id = s.nesting_event_id
                 WHERE trxi.thread_id = in_thread_id
                 GROUP BY trxi.thread_id, trxi.event_id
                ) trxs
          GROUP BY thread_id
    );
    IF (@old_group_concat_max_len IS NOT NULL) THEN
        SET SESSION group_concat_max_len = @old_group_concat_max_len;
    END IF;
    RETURN v_output;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `quote_identifier` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`mysql.sys`@`localhost` FUNCTION `quote_identifier`(in_identifier TEXT) RETURNS text CHARSET utf8mb4
    NO SQL
    DETERMINISTIC
    SQL SECURITY INVOKER
    COMMENT '\nDescription\n-----------\n\nTakes an unquoted identifier (schema name, table name, etc.) and\nreturns the identifier quoted with backticks.\n\nParameters\n-----------\n\nin_identifier (TEXT):\n  The identifier to quote.\n\nReturns\n-----------\n\nTEXT CHARSET UTF8MB4\n\nExample\n-----------\n\nmysql> SELECT sys.quote_identifier(''my_identifier'') AS Identifier;\n+-----------------+\n| Identifier      |\n+-----------------+\n| `my_identifier` |\n+-----------------+\n1 row in set (0.00 sec)\n\nmysql> SELECT sys.quote_identifier(''my`idenfier'') AS Identifier;\n+----------------+\n| Identifier     |\n+----------------+\n| `my``idenfier` |\n+----------------+\n1 row in set (0.00 sec)\n'
BEGIN
    RETURN CONCAT('`', REPLACE(in_identifier, '`', '``'), '`');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `sys_get_config` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`mysql.sys`@`localhost` FUNCTION `sys_get_config`(
        in_variable_name VARCHAR(128),
        in_default_value VARCHAR(128)
    ) RETURNS varchar(128) CHARSET utf8mb4
    READS SQL DATA
    DETERMINISTIC
    SQL SECURITY INVOKER
    COMMENT '\nDescription\n-----------\n\nReturns the value for the requested variable using the following logic:\n\n   1. If the option exists in sys.sys_config return the value from there.\n   2. Else fall back on the provided default value.\n\nNotes for using sys_get_config():\n\n   * If the default value argument to sys_get_config() is NULL and case 2. is reached, NULL is returned.\n     It is then expected that the caller is able to handle NULL for the given configuration option.\n   * The convention is to name the user variables @sys.<name of variable>. It is <name of variable> that\n     is stored in the sys_config table and is what is expected as the argument to sys_get_config().\n   * If you want to check whether the configuration option has already been set and if not assign with\n     the return value of sys_get_config() you can use IFNULL(...) (see example below). However this should\n     not be done inside a loop (e.g. for each row in a result set) as for repeated calls where assignment\n     is only needed in the first iteration using IFNULL(...) is expected to be significantly slower than\n     using an IF (...) THEN ... END IF; block (see example below).\n\nParameters\n-----------\n\nin_variable_name (VARCHAR(128)):\n  The name of the config option to return the value for.\n\nin_default_value (VARCHAR(128)):\n  The default value to return if the variable does not exist in sys.sys_config.\n\nReturns\n-----------\n\nVARCHAR(128)\n\nExample\n-----------\n\n-- Get the configuration value from sys.sys_config falling back on 128 if the option is not present in the table.\nmysql> SELECT sys.sys_get_config(''statement_truncate_len'', 128) AS Value;\n+-------+\n| Value |\n+-------+\n| 64    |\n+-------+\n1 row in set (0.00 sec)\n\n-- Check whether the option is already set, if not assign - IFNULL(...) one liner example.\nmysql> SET @sys.statement_truncate_len = IFNULL(@sys.statement_truncate_len, sys.sys_get_config(''statement_truncate_len'', 64));\nQuery OK, 0 rows affected (0.00 sec)\n\n-- Check whether the option is already set, if not assign - IF ... THEN ... END IF example.\nIF (@sys.statement_truncate_len IS NULL) THEN\n    SET @sys.statement_truncate_len = sys.sys_get_config(''statement_truncate_len'', 64);\nEND IF;\n'
BEGIN
    DECLARE v_value VARCHAR(128) DEFAULT NULL;
    -- Check if we have the variable in the sys.sys_config table
    SET v_value = (SELECT value FROM sys.sys_config WHERE variable = in_variable_name);
    -- Protection against the variable not existing in sys_config
    IF (v_value IS NULL) THEN
        SET v_value = in_default_value;
    END IF;
    RETURN v_value;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `version_major` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`mysql.sys`@`localhost` FUNCTION `version_major`() RETURNS tinyint unsigned
    NO SQL
    SQL SECURITY INVOKER
    COMMENT '\nDescription\n-----------\n\nReturns the major version of MySQL Server.\n\nReturns\n-----------\n\nTINYINT UNSIGNED\n\nExample\n-----------\n\nmysql> SELECT VERSION(), sys.version_major();\n+--------------------------------------+---------------------+\n| VERSION()                            | sys.version_major() |\n+--------------------------------------+---------------------+\n| 5.7.9-enterprise-commercial-advanced | 5                   |\n+--------------------------------------+---------------------+\n1 row in set (0.00 sec)\n'
BEGIN
    RETURN SUBSTRING_INDEX(SUBSTRING_INDEX(VERSION(), '-', 1), '.', 1);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `version_minor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`mysql.sys`@`localhost` FUNCTION `version_minor`() RETURNS tinyint unsigned
    NO SQL
    SQL SECURITY INVOKER
    COMMENT '\nDescription\n-----------\n\nReturns the minor (release series) version of MySQL Server.\n\nReturns\n-----------\n\nTINYINT UNSIGNED\n\nExample\n-----------\n\nmysql> SELECT VERSION(), sys.server_minor();\n+--------------------------------------+---------------------+\n| VERSION()                            | sys.version_minor() |\n+--------------------------------------+---------------------+\n| 5.7.9-enterprise-commercial-advanced | 7                   |\n+--------------------------------------+---------------------+\n1 row in set (0.00 sec)\n'
BEGIN
    RETURN SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(VERSION(), '-', 1), '.', 2), '.', -1);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `version_patch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`mysql.sys`@`localhost` FUNCTION `version_patch`() RETURNS tinyint unsigned
    NO SQL
    SQL SECURITY INVOKER
    COMMENT '\nDescription\n-----------\n\nReturns the patch release version of MySQL Server.\n\nReturns\n-----------\n\nTINYINT UNSIGNED\n\nExample\n-----------\n\nmysql> SELECT VERSION(), sys.version_patch();\n+--------------------------------------+---------------------+\n| VERSION()                            | sys.version_patch() |\n+--------------------------------------+---------------------+\n| 5.7.9-enterprise-commercial-advanced | 9                   |\n+--------------------------------------+---------------------+\n1 row in set (0.00 sec)\n'
BEGIN
    RETURN SUBSTRING_INDEX(SUBSTRING_INDEX(VERSION(), '-', 1), '.', -1);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addOneWayBooking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addOneWayBooking`(IN origin ENUM('ORD', 'LAX', 'CID'), IN destination ENUM('ORD', 'LAX', 'CID'), IN accompanyingNum int(2), IN bDate DATE, IN customerID varchar(36), IN finalFlightID varchar(36))
BEGIN
	INSERT INTO `booking`
	VALUES
	(UUID(),
	'oneWay',
	origin,
	destination,
	accompanyingNum,
	bDate,
	customerID);
	
    SET SQL_SAFE_UPDATES = 0;
    
	UPDATE flight
		SET passengerNo = passengerNo + accompanyingNum
		WHERE flightID = finalFlightID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addRoundTripBooking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addRoundTripBooking`(IN origin ENUM('ORD', 'LAX', 'CID'), IN destination ENUM('ORD', 'LAX', 'CID'), IN accompanyingNum int(2), IN departureDate DATE, IN returnDate DATE, IN customerID varchar(36), IN depatureFlightID varchar(36), IN returnFlightID varchar(36))
BEGIN
	INSERT INTO `booking`
	VALUES
	(UUID(),
	'roundTrip',
	origin,
	destination,
	accompanyingNum,
	departureDate,
	customerID);
    
    INSERT INTO `booking`
	VALUES
	(UUID(),
	'roundTrip',
	destination,
	origin,
	accompanyingNum,
	returnDate,
	customerID);
    
	SET SQL_SAFE_UPDATES = 0;
    
	UPDATE flight
		SET passengerNo = passengerNo + accompanyingNum
		WHERE flightID = departureFlightID;
        
	UPDATE flight
		SET passengerNo = passengerNo + accompanyingNum
		WHERE flightID = returnFlightID;
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cancelFlight` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cancelFlight`(IN bookingID2 VARCHAR(30), IN customerID VARCHAR(36), IN flightID2 VARCHAR(36), IN passengers INT(3))
BEGIN

	DELETE FROM booking WHERE bookingID = bookingID2 AND customer_ID1 = customerID;
    SET SQL_SAFE_UPDATES = 0;
    UPDATE flight SET passengerNO = passengerNO - passengers WHERE flightID = flightID2 ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `outputCustomerBooking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `outputCustomerBooking`(in ID VARCHAR(3))
BEGIN
	SELECT * FROM booking WHERE customer_ID1 = ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `outputOneWayFlights` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `outputOneWayFlights`(IN origin ENUM('ORD', 'LAX', 'CID'), IN destination ENUM('ORD', 'LAX', 'CID'), IN accompanyingNum int(2), IN departureDate DATE, OUT isEmpty int(1))
BEGIN
	DROP TEMPORARY TABLE if exists oneWayFlightOutput;
    
    SET isEmpty = 0;
    
    CREATE TEMPORARY TABLE oneWayFlightOutput AS
		SELECT f.flightID, f.origin_airport_id, f.destination_airport_id, f.flightDate, f.passengerNo, plane.seatNo
		FROM flight f
		INNER JOIN plane ON f.plane_id = plane.planeID
		WHERE (origin = f.origin_airport_id)
		AND (destination = f.destination_airport_id)
		AND (departureDate = f.flightDate)
		AND ((accompanyingNum + f.passengerNo) <= plane.seatNo);
        
        IF (NOT EXISTS(SELECT 1 FROM oneWayFlightOutput)) THEN
			SET isEmpty = 1;
		END IF;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `outputRoundTripFlights` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `outputRoundTripFlights`(IN origin ENUM('ORD', 'LAX', 'CID'), IN destination ENUM('ORD', 'LAX', 'CID'), IN accompanyingNum int(2), IN departureDate DATE, IN returnDate DATE, OUT isEmpty int(1))
BEGIN
	DROP TEMPORARY TABLE if exists oneWayFlightOutput;
    
    SET isEmpty = 0;
    
    CREATE TEMPORARY TABLE oneWayFlightOutput AS
		SELECT f.flightID, f.origin_airport_id, f.destination_airport_id, f.flightDate, f.passengerNo, plane.seatNo
		FROM flight f
		INNER JOIN plane ON f.plane_id = plane.planeID
		WHERE (origin = f.origin_airport_id)
		AND (destination = f.destination_airport_id)
		AND (departureDate = f.flightDate)
		AND ((accompanyingNum + f.passengerNo) <= plane.seatNo);
        
	IF (NOT EXISTS(SELECT 1 FROM oneWayFlightOutput)) THEN
		SET isEmpty = 1;
	END IF;
        
	CREATE TEMPORARY TABLE returnFlightOutput AS
		SELECT f.flightID, f.origin_airport_id, f.destination_airport_id, f.flightDate, f.passengerNo, plane.seatNo
		FROM flight f
		INNER JOIN plane ON f.plane_id = plane.planeID
		WHERE (origin = f.destination_airport_id)
		AND (destination = f.origin_airport_id)
		AND (returnDate = f.flightDate)
		AND ((accompanyingNum + f.passengerNo) <= plane.seatNo);
	
        
	IF (NOT EXISTS(SELECT 1 FROM returnFlightOutput)) THEN
		SET isEmpty = 1;
	END IF;
    
		
	 
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `outputSingleFlightInformation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `outputSingleFlightInformation`(IN flight_id varchar(11))
BEGIN
	SELECT * FROM flight WHERE flightID = flight_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `outputUserInformation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `outputUserInformation`(in lastName2 VARCHAR(30), in ID VARCHAR(3), in pass VARCHAR(30))
BEGIN
	SELECT userID, firstName, lastName, points from customer WHERE lastName = lastName2 AND userID = ID AND password = pass;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `userCreation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `userCreation`(IN firstName VARCHAR(20), IN lastName VARCHAR(30), IN userpass VARCHAR(20), IN username VARCHAR(20), IN DOB DATE)
BEGIN
	INSERT INTO customer VALUES(
    UUID(),
    firstName,
    lastName,
    username,
    userpass,
    0,
    DOB);
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-29 15:30:56
