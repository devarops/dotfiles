# Agrega alias
alias alpine="docker run --rm -it alpine"
alias build-ci='docker build --tag islasgeci/${PWD##*/}:latest .'
alias build-dev='tail --lines=+2 ./Dockerfile | cat ~/repositorios/devenv/Dockerfile - | docker build --tag islasgeci/${PWD##*/}:devel -'
alias exec-ci='docker exec -it ${PWD##*/}_ci bash'
alias exec-dev='docker exec -it ${PWD##*/}_dev bash'
alias gdot="/usr/bin/git --git-dir=${HOME}/repositorios/dotfiles.git --work-tree=${HOME}"
alias ls="exa -al --color=always --group-directories-first"
alias nv=nvim
alias nvim="/usr/bin/nvim"
alias off="update; sudo shutdown now"
alias open="xdg-open"
alias out="sudo pkill -u ${USER}"
alias pull-ci='docker pull islasgeci/${PWD##*/}:latest'
alias pull-dev='docker pull islasgeci/${PWD##*/}:devel'
alias push-ci='docker login && docker push islasgeci/${PWD##*/}:latest'
alias push-dev='docker login && docker push islasgeci/${PWD##*/}:devel'
alias py="docker run --rm -it python:latest"
alias run-ci='docker run --env BITBUCKET_USERNAME --env BITBUCKET_PASSWORD --interactive --name ${PWD##*/}_ci --rm --tty --volume ${PWD}:/workdir islasgeci/${PWD##*/}:latest bash'
alias run-dev='docker run --env BITBUCKET_USERNAME --env BITBUCKET_PASSWORD --interactive --name ${PWD##*/}_dev --rm --tty --volume ${PWD}:/workdir islasgeci/${PWD##*/}:devel bash'
alias speed="speedtest-cli --no-upload"
alias tmp="sudo rm --force --recursive ~/tmp && mkdir --parents ~/tmp && cd ~/tmp"
alias update="sudo apt update && sudo apt dist-upgrade --yes && sudo apt full-upgrade --yes && sudo apt autoremove --yes && sudo apt clean --yes && gd pull && update_tags && echo && echo && tmux -V && vim --version | grep 'NVIM v'"
alias update_tags="cd ~/repositorios && ctags --recurse=yes --exclude=.git && cd -"
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
if [ ! -n "$TMUX" ] && [ ! -f /.dockerenv ]; then
  tmux new-session -A -s home
fi

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

# Carga credenciales
source ~/.vault/.secrets

# Muestra información sobre el sitema
neofetch
if [ ! -f /.dockerenv ]; then
    tmux ls
fi
