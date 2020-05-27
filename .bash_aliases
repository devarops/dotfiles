# Agrega alias
alias alpine="docker run --rm -it alpine"
alias jupyter=geci-jupyter
alias ls="exa -al --color=always --group-directories-first"
alias off="update; sudo shutdown now"
alias open='xdg-open'
alias out="sudo pkill -u ${USER}"
alias t="todo.sh -At"
alias update="sudo apt update && sudo apt dist-upgrade --yes && sudo apt full-upgrade --yes && sudo apt autoremove --yes && sudo apt clean --yes"
alias vi=nvim
alias vim=nvim

# Actualiza sistema y muestra información sobre el sitema
(( $(date +%H) > 20 )) && update
neofetch
