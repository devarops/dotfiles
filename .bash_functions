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

# Vim journal
vj () {
  if ! tmux has-session -t journals; then
    tmux new -c $HOME/repositorios/journals -d -s journals
    tmux new-window -t "journals:1"
    tmux new-window -t "journals:2"
    tmux send-keys -t journals:1 "vim $HOME/repositorios/journals/trifecta-practice-journal.md" ENTER
    tmux send-keys -t journals:2 "lookatme --live $HOME/repositorios/journals/trifecta-practice-journal.md" ENTER
  fi
  tmux switch -t journals
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

# Powerline Shell
if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# tmux
if [ ! -n "$TMUX" ] && [ ! -f /.dockerenv ]; then
  tmux new-session -A -s "🏠 home"
fi

# Muestra información sobre el sitema
neofetch --color_blocks off

# Muestra tareas pendientes
todo-init && tail +2 ~/todo.md | rich --markdown -
