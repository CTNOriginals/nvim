#!/bin/zsh
config_dir="$HOME/.config/nvim"
target_dir="${0:A:h}"

while true; do
  (
    inotifywait -qq -r --exclude '/exsamples/' \
      -e modify,create,delete,move "$config_dir" 2>/dev/null
    nvim_pid=$(pgrep -f "nvim.*${target_dir}" | head -1)
    [ -n "$nvim_pid" ] && kill "$nvim_pid" 2>/dev/null
  ) &

  nvim
  exit_code=$?

  kill %1 2>/dev/null; wait 2>/dev/null
  [ "$exit_code" -eq 0 ] && break
done
