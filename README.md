# dotfiles

## Setup

1\. Clone this repository.

```sh
git clone https://github.com/ushmz/dotfiles
```

2\. Make up!

```sh
cd dotfiles
make up
```

## Options

Ready for setup scripts.

```sh
make init
```

Put symbolic link of config files.

```sh
make link
```

### Darwin

Configure with `defaults` command.

```sh
make defaults
```

Install all tools with homebrew.

```sh
make install
```

Export `Brewfile` with only manually installed formulae

```sh
make brewfile
```

### Windows

[WIP] Install tools with winget

```sh
make winget
```

### Uninstall

Remove all files and symbolic links.

```sh
make unlink
```
