import XMonad

main = xmonad def
    { terminal    = myTerminal
    , modMask     = mod4Mask
    , borderWidth = 1
    }

myTerminal = "st -f 'MesloLGM Nerd Font Mono:size=11'"