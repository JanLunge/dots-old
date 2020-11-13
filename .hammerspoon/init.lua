-- A global variable for the Hyper Mode
hyper = hs.hotkey.modal.new({}, 'F15')
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
  hyper.triggered = true
end
-- Bind the Hyper key
f15 = hs.hotkey.bind({}, 'F15', enterHyperMode, exitHyperMode)


hyperMod = {"ctrl", "alt", "cmd", "shift"}
hyperSmall = {"ctrl", "alt", "cmd"}
hs.window.animationDuration = 0.3 -- disable animations

yay = "ᕙ(⇀‸↼‶)ᕗ"
boo = "ლ(ಠ益ಠლ)"


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
    --redrawBorder()
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
    --redrawBorder()
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
    --redrawBorder()
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
    --redrawBorder()
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
    --redrawBorder()
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
    --redrawBorder()
end

function move_vthird(height, divisions, index)
  local win = hs.window.focusedWindow()
  if win == nil then
    return
  end
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + (max.h / divisions * index)
  f.w = max.w
  f.h = (max.h / divisions)*height
  win:setFrame(f)
  --redrawBorder()
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
    --redrawBorder()
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
    global_border = hs.drawing.rectangle(hs.geometry.rect(top_left['x']-4, top_left['y']-4, size['w']+4, size['h']+4))
    global_border:setStrokeColor({["red"]=0.9,["blue"]=0,["green"]=0.2,["alpha"]=0.8})
    global_border:setLevel("utility")
    global_border:setFill(false)
    global_border:setStrokeWidth(12)
    global_border:show()
  end
end
-- turn on border draw
-- redrawBorder()

-- allwindows = hs.window.filter.new(nil)
-- allwindows:subscribe(hs.window.filter.windowCreated, function () redrawBorder() end)
-- allwindows:subscribe(hs.window.filter.windowFocused, function () redrawBorder() end)
-- allwindows:subscribe(hs.window.filter.windowMoved, function () redrawBorder() end)
-- allwindows:subscribe(hs.window.filter.windowUnfocused, function () redrawBorder() end)
--------------------------------------------------------

---------------------------------------------------------
-- APPLICATION / WINDOW
---------------------------------------------------------

-- Returns the next successive window given a collection of windows
-- and a current selected window
--
-- @param  windows  list of hs.window or applicationName
-- @param  window   instance of hs.window
-- @return hs.window
local function getNextWindow(windows, window)
  if type(windows) == "string" then
    windows = hs.appfinder.appFromName(windows):allWindows()
  end

  windows = filter(windows, hs.window.isStandard)
  windows = filter(windows, hs.window.isVisible)

  -- need to sort by ID, since the default order of the window
  -- isn't usable when we change the mainWindow
  -- since mainWindow is always the first of the windows
  -- hence we would always get the window succeeding mainWindow
  table.sort(windows, function(w1, w2)
    return w1:id() > w2:id()
  end)

  lastIndex = indexOf(windows, window)

  return windows[getNextIndex(windows, lastIndex)]
end

function getApplicationWindow(applicationName)
  local apps = hs.application.runningApplications()
  local app = hs.fnutils.filter(apps, function(app)
    return result(app, 'title') == applicationName
  end)

  if app and #app then
    windows = app[1]:allWindows()
    window = windows[1]
    return window
  else
    return nil
  end
end

-- Needed to enable cycling of application windows
lastToggledApplication = ''

function launchOrCycleFocus(applicationName, applicationTitle)
  return function()
    local nextWindow = nil
    local targetWindow = nil
    local focusedWindow          = hs.window.focusedWindow()
    local lastToggledApplication = focusedWindow and focusedWindow:application():title()

    -- Note, applicationTitle is optional, and only useful in those
    -- cases where the name and title are not the same (i.e. Visual Studio Code).
    if applicationTitle == nil then
        applicationTitle = applicationName
    end

    if not focusedWindow then return nil end

    -- save the state of currently focused app
    appStates:save()

    dbgf('last: %s, current: %s', lastToggledApplication, applicationTitle)

    if lastToggledApplication == applicationTitle then
      nextWindow = getNextWindow(applicationTitle, focusedWindow)

      -- Becoming main means
      -- * gain focus (although docs say differently?)
      -- * next call to launchOrFocus will focus the main window <- important
      -- * when fetching allWindows() from an application mainWindow will be the first one
      --
      -- If we have two applications, each with multiple windows
      -- i.e:
      --
      -- Google Chrome: {window1} {window2}
      -- Firefox:       {window1} {window2} {window3}
      --
      -- and we want to move between Google Chrome {window2} and Firefox {window3}
      -- when pressing the hotkeys for those applications, then using becomeMain
      -- we cycle until those windows (i.e press hotkey twice for Chrome) have focus
      -- and then the launchOrFocus will trigger that specific window.
      nextWindow:becomeMain()
    else
      hs.application.launchOrFocus(applicationName)
    end

    -- this blindly assumed that previous steps have been successful..
    if nextWindow then -- won't be available when appState empty
      targetWindow = nextWindow
    else
      targetWindow = hs.window.focusedWindow()
    end

    if not targetWindow then
      dbgf('failed finding a window for application: %s', applicationName)
      return nil
    end

    if appStates:lookup(targetWindow) then
      dbgf('restoring state of: %s', targetWindow:application():title())
      appStates:restore(targetWindow)
    else
      local windowFrame = targetWindow:frame()
      hs.mouse.centerOnRect(windowFrame)
    end

    mouseHighlight()
  end
end


-- Hyper is the f15 key for prebuilt keyboards
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
-- hyper:bind({}, 'h', function()
--     focus_left()
--     hyper.triggered = true
-- end)
-- hyper:bind({}, 'l', function()
--     focus_right()
--     hyper.triggered = true
-- end)
hs.hotkey.bind(hyperSmall, 'Left', function()
    move_left()
end)
hs.hotkey.bind(hyperSmall, 'Right', function()
                 move_right()
end)
hs.hotkey.bind(hyperSmall, 'h', function()
    hs.application.launchOrFocus("Telegram")
end)

hs.hotkey.bind(hyperSmall, 'j', function()
    hs.application.launchOrFocus("Google Chrome")
end)
hs.hotkey.bind(hyperSmall, 'k', function()
    --launchOrCycleFocus("/Applications/Visual Studio Code.app", "Code")
    hs.application.launchOrFocus('Visual Studio Code')
end)
hs.hotkey.bind(hyperSmall, 'i', function()
  hs.osascript.applescriptFromFile("/Users/jan/.dots/osxAutomate/focusEmacs.applescript")
end)


hs.hotkey.bind(hyperSmall, 'l', function()
    hs.application.launchOrFocus('iTerm')
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
    hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
end)
-- write out the clipboard
-- hs.hotkey.bind({"cmd", "alt"}, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)

-- hs.hints.style = 'vimperator'
--hs.hints.showTitleThresh = 10
-- hs.hotkey.bind({'cmd', 'alt'}, 'p', hs.hints.windowHints)
-- hyper:bind({}, 'u', function()
--     hs.hints.windowHints()
--     hyper.triggered = true
-- end)
-- hyper:bind({}, 't', function()
--     hs.eventtap.keyStroke({'alt'}, 'space')
--     hyper.triggered = true
-- end)
-- hyper:bind({}, 'u', function()
--     hs.application.launchOrFocus("Vivaldi")
--     hyper.triggered = true
-- end)
-- hyper:bind({}, 'a', function()
--     hs.application.launchOrFocus("Google Chrome")
--     hyper.triggered = true
-- end)
-- hyper:bind({}, 'n', function()
--     hs.application.launchOrFocus("Google Chrome")
--     hyper.triggered = true
-- end)
-- hyper:bind({}, 'o', function()
--     hs.application.launchOrFocus("Telegram")
--     hyper.triggered = true
-- end)
-- hyper:bind({}, 'r', function()
--     hs.application.launchOrFocus("PhpStorm")
--     hyper.triggered = true
-- end)
-- hyper:bind({}, 'q', function()
--     hs.appfinder.appFromName("Telegram"):hide()
--     hs.appfinder.appFromName("Vivaldi"):hide()
--     hs.appfinder.appFromName("Vysor"):hide()
--     hyper.triggered = true
-- end)

-- hyper:bind({}, 'e', function()
--     hs.application.launchOrFocus("Emacs")
--     hyper.triggered = true
-- end)
-- hyper:bind({}, 'l', function()
--     move_vthird(0)
--     hyper.triggered = true
-- end)
-- hyper:bind({}, 'c', function()
--     move_vthird(1)
--     hyper.triggered = true
-- end)
-- hyper:bind({}, 'w', function()
--     move_vthird(2)
--     hyper.triggered = true
-- end)
-- hyper:bind({}, '.', function()
--     hs.window.switcher.nextWindow()
--     hyper.triggered = true
-- end)

-- ---- hypermod is the hotkey for custom keyboards that can press all modifiers on a single key
-- app switcher

hs.hotkey.bind(hyperMod, 'i', function()
                 move_left()
end)
hs.hotkey.bind(hyperMod, 'a', function()
                 maximize_window()
end)
hs.hotkey.bind(hyperMod, 'e', function()
                 move_right()
end)

hs.hotkey.bind(hyperMod, 'n', function()
    hs.application.launchOrFocus("Google Chrome")
end)
hs.hotkey.bind(hyperMod, 'h', function()
    hs.application.launchOrFocus("Vivaldi")
end)
hs.hotkey.bind(hyperMod, 'd', function()
                 hs.application.launchOrFocus("Firefox Developer Edition")
end)
hs.hotkey.bind(hyperMod, 'g', function()
    --hs.application.launchOrFocus("org.gnu.Emacs")
--    hs.application.launchOrFocusByBundleID("org.gnu.Emacs")
    hs.osascript.applescriptFromFile("/Users/jan/.dots/osxAutomate/focusEmacs.applescript")
end)
hs.hotkey.bind(hyperMod, 't', function()
    hs.application.launchOrFocus("iTerm")
end)
hs.hotkey.bind(hyperMod, 'r', function()
  --launchOrCycleFocus("/Applications/Visual Studio Code.app", "Code")
  hs.application.launchOrFocus('Visual Studio Code')
end)
hs.hotkey.bind(hyperMod, 's', function()
    hs.application.launchOrFocus("Telegram")
end)
--media
hs.hotkey.bind(hyperMod, 'm', function()
    hs.osascript.applescriptFromFile("/Users/jan/.dots/osxAutomate/youtube-music-play.applescript")
end)
hs.hotkey.bind(hyperMod, 'b', function()
    hs.osascript.applescriptFromFile("/Users/jan/playground/automate/youtube-play.applescript")
end)

switcherW = hs.window.switcher.new({})
switcher_space = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{})
--management
hs.hotkey.bind(hyperMod, 'f', function()
--  switcherW.nextWindow()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen():next()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h

  win:setFrame(f)
  win:moveToScreen(screen)
end)
hs.hotkey.bind(hyperMod, 'q', function()
  switcher_space.nextWindow()
end)


-- test for moving mouse to window
hs.hotkey.bind(hyperMod, "o", function()
  local win = hs.window.focusedWindow()
  if win == nil then
    return
  end
  point = win:topLeft()
  middle = hs.geometry(point.x + (win:size().w / 2), point.y + (win:size().h / 2))
  hs.mouse.setAbsolutePosition(middle)
end)

-- window movement
-- hs.hotkey.bind(hyperMod, 'i', function()
--   move_left()
-- end)
-- hs.hotkey.bind(hyperMod, 'a', function()
--   maximize_window()
-- end)
-- hs.hotkey.bind(hyperMod, 'e', function()
--   move_right()
-- end)
-- hs.hotkey.bind(hyperMod, 'v', function()
--   move_vthird(1, 3, 0)
-- end)
-- hs.hotkey.bind(hyperMod, 'l', function()
--   move_vthird(1, 3, 1)
-- end)
-- hs.hotkey.bind(hyperMod, 'c', function()
--   move_vthird(1, 3, 2)
-- end)
-- hs.hotkey.bind(hyperMod, 'c', function()
--   move_vthird(1, 3, 2)
-- end)
-- hs.hotkey.bind(hyperMod, 'x', function()
--   move_vthird(2, 3, 0)
-- end)
-- hs.hotkey.bind(hyperMod, 'w', function()
--   move_vthird(2, 3, 1)
-- end)

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
-- hs.timer.doAt("0:00","1h", function() hs.alert("Ding Dong") end)

