#  ______                _   _                 
# |  ____|              | | (_)                
# | |__ _   _ _ __   ___| |_ _  ___  _ __  ___ 
# |  __| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# | |  | |_| | | | | (__| |_| | (_) | | | \__ \
# |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
#                                              

# Connect to the development server
dev () {
  if [ -n "$TMUX" ]; then
    echo "❌ Please exit tmux before connecting to the development server." >&2
    return 1
  fi
  ssh devserver
}


# open a tmux session for a repo
open () {
  directory_name="${1%/}"                # remove trailing slash if present
  session_name="${directory_name//./_}"  # replace dots with underscores
  if ! tmux has-session -t "$session_name"; then
    if [ -d "$HOME/repositorios/$directory_name" ]; then
      tmux new -c "$HOME/repositorios/$directory_name" -d -s "$session_name"
    else
      tmux new -d -s "$session_name"
    fi
    tmux new-window -t "$session_name:1"
    sleep 0.1
    tmux send-keys  -t "$session_name:1" "vim ." ENTER
    tmux new-window -t "$session_name:2"
    sleep 0.1
    tmux send-keys  -t "$session_name:2" "cd $HOME/repositorios/$directory_name" ENTER
    tmux send-keys  -t "$session_name:2" "run-ci" ENTER
    tmux new-window -t "$session_name:3"
    sleep 0.1
    tmux send-keys  -t "$session_name:3" "cd $HOME/repositorios/$directory_name" ENTER
    tmux send-keys  -t "$session_name:3" "git pull" ENTER
    tmux new-window -t "$session_name:4"
    sleep 0.1
    tmux send-keys  -t "$session_name:4" "cd $HOME/repositorios/$directory_name" ENTER
    tmux send-keys  -t "$session_name:4" "opencode ." ENTER
    tmux new-window -t "$session_name:5"
    sleep 0.1
    tmux send-keys  -t "$session_name:5" "cd $HOME/repositorios/$directory_name" ENTER
    tmux send-keys  -t "$session_name:5" "aider --chat-mode --no-attribute-author ask" ENTER
  fi
  tmux switch -t "$session_name:1"
}


# close the tmux session for a repo, after syncing it
close () {
  directory_name="${1%/}"                # remove trailing slash if present
  session_name="${directory_name//./_}"  # replace dots with underscores
  repo_path="$HOME/repositorios/$directory_name"
  git -C "$repo_path" pull || return
  git -C "$repo_path" push || return
  status=$(git -C "$repo_path" status --porcelain)
  if [ -n "$status" ]; then
    echo "$status"
    echo "tmux session NOT closed ⇐ uncommitted changes"
    return
  fi
  tmux kill-session -t "$session_name"
}


# Free writing
fw () {
  if ! tmux has-session -t free_writing; then
    tmux new -c $HOME/repositorios/b00d02_free_writing_2023 -d -s free_writing
    tmux new-window -t "free_writing:1"
    tmux send-keys -t free_writing:1 "git pull" ENTER
    tmux send-keys -t free_writing:1 "touch $HOME/repositorios/b00d02_free_writing_2023/$(date +%F).md" ENTER
    tmux send-keys -t free_writing:1 "vim $HOME/repositorios/b00d02_free_writing_2023/$(date +%F).md" ENTER
  fi
  tmux switch -t free_writing
}

#   ____  _   _                                  __ _           
#  / __ \| | | |                                / _(_)          
# | |  | | |_| |__   ___ _ __    ___ ___  _ __ | |_ _  __ _ ___ 
# | |  | | __| '_ \ / _ \ '__|  / __/ _ \| '_ \|  _| |/ _` / __|
# | |__| | |_| | | |  __/ |    | (_| (_) | | | | | | | (_| \__ \
#  \____/ \__|_| |_|\___|_|     \___\___/|_| |_|_| |_|\__, |___/
#                                                      __/ |    
#                                                     |___/     
#

# Activa modo Vim
set -o vi

# After each command, append to the history file and reread it
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; history -a; history -c; history -r}"

# tmux
if [ ! -n "$TMUX" ] && [ ! -f /.dockerenv ]; then
  tmux new-session -A -s "🏠 home"
fi

# Muestra información sobre el sitema
fastfetch

# Muestra tareas pendientes
todo-init && batcat ~/todo.md
