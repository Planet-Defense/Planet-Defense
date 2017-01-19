return {
	abuilderlvl3 = {
		acceleration = 0.015,
		airhoverfactor = 0,
		brakerate = 0.35,
		buildcostenergy = 533333,
		buildcostmetal = 26133,
		builddistance = 180,
		builder = true,
		buildtime = 340000,
		canfly = true,
		canguard = true,
		canmove = true,
		canpatrol = true,
		canreclaim = true,
		canstop = 1,
		category = "ALL CONSTR MOBILE NOTDEFENSE NOTSUB NOTSUBNOTSHIP NOTWEAPON VTOL",
		collide = false,
		corpse = "dead",
		cruisealt = 180,
		description = "Cruiser",
		designation = "ARM-SS-SUP",
		dontland = 0,
		energymake = 50,
		energystorage = 750,
		energyuse = 30,
		explodeas = "SHIPBLAST",
		footprintx = 3,
		footprintz = 5,
		hoverattack = true,
		icontype = "air",
		idleautoheal = 5,
		idletime = 1800,
		mass = 24500,
		maxdamage = 7000,
		maxslope = 10,
		maxvelocity = 3.2,
		maxwaterdepth = 0,
		metalmake = 3.75,
		metalstorage = 100,
		name = "Builder Level 3",
		nochasecategory = "SUB VTOL",
		objectname = "ABuilderLvl3",
		radardistance = 0,
		selfdestructas = "SHIPBLAST",
		side = "ARM",
		sightdistance = 400,
		turninplaceanglelimit = 360,
		turninplacespeedlimit = 2.112,
		turnrate = 199.5,
		unitname = "abuilderlvl3",
		workertime = 2000,
		buildoptions = {
			[1] = "afusionplant",
			[2] = "armmas",
			[3] = "ametalmakerlvl2",
			[4] = "armses",
			[5] = "cadvmsto",
			[6] = "armnanotc3",
			[7] = "armgate1",
			[8] = "armamd2",
			[9] = "armanni1",
			[10] = "armhys",
			[11] = "armbrtha1",
			[12] = "armvulc1",
			[13] = "armfsilo",
			[14] = "armtabi",
			[15] = "armshltx1",
			[16] = "ashipyardlvl3",
			[17] = "nebraska2",
		},
		featuredefs = {
			dead = {
				blocking = false,
				category = "arm_corpses",
				damage = 4200,
				description = "Reliance Wreck",
				featurereclamate = "smudge01",
				footprintx = 4,
				footprintz = 8,
				height = 40,
				hitdensity = 100,
				metal = 19600,
				object = "ABuilderLvl3_dead",
				reclaimable = true,
				seqnamereclamate = "tree1reclamate",
				world = "All Worlds",
			},
		},
		nanocolor = {
			[1] = 0.8,
			[2] = 1,
			[3] = 0.8,
		},
		sounds = {
			canceldestruct = "cancel2",
			underattack = "warning1",
			arrived = {
				[1] = "armshipstop",
			},
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
				[1] = "armshipgo",
			},
			select = {
				[1] = "armselect",
			},
		},
	},
}
