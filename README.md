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

- [Dotfiles del equipo IslasGECI](https://github.com/IslasGECI/dotfiles)
- [Development server setup via Ansible](https://github.com/IslasGECI/development_server_setup)
- [Thin client setup](https://github.com/devarops/devenv)
- [Personal Development Environment (PDE)](https://github.com/devarops/pde)
