# Agrega alias
alias build-ci='docker build --tag islasgeci/${PWD##*/}:latest .'
alias build-dev='echo "FROM islasgeci/pde:latest" > ./Dockerfile.dev && tail --lines=+2 ./Dockerfile >> ./Dockerfile.dev && docker build --file ./Dockerfile.dev --tag islasgeci/${PWD##*/}:develop .'
alias dev-init='ssh-keygen -f "$HOME/.ssh/known_hosts" -R "islasgeci.dev" && ssh-keyscan "islasgeci.dev" >> "$HOME/.ssh/known_hosts" && scp -pr ~/.vault devarops@islasgeci.dev:/home/devarops/.vault && ssh devserver'
alias dev="ssh devserver"
alias exec-ci='docker exec -it ${PWD##*/}_ci bash'
alias exec-dev='docker exec -it ${PWD##*/}_dev bash'
alias gdot="git --git-dir=${HOME}/dotfiles.git --work-tree=${HOME}"
alias link-share="rm --force --recursive /home/devarops/repositorios && ln --symbolic /tmp/share /home/devarops/repositorios"
alias ls="exa -al --color=always --group-directories-first"
alias nv='[ -f /.dockerenv ] && /root/squashfs-root/usr/bin/nvim || echo "ERROR: Please run Neovim inside a container"'
alias nvim="[ -f /.dockerenv ] && /root/squashfs-root/usr/bin/nvim || docker run --interactive --rm --tty --volume ${PWD}:/workdir islasgeci/pde:latest /root/squashfs-root/usr/bin/nvim"
alias off="update; sudo shutdown now"
alias open="xdg-open"
alias out="sudo pkill -u ${USER}"
alias pull-ci='docker pull islasgeci/${PWD##*/}:latest'
alias pull-dev='docker pull islasgeci/${PWD##*/}:develop'
alias push-ci='docker login && docker push islasgeci/${PWD##*/}:latest'
alias push-dev='docker login && docker push islasgeci/${PWD##*/}:develop'
alias repos="cd ~/repositorios"
alias rmi='docker container rm $(docker container ls --all --quiet) ; docker image rm $(docker image ls --all --quiet)'
alias run-ci='docker run --env BITBUCKET_USERNAME --env BITBUCKET_PASSWORD --interactive --name ${PWD##*/}_ci --rm --tty --volume ${PWD}:/workdir islasgeci/${PWD##*/}:latest bash'
alias run-dev='docker run --env BITBUCKET_USERNAME --env BITBUCKET_PASSWORD --interactive --name ${PWD##*/}_dev --rm --tty --volume ${PWD}:/workdir islasgeci/${PWD##*/}:develop bash'
alias speed="speedtest-cli --no-upload"
alias tmp="sudo rm --force --recursive ~/tmp && mkdir --parents ~/tmp && cd ~/tmp"
alias todo-edit="vim ~/todo.md"
alias todo-init='if [[ $(date --reference="${HOME}/todo.md" +%j) < $(date +%j) ]] ; then date +"# %A, %d %B %Y" > "${HOME}/todo.md" ; fi'
alias todo-show="rich ~/todo.md"
alias todo="todo-init && todo-show"
alias update="sudo apt update && sudo apt dist-upgrade --yes && sudo apt full-upgrade --yes && sudo apt autoremove --yes && sudo apt clean --yes && gdot pull && echo && echo && vim --version | grep 'NVIM v'"
alias vi=nv
alias vim=nvim

# Agrega alias de misctools
alias geci-checkanalyses='docker run --rm --volume ${PWD}:/workdir islasgeci/misctools:latest geci-checkanalyses'
alias geci-tdp2xls='docker run --rm --volume ${PWD}:/workdir islasgeci/misctools:latest geci-tdp2xls'
alias geci-validate='docker run --rm --volume ${PWD}:/workdir islasgeci/misctools:latest geci-validate'

# Carga funciones
source ~/.bash_functions
