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
git clone https://github.com/evaristor/dotfiles.git
cd dotfiles
sudo make install
```
