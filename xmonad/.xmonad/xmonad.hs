-- Copyright (c) 2020 Matthew B. Gray
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of
-- this software and associated documentation files (the "Software"), to deal in
-- the Software without restriction, including without limitation the rights to
-- use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
-- the Software, and to permit persons to whom the Software is furnished to do so,
-- subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
-- FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
-- COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
-- IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
-- CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

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
