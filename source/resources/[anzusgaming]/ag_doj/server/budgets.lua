local function DiscordLog(title, fields)
  local embedData = {
    {
      title = title,
      color = 14423100,
      footer = {
        text = os.date('%c'),
      },
      fields = fields,
      author = {
        name = 'Randy',
        icon_url = 'https://cdn.mk3ext.dev/yuva7/KoyAduha19.png/raw',
      },
    }
  }
  PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = 'Randy', embeds = embedData }), { ["Content-Type"] = 'application/json' })
end

AddEventHandler("pefcl:newTransaction", function(transaction)
  if not transaction.fromAccount then return end
  local account = transaction.fromAccount.ownerIdentifier
  if account ~= 'lspd' and account ~= 'gov' and account ~= 'ambulance' then return end

  local webhook = GetConvar(('budget_%s_webhook'):format(account), "nil")

  if webhook == "nil" then return end

  local fields = {
    {
      name = 'Type',
      value = transaction.type,
      inline = true
    },
    {
      name = 'Amount',
      value = '$' .. transaction.amount,
      inline = true
    },
    {
      name = 'Balance',
      value = '$' .. transaction.fromAccount.balance,
      inline = true
    }
  }

  if transaction.toAccount then
    fields[#fields + 1] = {
      name = 'To',
      value = transaction.toAccount.number
    }
  end

  fields[#fields + 1] = {
    name = 'Message',
    value = ('```%s```'):format(transaction.message),
    inline = false
  }

  DiscordLog('Bank Transaction', fields)
end)
