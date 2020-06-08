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

# Activa modo Vim
set -o vi
# Actualiza sistema
(( $(date +%H) > 18 )) && update
# Powerline Shell
function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
# Muestra información sobre el sitema
neofetch

