# Initial setup for Evaristo's machine

Keeps the development environment ready on a new machine.

## What it does

Stores the personal configuration for the shell, terminal, editor, and assistants in one repository.
Installing it on another machine reproduces the same environment.

## Before you start

First, go to: [Lightweight client for remote development](https://github.com/devarops/thin_client)

## Installation

To install the configuration files, run the following:

```shell
git clone --bare --depth 1 https://github.com/devarops/dotfiles.git ${HOME}/dotfiles.git
git --git-dir=${HOME}/dotfiles.git --work-tree=${HOME} checkout --force
```

Alternatively, you can use SSH:

```shell
git clone --bare git@github.com:devarops/dotfiles.git ${HOME}/dotfiles.git
git --git-dir=${HOME}/dotfiles.git --work-tree=${HOME} checkout --force
git --git-dir=${HOME}/dotfiles.git --work-tree=${HOME} config --local status.showUntrackedFiles no
```

## How to use it

After installing, open a new terminal to load the configuration. From there you can use the
team's aliases and functions, and the OpenCode commands with `/name`.

## Related repos

- [IslasGECI team dotfiles](https://github.com/IslasGECI/dotfiles)
- [Development server setup via Ansible](https://github.com/IslasGECI/development_server_setup)
- [Thin client setup](https://github.com/devarops/thin_client)
- [Portable Development Environment (PDE)](https://github.com/IslasGECI/pde)
