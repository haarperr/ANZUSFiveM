local ped = PlayerPedId()

CreateThread(function()
  local resetcounter = 0
  local jumpDisabled = false
  local jumps = 0
  while true do
    Wait(1)
    if jumpDisabled and resetcounter > 0 and IsPedJumping(ped) then
      SetPedToRagdoll(ped, 900, 900, 2, false, false, false)
      resetcounter = 0
    end
    if not jumpDisabled and IsPedJumping(ped) then
      if jumps >= 2 then
        jumpDisabled = true
        jumps = 0
      else
        jumps += 1
      end
      resetcounter = 1000
      Wait(1000)
    end
    if resetcounter > 0 then
      resetcounter = resetcounter - 1
    else
      if jumpDisabled then
        resetcounter = 0
        jumpDisabled = false
        jumps = 0
      end
    end
  end
end)
