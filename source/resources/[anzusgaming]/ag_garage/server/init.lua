local queries = {
  {
    query = [[CREATE TABLE IF NOT EXISTS `character_vehicles` (
          `type` ENUM('heli','boat','automobile','plane','bike','trailer','train') NOT NULL DEFAULT 'automobile' COLLATE 'utf8mb4_general_ci',
          `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
          `plate` CHAR(8) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
          `vin` CHAR(17) NOT NULL COLLATE 'utf8mb4_general_ci',
          `owner` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
          `model` VARCHAR(24) NOT NULL COLLATE 'utf8mb4_general_ci',
          `garage` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
          `data` LONGTEXT NOT NULL COLLATE 'utf8mb4_general_ci',
          `class` TINYINT(3) UNSIGNED NULL DEFAULT NULL,
          `out` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
          `trunk` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
          `glovebox` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
          `shared` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
          `lock` INT(4) UNSIGNED NOT NULL DEFAULT '4321',
          `vinscratched` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
          PRIMARY KEY (`id`) USING BTREE,
          UNIQUE INDEX `plate` (`plate`) USING BTREE,
          UNIQUE INDEX `vin` (`vin`) USING BTREE,
          INDEX `garage` (`garage`) USING BTREE,
          INDEX `owner` (`owner`) USING BTREE,
          INDEX `shared` (`shared`) USING BTREE,
          INDEX `out` (`out`) USING BTREE,
          INDEX `lock` (`lock`) USING BTREE,
          CONSTRAINT `FK_character_vehicles_characters` FOREIGN KEY (`owner`) REFERENCES `characters` (`citizenid`) ON UPDATE NO ACTION ON DELETE CASCADE
      )
      COLLATE='utf8mb4_general_ci'
      ENGINE=InnoDB;]],
    values = {}
  },
  {
    query = [[
          ALTER TABLE `characters`
          ADD COLUMN IF NOT EXISTS `customNumber` TINYINT(1) NOT NULL DEFAULT '0';
      ]],
    values = {}
  },
  {
    query = [[
          ALTER TABLE `character_vehicles`
          ADD COLUMN IF NOT EXISTS `customPlate` TINYINT(1) NOT NULL DEFAULT '0';
      ]],
    values = {}
  },
  {
    query = [[CREATE TABLE IF NOT EXISTS `premium_vehicles` (
          `id` INT(11) NOT NULL AUTO_INCREMENT,
          `license` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
          `model` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
          `purchased` TINYINT(4) NOT NULL DEFAULT '0',
          `vehicle` INT(11) NULL DEFAULT NULL,
          `comment` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
          PRIMARY KEY (`id`) USING BTREE
      )
      COLLATE='utf8mb3_general_ci'
      ENGINE=InnoDB
      ROW_FORMAT=DYNAMIC
      ;
      ]],
    values = {}
  },
}

MySQL.ready(function()
  local success, result = pcall(MySQL.transaction, queries)

  if not success then
    return error(result)
  end

  if result == nil then return end

  print("Created tables all tables needed in the database")
end)
