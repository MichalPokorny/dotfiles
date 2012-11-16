import Data.Ratio ((%))

import System.Exit

import Graphics.X11.ExtraTypes.XF86

import XMonad hiding ((|||))

import XMonad.Hooks.ManageDocks(manageDocks, Direction2D(D, U, L, R))
import XMonad.Hooks.ManageHelpers(isDialog)

import qualified XMonad.StackSet as StackSet

import XMonad.Actions.RandomBackground
import XMonad.Actions.GridSelect
import XMonad.Actions.UpdatePointer(updatePointer, PointerPosition(Relative))

import XMonad.Layout.ShowWName(showWName)
import XMonad.Layout.Named
import XMonad.Layout.ResizableTile
import XMonad.Layout.WindowNavigation(Navigate(Go), windowNavigation)
import XMonad.Layout.NoBorders(smartBorders, noBorders)
import XMonad.Layout.Renamed(renamed, Rename(CutWordsLeft))
import XMonad.Layout.Groups(group, GroupsMessage(ToEnclosing, ToFocused))
import XMonad.Layout.Groups.Examples(zoomRowG, zoomColumnIn, zoomColumnOut)
import XMonad.Layout.Groups.Helpers(moveToGroupUp, moveToGroupDown, swapUp, swapDown)
import XMonad.Layout.ZoomRow(zoomIn,zoomOut,zoomRow)
import XMonad.Layout.Simplest
import XMonad.Layout.Tabbed
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.MessageControl(escape, unEscape, ignore)

import XMonad.Prompt(amberXPConfig, showCompletionOnTab)
import XMonad.Prompt.Shell(shellPrompt)
import XMonad.Prompt.AppendFile(appendFilePrompt)
import XMonad.Prompt.Man(manPrompt)
import XMonad.Prompt.XMonad(xmonadPrompt)

import qualified Data.Map as Map

import Data.Monoid(mempty)

xK_Battery = 0x1008FF93

role = (stringProperty "WM_WINDOW_ROLE")

myWorkspaces = (map show [1..9]) ++ [ "0", "-", "=" ]
workspaceKeys = ([xK_1 .. xK_9] ++ [xK_0, xK_minus, xK_equal])

xosdutilCommand cmd = spawn ("xosdutilctl " ++ cmd)

xpTheme = amberXPConfig
xpConfig = amberXPConfig {
	showCompletionOnTab = True
--	, autoComplete = Just 0
}

myTerminal = "urxvt" 
spawnInTerminal app = spawn (myTerminal ++ " -e " ++ app)

-- | A layout inspired by wmii
-- TODO: tweak parameters
wmii s t = group innerLayout zoomRowG
    where column = Mirror zoomRow
          tabs = Simplest
          innerLayout = (column ||| (addTabs s t $ tabs) ||| Full)

myKeys conf@(XConfig {XMonad.modMask = modm}) = Map.fromList $
	[
-- XMonad system shortcuts
	-- Kill current window
	  ((modm .|. shiftMask,xK_c ), kill)
	-- Quit XMonad
	, ((modm .|. shiftMask, xK_q), io (exitWith ExitSuccess))
	-- Recompile and restart
	, ((modm, xK_q), spawn "xmonad --recompile; xmonad --restart")

-- Terminal spawning keys
	, ((0, xK_Menu), randomBg $ RGB 0 10) -- The useless right-click-key shall spawn a terminal.
	, ((shiftMask, xK_Menu), spawn "/home/prvak/bin/terminal-big") -- +shift - make it big.
	, ((controlMask, xK_Menu), spawnInTerminal "su")

-- Terminal spawn shortcuts
	, ((modm .|. shiftMask, xK_w), spawnInTerminal "wicd-curses")
	, ((modm, xK_n), spawnInTerminal "ncmpcpp")
	, ((modm, xK_a), spawnInTerminal "alsamixer")
	, ((modm, xK_m), spawnInTerminal "mutt")

-- Program spawn shortcuts
	, ((modm .|. shiftMask, xK_f), spawn "firefox")
	, ((modm .|. shiftMask, xK_v), spawn "VirtualBox")
	, ((modm .|. shiftMask, xK_p), spawn "/home/prvak/bin/change-wallpaper")
	, ((modm .|. shiftMask, xK_z), spawn "zim")

-- Cycle through windows
	, ((modm, xK_Tab), windows StackSet.focusDown)
	, ((modm .|. shiftMask, xK_Tab), windows StackSet.focusUp)

-- Window navigation (Vim keys)
	, ((modm, xK_j), sendMessage $ Go D)
	, ((modm, xK_k), sendMessage $ Go U)
	, ((modm, xK_h), sendMessage $ Go L)
	, ((modm, xK_l), sendMessage $ Go R)

-- Column / window resizing (Vim keys)
	, ((modm .|. shiftMask, xK_h), zoomColumnOut)
	, ((modm .|. shiftMask, xK_j), sendMessage zoomIn)
	, ((modm .|. shiftMask, xK_k), sendMessage zoomOut)
	, ((modm .|. shiftMask, xK_l), zoomColumnIn)

-- Window moving (Vim keys)
	, ((modm .|. controlMask, xK_h), moveToGroupUp False)
	, ((modm .|. controlMask, xK_j), swapDown)
	, ((modm .|. controlMask, xK_k), swapUp)
	, ((modm .|. controlMask, xK_l), moveToGroupDown False)

-- Column layout changes
	, ((modm, xK_space), sendMessage NextLayout)

-- Prompts
	-- Write a quick note
	, ((modm .|. shiftMask, xK_n), appendFilePrompt xpConfig "/home/prvak/NOTES")
	-- Browse a man page
	, ((modm .|. shiftMask, xK_m), manPrompt xpConfig)
	-- Spawn a program
	, ((modm, xK_s), shellPrompt xpConfig)
	-- XMonad prompt
	, ((modm, xK_x), xmonadPrompt xpConfig)

-- Unfloat a window
	, ((modm, xK_t), withFocused $ windows . StackSet.sink)

-- xscreensaver
	, ((modm, xK_z), spawn "xscreensaver-command -lock")
	, ((0, xF86XK_ScreenSaver), spawn "xscreensaver-command -lock")

-- Window bringing
	, ((modm, xK_f), goToSelected $ buildDefaultGSConfig defaultColorizer)
	, ((modm, xK_d), bringSelected $ buildDefaultGSConfig defaultColorizer)

-- xosdutil
	, ((modm, xK_c), xosdutilCommand "time")
	, ((modm, xK_u), xosdutilCommand "uptime")
	, ((modm, xK_a), xosdutilCommand "acpi")

-- Special key miscellany
	, ((0, xK_Battery), xosdutilCommand "acpi")
	, ((modm, xK_b), xosdutilCommand "bitcoins")
	, ((0, xK_Print), spawn "/home/prvak/bin/take-screenshot")
	, ((0, xF86XK_HomePage), spawn "xosdutilctl echo Ahoj") -- TODO
	, ((0, xF86XK_AudioPlay), spawn "/home/prvak/bin/mpc-toggle")
	, ((0, xF86XK_AudioPrev), spawn "mpc prev")
	, ((0, xF86XK_AudioNext), spawn "mpc next")
	, ((0, xF86XK_AudioMute), spawn "xosdutilctl echo Ahoj") -- TODO
	, ((0, xF86XK_AudioLowerVolume), spawn "xosdutilctl echo Ahoj") -- TODO
	, ((0, xF86XK_AudioRaiseVolume), spawn "xosdutilctl echo Ahoj") -- TODO
	, ((0, xF86XK_MonBrightnessUp), spawn "xbacklight -inc 20")
	, ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -dec 20")
	, ((0, xF86XK_Sleep), spawn "sudo pm-suspend")
	]
	++
-- Workspace switching (1...90-=, +Shift = move)
	[((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) workspaceKeys
	, (f, m) <- [(StackSet.greedyView, 0), (StackSet.shift, shiftMask)]]
	++

-- Screen switching (U, I, O, +Shift = move)
	[((modm .|. m, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_u, xK_i, xK_o] [0..]
        , (f, m) <- [(StackSet.view, 0), (StackSet.shift, shiftMask)]]

-- Mouse bindings: default actions bound to mouse events
myMouseBindings (XConfig {XMonad.modMask = modm}) = Map.fromList $
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w >> windows StackSet.shiftMaster))
    , ((modm, button2), (\w -> focus w >> windows StackSet.shiftMaster))
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w >> windows StackSet.shiftMaster))
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

-- TODO: avoidStruts (?)
myLayout = showWName $ windowNavigation $ noBorders $ wmii shrinkText defaultTheme

myManageHook = manageDocks <+> composeAll
    [ className =? "MPlayer"        --> doFloat
--  , className =? "VirtualBox"     --> doShift "4"
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
	, className =? "git-gui"        --> doFloat
	, className =? "Git-gui"        --> doFloat
	, className =? "gnuplot"		--> doFloat
    , isDialog --> doFloat]

myEventHook = mempty

myLogHook = updatePointer (Relative 0.5 0.5)

main = do
      xmonad $ defaultConfig {
        terminal           = myTerminal,
        focusFollowsMouse  = True,
        borderWidth        = 1,
        modMask            = mod4Mask,
        workspaces         = myWorkspaces,
        normalBorderColor  = "#dddddd",
        focusedBorderColor = "#ff9900",

        keys               = myKeys,
        mouseBindings      = myMouseBindings,

        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
	logHook            = myLogHook
    }
