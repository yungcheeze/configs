--Base
import XMonad
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

-- Utilities
import XMonad.Util.EZConfig (additionalKeysP, removeKeysP)
import XMonad.Util.SpawnOnce (spawnOnce)

-- Layouts Modifiers
import XMonad.Layout.Renamed (renamed, Rename(CutWordsLeft, Replace))
import XMonad.Layout.Spacing (spacing)
import XMonad.Layout.NoBorders (smartBorders)

--Layouts
import XMonad.Layout.StackTile
import XMonad.Layout.Dishes
import XMonad.Layout.TwoPane
import XMonad.Util.NamedScratchpad ( NamedScratchpad(NS), customFloating, namedScratchpadManageHook, namedScratchpadAction)
-- Hooks
import XMonad.Hooks.ManageDocks (avoidStruts, manageDocks)
import XMonad.Hooks.FadeInactive (fadeInactiveLogHook)

-- Actions
import XMonad.Actions.CycleWS (nextScreen, shiftNextScreen)
import XMonad.Actions.WindowBringer (gotoMenu)
import XMonad.Actions.UpdatePointer (updatePointer)

------------------------------------------------------------------------
-- General:
myTerminal = "terminator"
myBrowser = "google-chrome"
myEditor = "emacsclient -c -a emacs"
myLauncher = myConfigsDir ++ "/scripts/dmenu_recency"
myConfigsDir = "/home/ucizi/configs"
myWindowSwitcher = "rofi -show window -theme sidetab"
myStatusBar = myConfigsDir ++ "/config/polybar/launch.sh"
myWallpaper = "/home/ucizi/Pictures/simple-subtle-abstract-dark-minimalism-4k-u9.jpg"
myModMask = mod4Mask

------------------------------------------------------------------------
-- Layouts:
mySpacing = 3

myLayoutHook = avoidStruts $ myLayouts

myLayouts = myFull ||| myTile

myTile = renamed [Replace "Tiled"] $ spacing mySpacing $ Tall 1 (3/100) (1/2)
myFull = renamed [Replace "Full"] $ spacing mySpacing $ Full
myTwoPane = renamed [Replace "TwoPane"] $ spacing mySpacing $ TwoPane (3/100) (1/2)

------------------------------------------------------------------------
-- Scratchpads:
myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                , NS "workrave" "workrave" (className =? "Workrave") manageWorkrave]
    where
    spawnTerm  = myTerminal ++  " -c scratchpad"
    findTerm   = resource =? "scratchpad"
    manageTerm =  customFloating $ W.RationalRect l t w h
                 where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w
    manageWorkrave =  customFloating $ W.RationalRect left_offset top_offset width height
                   where
                   width = 0.2
                   height = 0.2
                   left_offset = 0.05
                   top_offset = 0.05

------------------------------------------------------------------------
-- WindowManagement:
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

------------------------------------------------------------------------
-- Log Hook:
myLogHook = fadeInactiveLogHook fadeAmount
    where fadeAmount = 0.85
------------------------------------------------------------------------
-- Keys:
myKeys =
  [ ("M-S-r", spawn "xmonad --recompile; xmonad --restart")
  , ("M-<Return>", spawn myTerminal)
  , ("M-;", namedScratchpadAction myScratchPads "terminal")
  , ("M-x", spawn myLauncher)
  , ("M-w", gotoMenu)
  , ("M-<Esc>", io exitSuccess)
  , ("M-c", spawn myBrowser)
  , ("M-S-e", spawn myEditor)
  , ("M-o", nextScreen)
  , ("M-S-o", shiftNextScreen)
  , ("M-S-q", kill)
  ]

------------------------------------------------------------------------
-- Keys:
removedKeys =
  [ "M-q" -- restart
  , "M-S-q" -- quit
  , "M-S-c" -- close window
  , "M-<Tab>" -- cycle window forward
  , "M-S-<Tab>" -- cycle window backward
  , "M-p" -- dmenu
  , "M-S-p" -- dmenu
  , "M-S-w" , "M-S-e" , "M-S-r" -- move window to monitor
  , "M-w" , "M-e" , "M-r" -- switch to monitor
  ]


------------------------------------------------------------------------
-- Startup:
myStartupHook = do
  spawnOnce myStatusBar
  spawnOnce "redshift"
  spawnOnce "compton -b"
  spawnOnce ("nitrogen --set-auto " ++ myWallpaper)
  spawnOnce "xbindkeys"
  spawnOnce "dropbox start"
  spawnOnce "workrave"

------------------------------------------------------------------------
-- Main:
myConfig = def
  { terminal    = myTerminal
  , modMask     = mod4Mask
  , borderWidth = 0
  , layoutHook = myLayoutHook
  , startupHook = myStartupHook
  , manageHook = myManageHook <+> namedScratchpadManageHook myScratchPads <+> manageDocks
  , logHook = myLogHook >> updatePointer (0.5, 0.5) (0, 0)
  }

main = xmonad $ myConfig
  `removeKeysP` removedKeys
  `additionalKeysP` myKeys
