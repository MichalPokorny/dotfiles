import Data.Ratio ((%))

import System.IO
import XMonad
import XMonad.ManageHook
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.WindowProperties
import System.Exit
import XMonad.Actions.RandomBackground
import Graphics.X11.ExtraTypes.XF86

import XMonad.Actions.CycleWS
import XMonad.Actions.WindowGo
import XMonad.Actions.GridSelect
import XMonad.Actions.MouseResize
import XMonad.Actions.UpdatePointer

import XMonad.Layout.ShowWName
import XMonad.Layout.Named
import XMonad.Layout.Reflect
import XMonad.Layout.ResizableTile
import XMonad.Layout.WindowNavigation
import XMonad.Layout.NoBorders
import XMonad.Layout.StackTile
import XMonad.Layout.BorderResize

import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.AppendFile
import XMonad.Prompt.Man

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import Data.Monoid

xK_Battery = 0x1008FF93

role = (stringProperty "WM_WINDOW_ROLE")

myWorkspaces = (map show [0..9]) ++ [ "-", "=" ]
workspaceKeys = ([xK_0 .. xK_9] ++ [xK_minus, xK_equal])

xosdutilCommand cmd = spawn ("/home/prvak/bin/xosdutilctl " ++ cmd)

xpConfig = amberXPConfig {
	showCompletionOnTab = True
--	, autoComplete = Just 0
}

myTerminal = "urxvt" 
spawnInTerminal app = spawn (myTerminal ++ " -e " ++ app)

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [--	  ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
		  ((modm, xK_Return), randomBg $ RGB 0 10)
		, ((modm .|. controlMask, xK_Return), spawn "/home/prvak/bin/terminal_big")
		--, ((modm, xK_Return), spawn $ "xterm")
		--, ((modm, xK_p), spawn "/home/prvak/bin/run_yeganesh")
		, ((modm .|. shiftMask,xK_w ), spawnInTerminal "wicd-curses")
		, ((modm, xK_n ), spawnInTerminal "ncmpcpp")
		, ((modm, xK_a ), spawnInTerminal "alsamixer")
		, ((modm, xK_m ), spawnInTerminal "mutt")
		, ((modm .|. shiftMask,xK_f ), spawn "firefox")
		, ((modm .|. shiftMask,xK_v ), spawn "VirtualBox")
		, ((modm .|. shiftMask,xK_p ), spawn "/home/prvak/bin/change_wallpaper")
		, ((modm .|. shiftMask,xK_c ), kill)
		, ((modm, xK_space ), sendMessage NextLayout)
		, ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
		, ((modm .|. shiftMask, xK_Tab), windows W.focusUp)
		, ((modm, xK_j), sendMessage $ Go D)
		, ((modm, xK_k), sendMessage $ Go U)
		, ((modm, xK_h), sendMessage $ Go L)
		, ((modm, xK_l), sendMessage $ Go R)
		--, ((modm,xK_m), windows W.focusMaster  )
		--, ((modm,xK_Return), windows W.swapMaster)
		, ((modm .|. controlMask, xK_j), windows W.swapDown  )
		, ((modm .|. controlMask, xK_k), windows W.swapUp    )
		, ((modm .|. shiftMask, xK_h), sendMessage Expand)
		, ((modm .|. shiftMask, xK_l), sendMessage Shrink)
		, ((modm .|. shiftMask, xK_j), sendMessage MirrorShrink)
		, ((modm .|. shiftMask, xK_k), sendMessage MirrorExpand)
		, ((modm .|. shiftMask, xK_n), appendFilePrompt defaultXPConfig "/home/prvak/NOTES")
		, ((modm .|. shiftMask, xK_m), manPrompt defaultXPConfig)
		, ((modm, xK_t), withFocused $ windows . W.sink)
		, ((modm, xK_comma), sendMessage (IncMasterN 1))
		, ((modm, xK_period), sendMessage (IncMasterN (-1)))
		, ((modm, xK_z), spawn "xscreensaver-command -lock")
		, ((0, xF86XK_ScreenSaver), spawn "xscreensaver-command -lock")
		, ((modm .|. shiftMask, xK_q), io (exitWith ExitSuccess))
		, ((modm, xK_f), goToSelected $ buildDefaultGSConfig defaultColorizer)
		, ((modm, xK_q), spawn "xmonad --recompile; xmonad --restart")
		, ((modm, xK_c), xosdutilCommand "time")
		, ((modm, xK_u), xosdutilCommand "uptime")
		, ((modm, xK_a), xosdutilCommand "acpi")
		, ((0, xK_Battery), xosdutilCommand "acpi")
		, ((modm, xK_b), xosdutilCommand "bitcoins")
		, ((modm, xK_s), shellPrompt xpConfig)
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
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) workspaceKeys
	, (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
		++
	-- mod-{u,i,o} - switch to Xine screen #{1..3}
	-- mod-shift-{u,i,o} - move Xine screen #{1..3}
    [((modm .|. m, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_u, xK_i, xK_o] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

-- Mouse bindings: default actions bound to mouse events
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster))
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

supermod x = noBorders $ windowNavigation $ avoidStruts x

myLayout = showWName (
			(supermod $ named "RT" $ tiled) ||| 
			(supermod $ named "F" Full)
	)
  where
     tiled   = ResizableTall nmaster delta ratio [5/4,5/4,5/4]
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

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
      --xmproc <- spawnPipe "/usr/bin/xmobar /home/prvak/.xmobarrc"
      
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
	logHook            = myLogHook --xmproc,
    }
