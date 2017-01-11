-- $Id$
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "Chicken Panel",
    desc      = "Shows stuff",
    author    = "quantum",
    date      = "May 04, 2008",
    license   = "GNU GPL, v2 or later",
    layer     = -9,
    enabled   = true  --  loaded by default?
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

if (not Spring.GetGameRulesParam("difficulty")) then
  return false
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local Spring          = Spring
local GetGameSeconds  = Spring.GetGameSeconds
local GetGameRulesParam = Spring.GetGameRulesParam
local GetGameRulesParams = Spring.GetGameRulesParams
local gl              = gl
local widgetHandler   = widgetHandler
local math            = math
local table           = table

local displayList
local spawnList
local fontHandler     = loadstring(VFS.LoadFile(LUAUI_DIRNAME.."modfonts.lua", VFS.ZIP_FIRST))()
local panelFont       = LUAUI_DIRNAME.."Fonts/FreeSansBold_14"
local waveFont        = LUAUI_DIRNAME.."Fonts/Skrawl_40"
local panelTexture

local viewSizeX, viewSizeY = 0,0
local w               = 300
local h               = 210
local x1              = - w - 50
local y1              = - h - 50
local panelMarginX    = 30
local panelMarginY    = 40
local panelSpacingY   = 7
local waveSpacingY    = 7
local moving
local capture
local gameInfo
local waveSpeed       = 0.2
local waveCount       = 0
local currentTimeSeconds
local waveTimeTimer
local waveTimeSeconds
local enabled
local gotScore
local scoreCount	  = 0

local guiPanel --// a displayList
local spawnPanel --// a displayList
local updatePanel
local updateSpawnPanel
local hasChickenEvent = false


local side
local aifaction
local mo_level = tonumber(Spring.GetModOptions().mo_norobot)
local cenabled = mo_level == 5

if cenabled then
  side = "Queen"
  aifaction = "Chicken's"
  panelTexture    = ":n:"..LUAUI_DIRNAME.."Images/panel.tga"
else
  side = "King"
  aifaction = "Robot's"
  panelTexture    = ":n:"..LUAUI_DIRNAME.."Images/panel.tga" -- todo make panel for robot mode
end


local red             = "\255\255\001\001"
local white           = "\255\255\255\255"

local difficulties = {
  [1] = '1-4 Players',
  [2] = '5-8 Players',
  [3] = '+9 Players',
  [4] = 'Custom',
}

local waveColors = {}
waveColors[1] = "\255\184\100\255"
waveColors[2] = "\255\120\50\255"
waveColors[3] = "\255\255\153\102"
waveColors[4] = "\255\120\230\230"
waveColors[5] = "\255\100\255\100"
waveColors[6] = "\255\150\001\001"
waveColors[7] = "\255\255\255\100"
waveColors[8] = "\255\100\255\255"
waveColors[9] = "\255\100\100\255"
waveColors[10] = "\255\200\050\050"
waveColors[11] = "\255\255\255\255"

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


fontHandler.UseFont(panelFont)
local panelFontSize  = fontHandler.GetFontSize()
fontHandler.UseFont(waveFont)
local waveFontSize   = fontHandler.GetFontSize()

function CommaValue(amount)
  local formatted = amount
  while true do
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

local function ScaleRGBInt(RGBInt)
  local OldMin = 0
  local OldMax = 255
  local OldRange = (OldMax - OldMin)
  local NewMin = 20
  local NewMax = 255
  local NewValue
  if (OldRange == 0) then
      NewValue = (NewMin + NewMax) / 2
  else
      local NewRange = (NewMax - NewMin)
      NewValue = (((RGBInt - OldMin) * NewRange) / OldRange) + NewMin
  end
  return NewValue
end

local function GetUnitDefColor(unitDef)
  local power = unitDef.power

  local hardKingPower = UnitDefNames['h_chickenqr'] and UnitDefNames['h_chickenqr'].power or 6000

  local scaleFraction = math.log(hardKingPower/3)/255

  local red = math.min(255, math.max(0, math.ceil(math.log(power/3)/scaleFraction)))
  local green = 255 - red

  red = ScaleRGBInt(red)
  green = ScaleRGBInt(green)

  return string.char(255) .. string.char(red) .. string.char(green) .. string.char(50)

end

local function GetSquadCountTable(count_or_kills, sortByPower)
  local total = 0
  local t = {}
  for ruleName, value in pairs(gameInfo) do

    if string.match(ruleName, count_or_kills) then
      local unitName = ruleName:gsub(count_or_kills, "")
      local squadDef = UnitDefNames[unitName]

      local subTotal = value

      -- skip empty squaddefs and burrows, subtotal, squaddef and squaddef.name should not be nil
      if subTotal and squadDef and subTotal > 0 and squadDef.name ~= "rroost" and squadDef.name ~= "roost" then
        local squadPower = squadDef.power * subTotal
        local squadName = squadDef.humanName
        local unitDefColor = GetUnitDefColor(squadDef)
        table.insert(t, { unitDefColor .. subTotal .. " " .. squadName .. white, squadPower })
        total = total + subTotal
      end
    end
  end

  -- sort squads by cumulative power
  if sortByPower then
    table.sort(t, function( a,b )
      if (a[2] < b[2]) then
        return false
      elseif (a[2] > b[2]) then
        return true
      else
        return false
      end
    end)
  end

  -- strip power sums strings,power-table
  local tempTable = {}
  for k, v in pairs(t) do
    tempTable[k] = v[1]
  end

  return tempTable, total
end

local function ShortenColorString(str, length)
  if #str+2 > length then
    local substring = string.sub(str, 0, length)
    -- strip color bytes in ending
    str = string.match(substring, "(.*%w)")..white..'...'
  end
  return str
end

local function MakeCountString(type, showbreakdown)

  local t, total = GetSquadCountTable(type, true)

  if showbreakdown then
    -- join squad strings
    local csvColorSquads =  table.concat(t, ",")
    local squadsShort = ShortenColorString(csvColorSquads, 22)

    local squadsString = total > 0 and '('..squadsShort..')' or ''
    return aifaction..': '..total..' '.. squadsString
  else
    return (aifaction.." Kills: " .. white .. total)
  end
end

local function UpdatePos(x, y)
  x1 = math.min(viewSizeX-w/2,x)
  y1 = math.min(viewSizeY-h/2,y)
  updatePanel = true
end


local function PanelRow(n, indent)
  return panelMarginX + (indent and indent or 0), h-panelMarginY-(n-1)*(panelFontSize+panelSpacingY)
end


local function WaveRow(n)
  return n*(waveFontSize+waveSpacingY)
end


local function CreatePanelDisplayList()
  gl.PushMatrix()
  gl.Translate(x1, y1, 0)
  gl.CallList(displayList)
  fontHandler.DisableCache()
  fontHandler.UseFont(panelFont)
  fontHandler.BindTexture()
  local stageProgress = ""
  if (currentTimeSeconds > gameInfo.gracePeriod and waveCount > 0) then
    if gameInfo.queenAnger < 100 then
      local secondsLeftWave = math.max(0, math.ceil(GetGameRulesParam('chickenSpawnRate') - (waveTimeSeconds and currentTimeSeconds - waveTimeSeconds or 0)))
      stageProgress = side.." Anger: " .. gameInfo.queenAnger .. "% (wave "..(waveCount+1).." in "..secondsLeftWave.."s)"
    else
      stageProgress = side.." Health: " .. gameInfo.queenLife .. "%"
    end
  else
    stageProgress = "Grace Period: " .. math.max(0, math.floor(gameInfo.gracePeriod - currentTimeSeconds))
  end

  fontHandler.DrawStatic(white.. stageProgress, PanelRow(1))
  fontHandler.DrawStatic(white..gameInfo.unitCounts, PanelRow(2))
  fontHandler.DrawStatic(white..gameInfo.unitKills, PanelRow(3))

  if cenabled then
    fontHandler.DrawStatic(white.."Burrows: "..gameInfo.roostCount, PanelRow(4))
    fontHandler.DrawStatic(white.."Burrow Kills: "..gameInfo.roostKills, PanelRow(5))
  else
    fontHandler.DrawStatic(white.."Burrows: "..gameInfo.rroostCount, PanelRow(4))
    fontHandler.DrawStatic(white.."Burrow Kills: "..gameInfo.rroostKills, PanelRow(5))
  end

  if gotScore then
    fontHandler.DrawStatic(white.."Your Score: "..CommaValue(scoreCount), 88, h-170)
  else
    fontHandler.DrawStatic(white.."Mode: "..difficulties[gameInfo.difficulty], 120, h-170)
  end

  gl.Texture(false)
  gl.PopMatrix()
end

local function DrawBlackAlphaBox(minX, minY, minZ, maxX, maxY, maxZ)
   gl.BeginEnd(GL.QUADS, function()
      gl.Color(0,0,0,0.45)
      --// top
      gl.Vertex(minX, maxY, minZ);
      gl.Vertex(maxX, maxY, minZ);
      gl.Vertex(maxX, maxY, maxZ);
      gl.Vertex(minX, maxY, maxZ);
      --// bottom
      gl.Vertex(minX, minY, minZ);
      gl.Vertex(minX, minY, maxZ);
      gl.Vertex(maxX, minY, maxZ);
      gl.Vertex(maxX, minY, minZ);
   end);
   gl.BeginEnd(GL.QUAD_STRIP, function()
      --// sides
      gl.Vertex(minX, minY, minZ);
      gl.Vertex(minX, maxY, minZ);
      gl.Vertex(minX, minY, maxZ);
      gl.Vertex(minX, maxY, maxZ);
      gl.Vertex(maxX, minY, maxZ);
      gl.Vertex(maxX, maxY, maxZ);
      gl.Vertex(maxX, minY, minZ);
      gl.Vertex(maxX, maxY, minZ);
      gl.Vertex(minX, minY, minZ);
      gl.Vertex(minX, maxY, minZ);
   end);
end

local function Draw()
  currentTimeSeconds = GetGameSeconds()

  if (not enabled)or(not gameInfo) then
    return
  end

  if (updatePanel) then
    if (guiPanel) then gl.DeleteList(guiPanel); guiPanel=nil end
    guiPanel = gl.CreateList(CreatePanelDisplayList)
    updatePanel = false
  end

  if (guiPanel) then
    gl.CallList(guiPanel)
  end

  if (updateSpawnPanel) then
    if (spawnPanel) then gl.DeleteList(spawnPanel); spawnPanel=nil end
    spawnPanel = gl.CreateList(CreatePanelDisplayList)
    updateSpawnPanel = false
  end

  if (spawnPanel) then
    gl.CallList(spawnPanel)
  end

  if (waveMessage)  then
    local t = Spring.GetTimer()
    fontHandler.UseFont(waveFont)
    local waveY = viewSizeY - Spring.DiffTimers(t, waveTimeTimer)*waveSpeed*viewSizeY
    if (waveY > 0) then
      for i, message in ipairs(waveMessage) do
        fontHandler.DrawCentered(message, viewSizeX/2, waveY-WaveRow(i))
      end
    else
      waveMessage = nil
      waveY = viewSizeY
    end
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


local function UpdateRules()
  if (not gameInfo) then
    gameInfo = {}
  end
  for ruleNumber, ruleTable in pairs(GetGameRulesParams()) do
    if type(ruleTable) == 'table' then
      for name, value in pairs(ruleTable) do
        if value ~= nil then
          gameInfo[name] = value
        end
      end
    end
  end

  gameInfo.unitCounts = MakeCountString("Count", true)
  gameInfo.unitKills  = MakeCountString("Kills", false)

  updatePanel = true
end


function ChickenEvent(chickenEventArgs)
  if (chickenEventArgs.type == "wave") then
    waveTimeSeconds = currentTimeSeconds
    waveTimeTimer = Spring.GetTimer()
    if cenabled then
      if (gameInfo.roostCount < 1) then
        return
      end
    else
      if (gameInfo.rroostCount < 1) then
        return
      end
    end
    waveMessage    = {}
    waveCount      = waveCount + 1
    waveMessage[1] = "Wave "..waveCount
    waveMessage[2] = waveColors[chickenEventArgs.tech]..chickenEventArgs.number.." "..aifaction

  elseif (chickenEventArgs.type == "burrowSpawn") then
    UpdateRules()
  elseif (chickenEventArgs.type == "queen") then
    waveMessage    = {}
    waveMessage[1] = "The "..side.." is angered!"
  elseif (chickenEventArgs.type == "score"..(Spring.GetMyTeamID())) then
    gotScore = chickenEventArgs.number
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:Initialize()
  displayList = gl.CreateList( function()
    gl.Color(1, 1, 1, 1)
    gl.Texture(panelTexture)
    gl.TexRect(0, 0, w, h)
  end)

  spawnList = gl.CreateList( function()
    gl.Color(0.5, 1, 1, 0)
    gl.Texture(panelTexture)
    gl.TexRect(0, 0, 100, 100)
  end)

  widgetHandler:RegisterGlobal("ChickenEvent", ChickenEvent)

  UpdateRules()
   viewSizeX, viewSizeY = gl.GetViewSizes()
  local x = math.abs(math.floor(viewSizeX - 320))
  local y = math.abs(math.floor(viewSizeY - 300))
  UpdatePos(x, y)
end


function widget:Shutdown()
  if hasChickenEvent then
    Spring.SendCommands({"luarules HasChickenEvent 0"})
  end
  fontHandler.FreeFont(panelFont)
  fontHandler.FreeFont(waveFont)

  if (guiPanel) then gl.DeleteList(guiPanel); guiPanel=nil end

  gl.DeleteList(displayList)
  gl.DeleteTexture(panelTexture)
  widgetHandler:DeregisterGlobal("ChickenEvent")
end

function widget:GameFrame(n)
  if not(hasChickenEvent) and n > 0 then
    Spring.SendCommands({"luarules HasChickenEvent 1"})
    hasChickenEvent = true
  end
  if (n%30< 1) then
    UpdateRules()

    if (not enabled and n > 0) then
      enabled = true
    end

  end
  if gotScore then
    local sDif = gotScore - scoreCount
    if sDif > 0 then
      scoreCount = scoreCount + math.ceil(sDif / 7.654321)
      if scoreCount > gotScore then
        scoreCount = gotScore
      else
        updatePanel = true
      end
    end
  end
end


function widget:DrawScreen()
  Draw()
end


function widget:MouseMove(x, y, dx, dy, button)
  if (enabled and moving) then
    UpdatePos(x1 + dx, y1 + dy)
  end
end


function widget:IsAbove(x, y)
  local hoverXMin = x1 + 110
  local hoverYMin = y1 + 160
  local yMargin = 7
  -- within unitdefs text row in chicken box and grace passed and more than 0 squads spawned
  if hoverXMin < x and y1 + 145 < y and x < x1 + 240 and y < hoverYMin and currentTimeSeconds > gameInfo.gracePeriod and #GetSquadCountTable('Count', true) > 0 then
    local squadCountTable = GetSquadCountTable('Count', true)
    spawnPanel = gl.CreateList(function()
      local dropdownIndent = 100
      local squadDropdownHeight = (#squadCountTable)*(panelFontSize+panelSpacingY)+yMargin
      DrawBlackAlphaBox(hoverXMin+5,hoverYMin,0,hoverXMin+185,hoverYMin-squadDropdownHeight,0)
      gl.PushMatrix()
      gl.Translate(x1, y1, 0)

      fontHandler.DisableCache()
      fontHandler.UseFont(panelFont)
      fontHandler.BindTexture()
      for i, v in ipairs(squadCountTable) do
        v = ShortenColorString(v, 19)
        -- draw row with indentation and top margin
        local displayListX, displayListY = PanelRow(1 + i, dropdownIndent)
        fontHandler.DrawStatic(v, displayListX, displayListY-yMargin)
      end

      gl.PopMatrix()
    end)
  end
  DeleteSpawnPanel()
end

function DeleteSpawnPanel()
  if spawnPanel then
    gl.DeleteList(spawnPanel)
    spawnPanel = nil
  end
end

function widget:MousePress(x, y, button)
  if (enabled and
       x > x1 and x < x1 + w and
       y > y1 and y < y1 + h) then
    capture = true
    moving  = true
  end
  return capture
end


function widget:MouseRelease(x, y, button)
  if (not enabled) then
    return
  end
  capture = nil
  moving  = nil
  return capture
end


function widget:ViewResize(vsx, vsy)
  x1 = math.floor(x1 - viewSizeX)
  y1 = math.floor(y1 - viewSizeY)
  viewSizeX, viewSizeY = vsx, vsy
  x1 = viewSizeX + x1
  y1 = viewSizeY + y1
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- for debug
function table.has_value(tab, val)
    for _, value in ipairs (tab) do
        if value == val then
            return true
        end
    end
    return false
end

function table.full_of(tab, val)
    for _, value in ipairs (tab) do
        if value ~= val then
            return false
        end
    end
    return true
end

-- for printing tables
function table.val_to_str(v)
  if "string" == type(v) then
    v = string.gsub(v, "\n", "\\n" )
    if string.match(string.gsub(v,"[^'\"]",""), '^"+$' ) then
      return "'" .. v .. "'"
    end
    return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
  else
    return "table" == type(v) and table.tostring(v) or
      tostring(v)
  end
end

function table.key_to_str(k)
  if "string" == type(k) and string.match(k, "^[_%a][_%a%d]*$" ) then
    return k
  else
    return "[" .. table.val_to_str(k) .. "]"
  end
end

function table.tostring(tbl)
  local result, done = {}, {}
  for k, v in ipairs(tbl ) do
    table.insert(result, table.val_to_str(v) )
    done[ k ] = true
  end
  for k, v in pairs(tbl) do
    if not done[ k ] then
      table.insert(result,
        table.key_to_str(k) .. "=" .. table.val_to_str(v) )
    end
  end
  return "{" .. table.concat(result, "," ) .. "}"
end
