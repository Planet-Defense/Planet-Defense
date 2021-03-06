return {
	corhrk1 = {
		acceleration = 0.11,
		bmcode = 1,
		brakerate = 0.564,
		buildcostenergy = 5850,
		buildcostmetal = 590,
		builder = false,
		buildpic = "CORHRK.png",
		buildtime = 6591,
		canattack = true,
		canguard = true,
		canmove = true,
		canpatrol = true,
		canstop = 1,
		category = "ALL MEDIUM MOBILE NOTDEFENSE NOTHOVERNOTVTOL NOTSUB NOTSUBNOTSHIP NOTVTOL WEAPON",
		corpse = "DEAD",
		defaultmissiontype = "Standby",
		description = "Anti-Scout Kbot",
		energymake = 0.6,
		energystorage = 0,
		energyuse = 0.6,
		explodeas = "BIG_UNITEX",
		firestandorders = 1,
		footprintx = 2,
		footprintz = 2,
		idleautoheal = 5,
		idletime = 1800,
		maneuverleashlength = 640,
		mass = 560,
		maxdamage = 5500,
		maxslope = 14,
		maxvelocity = 2.8,
		maxwaterdepth = 21,
		metalstorage = 0,
		mobilestandorders = 1,
		movementclass = "KBOT2",
		name = "Sturdle Dominator",
		noautofire = false,
		nochasecategory = "SUB VTOL",
		objectname = "CORHRK",
		seismicsignature = 0,
		selfdestructas = "BIG_UNIT",
		side = "CORE",
		sightdistance = 370.5,
		standingfireorder = 2,
		standingmoveorder = 1,
		steeringmode = 2,
		script = "corhrk.cob",
		turninplaceanglelimit = 140,
		turninplacespeedlimit = 1.188,
		turnrate = 1103,
		unitname = "corhrk1",
		upright = true,
		workertime = 0,
		customparams = {
			buildpic = "CORHRK.png",
		},
		featuredefs = {
			dead = {
				blocking = true,
				category = "corpses",
				collisionvolumeoffsets = "0.59033203125 -0.11500802002 -0.125",
				collisionvolumescales = "31.73046875 27.05418396 31.9737854004",
				collisionvolumetype = "Box",
				damage = 2330,
				description = "Sturdle Dominator Wreckage",
				energy = 0,
				featuredead = "HEAP",
				featurereclamate = "SMUDGE01",
				footprintx = 2,
				footprintz = 2,
				height = 20,
				hitdensity = 100,
				metal = 1248,
				object = "CORHRK_DEAD",
				reclaimable = true,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
			},
			heap = {
				blocking = false,
				category = "heaps",
				damage = 198.00002,
				description = "Sturdle Dominator Heap",
				energy = 0,
				featurereclamate = "SMUDGE01",
				footprintx = 2,
				footprintz = 2,
				height = 4,
				hitdensity = 100,
				metal = 758.39999,
				object = "2X2B",
				reclaimable = true,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
			},
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
				[1] = "kbcormov",
			},
			select = {
				[1] = "kbcorsel",
			},
		},
		weapondefs = {
			corhrk_rocket = {
				areaofeffect = 2100,
				cegtag = "CORRAVENTRAIL",
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.5,
				explosiongenerator = "custom:FLASHJUNO",
				firestarter = 100,
				flighttime = 30,
				impulseboost = 0.123,
				impulsefactor = 0.123,
				metalpershot = 0,
				model = "epulse",
				name = "HeavyRockets",
				noselfdamage = true,
				range = 4000,
				reloadtime = 120,
				smoketrail = true,
				soundhitdry = "junohit2",
				soundstart = "junofir2",
				turnrate = 28384,
				weaponacceleration = 100,
				weapontimer = 5,
				weapontype = "StarburstLauncher",
				weaponvelocity = 800,
				damage = {
					commanders = 1,
					default = 1,
					mines = 1000,
					scouts = 500,
					subs = 1,
				},
			},
		},
		weapons = {
			[1] = {
				def = "CORHRK_ROCKET",
				onlytargetcategory = "NOTVTOL",
			},
		},
	},
}
