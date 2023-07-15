CREATE TABLE IF NOT EXISTS `buildings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) DEFAULT NULL,
  `label` varchar(250) DEFAULT NULL,
  `metadata` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
);