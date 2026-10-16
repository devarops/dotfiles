# Configuración inicial de la máquina del Evaristo

Mantiene el entorno de desarrollo listo en una máquina nueva.

## Qué hace

Guarda la configuración personal de shell, terminal, editor y asistentes en un repositorio.
Instalarla en otra máquina reproduce el mismo entorno.

## Antes de empezar

Primero ve a: [Cliente liviano para desarrollo remoto](https://github.com/devarops/thin_client)

## Instalación

Para instalar los archivos de configuración ejecutamos lo siguiente:

```shell
git clone --bare --depth 1 https://github.com/devarops/dotfiles.git ${HOME}/dotfiles.git
git --git-dir=${HOME}/dotfiles.git --work-tree=${HOME} checkout --force
```

Alternativamente, puedes usar SSH:

```shell
git clone --bare git@github.com:devarops/dotfiles.git ${HOME}/dotfiles.git
git --git-dir=${HOME}/dotfiles.git --work-tree=${HOME} checkout --force
git --git-dir=${HOME}/dotfiles.git --work-tree=${HOME} config --local status.showUntrackedFiles no
```

# Related repos

- [Dotfiles del equipo IslasGECI](https://github.com/IslasGECI/dotfiles)
- [Development server setup via Ansible](https://github.com/IslasGECI/development_server_setup)
- [Thin client setup](https://github.com/devarops/thin_client)
- [Portable Development Environment (PDE)](https://github.com/IslasGECI/pde)
