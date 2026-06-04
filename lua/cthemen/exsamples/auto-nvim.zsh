#!/bin/zsh
config_dir="$HOME/.config/nvim"
target_dir="${0:A:h}"
run_id="auto-nvim-$$"

(
  while IFS= read -r event; do
    case "$event" in
      *.lua) ;;
      *) continue ;;
    esac
    nvim_pid=$(pgrep -f "${run_id}" 2>/dev/null | head -1)
    if [ -n "$nvim_pid" ]; then
      kill -KILL "$nvim_pid" 2>/dev/null
    fi
  done < <(stdbuf -oL inotifywait -mqr --format '%f' --exclude '/exsamples/' \
    -e modify,create,delete,move "$config_dir" 2>/dev/null)
) &
watcher_pid=$!
trap 'kill $watcher_pid 2>/dev/null; exit 0' INT TERM EXIT

while true; do
  nvim -c "let g:auto_nvim_run_id='${run_id}'" "$target_dir"
  [ $? -eq 0 ] && break
done
