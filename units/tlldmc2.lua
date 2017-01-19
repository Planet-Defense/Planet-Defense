return {
	tlldmc2 = {
		bmcode = 0,
		buildangle = 8192,
		buildcostenergy = 542000,
		buildcostmetal = 46467,
		builder = false,
		buildinggrounddecaldecayspeed = 30,
		buildinggrounddecalsizex = 8,
		buildinggrounddecalsizey = 8,
		buildinggrounddecaltype = "tlldmc_aoplane.dds",
		buildpic = "tlldmc.png",
		buildtime = 300000,
		canattack = true,
		canstop = 1,
		category = "ALL NOTHOVERNOTVTOL NOTMOBILE NOTSUB NOTSUBNOTSHIP NOTVTOL WEAPON",
		corpse = "dead",
		defaultmissiontype = "GUARD_NOMOVE",
		description = "Super Dark Matter Cannon",
		designation = "ARM-ERC",
		energymake = 0,
		energystorage = 0,
		energyuse = 0,
		explodeas = "MEDIUM_BUILDINGEX",
		firestandorders = 1,
		footprintx = 6,
		footprintz = 6,
		icontype = "building",
		idleautoheal = 7,
		idletime = 1800,
		losemitheight = 49.5,
		mass = 22000,
		maxdamage = 200000,
		maxslope = 10,
		maxwaterdepth = 0,
		metalstorage = 0,
		name = "Super DMC",
		noautofire = false,
		objectname = "tlldmc2",
		radardistance = 0,
		radaremitheight = 49.5,
		selfdestructas = "MEDIUM_BUILDING",
		shootme = 1,
		sightdistance = 2850,
		standingfireorder = 0,
		script = "tlldmc.cob",
		unitname = "tlldmc2",
		unitnumber = 200000,
		usebuildinggrounddecal = true,
		workertime = 0,
		yardmap = "ooooooo ooooooo ooooooo ooooooo ooooooo ooooooo ooooooo",
		customparams = {
			buildpic = "tlldmc.png",
			canareaattack = 1,
		},
		featuredefs = {
			dead = {
				blocking = false,
				category = "corpses",
				damage = 100000,
				description = "Super DMC Wreckage",
				energy = 0,
				featuredead = "heap",
				featurereclamate = "SMUDGE01",
				footprintx = 7,
				footprintz = 7,
				height = 40,
				hitdensity = 100,
				metal = 35600,
				object = "TLLDMC2_DEAD",
				reclaimable = false,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
			},
			heap = {
				blocking = false,
				category = "heaps",
				damage = 60800.00195,
				description = "Super DMC Heap",
				energy = 0,
				featurereclamate = "SMUDGE01",
				footprintx = 3,
				footprintz = 3,
				height = 4,
				hitdensity = 100,
				metal = 25080,
				object = "3X3E",
				reclaimable = false,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
			},
		},
		sfxtypes = {
			explosiongenerators = {
				[1] = "custom:tlldmc_flare",
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
				[1] = "servlrg3",
			},
			select = {
				[1] = "servlrg3",
			},
		},
		weapondefs = {
			tlldmc = {
				areaofeffect = 600,
				cegtag = "Trail_dmc_cannon",
				collidefriendly = false,
				craterboost = 0,
				cratermult = 0,
				duration = 0.025,
				energypershot = 350000,
				explosiongenerator = "custom:Tlldmc_Explosion",
				firestarter = 90,
				id = 254,
				impactonly = 1,
				impulseboost = 0,
				impulsefactor = 0,
				intensity = 0.75,
				name = "Dark Matter Cannon",
				nogap = 1,
				noselfdamage = true,
				range = 3820,
				reloadtime = 10,
				rgbcolor = "1 0.15 0.15",
				size = 7,
				sizedecay = -0.25,
				soundhitdry = "xplolrg1",
				soundstart = "Energy",
				stages = 20,
				turret = true,
				weapontype = "Cannon",
				weaponvelocity = 1400,
				damage = {
					commanders = 25000,
					default = 125000,
					experimental_land = 350000,
					experimental_ships = 350000,
					subs = 5,
				},
			},
			tlldmc_rapid = {
				areaofeffect = 360,
				cegtag = "Trail_dmc_cannon",
				collidefriendly = false,
				craterboost = 0,
				cratermult = 0,
				duration = 0.025,
				energypershot = 175000,
				explosiongenerator = "custom:Tlldmc_Explosion",
				firestarter = 90,
				impactonly = 1,
				impulseboost = 0,
				impulsefactor = 0,
				intensity = 0.75,
				name = "Dark Matter Cannon",
				nogap = 1,
				noselfdamage = true,
				range = 3820,
				reloadtime = 5,
				rgbcolor = "1 0.15 0.15",
				size = 7,
				sizedecay = -0.25,
				soundhitdry = "xplolrg1",
				soundstart = "Energy",
				stages = 20,
				turret = true,
				weapontype = "Cannon",
				weaponvelocity = 1400,
				damage = {
					commanders = 10000,
					default = 50000,
					experimental_land = 150000,
					experimental_ships = 150000,
					subs = 5,
				},
			},
		},
		weapons = {
			[1] = {
				badtargetcategory = "MEDIUM SMALL TINY",
				def = "tlldmc",
				onlytargetcategory = "NOTVTOL",
			},
			[2] = {
				badtargetcategory = "MEDIUM SMALL TINY",
				def = "tlldmc_rapid",
				onlytargetcategory = "NOTVTOL",
			},
		},
	},
}
