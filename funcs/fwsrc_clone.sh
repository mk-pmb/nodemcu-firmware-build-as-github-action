#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-


function fwsrc_clone () {
  if [ -f "$INPUT_FIRMWARE_SRCDIR"/Makefile ]; then
    echo "D: Makefile already exists in $INPUT_FIRMWARE_SRCDIR => skip cloning."
  else
    git clone --single-branch --branch "$INPUT_FIRMWARE_BRANCH" \
      "$INPUT_FIRMWARE_REPO" "$INPUT_FIRMWARE_SRCDIR" || return $?
  fi
  cd -- "$INPUT_FIRMWARE_SRCDIR" || return $?
  [ -z "$INPUT_FIRMWARE_GIT_RESET" ] \
    || snip_run '' git reset --hard "$INPUT_FIRMWARE_GIT_RESET" || return $?
  snip_run '' git submodule init || return $?
  snip_run '' git submodule update --recursive || return $?

  echo -n "D: Firmware repo is at branch $(
    git branch | sed -nre 's~^\* ~~p' || echo '(no branch?)'
    ), commit ";
  git log --format=oneline --abbrev-commit --max-count=15 | sed -re '
    1b
    s~^~   ~
    2s~^~Recent history:\n~
    s~^|\n~&D: ~g
    '
}










[ "$1" == --lib ] && return 0; fwsrc_clone "$@"; exit $?