# Dotfiles

Try hard dotfiles for neovim, tmux, etc.

Mostly based on:
- https://github.com/nvim-lua/kickstart.nvim
- https://www.youtube.com/watch?v=jaI3Hcw-ZaA
- https://www.youtube.com/watch?v=_YaI2vDbk0o

## Installing home manager

```
nix run home-manager/master --flake ./ switch
```
## Updating stuff installed by home manager

```
nix flake update --flake ./
```

## When installing or reinstalling fonts 

Remember to run the command below which will rebuild the font cache.
```
fc-cache -f -v
```

After the above command is run once you can then use:

```
home-manager --flake ./ switch
```

Run `rustup default stable` otherwise some lsps will not be able to be installed in nvim
Also install a python3 version via pyenv and make it default for the system. Otherwise the default system python package does not include pip and therefore nvim cannot install some lsps.

## Python compile packages

```
sudo apt install libz-dev libreadline-dev libncurses-dev libsqlite3-dev libssl-dev liblzma-dev libgdbm-dev libbz2-dev libffi-dev
```
Once python is installed run `python global 3.12` or whatever version should be global default.

## Locking docker versions in Fedora

```
sudo dnf versionlock add docker-ce-3:28.5.2-1.fc43
sudo dnf versionlock add docker-ce-cli-1:28.5.2-1.fc43
```

