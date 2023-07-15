local function GetConfigNumber(houseid)
	local GState = HouseData
	if GState[houseid] then
		return GState[houseid].number
	end
end

local function IsWearingHandShoes()
	local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
	local model = GetEntityModel(PlayerPedId())
	local retval = true
	if model == `mp_m_freemode_01` then
		if Config.MaleNoHandshoes[armIndex] ~= nil and Config.MaleNoHandshoes[armIndex] then
			retval = false
		end
	else
		if Config.FemaleNoHandshoes[armIndex] ~= nil and Config.FemaleNoHandshoes[armIndex] then
			retval = false
		end
	end
	return retval
end

local function IsWearingShoes()
	local footIndex = GetPedDrawableVariation(PlayerPedId(), 6)
	local model = GetEntityModel(PlayerPedId())
	return footIndex ~= 34
end

---@param title? string
---@param description string
---@param type? 'error' | 'success' | 'default'
local function Notify(title, description, type)
	lib.notify({ title = title, description = description, type = type })
end

---comment
---@param type "drill" | "lockpick" | "screw_driver" | "hammer"
local function TargetLabel(type)
	if type == "drill" then
		return "Drill the safe.."
	elseif type == "lockpick" then
		return "Lockpick the stash"
	elseif type == "screw_driver" then
		return "Screw the stash"
	elseif type == "hammer" then
		return "Smash the safe.."
	else
		return "Crack the stash.."
	end
end

local function DrawOutline(entity)
	if not entity then return end
	if not Config.Debug then return end
	if not DoesEntityExist(entity) then return end
	SetEntityDrawOutline(entity, true)
	SetEntityDrawOutlineColor(255, 35, 35, 0.8)
end

local function StartDebugging()
	if not Config.Debug then return end
	if not IsInside then return end
	local housecoords = GetEntityCoords(ShellData.entity)
	CreateThread(function()
		while IsInside do
			SetTextScale(0.4, 0.4)
			SetTextColour(0, 0, 0, 255)
			SetTextEntry("STRING")
			AddTextComponentString("Debug: true")
			DrawText(0.90, 0.1)
			if ShellData.entity then
				local ped = PlayerPedId()
				local heading = GetEntityHeading(ped)
				local coords = GetEntityCoords(ped)
				local xdist, ydist, zdist = coords.x - housecoords.x, coords.y - housecoords.y, coords.z - housecoords.z
				SetTextScale(0.4, 0.4)
				SetTextColour(0, 0, 0, 255)
				SetTextCentre(true)
				SetTextEntry("STRING")
				AddTextComponentString(string.format("Offsets: x: %.2f, y: %.2f, z: %.2f, h: %.2f", xdist, ydist, zdist,
					heading))
				DrawText(0.5, 0.1)
				if IsControlJustPressed(0, 215) then
					local zonedata = {
						name = "your:name",
						coords = vec3(xdist, ydist, zdist),
						size = vec3(0.3, 0.3, 0.7),
						rotation = heading,
						label = "Your label"
					}

					local code = string.format([[
{
  name = "%s",
  coords = vec3(%f, %f, %f),
  size = vec3(%f, %f, %f),
  rotation = %f,
  label = "%s"
}
]], zonedata.name, zonedata.coords.x, zonedata.coords.y, zonedata.coords.z, zonedata.size.x, zonedata.size.y,
						zonedata.size.z, zonedata.rotation, zonedata.label)

					code = string.gsub(code, ", ", ",\n  ")
					lib.setClipboard(code)
					-- lib.setClipboard(string.format("vector4(%.2f, %.2f, %.2f, %.2f)", xdist, ydist, zdist, heading))
				end
			end
			Wait(1)
		end
	end)
end

local function IsDead()
	return PlayerData.metadata.isdead or PlayerData.metadata.inlaststand
end

return {
	GetConfigNumber = GetConfigNumber,
	IsWearingHandShoes = IsWearingHandShoes,
	IsWearingShoes = IsWearingShoes,
	Notify = Notify,
	TargetLabel = TargetLabel,
	DrawOutline = DrawOutline,
	StartDebugging = StartDebugging,
	IsDead = IsDead
}
