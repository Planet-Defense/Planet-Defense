--------------------------------------------------------------------------------
--Planet Defense Config
--------------------------------------------------------------------------------

maxChicken           = tonumber(Spring.GetModOptions().mo_maxchicken) or 400
maxBurrows           = 18 -- Max burrows on the game, even with 1 player only
gracePeriod          = tonumber(Spring.GetModOptions().mo_graceperiod) or 160  -- no chicken spawn in this period, seconds
queenTime            = (Spring.GetModOptions().mo_queentime or 40) * 60 -- time at which the queen appears, seconds
addQueenAnger        = tonumber(Spring.GetModOptions().mo_queenanger) or 1
burrowSpawnType      = Spring.GetModOptions().mo_chickenstart or "avoid"
spawnSquare          = 250       -- size of the chicken spawn square centered on the burrow
spawnSquareIncrement = 5         -- square size increase for each unit spawned
burrowName           = "rroost"   -- burrow unit name
maxAge               = 3600      -- chicken die at this age, seconds
queenName            = Spring.GetModOptions().mo_queendifficulty.."r"  or "n_chickenqr" 
burrowDef            = UnitDefNames[burrowName].id
defenderChance       = 0.5       -- probability of spawning a single turret
maxTurrets           = 3   		 -- Max Turrets per burrow
queenSpawnMult       = 1         -- how many times bigger is a queen hatch than a normal burrow hatch
burrowSpawnRate      = 60
chickenSpawnRate     = 59
minBaseDistance      = 600      
maxBaseDistance      = 7200
chickensPerPlayer    = 40
spawnChance          = 1.0
bonusTurret          = "armrl" -- Turret that gets spawned when a burrow dies
angerBonus           = 0.25
expStep              = 0.0625
lobberEMPTime        = 4
damageMod            = 1
waves                = {}
newWaveSquad         = {}

local mRandom        = math.random

bonusTurret5a = "armflak"
bonusTurret5b = "arm_big_bertha"
bonusTurret7a = "tlldb"

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function Copy(original)
  local copy = {} 
  for k, v in pairs(original) do
    if (type(v) == "table") then
      copy[k] = Copy(v)
    else
      copy[k] = v
    end
  end
  return copy
end

local function addWave(wave, unitList)
 if not waves[wave] then waves[wave] = {} end
 table.insert(waves[wave], unitList)
end





   
local chickenTypes = {
  ve_chickenqr  =  true,
  e_chickenqr   =  true,
  n_chickenqr   =  true,
  h_chickenqr   =  true,
  vh_chickenqr  =  true,
  fh_chickenqr  =  true,
  corcrash      =  true,
  armflea       =  true,
  armflash      =  true,
  armflash1     =  true,
  armsam        =  true,
  armsam1       =  true,
  bladew        =  true,
  cormist       =  true,
  cormist1      =  true,
  corthud       =  true,
  corthud1      =  true,
  armrectr      =  true,
  armstump      =  true,
  armthund      =  true,
  armblz        =  true,
  tllprob       =  true,
  corhurc       =  true,
  armjanus1     =  true,
  corgol        =  true,
  armraven1     =  true, --piece count 16
  armshock1     =  true,
  armsnipe      =  true,
  taipan        =  true,
  armmerl       =  true,
  tankanotor    =  true,
  airwolf3g     =  true,
  armcybr       =  true,
  corpyro       =  true, --piece count 17
  krogtaar      =  true, --piece count 13
  corprot       =  true, --piece count 26
  cortotal      =  true, --piece count 6
  armraven      =  true, --piece count 16
  tllsham       =  true,
  corkrog       =  true, --piece count 21
  arm_furie     =  true, --piece count 18
  corkarg       =  true, --piece count 33
  corkarg1      =  true, --piece count 33
  corgala       =  true, --piece count 20
  armcrabe      =  true, --piece count 10
  trem          =  true,
  clb           =  true,
  armzeus       =  true,
  armzeus1      =  true,
  tllcoyote     =  true,
  armack        =  true,
  corack        =  true,
  tllack        =  true,
  armfark       =  true,
  armraz        =  true,
  armshock      =  true,
  armbanth      =  true,
  bladew1       =  true,
  armspy1       =  true,
  corak         =  true,
  armpw         =  true,
  roland        =  true,
  corhrk1       =  true,
  requ2         =  true,
  requ3         =  true,

  
  armhdpw       =  true,
  armbull       =  true,
  cordem        =  true, --piece count 23
  tllgrim       =  true, --piece count 24
  aexxec        =  true, --piece count 8
  armaak        =  true,
  corsumo       =  true, --piece count 16
  corsumo1      =  true, --piece count 16
  corhrk        =  true, --piece count 9
  armfboy       =  true, --piece count 10
  cormort       =  true,
  corcrw        =  true,
  armcyclone    =  true,
  armfast       =  true,
  gorg          =  true, --piece count 23
  armtigre2     =  true, --piece count 18
  armlaspd      =  true,
  armsonic      =  true,
  cormonsta     =  true, --piece count 12
  armpraet      =  true, --piece count 17
  armjag        =  true, --piece count 27
  corspec       =  true,
  armspid       =  true,
  anvil         =  true, --piece count 4
  hyperion      =  true, --piece count 28
  armorion      =  true, --piece count 3
  corrag        =  true,
  armmart       =  true,
  --new
  marauder      =  true, --piece count 15
  heavyimpact   =  true, --piece count 17
  tllblind      =  true, --piece count 13
  tllvaliant    =  true, --piece count 22
  abroadside    =  true, --piece count 25
  tlllongshot   =  true, --piece count 5
  tllcrawlb     =  true,
  airwolf3g     =  true,
  armbanthaar   =  true,
  wplatform     =  true,
  cormddm       =  true,
  mammouth      =  true,
  tawf114       =  true,
  tllcome       =  true,
  armcomm       =  true,
  corcomh       =  true,
  
  --added only for insane king spawn
  abroadside    =  true, 
  cdevastator   =  true, 
  monkeylord    =  true,
  irritator     =  true,
}

local defenders = { 
  armrl = true,
  armflak = true,
  arm_big_bertha = true,
  tlldb = true,
}
--First weak wave
addWave(1,{"5 armflea", "5 armflea", "2 armstump", "5 armflash", "1 armfark", "2 armaak"})
addWave(1,{"5 armflea", "1 armfark", "4 corthud", "5 armflea", "2 armpw", "3 corak"})

--t1 only
newWaveSquad[2] =
addWave(2,{"5 armflea", "1 armack", "2 armstump", "5 armflash", "1 armfark", "2 armaak"})
addWave(2,{"1 tllack", "1 corack", "4 corthud", "5 armstump", "2 armjanus1", "3 armaak"})

--t1/t1.5
newWaveSquad[3] =
addWave(3,{"5 armflea", "5 armstump", "2 armstump", "8 armflash", "1 armfark", "1 roland"})
addWave(3,{"5 armstump", "1 armfark", "4 corthud", "5 armstump", "4 armfboy", "1 roland"})

--t1.5 
newWaveSquad[4] = 
addWave(4,{"10 bladew1", "1 corack", "4 tllcoyote", "5 armflash1", "4 armflash1", "1 corthud"})
addWave(4,{"10 bladew1", "5 armflash1", "3 armflash1", "1 armack", "1 tllack", "5 armshock1"})


--t1.5/t2
newWaveSquad[5] =
addWave(5,{"1 corsumo", "1 wplatform", "3 armsnipe", "1 corhrk1", "1 tllcome", "3 tllcoyote", "5 corsumo", "1 armaak"})
addWave(5,{"1 cormonsta", "1 armraz", "3 armsnipe", "5 corgol", "5 armbull", "1 tllcome", "1 corhrk1"})


--t2 --wip beyond
newWaveSquad[6] =
addWave(6,{"1 mammouth", "1 krogtaar", "1 armspy1", "1 requ2", "3 corprot", "5 cormddm", "2 roland"})
addWave(6,{"1 wplatform", "2 corkarg", "1 armspy1", "3 requ3", "3 armsnipe", "2 cortotal", "1 corhrk1"})


newWaveSquad[7] =
addWave(7,{"2 tllcome", "1 krogtaar", "2 requ3", "2 corcrw", "1 corhrk1", "5 roland", "1 armbanthaar"})
addWave(7,{"2 tllcome",  "5 airwolf3g", "1 requ2", "1 corhrk1", "1 roland", "1 armbanth", "1 krogtaar", "4 armorion"})


newWaveSquad[8] =
addWave(8,{"2 corcomh", "1 armbanthaar", "1 mammouth", "1 corhrk1", "2 corkarg", "5 armsnipe", "2 airwolf3g", "2 roland"})
addWave(8,{"2 corcomh", "1 armbanthaar", "2 requ3", "1 corhrk1", "2 armbanth", "5 armshock", "1 corkrog", "2 corcrw"})


newWaveSquad[9] =
addWave(9,{"2 requ3", "1 hyperion", "5 corcrw", "5 corkarg", "2 mammouth", "2 roland"})
addWave(9,{"3 armraven", "1 hyperion", "2 requ2", "7 roland", "1 hyperion", "1 corcomh"})


newWaveSquad[10] =
addWave(10,{"2 anvil", "1 armcomm", "2 corcrw", "2 corkarg", "4 mammouth", "2 roland", "3 wplatform", "1 arm_furie", "3 armorion"})
addWave(10,{"2 anvil", "1 armcomm", "2 airwolf3g", "3 roland", "1 hyperion", "1 corcomh", "1 armcomm", "3 wplatform", "6 heavyimpact"})


newWaveSquad[11] =
addWave(11,{"2 arm_furie", "1 corkrog1", "1 corhrk1", "2 requ2", "5 corcrw", "5 hyperion", "1 corcomh", "1 abroadside"})
addWave(11,{"2 arm_furie", "1 corkrog1", "1 corhrk1", "2 requ3", "5 roland", "4 corkrog1", "3 corcomh"})


newWaveSquad[12] = {"3 corkrog", "6 heavyimpact"}
addWave(12,{"1 corkrog1", "1 corgala"})
addWave(12,{"2 corcrw", "2 corcrw", "3 corhrk1", "2 corcrw", "2 corcrw"})
addWave(12,{"2 corcrw", "2 corcrw", "3 corhrk1", "2 corcrw", "2 corcrw"})
if (queenName == "e_chickenqr") then addWave(12,{"1 corkrog1" ,"1 corgala", "1 corcomh", "10 roland", "1 requ3"}) end
if (queenName == "n_chickenqr") then addWave(12,{"2 cdevastator" ,"2 abroadside", "2 corcomh", "20 roland", "5 requ3"}) end
if (queenName == "h_chickenqr") then addWave(12,{"3 cdevastator" ,"3 abroadside", "3 corcomh", "30 roland", "10 requ3"}) end
addWave(12,{"1 tllvaliant", "1 tllvaliant"})
addWave(12,{"1 arm_furie", "1 arm_furie", "1 arm_furie"})
addWave(12,{"4 armorion", "4 armorion"})
addWave(12,{"3 corcrw", "3 corcrw", "3 corcrw", "3 corcrw"})

FEWPLAYERS = "1-4 Players"
MOREPLAYERS = "5-8 Players"
TEAMGAME = "+9 Players"
CUSTOM = "Custom"

difficulties = {
  [FEWPLAYERS] = {
    chickenSpawnRate  = 240, 
    burrowSpawnRate   = 240,
    queenSpawnMult    = 3,
    angerBonus        = 2.00,
    expStep           = 0.5,
    lobberEMPTime     = 2.5,
    chickenTypes      = Copy(chickenTypes),
    defenders         = Copy(defenders),
    chickensPerPlayer = 40,
    spawnChance       = 1.00,
    damageMod         = 0.8,
  },
  
  [MOREPLAYERS] = {
    chickenSpawnRate  = 240, 
    burrowSpawnRate   = 180,
    queenSpawnMult    = 4,
    angerBonus        = 2.00,
    expStep           = 0.5,
    lobberEMPTime     = 2.5,
    chickenTypes      = Copy(chickenTypes),
    defenders         = Copy(defenders),
    chickensPerPlayer = 40,
    spawnChance       = 1.00,
    damageMod         = 0.9,
  },
  
  [TEAMGAME] = {
    chickenSpawnRate  = 240, 
    burrowSpawnRate   = 30,
    queenSpawnMult    = 5,
    angerBonus        = 2.00,
    expStep           = 0.5,
    lobberEMPTime     = 2.5,
    chickenTypes      = Copy(chickenTypes),
    defenders         = Copy(defenders),
    chickensPerPlayer = 40,
    spawnChance       = 1.00,
    damageMod         = 1.00,
  },

  
  [CUSTOM] = {
    chickenSpawnRate  = tonumber(Spring.GetModOptions().mo_custom_chickenspawn),
    burrowSpawnRate   = tonumber(Spring.GetModOptions().mo_custom_burrowspawn),
    queenSpawnMult    = tonumber(Spring.GetModOptions().mo_custom_queenspawnmult),
    angerBonus        = tonumber(Spring.GetModOptions().mo_custom_angerbonus),
    expStep           = (tonumber(Spring.GetModOptions().mo_custom_expstep) or 0.6) * -1,
    lobberEMPTime     = tonumber(Spring.GetModOptions().mo_custom_lobberemp),
    chickenTypes      = Copy(chickenTypes),
    defenders         = Copy(defenders),
    chickensPerPlayer = tonumber(Spring.GetModOptions().mo_custom_minchicken),
    spawnChance       = (tonumber(Spring.GetModOptions().mo_custom_spawnchance) or 50) / 100,
    damageMod         = (tonumber(Spring.GetModOptions().mo_custom_damagemod) or 100) / 100,
  },

}



defaultDifficulty = 'Custom'

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
