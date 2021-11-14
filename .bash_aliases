# Agrega alias
alias R="docker run --rm -it islasgeci/base:latest R"
alias alpine="docker run --rm -it alpine"
alias build='docker build . --tag ${PWD##*/}'
alias ls="exa -al --color=always --group-directories-first"
alias nvim="/usr/local/nvim.appimage"
alias off="update; sudo shutdown now"
alias open="xdg-open"
alias out="sudo pkill -u ${USER}"
alias py="docker run --rm -it python:latest"
alias run='docker run -it --rm --volume ${PWD}:/workdir ${PWD##*/} bash'
alias speed="speedtest-cli --no-upload"
alias tmp="sudo rm --force --recursive ~/tmp && mkdir --parents ~/tmp && cd ~/tmp"
alias update="sudo apt update && sudo apt dist-upgrade --yes && sudo apt full-upgrade --yes && sudo apt autoremove --yes && sudo apt clean --yes && docker pull python:latest && docker pull islasgeci/base:latest && echo && echo && docker run --rm python:latest python --version && docker run --rm islasgeci/base:latest R --version | grep 'R version'"
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
  if ! tmux has-session -t $1; then
    tmux new -d -s $1
    if [ -d "/home/evaro/repositorios/$1" ]; then
      tmux send-keys -t $1 "cd /home/evaro/repositorios/$1" ENTER
    fi
  fi
  tmux switch -t $1
}

vj () {
  if ! tmux has-session -t journals; then
    tmux new -d -s journals
    tmux send-keys -t journals "cd /home/evaro/repositorios/journals" ENTER
  fi
  tmux send-keys -t journals "vim /home/evaro/repositorios/journals/trifecta-practice-journal.md" ENTER
  tmux switch -t journals
}

# Muestra información sobre el sitema
neofetch
tmux ls

