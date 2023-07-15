---@class LoginData
---@field keyPhrase string

---@class CreateData
---@field keyPhrase string
---@field wallet string

---@class OrderData
---@field amount number
---@field price number
---@field wallet string

---@class Wallet
---@field wallet string

---@class TransactionSearch
---@field page number
---@field search string | nil

---@class WalletLookup
---@field search string

---@class TransferData
---@field amount number
---@field transferWallet string
---@field wallet string

---@class DeleteOrder
---@field id number

---@param data TransactionSearch
local function getTransactionData(data)
    local res = lib.callback.await('ag_crypto:getTransactionData', 500, data.page, data.search)
    SendNuiMessage(json.encode({
        action = 'updateTransactionData',
        data = res
    }))
end

local function getPriceHistory()
    local res = lib.callback.await('ag_crypto:getPriceHistory', 500)
    SendNuiMessage(json.encode({
        action = 'updatePriceHistory',
        data = res
    }))
end

local function openUi()
    SetNuiFocus(true, true)
    SendNuiMessage(json.encode({
        action = 'setVisible'
    }))
    getPriceHistory()
    getTransactionData({ page = 0, search = nil })
end

---@param data LoginData
---@param cb function
RegisterNUICallback('login', function(data, cb)
    local res = lib.callback.await('ag_crypto:Login', 500, data)

    if res.result == nil then
        lib.notify({ type = 'error', description = 'Invalid key phrase' })
    end

    cb(res)
end)

---@param data WalletLookup
---@param cb function
RegisterNUICallback('walletLookup', function(data, cb)
    local res = lib.callback.await('ag_crypto:lookupWallet', 500, data)

    cb(res)
end)

---@param data CreateData
RegisterNUICallback('createWallet', function(data, cb)
    local res = lib.callback.await('ag_crypto:createWallet', 200, data)

    if res == nil then
        lib.notify({ type = 'error', description = 'Unknown error occured' })
    end

    cb(res)
end)

---@param data TransactionSearch
---@param cb function
RegisterNUICallback('getTransactionData', function(data, cb)
    getTransactionData(data or 0)
    cb(true)
end)

---@param data Wallet
RegisterNUICallback('getUserOrders', function(data, cb)
    local res = lib.callback.await('ag_crypto:getWalletOrders', 500, data)
    cb(res)
end)

---@param data DeleteOrder
RegisterNUICallback('deleteOrder', function(data, cb)
    local res = lib.callback.await('ag_crypto:deleteOrder', 500, data)

    cb(res)
end)

---@param data TransactionSearch
---@param cb function
RegisterNUICallback('getOwnTransactionData', function(data, cb)
    local res = lib.callback.await('ag_crypto:getTransactionData', 500, data.page, data.search)
    cb(res)
end)


RegisterNUICallback('getPriceHistory', function()
    getPriceHistory()
end)

---@param data TransferData
---@param cb function
RegisterNUICallback('submitTransfer', function(data, cb)
    local res = lib.callback.await('ag_crypto:submitTransfer', 200, data)

    cb(res)
end)

---@param data OrderData
---@param cb function
RegisterNUICallback('submitBuyOrder', function(data, cb)
    local res = lib.callback.await('ag_crypto:submitBuyOrder', 200, data)

    cb(res)
end)

---@param data OrderData
---@param cb function
RegisterNUICallback('submitSellOrder', function(data, cb)
    local res = lib.callback.await('ag_crypto:submitSellOrder', 200, data)

    cb(res)
end)

RegisterCommand('openc', function()
    openUi()
end)

RegisterNUICallback('exit', function(_, cb)
    cb(1)
    SetNuiFocus(false, false)
end)
