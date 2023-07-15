-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.10.2-MariaDB-1:10.10.2+maria~ubu2204 - mariadb.org binary distribution
-- Server OS:                    debian-linux-gnu
-- HeidiSQL Version:             12.2.0.6576
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for anzus-project
CREATE DATABASE IF NOT EXISTS `anzus-project` /*!40100 DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci */;
USE `anzus-project`;

-- Dumping structure for table anzus-project.apartments
CREATE TABLE IF NOT EXISTS `apartments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `citizenid` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `name` (`name`),
  CONSTRAINT `FK_apartments_players` FOREIGN KEY (`citizenid`) REFERENCES `characters` (`citizenid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.auctions
CREATE TABLE IF NOT EXISTS `auctions` (
  `id` int(10) unsigned NOT NULL,
  `type` enum('ITEM','VEHICLE') NOT NULL,
  `sid` varchar(50) NOT NULL,
  `data` longtext NOT NULL,
  `timestamp` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.bans
CREATE TABLE IF NOT EXISTS `bans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `license2` varchar(50) NOT NULL,
  `steamid` varchar(50) NOT NULL,
  `discord` varchar(50) NOT NULL,
  `ip` varchar(50) NOT NULL,
  `reason` mediumtext NOT NULL,
  `expire` int(11) NOT NULL,
  `bannedby` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `license2` (`license2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.blackmarket
CREATE TABLE IF NOT EXISTS `blackmarket` (
  `id` int(10) unsigned NOT NULL,
  `pid` varchar(50) NOT NULL,
  `pname` varchar(50) NOT NULL,
  `item` longtext NOT NULL,
  `amount` int(11) NOT NULL,
  `price` float unsigned NOT NULL,
  `timestamp` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.blackmarket_purchased
CREATE TABLE IF NOT EXISTS `blackmarket_purchased` (
  `id` int(10) unsigned NOT NULL,
  `sid` varchar(50) NOT NULL,
  `bid` varchar(50) NOT NULL,
  `item` longtext NOT NULL,
  `escrow` float unsigned DEFAULT NULL,
  `amount` int(5) unsigned NOT NULL,
  `delivered` int(1) unsigned NOT NULL,
  `postop` int(2) unsigned NOT NULL,
  `expire` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.characters
CREATE TABLE IF NOT EXISTS `characters` (
  `userid` int(11) NOT NULL,
  `citizenid` varchar(50) NOT NULL,
  `fullname` varchar(64) NOT NULL,
  `charinfo` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '{}',
  `money` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '{}',
  `job` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '{}',
  `gang` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '{}',
  `position` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '{}',
  `metadata` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '{}',
  `inventory` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '{}',
  `phone_number` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`citizenid`),
  KEY `last_updated` (`last_updated`),
  KEY `userid` (`userid`),
  KEY `phone_number` (`phone_number`),
  CONSTRAINT `players_users_fk` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

CREATE TABLE IF NOT EXISTS `character_mails` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`citizenid` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`sender` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`subject` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`message` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`read` TINYINT(4) NULL DEFAULT '0',
	`mailid` INT(11) NULL DEFAULT NULL,
	`date` TIMESTAMP NULL DEFAULT current_timestamp(),
	`button` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`id`) USING BTREE,
	INDEX `citizenid` (`citizenid`) USING BTREE,
	CONSTRAINT `FK_character_mails_characters` FOREIGN KEY (`citizenid`) REFERENCES `characters` (`citizenid`) ON UPDATE CASCADE ON DELETE CASCADE
) COLLATE='utf8mb4_general_ci' ENGINE=InnoDB;


-- Dumping structure for table anzus-project.character_boats
CREATE TABLE IF NOT EXISTS `character_boats` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(50) NOT NULL,
  `model` varchar(50) DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `boathouse` varchar(50) DEFAULT NULL,
  `fuel` int(11) NOT NULL,
  `state` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  CONSTRAINT `FK_player_boats_players` FOREIGN KEY (`citizenid`) REFERENCES `characters` (`citizenid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.character_houses
CREATE TABLE IF NOT EXISTS `character_houses` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `house` varchar(50) NOT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `citizenid` varchar(50) NOT NULL,
  `keyholders` text DEFAULT NULL,
  `decorations` text DEFAULT NULL,
  `stash` text DEFAULT NULL,
  `outfit` text DEFAULT NULL,
  `logout` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `house` (`house`),
  KEY `citizenid` (`citizenid`),
  KEY `identifier` (`identifier`),
  CONSTRAINT `FK_player_houses_players` FOREIGN KEY (`citizenid`) REFERENCES `characters` (`citizenid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.character_jobs
CREATE TABLE IF NOT EXISTS `character_jobs` (
  `citizenid` varchar(50) NOT NULL,
  `jobdata` mediumtext NOT NULL,
  PRIMARY KEY (`citizenid`),
  CONSTRAINT `FK_player_jobs_players` FOREIGN KEY (`citizenid`) REFERENCES `characters` (`citizenid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.character_outfits
CREATE TABLE IF NOT EXISTS `character_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `outfitname` varchar(50) NOT NULL DEFAULT '0',
  `model` varchar(50) DEFAULT NULL,
  `props` varchar(1000) DEFAULT NULL,
  `components` varchar(1500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `citizenid_outfitname_model` (`citizenid`,`outfitname`,`model`),
  KEY `citizenid` (`citizenid`),
  CONSTRAINT `FK_player_outfits_players` FOREIGN KEY (`citizenid`) REFERENCES `characters` (`citizenid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.character_skins
CREATE TABLE IF NOT EXISTS `character_skins` (
  `citizenid` varchar(50) NOT NULL,
  `model` varchar(255) NOT NULL,
  `skin` text NOT NULL,
  `active` tinyint(2) NOT NULL DEFAULT 1,
  KEY `citizenid` (`citizenid`),
  KEY `active` (`active`),
  CONSTRAINT `playerskins_player_fk` FOREIGN KEY (`citizenid`) REFERENCES `characters` (`citizenid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.character_vehicles
CREATE TABLE IF NOT EXISTS `character_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `vehicle` varchar(50) NOT NULL,
  `hash` varchar(50) NOT NULL,
  `mods` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '{}',
  `plate` varchar(15) NOT NULL,
  `fakeplate` varchar(50) DEFAULT NULL,
  `garage` varchar(50) NOT NULL DEFAULT 'pillboxgarage',
  `fuel` int(11) NOT NULL DEFAULT 100,
  `engine` float NOT NULL DEFAULT 1000,
  `body` float NOT NULL DEFAULT 1000,
  `state` int(11) NOT NULL DEFAULT 1,
  `depotprice` int(11) NOT NULL DEFAULT 0,
  `drivingdistance` int(50) NOT NULL DEFAULT 0,
  `status` mediumtext DEFAULT NULL,
  `glovebox` longtext DEFAULT NULL,
  `trunk` longtext DEFAULT NULL,
  `vinnumber` varchar(50) NOT NULL,
  `vinscratch` int(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_playervehicles_plate` (`plate`),
  KEY `plate` (`plate`),
  KEY `citizenid` (`citizenid`),
  CONSTRAINT `FK_playervehicles_players` FOREIGN KEY (`citizenid`) REFERENCES `characters` (`citizenid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.daily_challenges
CREATE TABLE IF NOT EXISTS `daily_challenges` (
  `citizenid` varchar(50) NOT NULL,
  `id` varchar(50) NOT NULL,
  `amount` int(11) unsigned NOT NULL DEFAULT 1,
  `completed` int(11) unsigned NOT NULL DEFAULT 0,
  KEY `citizenid` (`citizenid`),
  CONSTRAINT `FK_daily_challenges_players` FOREIGN KEY (`citizenid`) REFERENCES `characters` (`citizenid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.dealers
CREATE TABLE IF NOT EXISTS `dealers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `coords` longtext DEFAULT NULL,
  `time` longtext DEFAULT NULL,
  `createdby` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.event
CREATE TABLE IF NOT EXISTS `event` (
  `id` int(10) unsigned NOT NULL,
  `level` enum('CRITICAL','WARN','INFO') NOT NULL,
  `event` varchar(191) NOT NULL,
  `info` longtext NOT NULL,
  `citizenid` varchar(191) NOT NULL,
  `steam` varchar(191) NOT NULL,
  `ip` varchar(191) NOT NULL,
  `timestamp` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.evidence_storage
CREATE TABLE IF NOT EXISTS `evidence_storage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.exploitlog
CREATE TABLE IF NOT EXISTS `exploitlog` (
  `id` int(10) unsigned NOT NULL,
  `level` enum('CRITICAL','WARN','INFO') NOT NULL,
  `event` varchar(191) NOT NULL,
  `message` longtext NOT NULL,
  `citizenid` varchar(191) NOT NULL,
  `steam` varchar(191) NOT NULL,
  `ip` varchar(191) NOT NULL,
  `timestamp` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.gl_pgangs
CREATE TABLE IF NOT EXISTS `gl_pgangs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `gang` varchar(250) NOT NULL,
  `reputation` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_gl_pgangs_players` (`identifier`),
  CONSTRAINT `FK_gl_pgangs_players` FOREIGN KEY (`identifier`) REFERENCES `characters` (`citizenid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.houselocations
CREATE TABLE IF NOT EXISTS `houselocations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `coords` mediumtext DEFAULT NULL,
  `owned` tinyint(2) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `tier` tinyint(4) DEFAULT NULL,
  `garage` mediumtext NOT NULL DEFAULT '{"y":0,"x":0,"h":0,"z":0}',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.lapraces
CREATE TABLE IF NOT EXISTS `lapraces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `checkpoints` mediumtext DEFAULT NULL,
  `records` mediumtext DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `distance` int(11) DEFAULT NULL,
  `raceid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `raceid` (`raceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.management_funds
CREATE TABLE IF NOT EXISTS `management_funds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) NOT NULL,
  `amount` int(100) NOT NULL,
  `type` enum('boss','gang') NOT NULL DEFAULT 'boss',
  `rep` int(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `job_name` (`job_name`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.mdt_bolos
CREATE TABLE IF NOT EXISTS `mdt_bolos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` varchar(50) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `individual` varchar(50) DEFAULT NULL,
  `detail` text DEFAULT NULL,
  `tags` text DEFAULT NULL,
  `gallery` text DEFAULT NULL,
  `officersinvolved` text DEFAULT NULL,
  `time` varchar(20) DEFAULT NULL,
  `jobtype` varchar(25) NOT NULL DEFAULT 'police',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.mdt_bulletin
CREATE TABLE IF NOT EXISTS `mdt_bulletin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `desc` text NOT NULL,
  `author` varchar(50) NOT NULL,
  `time` varchar(20) NOT NULL,
  `jobtype` varchar(25) DEFAULT 'police',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.mdt_convictions
CREATE TABLE IF NOT EXISTS `mdt_convictions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` varchar(50) DEFAULT NULL,
  `linkedincident` int(11) NOT NULL DEFAULT 0,
  `warrant` varchar(50) DEFAULT NULL,
  `guilty` varchar(50) DEFAULT NULL,
  `processed` varchar(50) DEFAULT NULL,
  `associated` varchar(50) DEFAULT '0',
  `charges` text DEFAULT NULL,
  `fine` int(11) DEFAULT 0,
  `sentence` int(11) DEFAULT 0,
  `recfine` int(11) DEFAULT 0,
  `recsentence` int(11) DEFAULT 0,
  `time` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.mdt_data
CREATE TABLE IF NOT EXISTS `mdt_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` varchar(20) NOT NULL,
  `information` mediumtext DEFAULT NULL,
  `tags` text NOT NULL,
  `gallery` text NOT NULL,
  `jobtype` varchar(25) DEFAULT 'police',
  `pfp` text DEFAULT NULL,
  `fingerprint` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cid`),
  KEY `id` (`id`),
  CONSTRAINT `FK_mdt_data_characters` FOREIGN KEY (`cid`) REFERENCES `characters` (`citizenid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.mdt_impound
CREATE TABLE IF NOT EXISTS `mdt_impound` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicleid` int(11) NOT NULL,
  `linkedreport` int(11) NOT NULL,
  `fee` int(11) DEFAULT NULL,
  `time` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.mdt_incidents
CREATE TABLE IF NOT EXISTS `mdt_incidents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` varchar(50) NOT NULL DEFAULT '',
  `title` varchar(50) NOT NULL DEFAULT '0',
  `details` text NOT NULL,
  `tags` text NOT NULL,
  `officersinvolved` text NOT NULL,
  `civsinvolved` text NOT NULL,
  `evidence` text NOT NULL,
  `time` varchar(20) DEFAULT NULL,
  `jobtype` varchar(25) NOT NULL DEFAULT 'police',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.mdt_logs
CREATE TABLE IF NOT EXISTS `mdt_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` text NOT NULL,
  `time` varchar(20) DEFAULT NULL,
  `jobtype` varchar(25) DEFAULT 'police',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.mdt_reports
CREATE TABLE IF NOT EXISTS `mdt_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` varchar(50) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `tags` text DEFAULT NULL,
  `officersinvolved` text DEFAULT NULL,
  `civsinvolved` text DEFAULT NULL,
  `gallery` text DEFAULT NULL,
  `time` varchar(20) DEFAULT NULL,
  `jobtype` varchar(25) DEFAULT 'police',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.mdt_vehicleinfo
CREATE TABLE IF NOT EXISTS `mdt_vehicleinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(50) DEFAULT NULL,
  `information` text NOT NULL DEFAULT '',
  `stolen` tinyint(1) NOT NULL DEFAULT 0,
  `code5` tinyint(1) NOT NULL DEFAULT 0,
  `image` text NOT NULL DEFAULT '',
  `points` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.mdt_weaponinfo
CREATE TABLE IF NOT EXISTS `mdt_weaponinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serial` varchar(50) DEFAULT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `information` text NOT NULL DEFAULT '',
  `weapClass` varchar(50) DEFAULT NULL,
  `weapModel` varchar(50) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `serial` (`serial`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.money
CREATE TABLE IF NOT EXISTS `money` (
  `id` int(10) unsigned NOT NULL,
  `level` enum('CRITICAL','WARN','INFO') NOT NULL,
  `type` enum('BANK','CASH','CRYPTO') NOT NULL,
  `resource` varchar(191) NOT NULL,
  `before` double NOT NULL,
  `change` double NOT NULL,
  `after` double NOT NULL,
  `reason` varchar(191) NOT NULL,
  `citizenid` varchar(191) NOT NULL,
  `steam` varchar(191) NOT NULL,
  `ip` varchar(191) NOT NULL,
  `timestamp` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.npwd_calls
CREATE TABLE IF NOT EXISTS `npwd_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(48) DEFAULT NULL,
  `transmitter` varchar(255) NOT NULL,
  `receiver` varchar(255) NOT NULL,
  `is_accepted` tinyint(4) DEFAULT 0,
  `start` varchar(255) DEFAULT NULL,
  `end` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.npwd_darkchat_channels
CREATE TABLE IF NOT EXISTS `npwd_darkchat_channels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_identifier` varchar(255) NOT NULL,
  `label` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `darkchat_channels_channel_identifier_uindex` (`channel_identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.npwd_darkchat_channel_members
CREATE TABLE IF NOT EXISTS `npwd_darkchat_channel_members` (
  `channel_id` int(11) NOT NULL,
  `user_identifier` varchar(255) NOT NULL,
  `is_owner` tinyint(4) NOT NULL DEFAULT 0,
  KEY `npwd_darkchat_channel_members_npwd_darkchat_channels_id_fk` (`channel_id`) USING BTREE,
  CONSTRAINT `npwd_darkchat_channel_members_npwd_darkchat_channels_id_fk` FOREIGN KEY (`channel_id`) REFERENCES `npwd_darkchat_channels` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.npwd_darkchat_messages
CREATE TABLE IF NOT EXISTS `npwd_darkchat_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `user_identifier` varchar(255) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_image` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `darkchat_messages_darkchat_channels_id_fk` (`channel_id`) USING BTREE,
  CONSTRAINT `darkchat_messages_darkchat_channels_id_fk` FOREIGN KEY (`channel_id`) REFERENCES `npwd_darkchat_channels` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.npwd_marketplace_listings
CREATE TABLE IF NOT EXISTS `npwd_marketplace_listings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `number` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `reported` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`),
  CONSTRAINT `FK_npwd_marketplace_listings_players` FOREIGN KEY (`identifier`) REFERENCES `characters` (`citizenid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.npwd_match_profiles
CREATE TABLE IF NOT EXISTS `npwd_match_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(48) NOT NULL,
  `name` varchar(90) NOT NULL,
  `image` varchar(255) NOT NULL,
  `bio` varchar(512) DEFAULT NULL,
  `location` varchar(45) DEFAULT NULL,
  `job` varchar(45) DEFAULT NULL,
  `tags` varchar(255) NOT NULL DEFAULT '',
  `voiceMessage` varchar(512) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifier_UNIQUE` (`identifier`),
  CONSTRAINT `FK_npwd_match_profiles_players` FOREIGN KEY (`identifier`) REFERENCES `characters` (`citizenid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.npwd_match_views
CREATE TABLE IF NOT EXISTS `npwd_match_views` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `profile` int(11) NOT NULL,
  `liked` tinyint(4) DEFAULT 0,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `match_profile_idx` (`profile`),
  KEY `identifier` (`identifier`),
  CONSTRAINT `match_profile` FOREIGN KEY (`profile`) REFERENCES `npwd_match_profiles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.npwd_messages
CREATE TABLE IF NOT EXISTS `npwd_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(512) NOT NULL,
  `user_identifier` varchar(48) NOT NULL,
  `conversation_id` varchar(512) NOT NULL,
  `isRead` tinyint(4) NOT NULL DEFAULT 0,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `visible` tinyint(4) NOT NULL DEFAULT 1,
  `author` varchar(255) NOT NULL,
  `is_embed` tinyint(4) NOT NULL DEFAULT 0,
  `embed` varchar(512) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `user_identifier` (`user_identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.npwd_messages_conversations
CREATE TABLE IF NOT EXISTS `npwd_messages_conversations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `conversation_list` varchar(225) NOT NULL,
  `label` varchar(60) DEFAULT '',
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_message_id` int(11) DEFAULT NULL,
  `is_group_chat` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.npwd_messages_participants
CREATE TABLE IF NOT EXISTS `npwd_messages_participants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `conversation_id` int(11) NOT NULL,
  `participant` varchar(225) NOT NULL,
  `unread_count` int(11) DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `message_participants_npwd_messages_conversations_id_fk` (`conversation_id`) USING BTREE,
  CONSTRAINT `message_participants_npwd_messages_conversations_id_fk` FOREIGN KEY (`conversation_id`) REFERENCES `npwd_messages_conversations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.npwd_notes
CREATE TABLE IF NOT EXISTS `npwd_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.npwd_phone_contacts
CREATE TABLE IF NOT EXISTS `npwd_phone_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(48) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `number` varchar(20) DEFAULT NULL,
  `display` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.npwd_phone_gallery
CREATE TABLE IF NOT EXISTS `npwd_phone_gallery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(48) DEFAULT NULL,
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.npwd_twitter_likes
CREATE TABLE IF NOT EXISTS `npwd_twitter_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) NOT NULL,
  `tweet_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_combination` (`profile_id`,`tweet_id`),
  KEY `profile_idx` (`profile_id`),
  KEY `tweet_idx` (`tweet_id`),
  CONSTRAINT `profile` FOREIGN KEY (`profile_id`) REFERENCES `npwd_twitter_profiles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tweet` FOREIGN KEY (`tweet_id`) REFERENCES `npwd_twitter_tweets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.npwd_twitter_profiles
CREATE TABLE IF NOT EXISTS `npwd_twitter_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_name` varchar(90) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `avatar_url` varchar(255) DEFAULT 'https://i.file.glass/QrEvq.png',
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `profile_name_UNIQUE` (`profile_name`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.npwd_twitter_reports
CREATE TABLE IF NOT EXISTS `npwd_twitter_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) NOT NULL,
  `tweet_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_combination` (`profile_id`,`tweet_id`),
  KEY `profile_idx` (`profile_id`),
  KEY `tweet_idx` (`tweet_id`),
  CONSTRAINT `report_profile` FOREIGN KEY (`profile_id`) REFERENCES `npwd_twitter_profiles` (`id`),
  CONSTRAINT `report_tweet` FOREIGN KEY (`tweet_id`) REFERENCES `npwd_twitter_tweets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.npwd_twitter_tweets
CREATE TABLE IF NOT EXISTS `npwd_twitter_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(1000) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `likes` int(11) NOT NULL DEFAULT 0,
  `identifier` varchar(48) NOT NULL,
  `visible` tinyint(4) NOT NULL DEFAULT 1,
  `images` varchar(1000) DEFAULT '',
  `retweet` int(11) DEFAULT NULL,
  `profile_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `npwd_twitter_tweets_npwd_twitter_profiles_id_fk` (`profile_id`) USING BTREE,
  CONSTRAINT `npwd_twitter_tweets_npwd_twitter_profiles_id_fk` FOREIGN KEY (`profile_id`) REFERENCES `npwd_twitter_profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.occasion_vehicles
CREATE TABLE IF NOT EXISTS `occasion_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seller` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `mods` mediumtext DEFAULT NULL,
  `occasionid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `occasionId` (`occasionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.okokvehicleshop_orders
CREATE TABLE IF NOT EXISTS `okokvehicleshop_orders` (
  `id` int(11) NOT NULL,
  `shop_id` varchar(255) NOT NULL,
  `shop_type` varchar(255) NOT NULL,
  `vehicle_name` varchar(255) NOT NULL,
  `vehicle_id` varchar(255) NOT NULL,
  `reward` varchar(255) NOT NULL,
  `in_progress` varchar(255) NOT NULL,
  `employee_name` varchar(255) NOT NULL,
  `employee_id` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.okokvehicleshop_saleshistory
CREATE TABLE IF NOT EXISTS `okokvehicleshop_saleshistory` (
  `shop_id` varchar(255) NOT NULL,
  `vehicle_name` varchar(255) NOT NULL,
  `vehicle_id` varchar(255) NOT NULL,
  `buyer_name` varchar(255) NOT NULL,
  `buyer_id` varchar(255) NOT NULL,
  `price` varchar(255) NOT NULL,
  `date` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.okokvehicleshop_shops
CREATE TABLE IF NOT EXISTS `okokvehicleshop_shops` (
  `shop_name` varchar(255) NOT NULL,
  `shop_id` varchar(255) NOT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `owner_name` varchar(255) DEFAULT NULL,
  `money` varchar(255) NOT NULL,
  `employees` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.okokvehicleshop_vehicles
CREATE TABLE IF NOT EXISTS `okokvehicleshop_vehicles` (
  `vehicle_name` varchar(255) NOT NULL,
  `vehicle_id` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `stock` longtext DEFAULT NULL,
  `unlisted` longtext DEFAULT NULL,
  `min_price` varchar(255) NOT NULL,
  `max_price` varchar(255) NOT NULL,
  `owner_buy_price` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.ox_doorlock
CREATE TABLE IF NOT EXISTS `ox_doorlock` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.ox_inventory
CREATE TABLE IF NOT EXISTS `ox_inventory` (
  `owner` varchar(60) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `data` longtext DEFAULT NULL,
  `lastupdated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  UNIQUE KEY `owner` (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.pefcl_accounts
CREATE TABLE IF NOT EXISTS `pefcl_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(255) DEFAULT NULL,
  `accountName` varchar(255) DEFAULT NULL,
  `isDefault` tinyint(1) DEFAULT 0,
  `ownerIdentifier` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT 'owner',
  `balance` int(11) DEFAULT 25000,
  `type` varchar(255) DEFAULT 'personal',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  UNIQUE KEY `number_2` (`number`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.pefcl_cash
CREATE TABLE IF NOT EXISTS `pefcl_cash` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` int(11) DEFAULT 2000,
  `ownerIdentifier` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ownerIdentifier` (`ownerIdentifier`),
  UNIQUE KEY `ownerIdentifier_2` (`ownerIdentifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.pefcl_external_accounts
CREATE TABLE IF NOT EXISTS `pefcl_external_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `userId` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pefcl_external_accounts_user_id_number` (`userId`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.pefcl_invoices
CREATE TABLE IF NOT EXISTS `pefcl_invoices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(255) NOT NULL,
  `from` varchar(255) NOT NULL,
  `to` varchar(255) NOT NULL,
  `fromIdentifier` varchar(255) NOT NULL,
  `toIdentifier` varchar(255) NOT NULL,
  `receiverAccountIdentifier` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT 0,
  `status` varchar(255) DEFAULT 'PENDING',
  `expiresAt` datetime NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.pefcl_shared_accounts
CREATE TABLE IF NOT EXISTS `pefcl_shared_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userIdentifier` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT 'contributor',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `accountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `accountId` (`accountId`),
  CONSTRAINT `pefcl_shared_accounts_ibfk_1` FOREIGN KEY (`accountId`) REFERENCES `pefcl_accounts` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.pefcl_transactions
CREATE TABLE IF NOT EXISTS `pefcl_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT 0,
  `type` varchar(255) DEFAULT 'Outgoing',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `toAccountId` int(11) DEFAULT NULL,
  `fromAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `toAccountId` (`toAccountId`),
  KEY `fromAccountId` (`fromAccountId`),
  CONSTRAINT `pefcl_transactions_ibfk_1` FOREIGN KEY (`toAccountId`) REFERENCES `pefcl_accounts` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `pefcl_transactions_ibfk_2` FOREIGN KEY (`fromAccountId`) REFERENCES `pefcl_accounts` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.plants
CREATE TABLE IF NOT EXISTS `plants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coords` longtext DEFAULT NULL,
  `type` varchar(100) NOT NULL,
  `water` double NOT NULL,
  `food` double NOT NULL,
  `growth` double NOT NULL,
  `rate` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.processing
CREATE TABLE IF NOT EXISTS `processing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(100) NOT NULL,
  `item` longtext DEFAULT NULL,
  `time` int(11) NOT NULL,
  `coords` longtext DEFAULT NULL,
  `rot` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.shared_vehicles
CREATE TABLE IF NOT EXISTS `shared_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle` varchar(50) DEFAULT NULL,
  `hash` varchar(50) DEFAULT NULL,
  `mods` text DEFAULT NULL,
  `plate` varchar(15) NOT NULL,
  `fakeplate` varchar(50) DEFAULT NULL,
  `garage` varchar(50) DEFAULT NULL,
  `parkingspot` varchar(200) DEFAULT NULL,
  `damage` varchar(1500) DEFAULT NULL,
  `fuel` int(11) DEFAULT NULL,
  `engine` float DEFAULT NULL,
  `body` float DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `depotprice` int(11) NOT NULL,
  `drivingdistance` int(50) DEFAULT NULL,
  `status` mediumtext DEFAULT NULL,
  `vinnumber` varchar(50) DEFAULT NULL,
  `vinscratch` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plate_unique` (`plate`),
  KEY `plate` (`plate`),
  KEY `vehicle` (`vehicle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.stashitems
CREATE TABLE IF NOT EXISTS `stashitems` (
  `id` int(11) NOT NULL,
  `stash` varchar(255) NOT NULL,
  `items` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.tax_settings
CREATE TABLE IF NOT EXISTS `tax_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `start` datetime NOT NULL DEFAULT current_timestamp(),
  `end` datetime NOT NULL DEFAULT (current_timestamp() + interval 7 day),
  `percentage` float unsigned NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.users
CREATE TABLE IF NOT EXISTS `users` (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL DEFAULT '0',
  `license` varchar(50) NOT NULL DEFAULT '0',
  `license2` varchar(64) NOT NULL DEFAULT '0',
  `steam` varchar(20) NOT NULL DEFAULT '0',
  `fivem` varchar(20) NOT NULL DEFAULT '0',
  `discord` varchar(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table anzus-project.whitelist
CREATE TABLE IF NOT EXISTS `whitelist` (
  `id` int(10) unsigned NOT NULL,
  `previous` int(11) NOT NULL,
  `new` int(11) NOT NULL,
  `job` varchar(191) NOT NULL,
  `target` varchar(191) NOT NULL,
  `citizenid` varchar(191) NOT NULL,
  `steam` varchar(191) NOT NULL,
  `ip` varchar(191) NOT NULL,
  `timestamp` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
