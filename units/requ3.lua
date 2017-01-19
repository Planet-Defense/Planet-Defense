return {
	requ3 = {
		acceleration = 0.024,
		bmcode = 1,
		brakerate = 0.024,
		buildcostenergy = 65000,
		buildcostmetal = 5100,
		builder = false,
		buildpic = "REQU1.png",
		buildtime = 98945,
		canattack = true,
		canbuild = true,
		canguard = true,
		canmove = true,
		canpatrol = true,
		canstop = 1,
		category = "ALL LARGE MOBILE NOTDEFENSE NOTHOVERNOTVTOL NOTSUB NOTSUBNOTSHIP NOTVTOL WEAPON",
		defaultmissiontype = "Standby",
		description = "Mobile Nuclear Tank",
		energymake = 0,
		energystorage = 10,
		energyuse = 0.8,
		explodeas = "CORGRIPN_BOMB",
		firestandorders = 1,
		firestate = 2,
		footprintx = 6,
		footprintz = 6,
		idleautoheal = 5,
		idletime = 1800,
		leavetracks = true,
		maneuverleashlength = 640,
		mass = 3901,
		maxdamage = 15000,
		maxslope = 12,
		maxvelocity = 0.85,
		maxwaterdepth = 100,
		metalstorage = 2,
		mobilestandorders = 1,
		movementclass = "TANK3",
		name = "Nuclear Aegis",
		noautofire = false,
		nochasecategory = "SUB VTOL",
		objectname = "REQU3",
		radardistance = 1800,
		selfdestructas = "SPYBOMBX",
		shootme = 1,
		side = "CORE",
		sightdistance = 390,
		standingfireorder = 2,
		standingmoveorder = 1,
		steeringmode = 1,
		script = "requ1.cob",
		trackoffset = 8,
		trackstrength = 10,
		trackstretch = 1,
		tracktype = "StdTank",
		trackwidth = 100,
		turninplace = 0,
		turninplaceanglelimit = 140,
		turninplacespeedlimit = 0.5478,
		turnrate = 165,
		unitname = "requ3",
		unitnumber = 323,
		workertime = 0,
		customparams = {
			buildpic = "REQU1.png",
			requiretech = "Advanced T2 Unit Research Centre",
		},
		sounds = {
			canceldestruct = "cancel2",
			underattack = "warning1",
			cant = {
				[1] = "cantdo4",
			},
			count = {
				[1] = "count6",
				[2] = "count5",
				[3] = "count4",
				[4] = "count3",
				[5] = "count2",
				[6] = "count1",
			},
			ok = {
				[1] = "tarmmove",
			},
			select = {
				[1] = "tarmsel",
			},
		},
		weapondefs = {
			cortron_weapon2 = {
				areaofeffect = 1650,
				avoidfriendly = false,
				cegtag = "Trail_Large_Rocket",
				collidefriendly = false,
				craterboost = 6,
				cratermult = 3,
				edgeeffectiveness = 0.3,
				energypershot = 0,
				explosiongenerator = "custom:nuke_explo_1280",
				firestarter = 0,
				flighttime = 400,
				impulseboost = 0.5,
				impulsefactor = 2.5,
				model = "crblmssl",
				name = "CoreNuclearMissile",
				range = 72000,
				reloadtime = 150,
				smoketrail = true,
				soundhitdry = "xplomed4",
				soundstart = "misicbm1",
				targetable = 1,
				tolerance = 4000,
				turnrate = 32768,
				weaponacceleration = 100,
				weapontimer = 9,
				weapontype = "StarburstLauncher",
				weaponvelocity = 600,
				damage = {
					bomb_resistant = 4000,
					commanders = 2500,
					default = 12000,
					subs = 5,
				},
			},
		},
		weapons = {
			[1] = {
				badtargetcategory = "MOBILE",
				def = "CORTRON_WEAPON2",
				onlytargetcategory = "NOTVTOL",
			},
		},
	},
}
