#!/bin/bash

# spotify-controls.sh - Scripted controls for Spotify
# Copyright (C) 2015  Matthew B. Gray
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


ACTION=$1;
case $ACTION in
  PlayPause | Pause | Next | Previous)
    dbus-send --print-reply --session \
      --dest=org.mpris.MediaPlayer2.spotify \
        /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.$ACTION;
    ;;
  *)
    echo Please call with a valid dbus MediaPlayer2 command, e.g. Next
    ;;
esac
