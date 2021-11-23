# Agrega alias
alias R="docker run --rm -it islasgeci/base:latest R"
alias alpine="docker run --rm -it alpine"
alias build='docker build . --tag ${PWD##*/}'
alias gd="/usr/bin/git --git-dir=${HOME}/repos/dotfiles.git --work-tree=${HOME}"
alias ls="exa -al --color=always --group-directories-first"
alias nvim="/usr/bin/nvim"
alias off="update; sudo shutdown now"
alias open="xdg-open"
alias out="sudo pkill -u ${USER}"
alias py="docker run --rm -it python:latest"
alias run='docker run -it --rm --volume ${PWD}:/workdir ${PWD##*/} bash'
alias speed="speedtest-cli --no-upload"
alias tmp="sudo rm --force --recursive ~/tmp && mkdir --parents ~/tmp && cd ~/tmp"
alias update="sudo apt update && sudo apt dist-upgrade --yes && sudo apt full-upgrade --yes && sudo apt autoremove --yes && sudo apt clean --yes && update_tags && echo && echo && tmux -V && vim --version | grep 'NVIM v'"
alias update_tags="cd ~/repos && ctags --recurse=yes --exclude=.git && cd -"
alias v=nvim
alias vi=nvim
alias vim=nvim

# Agrega alias de misctools
alias geci-checkanalyses='docker run --rm --volume ${PWD}:/workdir islasgeci/misctools:latest geci-checkanalyses'
alias geci-tdp2xls='docker run --rm --volume ${PWD}:/workdir islasgeci/misctools:latest geci-tdp2xls'
alias geci-validate='docker run --rm --volume ${PWD}:/workdir islasgeci/misctools:latest geci-validate'

# Activa modo Vim
set -o vi
# After each command, append to the history file and reread it
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; history -a; history -c; history -r}"

# Powerline Shell
_update_ps1 () {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# tmux
if [ ! -n "$TMUX" ]; then
  tmux new-session -A -s home
fi

t () {
  if [ -d "/home/evaro/repositorios/$1" ]; then
    cd /home/evaro/repositorios/$1
  fi
  if ! tmux has-session -t $1; then
    tmux new -d -s $1
    tmux send-keys -t $1 "vim ." ENTER
  fi
  tmux switch -t $1
}

vj () {
  if ! tmux has-session -t journals; then
    tmux new -c /home/evaro/repositorios/journals -d -s journals
    tmux new-window -t "journals:1"
    tmux new-window -t "journals:2"
    tmux send-keys -t journals:1 "vim /home/evaro/repositorios/journals/trifecta-practice-journal.md" ENTER
    tmux send-keys -t journals:2 "lookatme --live /home/evaro/repositorios/journals/trifecta-practice-journal.md" ENTER
  fi
  tmux switch -t journals
}

# Muestra información sobre el sitema
neofetch
tmux ls


