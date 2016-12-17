-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: 141.117.233.232    Database: mydb
-- ------------------------------------------------------
-- Server version	5.5.53-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `CSV`
--

DROP TABLE IF EXISTS `CSV`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CSV` (
  `Row` varchar(20) DEFAULT NULL,
  `time` varchar(20) DEFAULT NULL,
  `time_u` varchar(20) DEFAULT NULL,
  `SM1` varchar(20) DEFAULT NULL,
  `SM2` varchar(20) DEFAULT NULL,
  `SM3` varchar(20) DEFAULT NULL,
  `SM4` varchar(20) DEFAULT NULL,
  `SM5` varchar(20) DEFAULT NULL,
  `SM6` varchar(20) DEFAULT NULL,
  `DM1` varchar(20) DEFAULT NULL,
  `DM2` varchar(20) DEFAULT NULL,
  `DM3` varchar(20) DEFAULT NULL,
  `DM4` varchar(20) DEFAULT NULL,
  `DM5` varchar(20) DEFAULT NULL,
  `DM6` varchar(20) DEFAULT NULL,
  `VlanTag_X` varchar(20) DEFAULT NULL,
  `EthType_X` varchar(20) DEFAULT NULL,
  `SIP1` varchar(20) DEFAULT NULL,
  `SIP2` varchar(20) DEFAULT NULL,
  `SIP3` varchar(20) DEFAULT NULL,
  `SIP4` varchar(20) DEFAULT NULL,
  `DIP1` varchar(20) DEFAULT NULL,
  `DIP2` varchar(20) DEFAULT NULL,
  `DIP3` varchar(20) DEFAULT NULL,
  `DIP4` varchar(20) DEFAULT NULL,
  `IPProto` varchar(20) DEFAULT NULL,
  `IPTos` varchar(20) DEFAULT NULL,
  `SrcPort` varchar(20) DEFAULT NULL,
  `DstPort` varchar(20) DEFAULT NULL,
  `FIN` varchar(20) DEFAULT NULL,
  `SYN` varchar(20) DEFAULT NULL,
  `RES` varchar(20) DEFAULT NULL,
  `ACK` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flows`
--

DROP TABLE IF EXISTS `flows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flows` (
  `idFlows` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ipSrc` int(10) unsigned NOT NULL,
  `ipDst` int(10) unsigned NOT NULL,
  `portSrc` int(10) unsigned NOT NULL,
  `portDst` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idFlows`),
  UNIQUE KEY `idFlows_UNIQUE` (`idFlows`),
  KEY `1_idx` (`ipSrc`),
  KEY `2_idx` (`ipDst`),
  CONSTRAINT `10` FOREIGN KEY (`ipSrc`) REFERENCES `ipaddr` (`idIPAddr`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `11` FOREIGN KEY (`ipDst`) REFERENCES `ipaddr` (`idIPAddr`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=720373 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ipaddr`
--

DROP TABLE IF EXISTS `ipaddr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipaddr` (
  `idIPAddr` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IP1` tinyint(3) unsigned NOT NULL,
  `IP2` tinyint(3) unsigned NOT NULL,
  `IP3` tinyint(3) unsigned NOT NULL,
  `IP4` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`IP1`,`IP2`,`IP3`,`IP4`),
  UNIQUE KEY `idIPAddr_UNIQUE` (`idIPAddr`)
) ENGINE=InnoDB AUTO_INCREMENT=4352 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `macaddr`
--

DROP TABLE IF EXISTS `macaddr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `macaddr` (
  `idMac` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `M1` tinyint(3) unsigned NOT NULL,
  `M2` tinyint(3) unsigned NOT NULL,
  `M3` tinyint(3) unsigned NOT NULL,
  `M4` tinyint(3) unsigned NOT NULL,
  `M5` tinyint(3) unsigned NOT NULL,
  `M6` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`M1`,`M2`,`M3`,`M4`,`M5`,`M6`),
  UNIQUE KEY `idMac_UNIQUE` (`idMac`)
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `packets`
--

DROP TABLE IF EXISTS `packets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `packets` (
  `idPackets` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `time` double DEFAULT NULL,
  `macSrc` int(10) unsigned NOT NULL,
  `macDst` int(10) unsigned NOT NULL,
  `vlanTag` int(10) unsigned NOT NULL,
  `ethType` int(10) unsigned NOT NULL,
  `ipSrc` int(10) unsigned NOT NULL,
  `ipDst` int(10) unsigned NOT NULL,
  `ipProto` int(10) unsigned NOT NULL,
  `portSrc` int(11) NOT NULL,
  `portDst` int(11) NOT NULL,
  `ipTos` int(10) unsigned NOT NULL,
  `SYN` tinyint(1) DEFAULT NULL,
  `ACK` tinyint(1) DEFAULT NULL,
  `FIN` tinyint(1) DEFAULT NULL,
  `RES` tinyint(1) DEFAULT NULL,
  `Flow` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idPackets`),
  UNIQUE KEY `idPackets_UNIQUE` (`idPackets`),
  KEY `idMac_idx` (`macSrc`),
  KEY `vlanTag_idx` (`vlanTag`),
  KEY `4_idx` (`ethType`),
  KEY `5_idx` (`ipSrc`),
  KEY `6_idx` (`ipDst`),
  KEY `7_idx` (`ipProto`),
  KEY `idMac_idx1` (`macDst`),
  KEY `7_idx1` (`Flow`),
  KEY `flow_gen` (`portSrc`,`portDst`,`ipSrc`,`ipDst`,`time`),
  KEY `time_i` (`Flow`,`time`),
  CONSTRAINT `1` FOREIGN KEY (`macSrc`) REFERENCES `macaddr` (`idMac`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `2` FOREIGN KEY (`macDst`) REFERENCES `macaddr` (`idMac`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `5` FOREIGN KEY (`ipSrc`) REFERENCES `ipaddr` (`idIPAddr`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `6` FOREIGN KEY (`ipDst`) REFERENCES `ipaddr` (`idIPAddr`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `7` FOREIGN KEY (`Flow`) REFERENCES `flows` (`idFlows`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8650621 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-12-16 19:37:59
