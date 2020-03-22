import XMonad

main = xmonad $ def
    { borderWidth        = 2
    , terminal           = "gnome-terminal"
    , focusedBorderColor = "#008bcd"
    }
