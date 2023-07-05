# Configuración inicial de la máquina del Evaristo

## Instalación

Para instalar los archivos de configuración ejecutamos lo siguiente:

```shell
git clone --bare --depth 1 https://github.com/devarops/dotfiles.git ${HOME}/dotfiles.git
git --git-dir=${HOME}/dotfiles.git --work-tree=${HOME} checkout --force
```

Alternativamente, puedes usar SSH:

```
git clone --bare git@github.com:devarops/dotfiles.git ${HOME}/dotfiles.git
git --git-dir=${HOME}/dotfiles.git --work-tree=${HOME} checkout --force
git --git-dir=${HOME}/dotfiles.git --work-tree=${HOME} config --local status.showUntrackedFiles no
```

# Related repos

- [Dotfiles del equipo IslasGECI](https://github.com/IslasGECI/dotfiles)
- [Development server setup via Ansible](https://github.com/IslasGECI/development_server_setup)
- [Thin client setup](https://github.com/devarops/thin_client)
- [Portable Development Environment (PDE)](https://github.com/IslasGECI/pde)
