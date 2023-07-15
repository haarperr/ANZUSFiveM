CREATE TABLE IF NOT EXISTS `licenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `issuedByIdent` varchar(255) DEFAULT NULL,
  `issuedToIdent` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `issuedOn` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `issuedByIdent` (`issuedByIdent`),
  KEY `issuedToIdent` (`issuedToIdent`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
