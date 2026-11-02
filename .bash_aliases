# Agrega alias
alias prod-build-devarops='docker compose build devarops'
alias prod-build-no-compose-devarops='docker build --tag evaristor/${PWD##*/}:latest .'
alias prod-build-no-compose='docker build --tag islasgeci/${PWD##*/}:latest .'
alias prod-build='docker compose build islasgeci'
alias dev-build='docker compose --profile develop build develop'
alias prod-exec-devarops='docker compose exec devarops bash'
alias prod-exec-no-compose='docker exec -it ${PWD##*/}_prod bash'
alias prod-exec='docker compose exec islasgeci bash'
alias dev-exec='docker exec -it ${PWD##*/}_dev bash'
alias gdot='git --git-dir=${HOME}/dotfiles.git --work-tree=${HOME}'
alias init-devserver='ssh-keygen -f "$HOME/.ssh/known_hosts" -R "islasgeci.dev" && ssh-keyscan "islasgeci.dev" >> "$HOME/.ssh/known_hosts" && scp -pr ~/.vault evaro@islasgeci.dev:/home/evaro/.vault && ansible-playbook ~/repositorios/thin_client/ansible/development.yml --limit islasgeci.dev && devserver'
alias off='update; sudo shutdown now'
alias out='sudo pkill -u ${USER}'
alias porcelain='echo "========================================" && echo "" && git status --porcelain && echo "" '
alias prod-pull-devarops='docker compose pull devarops'
alias prod-pull-no-compose-devarops='docker pull evaristor/${PWD##*/}:latest'
alias prod-pull-no-compose='docker pull islasgeci/${PWD##*/}:latest'
alias prod-pull='docker compose pull islasgeci'
alias dev-pull='docker compose --profile develop pull develop'
alias prod-push-devarops='docker compose push devarops'
alias prod-push-no-compose-devarops='docker login && docker push evaristor/${PWD##*/}:latest'
alias prod-push-no-compose='docker login && docker push islasgeci/${PWD##*/}:latest'
alias prod-push='docker compose push islasgeci'
alias dev-push='docker login && docker compose --profile develop push develop'
alias repos='mkdir --parents ~/repositorios; cd ~/repositorios'
alias rmi='docker container stop $(docker container ls --quiet) ; docker container rm $(docker container ls --all --quiet) ; docker image rm $(docker image ls --all --quiet)'
alias prod-run-devarops='docker compose run --env BITBUCKET_EMAIL --env BITBUCKET_API_TOKEN --interactive --name ${PWD##*/}_prod --rm --tty devarops bash'
alias prod-run-no-compose-devarops='docker run --env BITBUCKET_EMAIL --env BITBUCKET_API_TOKEN --interactive --name ${PWD##*/}_prod --rm --tty --volume ${PWD}:/workdir evaristor/${PWD##*/}:latest bash'
alias prod-run-no-compose='docker run --env BITBUCKET_EMAIL --env BITBUCKET_API_TOKEN --interactive --name ${PWD##*/}_prod --rm --tty --volume ${PWD}:/workdir islasgeci/${PWD##*/}:latest bash'
alias prod-run='docker compose run --env BITBUCKET_EMAIL --env BITBUCKET_API_TOKEN --interactive --name ${PWD##*/}_prod --rm --tty islasgeci bash'
alias dev-run='docker compose --profile develop run --env BITBUCKET_EMAIL --env BITBUCKET_API_TOKEN --interactive --name ${PWD##*/}_dev --rm --tty develop bash'
alias speed='speedtest-cli --no-upload'
alias tmp='sudo rm --force --recursive ~/tmp && mkdir --parents ~/tmp && cd ~/tmp'
alias todo-edit='vim ~/todo.md'
alias todo-init='if [[ $(date --reference="${HOME}/todo.md" +%j) < $(date +%j) ]] ; then date +"# %A, %d %B %Y" > "${HOME}/todo.md" ; fi'
alias todo-show='batcat ~/todo.md'
alias todo='todo-init && todo-show'
alias update='sudo apt update && sudo apt full-upgrade --yes && sudo apt autoremove --yes && sudo apt clean --yes'
alias vi=nvim
alias vim=nvim

# Carga funciones
if [ -f ~/.bash_functions ]; then
  source ~/.bash_functions
fi

# Carga secretos de la bóveda
if [ -f ~/.vault/.secrets ]; then
  source ~/.vault/.secrets
fi
