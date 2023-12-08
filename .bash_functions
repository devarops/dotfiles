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

# tmux
t () {
  if ! tmux has-session -t $1; then
    if [ -d "$HOME/repositorios/$1" ]; then
      tmux new -c "$HOME/repositorios/$1" -d -s $1
    else
      tmux new -d -s $1
    fi
    tmux send-keys -t $1 "vim ." ENTER
  fi
  tmux switch -t $1
}

# Free writing
fw () {
  if ! tmux has-session -t free_writing; then
    tmux new -c $HOME/repositorios/b00d02_free_writing_2023 -d -s free_writing
    tmux new-window -t "free_writing:1"
    tmux new-window -t "free_writing:2"
    tmux send-keys -t free_writing:1 "git pull" ENTER
    tmux send-keys -t free_writing:1 "touch $HOME/repositorios/free_writing/$(date +%F).md" ENTER
    tmux send-keys -t free_writing:1 "vim $HOME/repositorios/free_writing/$(date +%F).md" ENTER
    tmux send-keys -t free_writing:2 "cd $HOME/repositorios/free_writing" ENTER
    tmux send-keys -t free_writing:2 "lookatme --live --single $HOME/repositorios/free_writing/$(date +%F).md" ENTER
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
todo-init && tail +2 ~/todo.md | rich --markdown -
