#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-


function esp8266_copy_custom_config () {
  local SRC= BFN= DEST=
  for SRC in "$REPO_DIR/$MCU_PLATFORM.app.include"/*.h; do
    [ -f "$SRC" ] || continue
    BFN="$(basename -- "$SRC")"
    DEST="$INPUT_FIRMWARE_SRCDIR/app/include/user_$BFN"
    cp --verbose --no-target-directory -- "$SRC" "$DEST" || return $?
  done
  snip_run 'user config MD5s' md5sum --binary \
    -- "$INPUT_FIRMWARE_SRCDIR"/app/include/user_* || return $?
}













[ "$1" == --lib ] && return 0; esp8266_cli "$@"; exit $?
