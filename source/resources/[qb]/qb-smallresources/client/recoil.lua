local recoils = {
	-- Melee
	-- [-1834847097] = 0.3,		--['weapon_dagger']
	-- [-1786099057] = 0.3,		--['weapon_bat']
	-- [-102323637] = 0.3,		--['weapon_bottle']
	-- [2067956739] = 0.3,		--['weapon_crowbar']
	-- [-1951375401] = 0.3,		--['weapon_flashlight']
	-- [1141786504] = 0.3,		--['weapon_golfclub']
	-- [1317494643] = 0.3,		--['weapon_hammer']
	-- [-102973651] = 0.3,		--['weapon_hatchet']
	-- [-656458692] = 0.3,		--['weapon_knuckle']
	-- [-1716189206] = 0.3,		--['weapon_knife']
	-- [-581044007] = 0.3,		--['weapon_machete']
	-- [-538741184] = 0.3,		--['weapon_switchblade']
	-- [1737195953] = 0.3,		--['weapon_nightstick']
	-- [419712736] = 0.3,		--['weapon_wrench']
	-- [-853065399] = 0.3,		--['weapon_battleaxe']
	-- [-1810795771] = 0.3,		--['weapon_poolcue']
	-- [-2000187721] = 0.0,		--['weapon_briefcase']
	-- [28811031] = 0.0,		--['weapon_briefcase_02']
	-- [-499989876] = 0.0,		--['weapon_garbagebag']
	-- [-800287667] = 0.0,		--['weapon_handcuffs']
	-- [1309015656] = 0.0,		--['weapon_bread']
	-- [940833800] = 0.3,		--['weapon_stone_hatchet']

	-- Handguns
	[`WEAPON_PISTOL`] = 0.9,			--[1911]
	[`WEAPON_PISTOL_MK2`] = 0.9,		-- [P226]
	[`WEAPON_COMBATPISTOL`] = 0.9,		--[Combat Pistol]
	[`WEAPON_APPISTOL`] = 2.5,			--[Full Auto Glock]
	[`WEAPON_STUNGUN`] = 0.1,			--[Stungun]
	[`WEAPON_PISTOL50`] = 2.7,		    --[Desert Eagle]
	[`WEAPON_SNSPISTOL`] = 0.9,		    --[SNS Pistol]
	[`WEAPON_HEAVYPISTOL`] = 1.2,	    --[19911 w/ Scope]
	[`WEAPON_VINTAGEPISTOL`] = 0.9,		--[Vintage Pistol]
	[`WEAPON_FLAREGUN`] = 0.9,			--[Flaregun]
	[`WEAPON_MARKSMANPISTOL`] = 0.9,	--[Marksman Pistol]
	[`WEAPON_REVOLVER`] = 2.7,		    --[Revolver]
	[`WEAPON_REVOLVER_MK2`] = 2.7,		--[Revolver MK2]
	[`WEAPON_DOUBLEACTION`] = 1.0,		--['Double Action]
	[`WEAPON_SNSPISTOL_MK2`] = 0.3,		--[SNS Pistol MK2]
	[`WEAPON_RAYPISTOL`] = 0.3,		    --[Ray Pistol]
	[`WEAPON_CERAMICPISTOL`] = 0.3,		--[Ceramic Pistol]
	[`WEAPON_NAVYREVOLVER`] = 1.6,		--[Navy Revolver]
	[`WEAPON_GADGETPISTOL`] = 0.3,		--[Gadget Pistol]
	[`WEAPON_GLOCK`] = 0.9,    			--[PD Glock]
	[`WEAPON_BROWNING`] = 1.3,          --[Browning]
	['WEAPON_FN57'] = 1.5,              --[FN57]
	['WEAPON_DP9'] = 1.3,               --[Diamondback DB9]

	-- Submachine Guns
	[`WEAPON_MICROSMG2`] = 3.1,	--[UZI]
	[`WEAPON_SMG`] = 1.2,		--[MP5]
	[`WEAPON_ASSAULTSMG`] = 1.2, --[Assault SMG]
	[`WEAPON_COMBATPDW`] = 0.2,	--[Combat PDW]
	[`WEAPON_MACHINEPISTOL`] = 2.5,	--[Tec 9]
	[`WEAPON_MINISMG`] = 0.5,		--[Skorpion]

	-- Shotguns
	[`WEAPON_PUMPSHOTGUN`] = 0.4, --[IZH-81]
	[`WEAPON_SAWNOFFSHOTGUN`] = 0.7,    --[Sawnoff Shotgun]
	[`WEAPON_ASSAULTSHOTGUN`] = 1.9,    --[Assault Shotgun]
	[`WEAPON_BULLPUPSHOTGUN`] = 1.6,	--[Bullpup Shotgun]
	[`WEAPON_MUSKET`] = 0.7,		    --[Musket]
	[`WEAPON_HEAVYSHOTGUN`] = 1.2,		--[Heavy Shotgun]
	[`WEAPON_DBSHOTGUN`] = 0.7,			--[DB Shotgun]
	[`WEAPON_PUMPSHOTGUN_MK2`] = 0.4,	--[PD Shotgun]
	[`WEAPON_COMBATSHOTGUN`] = 0.4,		--[SPAS 12]

	-- Assault Rifles
	[`WEAPON_ASSAULTRIFLE`] = 1.3,		--[AK-74]
	[`WEAPON_ASSAULTRIFLE_MK2`] = 1.3,	--['weapon_assaultrifle_mk2']
	[`WEAPON_CARBINERIFLE`] = 0.9,		--['weapon_carbinerifle']
	[`WEAPON_CARBINERIFLE_MK2`] = 0.9,	--['weapon_carbinerifle_mk2']
	[`WEAPON_ADVANCEDRIFLE`] = 0.8,		--['weapon_advancedrifle']
	[`WEAPON_SPECIALCARBINE`] = 0.8,	--['weapon_specialcarbine']
	[`WEAPON_BULLPUPRIFLE`] = 0.9,		--['weapon_bullpuprifle']
	[`WEAPON_COMPACTRIFLE`] = 0.4,		--['weapon_compactrifle']
	[`WEAPON_SPECIALCARBINE_MK2`] = 1.2, --['weapon_specialcarbine_mk2']
	[`WEAPON_BULLPUPRIFLE_MK2`] = 0.9,	--['weapon_bullpuprifle_mk2']
	[`WEAPON_MILITARYRIFLE`] = 0.9,		--['weapon_militaryrifle']
	[`WEAPON_M4`] = 1.2,
	[`WEAPON_TACTICALRIFLE`] = 1.2,

	-- Light Machine Guns
	[`WEAPON_MG`] = 0.9,		        --['weapon_mg']
	[`WEAPON_COMBATMG`] = 0.9,			--['weapon_combatmg']
	[`WEAPON_GUNSENBERG`] = 0.6,	    --['weapon_gusenberg']
	[`WEAPON_COMBATMG_MK2`] = 0.9,		--['weapon_combatmg_mk2']

	-- Sniper Rifles
	[`WEAPON_SNIPERRIFLE`] = 0.5,		--['weapon_sniperrifle']
	[`WEAPON_HEAVYRIFLE`] = 0.7,		--['weapon_heavysniper']
	[`WEAPON_MARKSMANRIFLE`] = 0.7,		--['weapon_marksmanrifle']
	[`WEAPON_HEAVYSNIPER_MK2`] = 0.6,	--['weapon_heavysniper_mk2']
	[`WEAPON_MARKSMANRIFLE_MK2`] = 0.7,	--['weapon_marksmanrifle_mk2']
	[`WEAPON_PRECISIONRIFLE`] = 0.5,
	['WEAPON_DRAGUNOV'] = 0.3,

	[`WEAPON_M14`] = 0.1,       --[M14 SWAT]
	[`WEAPON_G22`] = 0.1,       --[G22]

	-- Heavy Weapons
	[`WEAPON_RPG`] = 0.0,		        --['weapon_rpg']
	[`WEAPON_GRENADELAUNCHER`] = 1.0,		--['weapon_grenadelauncher']
	[`WEAPON_MINIGUN`] = 0.5,			--['weapon_minigun']
	[`WEAPON_FIREWORK`] = 0.3,			--['weapon_firework']
	[`WEAPON_RAILGUN`] = 2.4,			--['weapon_railgun']
	[`WEAPON_HOMINGLAUNCHER`] = 0.0,	--['weapon_hominglauncher']
	[`WEAPON_COMPACTLAUNCHER`] = 0.5,	--['weapon_compactlauncher']
	[`WEAPON_RAYMINIGUN`] = 0.3,		--['weapon_rayminigun']
	

	-- Throwables
	-- [-1813897027] = 0.3,		--['weapon_grenade']
	-- [-1600701090] = 0.3,		--['weapon_bzgas']
	-- [615608432] = 0.3,		--['weapon_molotov']
	-- [741814745] = 0.3,		--['weapon_stickybomb']
	-- [-1420407917] = 0.3,		--['weapon_proxmine']
	-- [126349499] = 0.3,		--['weapon_snowball']
	-- [-1169823560] = 0.3,		--['weapon_pipebomb']
	-- [600439132] = 0.3,		--['weapon_ball']
	-- [-37975472] = 0.3,		--['weapon_smokegrenade']
	-- [1233104067] = 0.3,		--['weapon_flare']

	-- Miscellaneous
	-- [883325847] = 0.3,		--['weapon_petrolcan']
	-- [101631238] = 0.3,		--['weapon_fireextinguisher']
	-- [-1168940174] = 0.3,		--['weapon_hazardcan']
}

CreateThread(function()
	while true do
		if IsPedShooting(cache.ped) and not IsPedDoingDriveby(cache.ped) then
			local _, wep = GetCurrentPedWeapon(cache.ped)
			if recoils[wep] and recoils[wep] ~= 0 then
				-- luacheck: ignore
				local tv = 0
				if GetFollowPedCamViewMode() ~= 4 then
					repeat
						Wait(0)
						local p = GetGameplayCamRelativePitch()
						SetGameplayCamRelativePitch(p+0.1, 0.2)
						tv += 0.1
					until tv >= recoils[wep]
				else
					repeat
						Wait(0)
						local p = GetGameplayCamRelativePitch()
						if recoils[wep] > 0.1 then
							SetGameplayCamRelativePitch(p+0.6, 1.2)
							tv += 0.6
						else
							SetGameplayCamRelativePitch(p+0.016, 0.333)
							tv += 0.1
						end
					until tv >= recoils[wep]
				end
			end
		end
		Wait(0)
	end
end)
