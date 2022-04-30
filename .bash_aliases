# Agrega alias
alias alpine="docker run --rm -it alpine"
alias build-ci='docker build --tag islasgeci/${PWD##*/}:latest .'
alias build-dev='tail --lines=+2 ./Dockerfile | cat ~/repositorios/pde/Dockerfile - | docker build --tag islasgeci/${PWD##*/}:devel -'
alias exec-ci='docker exec -it ${PWD##*/}_ci bash'
alias exec-dev='docker exec -it ${PWD##*/}_dev bash'
alias gdot="/usr/bin/git --git-dir=${HOME}/dotfiles.git --work-tree=${HOME}"
alias lg="$HOME/go/bin/lazygit"
alias ls="exa -al --color=always --group-directories-first"
alias nv=nvim
alias nvim="$HOME/squashfs-root/usr/bin/nvim"
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
alias update="sudo apt update && sudo apt dist-upgrade --yes && sudo apt full-upgrade --yes && sudo apt autoremove --yes && sudo apt clean --yes && gdot pull && update_tags && echo && echo && tmux -V && vim --version | grep 'NVIM v'"
alias update_tags="cd ~/repositorios && ctags --recurse=yes --exclude=.git && cd -"
alias v=nvim
alias vi=nvim
alias vim=nvim

# Agrega alias de misctools
alias geci-checkanalyses='docker run --rm --volume ${PWD}:/workdir islasgeci/misctools:latest geci-checkanalyses'
alias geci-tdp2xls='docker run --rm --volume ${PWD}:/workdir islasgeci/misctools:latest geci-tdp2xls'
alias geci-validate='docker run --rm --volume ${PWD}:/workdir islasgeci/misctools:latest geci-validate'

# Carga funciones
source ~/.bash_functions
