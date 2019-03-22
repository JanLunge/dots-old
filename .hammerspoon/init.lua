-- A global variable for the Hyper Mode
hyper = hs.hotkey.modal.new({}, 'F15')
hyperMod = {"ctrl", "alt", "cmd", "shift"}
-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
function enterHyperMode()
  hyper.triggered = false
  hyper:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
-- send ESCAPE if no other keys are pressed.
function exitHyperMode()
  hyper:exit()
  if not hyper.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

function move_left()
    local win = hs.window.focusedWindow()
    if win == nil then
        return
    end
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
    redrawBorder()
end

function move_right()
    local win = hs.window.focusedWindow()
    if win == nil then
        return
    end
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
    redrawBorder()
end

function move_topleft()
    local win = hs.window.focusedWindow()
    if win == nil then
        return
    end
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h / 2
    win:setFrame(f)
    redrawBorder()
end

function move_topright()
    local win = hs.window.focusedWindow()
    if win == nil then
        return
    end
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h / 2
    win:setFrame(f)
    redrawBorder()
end

function move_botleft()
    local win = hs.window.focusedWindow()
    if win == nil then
        return
    end
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y + (max.h / 2)
    f.w = max.w / 2
    f.h = max.h / 2
    win:setFrame(f)
    redrawBorder()
end

function move_botright()
    local win = hs.window.focusedWindow()
    if win == nil then
        return
    end
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w / 2)
    f.y = max.y + (max.h / 2)
    f.w = max.w / 2
    f.h = max.h / 2
    win:setFrame(f)
    redrawBorder()
end

function move_vthird(index)
  local win = hs.window.focusedWindow()
  if win == nil then
    return
  end
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + ((max.h / 3) * index)
  f.w = max.w
  f.h = max.h / 3
  win:setFrame(f)
  redrawBorder()
end

function maximize_window()
    local win = hs.window.focusedWindow()
    if win == nil then
        return
    end
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h
    win:setFrame(f)
    redrawBorder()
end

function focus_left()
    local win = hs.window.filter.new():setCurrentSpace(true)
    -- local win = hs.window.focusedWindow()
    if win == nil then
        return
    end
    win:focusWindowWest(nil, false, true)
    -- win:focusWindowWest(nil, nil, True)
end

function focus_right()
    local win = hs.window.filter.new():setCurrentSpace(true)
    if win == nil then
        return
    end
    win:focusWindowEast(nil, false, true)
end

function focus_north()
    local win = hs.window.filter.new():setCurrentSpace(true)
    if win == nil then
        return
    end
    win:focusWindowNorth(nil, false, true)
end

function focus_south()
    local win = hs.window.filter.new():setCurrentSpace(true)
    if win == nil then
        return
    end
    win:focusWindowSouth(nil, false, true)
end


-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', enterHyperMode, exitHyperMode)


-- hyper:bind({}, 'p', function()
--     hs.hints.windowHints
--     hyper.triggered = true
-- end)



-- I always end up losing my mouse pointer, particularly if it's on a monitor full of terminals.
-- This draws a bright red circle around the pointer for a few seconds
function mouseHighlight()
  if mouseCircle then
    mouseCircle:delete()
    if mouseCircleTimer then
      mouseCircleTimer:stop()
    end
  end
  mousepoint = hs.mouse.get()
  mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x-40, mousepoint.y-40, 80, 80))
  mouseCircle:setStrokeColor({["red"]=1,["blue"]=0,["green"]=0,["alpha"]=1})
  mouseCircle:setFill(false)
  mouseCircle:setStrokeWidth(5)
  mouseCircle:show()

  mouseCircleTimer = hs.timer.doAfter(3, function() mouseCircle:delete() end)
end

global_border = nil

function redrawBorder()
  win = hs.window.focusedWindow()
  if win ~= nil then
    top_left = win:topLeft()
    size = win:size()
    if global_border ~= nil then
      global_border:delete()
    end
    global_border = hs.drawing.rectangle(hs.geometry.rect(top_left['x'], top_left['y'], size['w'], size['h']))
    global_border:setStrokeColor({["red"]=0.9,["blue"]=0,["green"]=0.2,["alpha"]=0.8})
    global_border:setFill(false)
    global_border:setStrokeWidth(8)
    global_border:show()
  end
end

redrawBorder()

allwindows = hs.window.filter.new(nil)
allwindows:subscribe(hs.window.filter.windowCreated, function () redrawBorder() end)
allwindows:subscribe(hs.window.filter.windowFocused, function () redrawBorder() end)
allwindows:subscribe(hs.window.filter.windowMoved, function () redrawBorder() end)
allwindows:subscribe(hs.window.filter.windowUnfocused, function () redrawBorder() end)


hyper:bind({}, 'Left', function()
    move_left()
    hyper.triggered = true
end)
hyper:bind({}, 'Right', function()
    move_right()
    hyper.triggered = true
end)
hyper:bind({}, 'Up', function()
    maximize_window()
    hyper.triggered = true
end)
hyper:bind({}, 'h', function()
    focus_left()
    hyper.triggered = true
end)
hyper:bind({}, 'l', function()
    focus_right()
    hyper.triggered = true
end)

hyper:bind({}, 'i', function()
    ret = hs.application.launchOrFocus('iTerm')
    hyper.triggered = true
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
    hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
end)
-- write out the clipboard
hs.hotkey.bind({"cmd", "alt"}, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)

-- hs.hints.style = 'vimperator'
--hs.hints.showTitleThresh = 10
-- hs.hotkey.bind({'cmd', 'alt'}, 'p', hs.hints.windowHints)
-- hyper:bind({}, 'u', function()
--     hs.hints.windowHints()
--     hyper.triggered = true
-- end)
hyper:bind({}, 't', function()
    hs.eventtap.keyStroke({'alt'}, 'space')
    hyper.triggered = true
end)
hyper:bind({}, 'v', function()
    hs.application.launchOrFocus("Vivaldi")
    hyper.triggered = true
end)
hyper:bind({}, 'a', function()
    hs.application.launchOrFocus("Google Chrome")
    hyper.triggered = true
end)
hyper:bind({}, 'n', function()
    hs.application.launchOrFocus("Google Chrome")
    hyper.triggered = true
end)
hyper:bind({}, 'o', function()
    hs.application.launchOrFocus("Telegram")
    hyper.triggered = true
end)
hyper:bind({}, 'r', function()
    hs.application.launchOrFocus("PhpStorm")
    hyper.triggered = true
end)

hyper:bind({}, 'e', function()
    hs.application.launchOrFocus("Emacs")
    hyper.triggered = true
end)
hyper:bind({}, 'l', function()
    move_vthird(0)
    hyper.triggered = true
end)
hyper:bind({}, 'c', function()
    move_vthird(1)
    hyper.triggered = true
end)
hyper:bind({}, 'w', function()
    move_vthird(2)
    hyper.triggered = true
end)

---- hypermod
hs.hotkey.bind(hyperMod, 'n', function()
    hs.application.launchOrFocus("Google Chrome")
end)
hs.hotkey.bind(hyperMod, 'r', function()
    hs.application.launchOrFocus("PhpStorm")
end)
hs.hotkey.bind(hyperMod, 'g', function()
    hs.osascript.applescriptFromFile("/Users/jan/playground/automate/youtube-music-play.applescript")
end)
------------------------------------------------
-- GRID
------------------------------------------------
hs.grid.setGrid('4x4')
hs.grid.setMargins('10x10')
hs.hotkey.bind({'cmd'}, 'g', hs.grid.show)
--hs.hotkey.bind({'cmd'}, 'h', hs.grid.show)


------------------------------------------------
-- Expose
------------------------------------------------
-- set up your instance(s)
expose = hs.expose.new(nil,{showThumbnails=false}) -- default windowfilter, no thumbnails
expose_app = hs.expose.new(nil,{onlyActiveApplication=true}) -- show windows for the current application
expose_space = hs.expose.new(nil,{includeOtherSpaces=false}) -- only windows in the current Mission Control Space
expose_browsers = hs.expose.new{'Safari','Google Chrome'} -- specialized expose using a custom windowfilter
-- for your dozens of browser windows :)

-- then bind to a hotkey
hs.expose.ui.maxHintLetters = 1
--hs.hotkey.bind('ctrl-cmd','e','Expose',function()expose:toggleShow()end)
--hs.hotkey.bind('ctrl-cmd-shift','e','App Expose',function()expose_app:toggleShow()end)
--hs.hotkey.bind('cmd','e','Expose',function()expose:toggleShow()end)




hs.window.animationDuration = 0.1


hs.alert.show('Config loaded!')

function reloadConfig()
  if configFileWatcher ~= nil then
    configFileWatcher:stop()
    configFileWatcher = nil
  end

  hs.reload()
end

configFileWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/init.lua", reloadConfig)
configFileWatcher:start()

--[ hourly alarm ]----------------------------------------------------------
hs.timer.doAt("0:00","1h", function() hs.alert("Ding Dong") end)

