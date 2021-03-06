# -*- coding: utf-8, tab-width: 2 -*-


function sum_pipe_rv () {
  local PIPE_RV="${PIPESTATUS[*]}"
  let PIPE_RV="${PIPE_RV// /+}"
  return "$PIPE_RV"
}


function with_log_tee () {
  >>"$1" || return $?$(echo "E: cannot write log file: $1" >&2)
  "${@:2}" |& tee --append -- "$1"; sum_pipe_rv
}


function with_spaceword_args () {
  local WORDS=()
  readarray -t WORDS < <(<<<"$1" grep -oPe '\S+'); shift
  "$@" "${WORDS[@]}"; return $?
}






[ "$1" == --lib ] && return 0; "$@"; exit $?
