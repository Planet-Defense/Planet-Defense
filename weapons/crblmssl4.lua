-- WEAPONDEF -- CRBLMSSL4 --
--------------------------------------------------------------------------------

local weaponName = "crblmssl4"

--------------------------------------------------------------------------------

local weaponDef = {
	areaofeffect = 2720,
	craterboost = 6,
	cratermult = 3,
	edgeeffectiveness = 0.25,
	explosiongenerator = [[custom:FLASHNUKE1920]],
	impulseboost = 0.5,
	impulsefactor = 0.5,
	name = [[Matter/AntimatterExplosion]],
	range = 72000,
	reloadtime = 120,
	soundhit = [[xplomed4]],
	soundstart = [[misicbm1]],
	turret = 1,
	weaponvelocity = 250,
	damage = {
		commanders = 4500,
		default = 171500,
		chicken = 0,
	},
}
--------------------------------------------------------------------------------

return lowerkeys({[weaponName] = weaponDef})

--------------------------------------------------------------------------------
