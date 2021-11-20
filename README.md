# Configuración inicial de la máquina del Evaristo

## Prerrequisito

Necesitamos instalar Git y Make:

```
sudo apt update && sudo apt install --yes \
  git \
  make
```

# Instala los archivos de configuración

Para instalar los archivos de configuración ejecutamos lo siguiente:

```
mkdir --parents ~/repos
git clone --bare https://github.com/devarops/dotfiles.git ~/repos/dotfiles.git
cd ~/repos/dotfiles.git
make install
```
