--Base
import XMonad
import System.Exit (exitSuccess)

-- Utilities
import XMonad.Util.EZConfig (additionalKeysP, removeKeysP)

-- Layouts Modifiers
import XMonad.Layout.Renamed (renamed, Rename(CutWordsLeft, Replace))
import XMonad.Layout.Spacing (spacing)
import XMonad.Layout.NoBorders (noBorders)

--Layouts
import XMonad.Layout.StackTile
import XMonad.Layout.Dishes
import XMonad.Layout.TwoPane

-- Hooks
import XMonad.Hooks.ManageDocks (avoidStruts)

-- Actions
import XMonad.Actions.CycleWS (nextScreen, shiftNextScreen)
import XMonad.Actions.WindowBringer (gotoMenu)

------------------------------------------------------------------------
-- General:
myTerminal = "st -f 'MesloLGM Nerd Font Mono:size=11'"
myBrowser = "chromium"
myEditor = "emacsclient -c -a emacs"
myLauncher = "/home/ucizi/_configs/scripts/dmenu_recency"
myModMask = mod4Mask
myBorderWidth = 1

------------------------------------------------------------------------
-- Layouts:
mySpacing = 2
noSpacing = 0

myLayoutHook = avoidStruts $ myLayouts

myLayouts = myFull ||| myTwoPane



myTile = renamed [Replace "Tiled"] $ spacing mySpacing $ Tall 1 (3/100) (1/2)
myFull = renamed [Replace "Full"] $ spacing noSpacing $ noBorders Full
myTwoPane = renamed [Replace "TwoPane"] $ spacing mySpacing $ TwoPane (3/100) (1/2)

------------------------------------------------------------------------
-- Keys:
myKeys =
  [ ("M-S-r", spawn "xmonad --recompile; xmonad --restart")
  , ("M-<Return>", spawn myTerminal)
  , ("M-x", spawn myLauncher)
  , ("M-<Esc>", io exitSuccess)
  , ("M-c", spawn myBrowser)
  , ("M-S-e", spawn myEditor)
  , ("M-o", nextScreen)
  , ("M-S-o", shiftNextScreen)
  , ("M-S-q", kill)
  , ("M-w", gotoMenu)
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

myConfig = def
  { terminal    = myTerminal
  , modMask     = mod4Mask
  , borderWidth = 1
  , layoutHook = myLayoutHook
  }

main = xmonad $ myConfig
  `removeKeysP` removedKeys
  `additionalKeysP` myKeys
