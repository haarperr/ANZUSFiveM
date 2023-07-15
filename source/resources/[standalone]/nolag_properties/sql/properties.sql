CREATE TABLE IF NOT EXISTS `buildings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) DEFAULT NULL,
  `label` varchar(250) DEFAULT NULL,
  `metadata` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT 'shell',
  `keyholders` text DEFAULT '[]',
  `buildingid` int(11) DEFAULT NULL,
  `metadata` longtext DEFAULT NULL,
  `furniture` longtext DEFAULT '{"inside":[], "outside":[]}',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_buildingID` (`buildingid`),
  CONSTRAINT `fk_buildingID` FOREIGN KEY (`buildingid`) REFERENCES `buildings` (`id`)
);
