fx_version 'cerulean'
games {'gta5'}

description 'Weapon Meta Files'

files {
	'weaponcomponents.meta',
	'weaponarchetypes.meta',
	'weaponanimations.meta',
	'weapons.meta',
	'weapons_pistol_mk2.meta',
	'weaponheavypistol.meta',
	'weapons_snspistol_mk2.meta',
	'weapondbshotgun.meta',
	'weapons_pumpshotgun_mk2.meta',
	'weaponrailgun.meta',
	'weaponcombatpdw.meta',
	'weaponcompactrifle.meta',
	'weaponm14.meta',
	'weapondragunov.meta',
	'weapons_g22.meta',
	'weaponminismg2.meta',
	'weapons_doubleaction.meta',
	'weapons_specialcarbine_mk2.meta',
	'weaponhominglauncher.meta',
	'weapon_ceramicpistol.meta',
	'weapondagger.meta',
	'weapongusenberg.meta',
	'weapon_combatshotgun.meta',
	'weapon_gepard.meta',
	'weaponmachinepistol.meta'
}

-- BASE FILES
data_file 'WEAPONCOMPONENTSINFO_FILE' 'weaponcomponents.meta'
data_file 'WEAPON_METADATA_FILE' 'weaponarchetypes.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'weaponanimations.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons.meta'

-- REPLACE WEAPONS
data_file 'WEAPONINFO_FILE_PATCH' 'weapons_pistol_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weaponheavypistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons_snspistol_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons_pumpshotgun_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapondbshotgun.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weaponrailgun.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weaponcombatpdw.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weaponcompactrifle.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons_doubleaction.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons_specialcarbine_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weaponhominglauncher.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon_ceramicpistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapondagger.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapongusenberg.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon_combatshotgun.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weaponmachinepistol.meta'

-- ADD-ON WEAPONS
data_file 'WEAPONINFO_FILE' 'weapondragunov.meta'
data_file 'WEAPONINFO_FILE' 'weaponm14.meta'
data_file 'WEAPONINFO_FILE' 'weapons_g22.meta'
data_file 'WEAPONINFO_FILE' 'weaponminismg2.meta'
data_file 'WEAPONINFO_FILE' 'weapon_gepard.meta'
dependency '/assetpacks'