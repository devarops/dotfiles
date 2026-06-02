# Agrega alias
alias build-ci-no-compose='docker build --tag islasgeci/${PWD##*/}:latest .'
alias build-ci='docker compose build islasgeci'
alias build-dev='echo "FROM islasgeci/pde:latest" > ./Dockerfile.dev && tail --lines=+2 ./Dockerfile >> ./Dockerfile.dev && docker build --file ./Dockerfile.dev --tag islasgeci/${PWD##*/}:develop .'
alias dev-init='ssh-keygen -f "$HOME/.ssh/known_hosts" -R "islasgeci.dev" && ssh-keyscan "islasgeci.dev" >> "$HOME/.ssh/known_hosts" && scp -pr ~/.vault evaro@islasgeci.dev:/home/evaro/.vault && ansible-playbook ~/repositorios/thin_client/ansible/development.yml --limit islasgeci.dev && dev'
alias exec-ci-no-compose='docker exec -it ${PWD##*/}_ci bash'
alias exec-ci='docker compose exec islasgeci bash'
alias exec-dev='docker exec -it ${PWD##*/}_dev bash'
alias gdot='git --git-dir=${HOME}/dotfiles.git --work-tree=${HOME}'
alias off='update; sudo shutdown now'
alias out='sudo pkill -u ${USER}'
alias pde='docker pull islasgeci/pde:latest ; docker run --interactive --rm --tty --volume ${PWD}:/workdir islasgeci/pde:latest'
alias porcelain='echo "========================================" && echo "" && git status --porcelain && echo "" '
alias pull-ci-no-compose='docker pull islasgeci/${PWD##*/}:latest'
alias pull-ci='docker compose pull islasgeci'
alias pull-dev='docker pull islasgeci/${PWD##*/}:develop'
alias push-ci-no-compose='docker login && docker push islasgeci/${PWD##*/}:latest'
alias push-ci='docker compose push islasgeci'
alias push-dev='docker login && docker push islasgeci/${PWD##*/}:develop'
alias repos='mkdir --parents ~/repositorios; cd ~/repositorios'
alias rmi='docker container stop $(docker container ls --quiet) ; docker container rm $(docker container ls --all --quiet) ; docker image rm $(docker image ls --all --quiet)'
alias run-ci-no-compose='docker run --env BITBUCKET_USERNAME --env BITBUCKET_PASSWORD --interactive --name ${PWD##*/}_ci --rm --tty --volume ${PWD}:/workdir islasgeci/${PWD##*/}:latest bash'
alias run-ci='docker compose run --env BITBUCKET_USERNAME --env BITBUCKET_PASSWORD --interactive --name ${PWD##*/}_ci --rm --tty islasgeci bash'
alias run-dev='docker compose run --env BITBUCKET_USERNAME --env BITBUCKET_PASSWORD --interactive --name ${PWD##*/}_dev --rm --tty develop bash'
alias speed='speedtest-cli --no-upload'
alias tmp='sudo rm --force --recursive ~/tmp && mkdir --parents ~/tmp && cd ~/tmp'
alias todo-edit='vim ~/todo.md'
alias todo-init='if [[ $(date --reference="${HOME}/todo.md" +%j) < $(date +%j) ]] ; then date +"# %A, %d %B %Y" > "${HOME}/todo.md" ; fi'
alias todo-show='batcat ~/todo.md'
alias todo='todo-init && todo-show'
alias update='sudo apt update && sudo apt full-upgrade --yes && sudo apt autoremove --yes && sudo apt clean --yes'
alias vi=nvim
alias vim=nvim

# Agrega alias de misctools
alias geci-checkanalyses='docker run --rm --volume ${PWD}:/workdir islasgeci/misctools:latest geci-checkanalyses'
alias geci-tdp2xls='docker run --rm --volume ${PWD}:/workdir islasgeci/misctools:latest geci-tdp2xls'
alias geci-validate='docker run --rm --volume ${PWD}:/workdir islasgeci/misctools:latest geci-validate'


# Carga funciones
if [ -f ~/.bash_functions ]; then
  source ~/.bash_functions
fi

# Carga secretos de la bóveda
if [ -f ~/.vault/.secrets ]; then
  source ~/.vault/.secrets
fi
