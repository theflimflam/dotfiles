#!/usr/bin/env bash

# setup.sh - Utility script to setup new dotfiles
# Copyright (C) 2015 Matthew B. Gray
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

get_path() {
  # go to dir, if error, exit with code but suppress output
  cd "$1" 2>/dev/null || return $?

  # output full resolved path to stdout
  pwd -P
}

CHECKOUT_REL=$( dirname $0 )
CHECKOUT=$( get_path $CHECKOUT_REL )

cd $CHECKOUT/etc
FILES=$( ls | grep -v copy )

cd $HOME
for file in $FILES; do
  ln -sf "${CHECKOUT}/etc/${file}" ".$file"
done
