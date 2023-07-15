local SQL_QUERIES = {
  ADD_WALLET_VALUE = 'UPDATE crypto_wallets SET value = value + ? WHERE wallet = ?',
  REMOVE_WALLET_VALUE = 'UPDATE crypto_wallets SET value = value - ? WHERE wallet = ?',
  GET_WALLET_VALUE = 'SELECT value FROM crypto_wallets WHERE wallet = ?',
  GET_WALLET_VALUE_PASSCODE = 'SELECT value FROM crypto_wallets WHERE key_phrase = ?',
  CREATE_TRANSACTION = 'INSERT INTO `crypto_transactions` (`sender`, `receiver`, `amount`) VALUES (?, ?, ?)',
  DECREASE_ORDER = 'UPDATE crypto_orders SET amount = amount - ? WHERE id = ?',
  CHECK_ORDERS = 'SELECT * from crypto_orders WHERE type = ? AND price <= ? AND amount >= ? ORDER BY price ASC LIMIT 1',
  CREATE_ORDER = 'INSERT INTO crypto_orders (creator, type, wallet, amount, price) VALUES (?, ?, ?, ?, ?)',
  GET_PRICE_HISTORY = 'SELECT id, price, created AS time from crypto_orders WHERE type = "SELL" ORDER BY id DESC LIMIT 10',
  COUNT_TRANSACTIONS = 'SELECT COUNT(*) AS count from crypto_transactions',
  OFFSET_TRANSACTIONS = 'SELECT id, sender, receiver, amount, created AS time FROM crypto_transactions ORDER BY id DESC OFFSET ? ROWS FETCH NEXT 8 ROWS ONLY',
  OFFSET_TRANSACTIONS_SEARCH =
  'SELECT id, sender, receiver, amount, created AS time FROM crypto_transactions WHERE sender = ? or receiver = ? ORDER BY id DESC OFFSET ? ROWS FETCH NEXT 8 ROWS ONLY',
  CREATE_WALLET = 'INSERT INTO crypto_wallets (owner, wallet, key_phrase) VALUES (?, ?, ?)',
  CREATE_NOTE = 'INSERT INTO npwd_notes (identifier, title, content) VALUES (?, ?, ?)',
  LOGIN = 'SELECT wallet, value from crypto_wallets WHERE key_phrase = ?',
  GET_WALLET_ORDERS = 'SELECT id, type, amount, price FROM crypto_orders WHERE wallet = ? ORDER BY created DESC LIMIT 8',
  GET_WALLET = 'SELECT * from crypto_wallets WHERE wallet = ?',
  GET_WALLET_BY_KEYPHRASE = 'SELECT * from crypto_wallets WHERE key_phrase = ?',
  DELETE_ORDER = 'DELETE from crypto_orders WHERE id = ?',
  LOOKUP_WALLET =
  'SELECT cw.value, cw.wallet, cw.created, COUNT(ct.id) AS total_transactions, SUM(ct.amount) AS total_transacted, MAX(ct.created) as last_transaction from crypto_wallets cw LEFT JOIN crypto_transactions ct ON cw.wallet = ct.sender WHERE cw.wallet = ?'
}

---@param wallet string
---@param value number
---@return boolean
local function removeWalletValue(wallet, value)
  local result = MySQL.update.await(SQL_QUERIES.REMOVE_WALLET_VALUE, { value, wallet })

  return result == 1 and true or false
end

---@param wallet string
local function getWalletOrders(wallet)
  local result = MySQL.prepare.await(SQL_QUERIES.GET_WALLET_ORDERS, { wallet })

  return result
end

---@param sender string
---@param receiver string
---@param value number
local function createTransaction(sender, receiver, value)
  local queries = {
    { query = SQL_QUERIES.ADD_WALLET_VALUE,    values = { value, receiver } },
    { query = SQL_QUERIES.REMOVE_WALLET_VALUE, values = { value, sender } },
    { query = SQL_QUERIES.CREATE_TRANSACTION,  values = { sender, receiver, value } }
  }

  local success = MySQL.transaction.await(queries)
  return success
end

---@param wallet string
---@return number | nil
local function getWalletValue(wallet)
  local result = MySQL.prepare.await(SQL_QUERIES.GET_WALLET, { wallet })

  if result == nil then return nil end

  ---@diagnostic disable-next-line: return-type-mismatch
  return result.value
end

---@param wallet string
---@return boolean
local function checkValidWallet(wallet)
  local result = MySQL.prepare.await(SQL_QUERIES.GET_WALLET, { wallet })

  if result == nil then return false end
  return true
end

---@param data Wallet
lib.callback.register('ag_crypto:getWalletOrders', function(source, data)
  local result = getWalletOrders(data.wallet)
  return result
end)

---@param data LoginData
lib.callback.register('ag_crypto:Login', function(source, data)
  local result = MySQL.prepare.await(SQL_QUERIES.LOGIN, { data.keyPhrase })
  local orders = nil

  if result then
    orders = getWalletOrders(result.wallet)
  end

  return { result = result, orders = orders }
end)

---@param data CreateData
lib.callback.register('ag_crypto:createWallet', function(source, data)
  local player = Player(source).state

  local queries = {
    { query = SQL_QUERIES.CREATE_WALLET, values = { player.citizenid, data.wallet, data.keyPhrase } },
    { query = SQL_QUERIES.CREATE_NOTE,   values = { player.citizenid, 'Wallet Key Phrase', data.keyPhrase } }
  }

  local success = MySQL.transaction.await(queries)

  return success
end)

lib.callback.register('ag_crypto:getTransactionData', function(source, offset, search)
  offset = offset or 0
  search = search or nil

  if search then
    local result = MySQL.query.await(SQL_QUERIES.OFFSET_TRANSACTIONS_SEARCH, { search, search, offset })
    local count = MySQL.query.await(SQL_QUERIES.COUNT_TRANSACTIONS .. ' WHERE sender = ? OR receiver = ?', { search, search })
    return { results = result, count = count[1].count }
  else
    local count = MySQL.query.await(SQL_QUERIES.COUNT_TRANSACTIONS)
    local result = MySQL.query.await(SQL_QUERIES.OFFSET_TRANSACTIONS, { offset })
    return { results = result, count = count[1].count }
  end
end)

lib.callback.register('ag_crypto:getPriceHistory', function(source)
  local result = MySQL.query.await(SQL_QUERIES.GET_PRICE_HISTORY)
  return result
end)

---@param price number
---@param amount number
---@param wallet string
---@param type string
local function CheckOrders(price, amount, wallet, type)
  local result = MySQL.prepare.await(SQL_QUERIES.CHECK_ORDERS, { type, price, amount })
  if not result then return false end

  local queries = {
    { query = SQL_QUERIES.DECREASE_ORDER,     values = { amount, result.id } },
    { query = SQL_QUERIES.ADD_WALLET_VALUE,   values = { amount, wallet } },
    { query = SQL_QUERIES.CREATE_TRANSACTION, values = { result.wallet, wallet, amount } }
  }

  local success = MySQL.transaction.await(queries)

  return success
end

---@param data OrderData
lib.callback.register('ag_crypto:submitBuyOrder', function(source, data)
  local cost = data.amount * data.price
  local balance = exports.pefcl:getDefaultAccountBalance(source)

  if balance.data < cost then
    return { status = 'error', message = 'Your bank does not have enough funds' }
  end

  exports.pefcl:removeBankBalance(source, { amount = cost, message = string.format('Purchased %s Bitcoin for %s each', data.amount, data.price) })
  local player = Player(source).state

  local canFulfil = CheckOrders(data.price, data.amount, data.wallet, 'SELL')

  if not canFulfil then
    local result = MySQL.insert.await(SQL_QUERIES.CREATE_ORDER, { player.citizenid, 'BUY', data.wallet, data.amount, data.price })

    if not result then return { status = 'error', message = 'Unable to execute, report to Tax' } end

    lib.logger(source, 'submitBuyOrder',
      ('Player submitted buy order (%d) of %d for %d on wallet %s'):format(result, data.amount, data.price, data.wallet))

    return { status = 'success', message = 'Successfully submitted a buy order' }
  end
  lib.logger(source, 'submitBuyOrder',
    ('Player submitted buy order of %d for %d on wallet %s and was instantly fulfilled'):format(data.amount, data.price, data.wallet))
  return { status = 'success', message = 'Successfully purchased crypto' }
end)

---@param data OrderData
lib.callback.register('ag_crypto:submitSellOrder', function(source, data)
  local walletValue = getWalletValue(data.wallet)

  if walletValue < data.amount then
    return { status = 'error', message = 'The wallet does not have that much crypto to sell' }
  end

  local removed = removeWalletValue(data.wallet, data.amount)

  if not removed then return { status = 'error', message = 'Unable to execute, report to Tax' } end

  local canFulfil = CheckOrders(data.price, data.amount, data.wallet, 'BUY')
  local player = Player(source).state

  if not canFulfil then
    local result = MySQL.insert.await(SQL_QUERIES.CREATE_ORDER, { player.citizenid, 'SELL', data.wallet, data.amount, data.price })

    if not result then return { status = 'error', message = 'Unable to execute, report to Tax' } end

    lib.logger(source, 'submitSellOrder',
      ('Player submitted sell order (%d) of %d for %d on wallet %s'):format(result, data.amount, data.price, data.wallet))

    return { status = 'success', message = 'Successfully submitted a sell order' }
  end
  lib.logger(source, 'submitSellOrder',
    ('Player submitted sell order of %d for %d on wallet %s and was instantly fulfilled'):format(data.amount, data.price, data.wallet))

  return { status = 'success', message = 'Successfully submitted sell order' }
end)

---@param data TransferData
lib.callback.register('ag_crypto:submitTransfer', function(source, data)
  local walletValue = getWalletValue(data.wallet)

  if walletValue < data.amount then
    return { status = 'error', message = 'Your wallet does not have that much crypto to transfer' }
  end

  local isValidWallet = checkValidWallet(data.transferWallet)

  if not isValidWallet then
    return { status = 'error', message = 'Invalid wallet submitted' }
  end

  local transferred = createTransaction(data.wallet, data.transferWallet, data.amount)

  if not transferred then
    return { status = 'error', message = 'Unable to transfer funds' }
  end

  local player = Player(source).state
  lib.logger(source, 'submitTransfer', ('Player transferred %d to %s from %s'):format(data.amount, data.transferWallet, data.wallet))

  return { status = 'success', message = 'Successfully transferred' }
end)

---@param data WalletLookup
lib.callback.register('ag_crypto:lookupWallet', function(source, data)
  local result = MySQL.query.await(SQL_QUERIES.LOOKUP_WALLET, { data.search })

  if result[1] == nil then return { status = 'error', message = 'Unable to find wallet' } end

  return result[1]
end)

---@param data DeleteOrder
lib.callback.register('ag_crypto:deleteOrder', function(source, data)
  local result = MySQL.query.await(SQL_QUERIES.DELETE_ORDER, { data.id })

  local player = Player(source).state
  lib.logger(source, 'deleteOrder', ('Player deleted buy order %d'):format(data.id))

  return result.affectedRows
end)

local function getWalletByPasscode(passcode)
  local value = MySQL.single.await(SQL_QUERIES.GET_WALLET_BY_KEYPHRASE, { passcode })

  return value and value or nil
end

exports('getWalletByPasscode', getWalletByPasscode)

local function getCryptoValue(wallet)
  local value = MySQL.single.await(SQL_QUERIES.GET_WALLET_VALUE, { wallet })
  return value and value.value or 0
end

exports('getCryptoValue', getCryptoValue)

local function checkWalletByPasscode(data)
  local wallet = getWalletByPasscode(data)
  if not wallet then return nil end
  return { value = wallet.value, wallet = wallet.wallet, key_phrase = wallet.key_phrase }
end

exports('checkWalletByPasscode', checkWalletByPasscode)

lib.callback.register('ag_crypto:checkWalletByPasscode', function(source, data)
  return checkWalletByPasscode(data)
end)

---@param data {wallet: string, amount: number}
RegisterNetEvent('ag_crypto:removeWalletValue', function(data)
  if not data.wallet then return end
  if not data.amount then return end

  MySQL.update(SQL_QUERIES.REMOVE_WALLET_VALUE, { data.amount, data.wallet })
end)
