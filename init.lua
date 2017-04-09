--- Ryan's Hammerspoon Config. Forked from CCravens ---
-- Constants

local mash = {"cmd", "ctrl"}
local smash = {"cmd", "ctrl", "shift"}
local shopt = {"alt","shift"}
local shcmd = {"cmd","shift"}

local center    = { x= 0 , y= 0 }
local north     = { x= 0 , y= 1 }
local south     = { x= 0 , y=-1 }
local east      = { x= 1 , y= 0 }
local west      = { x=-1 , y= 0 }
local northeast = { x= 1 , y= 1 }
local southeast = { x=-1 , y= 1 }
local northwest = { x= 1 , y=-1 }
local southwest = { x=-1 , y=-1 }

-- Defines for window grid
hs.grid.setGrid('2x2','2560x1440') -- main monitor
hs.grid.setGrid('2x4','1440x2560') -- rotated monitor
hs.grid.setGrid('2x2','1920x1200') -- laptop (can go to 2880x1800!)
hs.grid.setGrid('2x2','1920x1080') -- home monitor
hs.grid.setMargins({0,0})

-- global screen information
-- my two screens have identical hardware-specified names
-- ("Thunderbolt Display") so in order to specify a display, I need a
-- display object.

-- 69731904 = "Color LCD"           = laptop screen
-- 69507481 = "Thunderbolt Display" = center???
-- 69505650 = "Thunderbolt Display" = right???

local myScreens = hs.screen.allScreens()
local numberOfScreens = #myScreens

-- Hotkeys to interact with the window grid
hs.hotkey.bind(mash, 'H'  , hs.grid.pushWindowLeft)
hs.hotkey.bind(mash, 'L' , hs.grid.pushWindowRight)
hs.hotkey.bind(mash, 'K'    , hs.grid.pushWindowUp)
hs.hotkey.bind(mash, 'J'  , hs.grid.pushWindowDown)

hs.hotkey.bind(mash, 'Left'  , hs.grid.pushWindowLeft)
hs.hotkey.bind(mash, 'Right' , hs.grid.pushWindowRight)
hs.hotkey.bind(mash, 'Up'    , hs.grid.pushWindowUp)
hs.hotkey.bind(mash, 'Down'  , hs.grid.pushWindowDown)

hs.hotkey.bind(smash, 'H'  , hs.grid.resizeWindowThinner)
hs.hotkey.bind(smash, 'L' , hs.grid.resizeWindowWider)
hs.hotkey.bind(smash, 'K'    , hs.grid.resizeWindowShorter)
hs.hotkey.bind(smash, 'J'  , hs.grid.resizeWindowTaller)

hs.hotkey.bind(smash, 'Left'  , hs.grid.resizeWindowThinner)
hs.hotkey.bind(smash, 'Right' , hs.grid.resizeWindowWider)
hs.hotkey.bind(smash, 'Up'    , hs.grid.resizeWindowShorter)
hs.hotkey.bind(smash, 'Down'  , hs.grid.resizeWindowTaller)

hs.hotkey.bind(shcmd, 'K'     , function()
    local win = hs.window.focusedWindow()
    win:focusWindowNorth()
end)

hs.hotkey.bind(shcmd, 'J'     , function()
    local win = hs.window.focusedWindow()
    win:focusWindowSouth()
end)

hs.hotkey.bind(shcmd, 'H'     , function()
    local win = hs.window.focusedWindow()
    win:focusWindowWest()
end)

hs.hotkey.bind(shcmd, 'L'     , function()
    local win = hs.window.focusedWindow()
    win:focusWindowEast()
end)

hs.hotkey.bind(shcmd, 'Up'    , function()
    local win = hs.window.focusedWindow()
    win:focusWindowNorth()
end)

hs.hotkey.bind(shcmd, 'Down'  , function()
    local win = hs.window.focusedWindow()
    win:focusWindowSouth()
end)

hs.hotkey.bind(shcmd, 'Left'  , function()
    local win = hs.window.focusedWindow()
    win:focusWindowWest()
end)

hs.hotkey.bind(shcmd, 'Right' , function()
    local win = hs.window.focusedWindow()
    win:focusWindowEast()
end)

-- informational foo
hs.hotkey.bind(mash, "W", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    
    hs.alert.show("foo: " .. max.x .. ":" .. max.y .. ":" .. max.w .. ":" .. max.h)
end)

-- -- function positionWindowThirds(gravity)
-- --     local win = hs.window.focusedWindow()
-- --     local f = win:frame()
-- --     local screen = win:screen()
-- --     local max = screen:frame()
-- -- 
-- --     -- first, we want to check if the window is *already* in the
-- --     -- initial position requested.  If so, expand it to the second
-- --     -- position... 1/3 becomes 2/3 for left and right.
-- --     if gravity == center then
-- --        f.x = max.x + (max.w / 3) -- middle third
-- --     elseif gravity == west then
-- --        f.x = max.x
-- --     elseif gravity == east then
-- --        f.x = max.w - (max.w / 3)
-- --     else
-- --        f.x = max.x
-- --     end
-- --     f.y = max.y
-- --     f.w = max.w / 3
-- --     f.h = max.h
-- --     win:setFrame(f)
-- -- end
-- -- 
-- -- -- playing with moving windows
-- -- -- middle third
-- -- hs.hotkey.bind(mash, "D", function()
-- --     positionWindowThirds(center)
-- -- end)
-- -- 
-- -- -- left third
-- -- hs.hotkey.bind(mash, "S", function()
-- --     positionWindowThirds(west)
-- -- end)
-- -- 
-- -- -- right-third
-- -- hs.hotkey.bind(mash, "F", function()
-- --     positionWindowThirds(east)
-- -- end)

-- permanent layouts
-- local rightScreen = "Thunderbolt Display"
-- local windowLayout = {
--    { "Thunderbird", nil, rightScreen, hs.layout.left50, nil, nil },
-- }
-- hs.layout.apply(windowLayout)
-- end permanent layouts

-- auto-reload config file
function reloadConfig(files)
   doReload = false
   for _,file in pairs(files) do
      if file:sub(-4) == ".lua" then
         doReload = true
      end
   end
   if doReload then
      hs.reload()
   end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
-- end auto-reload
