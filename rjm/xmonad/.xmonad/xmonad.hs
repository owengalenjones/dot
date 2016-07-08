--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad
import System.Exit
import XMonad.Hooks.SetWMName

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

--Bill added imports
import XMonad.Util.Run
import XMonad.Hooks.ManageDocks
import XMonad.Actions.OnScreen
import XMonad.Hooks.DynamicLog
import qualified XMonad.StackSet as S
import Data.List                         (intercalate, sortBy, isInfixOf)
import Data.Ord                          (comparing)
import Control.Monad                     (when, zipWithM_, liftM2)
import XMonad.Hooks.UrgencyHook
import XMonad.Util.NamedWindows          (getName)
import Codec.Binary.UTF8.String          (encodeString)
import Data.Maybe                        (isJust, catMaybes)
import XMonad.Layout.NoFrillsDecoration

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "gnome-terminal"

-- Width of the window border in pixels.
--
myBorderWidth   = 2

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The mask for the numlock key. Numlock status is "masked" from the
-- current modifier status, so the keybindings will work with numlock on or
-- off. You may need to change this on some systems.
--
-- You can find the numlock modifier by running "xmodmap" and looking for a
-- modifier with Num_Lock bound to it:
--
-- > $ xmodmap | grep Num
-- > mod2        Num_Lock (0x4d)
--
-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- numlock status separately.
--
myNumlockMask   = mod2Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#666666"
myFocusedBorderColor = "#4080aa"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_p     ), spawn "dmenu_run")

    -- launch gmrun
    --, ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- lock screen
    , ((modm .|. controlMask, xK_l     ), spawn "/home/owen/bin/lock.sh")

   -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)
    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm .|. shiftMask, xK_Tab       ), windows W.focusUp)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Bill experiment
    -- , ((modm,               xK_u     ), windows (W.greedyView "1")  )
    -- , ((modm .|. shiftMask, xK_u     ), windows (W.shift "1")  )
    -- , ((modm,               xK_i     ), windows (W.greedyView "2")  )
    -- , ((modm .|. shiftMask, xK_i     ), windows (W.shift "2")  )
    -- , ((modm,               xK_o     ), windows (W.greedyView "3")  )
    -- , ((modm .|. shiftMask, xK_o     ), windows (W.shift "3")  )
    -- , ((modm,               xK_p     ), windows (W.greedyView "4")  )
    -- , ((modm .|. shiftMask, xK_p     ), windows (W.shift "4")  )
    -- , ((modm,               xK_y     ), windows (W.greedyView "5")  )
    -- , ((modm .|. shiftMask, xK_y     ), windows (W.shift "5")  )
    -- , ((modm,               xK_bracketleft     ), windows (W.greedyView "6")  )
    -- , ((modm .|. shiftMask, xK_bracketleft     ), windows (W.shift "6")  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- toggle the status bar gap (used with avoidStruts from Hooks.ManageDocks)
    -- , ((modm , xK_b ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), restart "xmonad" True)
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0,1] -- default is [0..], set as [1,0,2] changed to flip screen order
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2), (\w -> focus w >> windows W.swapMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3), (\w -> focus w >> mouseResizeWindow w))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
-- myLayout = tiled ||| Mirror tiled ||| Full
--   where
     -- default tiling algorithm partitions the screen into two panes
--      tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
--      nmaster = 1

     -- Default proportion of screen occupied by master pane
--      ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
--      delta   = 3/100

myLayoutHook =
          avoidStruts
          $ noFrillsDeco shrinkText myTheme
          $ layoutHook defaultConfig

myTheme = defaultTheme {
            activeColor         = "SteelBlue"
          , activeBorderColor   = "#386890"
          , inactiveBorderColor = "#555555"
          , fontName            = "xft:DejaVu Sans-8:bold"
          }



------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True


------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'DynamicLog' extension for examples.
--
-- To emulate dwm's status bar
--
-- > logHook = dynamicLogDzen
--

myLogHook pps = do
  screens <- (sortBy (comparing S.screen) . S.screens) `fmap` gets windowset
  zipWithM_ dynamicLogWithPP' screens pps

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
-- myStartupHook = return ()

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
--    xmproc <- spawnPipe "/usr/bin/xmobar /home/bill/.xmobarcc"

main = do
    xmobar1 <- spawnPipe "/usr/bin/xmobar -x 1 /home/owen/xmonad/.xmobarcc"
    xmobar0 <- spawnPipe "/usr/bin/xmobar -x 0 /home/owen/xmonad/.xmobarcc-2"
    xmonad $ defaults xmobar0 xmobar1

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults bar0 bar1 = defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
    -- numlockMask        = myNumlockMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayoutHook, -- layout & manage hooks changed to show xmobar
        -- manageHook         = myManageHook,

--        logHook            = dynamicLogWithPP xmobarPP
--        { ppOutput = hPutStrLn xmproc
--          , ppTitle = xmobarColor "green" "" . shorten 50
--        },
        logHook            = myLogHook [ pp { ppOutput = hPutStrLn bar0 }
                                       , pp { ppOutput = hPutStrLn bar1 }],

        manageHook = manageDocks <+> manageHook defaultConfig,
--        layoutHook = avoidStruts  $  layoutHook defaultConfig,
        startupHook        = setWMName "LG3D"
    }


-- V=-=V=-=V=-=V=-=V=-=V=-=V=-=V
-- START from https://github.com/manzyuk/dotfiles/blob/master/.xmonad/xmonad.hs

pp = defaultPP {
       ppHiddenNoWindows = xmobarColor "DimGray"      ""            . pad
     , ppCurrent         = xmobarColor "White"        "#555555"     . pad
     , ppVisible         = pad
     , ppHidden          = pad
     , ppUrgent          = xmobarColor ""             "LightSalmon"       . xmobarStrip
     , ppLayout          = xmobarColor "LightSkyBlue" ""            . pad . iconify
     , ppTitle           = xmobarColor "green"    ""            . pad . shorten 200
     , ppWsSep           = ""
     , ppSep             = ""
     , ppOrder           = \(ws:l:_:rest) -> (ws:l:rest)
     }
    where
      iconify l | "Mirror" `isInfixOf` l = "[-]"
                | "Grid"   `isInfixOf` l = "[+]"
                | "Tall"   `isInfixOf` l = "[|]"
                | "Full"   `isInfixOf` l = "[ ]"
                | otherwise              = l



-- Extract the focused window from the stack of windows on the given screen.
-- Return Just that window, or Nothing for an empty stack.
focusedWindow = maybe Nothing (return . S.focus) . S.stack . S.workspace

-- The functions dynamicLogWithPP', dynamicLogString', and pprWindowSet' below
-- are similar to their undashed versions, with the difference being that the
-- latter operate on the current screen, whereas the former take the screen to
-- operate on as the first argument.

dynamicLogWithPP' screen pp = dynamicLogString' screen pp >>= io . ppOutput pp

dynamicLogString' screen pp = do

  winset <- gets windowset
  urgents <- readUrgents
  sort' <- ppSort pp

  -- layout description
  let ld = description . S.layout . S.workspace $ screen

  -- workspace list
  let ws = pprWindowSet' screen sort' urgents pp winset

  -- window title
  wt <- maybe (return "") (fmap show . getName) $ focusedWindow screen

  -- run extra loggers, ignoring any that generate errors.
  extras <- mapM (`catchX` return Nothing) $ ppExtras pp

  return $ encodeString . sepBy (ppSep pp) . ppOrder pp $
             [ ws
             , ppLayout pp ld
             , ppTitle  pp wt
             ]
             ++ catMaybes extras


pprWindowSet' screen sort' urgents pp s = sepBy (ppWsSep pp) . map fmt . sort' $ S.workspaces s
    where this     = S.tag . S.workspace $ screen
          visibles = map (S.tag . S.workspace) (S.current s : S.visible s)

          fmt w = printer pp (S.tag w)
              where printer | S.tag w == this                                               = ppCurrent
                            | S.tag w `elem` visibles                                       = ppVisible
                            | any (\x -> maybe False (== S.tag w) (S.findTag x s)) urgents  = \ppC -> ppUrgent ppC . ppHidden ppC
                            | isJust (S.stack w)                                            = ppHidden
                            | otherwise                                                     = ppHiddenNoWindows


sepBy :: String -> [String] -> String
sepBy sep = intercalate sep . filter (not . null)

-- END from https://github.com/manzyuk/dotfiles/blob/master/.xmonad/xmonad.hs
-- ^=-=^=-=^=-=^=-=^=-=^=-=^=-=^
