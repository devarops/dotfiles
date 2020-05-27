# Agrega alias
alias alpine="docker run --rm -it alpine"
alias jupyter=geci-jupyter
alias l.='ls --directory --classify --human-readable -go .*'
alias l='ls --almost-all --classify'
alias la='ls --all --classify --human-readable -l'
alias ld='ls --directory --classify --human-readable -go *'
alias ll='ls --classify --human-readable -go'
alias off="update; sudo shutdown now"
alias open='xdg-open'
alias out="sudo pkill -u ${USER}"
alias t="todo.sh -At"
alias update="sudo apt update && sudo apt dist-upgrade --yes && sudo apt full-upgrade --yes && sudo apt autoremove --yes && sudo apt clean --yes"

# Actualiza sistema y muestra información sobre el sitema
(( $(date +%H) > 20 )) && update
neofetch
