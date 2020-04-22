import System.IO
import XMonad
import XMonad.Actions.Volume
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Dzen
import XMonad.Util.EZConfig(additionalKeys, additionalKeysP)
import XMonad.Util.Run(spawnPipe)

system = "~/.system/"
music = "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify \
        \/org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player."

-- TODO investigate taffybar - https://hackage.haskell.org/package/taffybar

-- TODO investigate xmobar under windows - https://unix.stackexchange.com/a/303242/10329

-- Adapted from https://github.com/1stl0ve/xmonad-setup
main = do
    xmproc <- spawnPipe "/usr/bin/xmobar"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                { ppOutput = hPutStrLn xmproc
                , ppTitle = xmobarColor "green" "" . shorten 50
                }
        , modMask = mod4Mask -- super
        , layoutHook = avoidStruts $ layoutHook defaultConfig
        }
        `additionalKeys`
        [     ((0, 0x1008FF12), spawn (system ++ "mute-volume.sh"))
            , ((0 , 0x1008FF11), lowerVolume 4 >> spawn (system ++ "notify-volume.py"))
            , ((0 , 0x1008FF13), raiseVolume 4 >> spawn (system ++ "notify-volume.py"))
            , ((0 , 0x1008FF16), spawn (music ++ "Previous"))
            , ((0 , 0x1008FF17), spawn (music ++ "Next"))
        ]
        `additionalKeysP`
        [
            ("<XF86AudioPlay>", spawn (music ++ "PlayPause"))
        ]
