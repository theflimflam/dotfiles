#!/bin/sh

i3status | dzen2  -ta r -y 1180 -w 1300 -x 300 -bg black &

(sleep 0.5; gnome-settings-daemon; gnome-screensaver; gnome-power-manager ) &
(sleep 1; xsetroot -cursor_name left_ptr -bg white -solid black) &

# TODO fix this
#ssh-add ~/.ssh/martyn ~/.ssh/work

# Remove keybinding for capslock ^_^
xmodmap -e "remove lock = Caps_Lock"

