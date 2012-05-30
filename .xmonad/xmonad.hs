import Data.Ratio ((%))

import System.IO
import XMonad
import XMonad.ManageHook
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
--import XMonad.Util.NamedScratchpad
import XMonad.Util.WindowProperties
import System.Exit
import XMonad.Layout.ShowWName
import XMonad.Actions.RandomBackground

import XMonad.Actions.CycleWS
import XMonad.Actions.WindowGo
import XMonad.Actions.GridSelect
import XMonad.Actions.MouseResize
import XMonad.Actions.SpawnOn
import XMonad.Actions.UpdatePointer

import XMonad.Layout.Named
import XMonad.Layout.IM
import XMonad.Layout.Reflect
import XMonad.Layout.ResizableTile
import XMonad.Layout.WindowNavigation
import XMonad.Layout.NoBorders
import XMonad.Layout.StackTile
import XMonad.Layout.Tabbed
import XMonad.Layout.Mosaic
import XMonad.Layout.BorderResize
import XMonad.Layout.TabBarDecoration
import XMonad.Util.Themes

import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.RunOrRaise
import XMonad.Prompt.AppendFile
import XMonad.Prompt.Man
import XMonad.Prompt.AppLauncher

--import XMonad.Util.Scratchpad

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import Data.Monoid

role = (stringProperty "WM_WINDOW_ROLE")

myTerminal      = "urxvt"
myWorkspaces = map show [0..9] --myWorkspaces    = ["web","dev","gtr","vbox","admin","im"] ++ map show [7,8,9]

{--
scratchpads = [
            NS "F2" "urxvt -name scratch1 -e mutt" (stringProperty "WM_CLASS" =? "scratch1") defaultFloating,
            NS "F3" "urxvt -name scratch2 -e htop" (stringProperty "WM_CLASS" =? "scratch2") defaultFloating,
            NS "F4" "gvim --role 1" (role =? "1") nonFloating,
            NS "F5" "gvim --role 2" (role =? "2") nonFloating,
            NS "F6" "gvim --role 3" (role =? "3") nonFloating,
            NS "F7" "gvim --role 4" (role =? "4") nonFloating,
            NS "F8" "gvim --role 5" (role =? "5") nonFloating,
            NS "F9" "gvim --role 6" (role =? "6") nonFloating,
            NS "F10" "gvim --role 7" (role =? "7") nonFloating
            ]
--}
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    [--	  ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
		  ((modm .|. shiftMask, xK_Return), randomBg $ RGB 0 10)
	--	  ((modm .|. shiftMask, xK_Return), randomBg $ RGB 0 255)
		, ((modm, xK_Return), spawn $ "urxvt")
		, ((modm, xK_p), spawn "/home/prvak/bin/run_yeganesh")
		, ((modm .|. shiftMask,xK_w ), spawn "urxvt -e wicd-curses")
		, ((modm .|. shiftMask,xK_f ), spawn "firefox")
	--	, ((modm .|. shiftMask,xK_g ), spawn "gnucash")
		, ((modm .|. shiftMask,xK_v ), spawn "VirtualBox")
		, ((modm .|. shiftMask,xK_p ), spawn "/home/prvak/bin/change_wallpaper")
		, ((modm .|. shiftMask,xK_c ), kill)
		, ((modm, xK_space ), sendMessage NextLayout)
		, ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
		, ((modm, xK_n), refresh)
		, ((modm .|. shiftMask, xK_Tab), windows W.focusUp)
		, ((modm, xK_j), sendMessage $ Go D)
		, ((modm, xK_k), sendMessage $ Go U)
		, ((modm, xK_h), sendMessage $ Go L)
		, ((modm, xK_l), sendMessage $ Go R)
		, ((modm,xK_m), windows W.focusMaster  )
		, ((modm,xK_Return), windows W.swapMaster)
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
		, ((modm .|. shiftMask, xK_q), io (exitWith ExitSuccess))
		, ((modm, xK_f), goToSelected $ buildDefaultGSConfig defaultColorizer)
		, ((modm, xK_q), spawn "xmonad --recompile; xmonad --restart")
		, ((modm, xK_c), spawn "/home/prvak/bin/xosdutilctl time")
		, ((modm, xK_u), spawn "/home/prvak/bin/xosdutilctl uptime")
		, ((modm, xK_a), spawn "/home/prvak/bin/xosdutilctl acpi")
    ]
		++
{--map
      (\x -> ((modm, (snd x)), namedScratchpadAction (scratchpads) (fst x)))
      [("F2",xK_F2),("F3",xK_F3),("F4",xK_F4),("F5",xK_F5),("F6",xK_F6),("F7",xK_F7),("F8",xK_F8),("F9",xK_F9),("F10",xK_F10)]
		++ --}
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_0 .. xK_9]
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

gimpLayout x = mouseResize $ (withIM (1%7) (Role "gimp-toolbox")) $ reflectHoriz $ (withIM (1%7) (Role "gimp-dock")) x
--pidginLayout x = (withIM (1%7) (Role "buddy_list")) x

supermod x = showWName $ noBorders $ windowNavigation $ avoidStruts x

--- TODO: spravny tabbed...
myLayout = 
			(supermod $ named "RT" $ tiled) ||| 
			--(supermod $ named "IM" $ pidginLayout simpleTabbed) ||| 
			(smartBorders $ named "F" Full) ||| 
			(supermod $ named "GIMP" $ gimpLayout simpleTabbed)
  where
     tiled   = ResizableTall nmaster delta ratio [5/4,5/4,5/4]
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

myManageHook = {--namedScratchpadManageHook scratchpads <+>--} manageDocks <+> composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "VirtualBox"     --> doShift "4"
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
--    , className =? "Pidgin"         --> doShift "6"
	, className =? "git-gui"        --> doFloat
	, className =? "Git-gui"        --> doFloat
	, className =? "gnuplot"		--> doFloat
    , isDialog --> doFloat]

myEventHook = mempty

--myLogHook = dynamicLog >> updatePointer (Relative 0.5 0.5) -- Nearest
myLogHook = updatePointer (Relative 0.5 0.5) -- Nearest
{--WithPP $ xmobarPP {
  ppTitle=xmobarColor "green" "" . shorten 40,
  ppCurrent=xmobarColor "white" "",
  ppVisible = wrap "(" ")",
  ppHidden = xmobarColor "blue" "",
  ppHiddenNoWindows = xmobarColor "gray" "",
  ppUrgent=xmobarColor "red" "" . wrap "^" "",
  ppSep=" | ",
  ppOutput = hPutStrLn h
}--}


main = do
      --xmproc <- spawnPipe "/usr/bin/xmobar /home/prvak/.xmobarrc"
      
      xmonad $ defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = True,
        borderWidth        = 1,
        modMask            = mod4Mask,
        workspaces         = myWorkspaces,
        normalBorderColor  = "#dddddd",
        focusedBorderColor = "#ff9900",

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
		logHook            = myLogHook --xmproc,
    }
