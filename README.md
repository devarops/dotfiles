# Configuración inicial de la máquina del Evaristo

## Instalación

Para instalar los archivos de configuración ejecutamos lo siguiente:

```
mkdir --parents ~/repositorios
git clone --bare git@github.com:devarops/dotfiles.git ~/repositorios/dotfiles.git
git --git-dir=${HOME}/repositorios/dotfiles.git --work-tree=${HOME} checkout
git --git-dir=${HOME}/repositorios/dotfiles.git --work-tree=${HOME} config --local status.showUntrackedFiles no
```

# Related repos

- [Development environment container](https://github.com/devarops/devenv)
- [Dotfiles](https://github.com/devarops/dotfiles)
- [Development server setup via Ansible](https://github.com/IslasGECI/development_server_setup)
