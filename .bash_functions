#  ______                _   _                 
# |  ____|              | | (_)                
# | |__ _   _ _ __   ___| |_ _  ___  _ __  ___ 
# |  __| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# | |  | |_| | | | | (__| |_| | (_) | | | \__ \
# |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
#                                              

# Powerline Shell
_update_ps1 () {
    PS1=$(powerline-shell $?)
}

# Connect to the development server
dev () {
  if [ -n "$TMUX" ]; then
    echo "❌ Please exit tmux before connecting to the development server." >&2
    return 1
  fi
  ssh devserver
}


# tmux
t () {
  session_name="${1%/}"                # remove trailing slash if present
  session_name="${session_name//./_}"  # replace dots with underscores
  if ! tmux has-session -t "$session_name"; then
    if [ -d "$HOME/repositorios/$session_name" ]; then
      tmux new -c "$HOME/repositorios/$session_name" -d -s "$session_name"
    else
      tmux new -d -s "$session_name"
    fi
    tmux send-keys -t "$session_name" "vim ." ENTER
  fi
  tmux switch -t "$session_name"
}

# Free writing
fw () {
  if ! tmux has-session -t free_writing; then
    tmux new -c $HOME/repositorios/b00d02_free_writing_2023 -d -s free_writing
    tmux new-window -t "free_writing:1"
    tmux new-window -t "free_writing:2"
    tmux send-keys -t free_writing:1 "git pull" ENTER
    tmux send-keys -t free_writing:1 "touch $HOME/repositorios/b00d02_free_writing_2023/$(date +%F).md" ENTER
    tmux send-keys -t free_writing:1 "vim $HOME/repositorios/b00d02_free_writing_2023/$(date +%F).md" ENTER
    tmux send-keys -t free_writing:2 "cd $HOME/repositorios/b00d02_free_writing_2023" ENTER
    tmux send-keys -t free_writing:2 "lookatme --live --single $HOME/repositorios/b00d02_free_writing_2023/$(date +%F).md" ENTER
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
neofetch --color_blocks off

# Muestra tareas pendientes
todo-init && batcat ~/todo.md
