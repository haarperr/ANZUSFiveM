MySQL.ready(function()
    local success, result = pcall(MySQL.query.await, 'SELECT * FROM crypto_wallets') --[[@as any]]

    if not success then
        -- because some people can't run sql files
        success, result = pcall(MySQL.query, [[CREATE TABLE `crypto_wallets` (
            `id` INT(11) NOT NULL AUTO_INCREMENT,
            `owner` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
            `wallet` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8_general_ci',
            `key_phrase` VARCHAR(128) NOT NULL COLLATE 'utf8_general_ci',
            `created` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
            `value` FLOAT NOT NULL DEFAULT '0',
            PRIMARY KEY (`id`, `wallet`) USING BTREE,
            INDEX `owner` (`owner`) USING BTREE,
            CONSTRAINT `FK_crypto_wallets_characters` FOREIGN KEY (`owner`) REFERENCES `characters` (`citizenid`) ON UPDATE SET NULL ON DELETE NO ACTION
        )
        COLLATE='utf8_general_ci'
        ENGINE=InnoDB;]])

        success, result = pcall(MySQL.query, [[CREATE TABLE `crypto_transactions` (
            `id` INT(11) NOT NULL AUTO_INCREMENT,
            `sender` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
            `receiver` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
            `amount` FLOAT NOT NULL,
            `created` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
            PRIMARY KEY (`id`) USING BTREE,
            INDEX `receiver` (`receiver`) USING BTREE,
            INDEX `sender` (`sender`) USING BTREE
        )
        COLLATE='utf8_general_ci'
        ENGINE=InnoDB;]])

        if not success then
            return error(result)
        end

        print("Created tables 'crypto_wallets', 'crypto_transactions' in the database")
    end
end)
