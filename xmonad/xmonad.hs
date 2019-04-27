import XMonad

-- Utilities
import XMonad.Util.EZConfig (additionalKeysP)

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
------------------------------------------------------------------------
-- General:
myTerminal = "st -f 'MesloLGM Nerd Font Mono:size=11'"
myModMask = mod4Mask
myBorderWidth = 1

------------------------------------------------------------------------
-- Layouts:
mySpacing = 0

myLayoutHook = avoidStruts $ myLayouts

myLayouts = myFull ||| myTwoPane ||| myTile



myTile = renamed [Replace "Tiled"] $ spacing mySpacing $ Tall 1 (3/100) (1/2)
myFull = renamed [Replace "Full"] $ spacing 0 $ noBorders Full
myTwoPane = renamed [Replace "TwoPane"] $ spacing 1 $ TwoPane (3/100) (1/2)

main = xmonad def
    { terminal    = myTerminal
    , modMask     = mod4Mask
    , borderWidth = 1
    , layoutHook = myLayoutHook
    }
