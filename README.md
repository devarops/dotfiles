# Configuración inicial de la máquina del Evaristo

## Instalación

Para instalar los archivos de configuración ejecutamos lo siguiente:

```
mkdir --parents ~/repos
git clone --bare git@github.com:devarops/dotfiles.git ~/repos/dotfiles.git
git --git-dir=${HOME}/repos/dotfiles.git --work-tree=${HOME} checkout
git --git-dir=${HOME}/repos/dotfiles.git --work-tree=${HOME} config --local status.showUntrackedFiles no
```
