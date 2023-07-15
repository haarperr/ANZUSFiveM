local queries = {
  [1] = [[CREATE TABLE IF NOT EXISTS `darkweb_stock` (
    `id` INT(10) UNSIGNED NOT NULL,
    `item` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
    `stock` INT(11) NOT NULL,
    `price` FLOAT UNSIGNED NOT NULL,
    `label` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `item` (`item`) USING BTREE
  )
  COLLATE='utf8mb4_general_ci'
  ENGINE=InnoDB;]],
  [2] = [[CREATE TABLE IF NOT EXISTS `darkweb_purchases` (
    `id` INT(10) UNSIGNED NOT NULL,
    `buyer` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
    `amount` INT(11) UNSIGNED NOT NULL,
    PRIMARY KEY (`id`, `buyer`) USING BTREE,
    INDEX `FK_darkweb_purchases_characters` (`buyer`) USING BTREE,
    CONSTRAINT `FK__darkweb_stock` FOREIGN KEY (`id`) REFERENCES `darkweb_stock` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE,
    CONSTRAINT `FK_darkweb_purchases_characters` FOREIGN KEY (`buyer`) REFERENCES `characters` (`citizenid`) ON UPDATE NO ACTION ON DELETE CASCADE
  )
  COLLATE='utf8mb4_general_ci'
  ENGINE=InnoDB;]],
}


MySQL.ready(function()
  for _, value in ipairs(queries) do
    local success, result = pcall(MySQL.insert, value)
    if not success then
      return error(result)
    end

    if result == nil then
      return
    end
  end

  print("Created tables all tables needed in the database")
end)
