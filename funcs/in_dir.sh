#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-


function in_dir () {
  if [ "$1" == --if-exists ]; then
    shift
    [ -d "$1" ] || return 0$(echo "D: nothing to do: no such directory: $1" >&2)
  fi
  [ -d "$1" ] || return $?$(echo "E: not a directory: $1" >&2)
  pushd -- "$1" >/dev/null || return $?$(echo "E: cannot chdir to $1" >&2)
  shift
  "$@"
  local RV=$?
  popd >/dev/null || return $?$(
    echo "E: cannot chdir back from $1, cwd is $PWD" >&2)
  return $RV
}




[ "$1" == --lib ] && return 0; in_dir "$@"; exit $?
