DOJ = {}
local loaded = false
local queries = {
  [1] = [[CREATE TABLE IF NOT EXISTS `election` (
        `id` INT(11) NOT NULL AUTO_INCREMENT,
        `name` VARCHAR(128) NOT NULL COLLATE 'utf8mb3_general_ci',
        `votes` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
        `created` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
        `updated` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
        PRIMARY KEY (`id`) USING BTREE
    )
    COLLATE='utf8mb3_general_ci'
    ENGINE=InnoDB;]],
  [2] = [[CREATE TABLE IF NOT EXISTS `election_archive` (
        `id` INT(11) NOT NULL AUTO_INCREMENT,
        `results` LONGTEXT NOT NULL COLLATE 'utf8mb4_general_ci',
        `created` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
        PRIMARY KEY (`id`) USING BTREE
    )
    COLLATE='utf8mb4_general_ci'
    ENGINE=InnoDB;]],
  [3] = [[CREATE TABLE IF NOT EXISTS `election_votes` (
        `userid` INT(11) NOT NULL,
        `candidate` INT(11) NOT NULL,
        PRIMARY KEY (`userid`) USING BTREE,
        INDEX `FK_election_votes_election` (`candidate`) USING BTREE,
        CONSTRAINT `FK_election_votes_election` FOREIGN KEY (`candidate`) REFERENCES `election` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE,
        CONSTRAINT `FK_election_votes_users` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON UPDATE NO ACTION ON DELETE CASCADE
    )
    COLLATE='utf8mb3_general_ci'
    ENGINE=InnoDB;]],
  [4] = [[CREATE TABLE IF NOT EXISTS `settings` (
        `key` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
        `value` VARCHAR(128) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
        PRIMARY KEY (`key`) USING BTREE,
        INDEX `key` (`key`) USING BTREE
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
      loaded = true
      return
    end
  end

  print("Created tables all tables needed in the database")
  loaded = true
end)

AddEventHandler('onResourceStart', function(resourceName)
  if GetCurrentResourceName() ~= resourceName then return end
  while not loaded do Wait(100) end
  Wait(5000)
  GetAllVotes()
  OnElectionStart()
  SetTaxOnStart()
end)
