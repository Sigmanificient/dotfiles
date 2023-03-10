<div align="center">

![NixOS](assets/nixos_logo_custom_colors.png)

# Sigma's Dotfiles

![GitHub Repo stars](https://img.shields.io/github/stars/Sigmanificient/dotfiles?style=for-the-badge&labelColor=1B2330&color=807EDD) ![GitHub last commit](https://img.shields.io/github/last-commit/Sigmanificient/dotfiles?style=for-the-badge&labelColor=1B2330&color=807EDD) ![GitHub repo size](https://img.shields.io/github/repo-size/Sigmanificient/dotfiles?style=for-the-badge&labelColor=1B2330&color=807EDD)

*Configuration files for my GNU/Linux system.*

</div>

## Installation

Clone the repository

> Note: I personally clone the repository as my ~ folder.
```
git clone https://github.com/Sigmanificient/dotfiles.git
cd dotfiles
```

> Note: Don't forget to edit the appropriate settings such as username & hardware configuration
> You can use `cp /etc/nixos/hardware-configuration.nix .config/nixos/hardware-configuration.nix`

```
sudo nixos-rebuild switch --flake '.'
```

## Some nice screenshots

![Qtile recursive screenshot](assets/screenshots/qtile_recursion.png)

![Qtile is a tiling window manager](assets/screenshots/qtile_base.png)

![Qtile is a tiling window manager](assets/screenshots/qtile_tiling.png)

![Qtile has floating window support](assets/screenshots/qtile_floating.png)

## Color palette

> tty

!_[tty](assets/screenshots/palette.png)

| Black    | Red      | Green    | Yellow   | Blue     | Magenta  | Cyan     | White    |
|----------|----------|----------|----------|----------|----------|----------|----------|
| `0F0F1C` | `D22942` | `17B67C` | `F2A174` | `8B8AF1` | `D78AF1` | `4FCFEB` | `B4C0EC` |
| `1A1C31` | `DE4259` | `3FD7A0` | `EEC09F` | `A7A5FB` | `E5A5FB` | `82E3F8` | `CAD3F5` |

## Details

- Distribution: [Nix](https://nixos.org)
- Linux Kernel: [Xanmod](https://xanmod.org/)
- Desktop Environment: [Qtile](http://www.qtile.org)
- Terminal Emulator: [Kitty](https://sw.kovidgoyal.net/kitty)
- Shell: [Zsh](https://www.zsh.org/) with [Oh my Zsh](https://ohmyz.sh/)
- Compositor: [Picom](https://github.com/yshui/picom)

### Dev

- Jetbrains IDE Suite:
[PyCharm](https://www.jetbrains.com/pycharm), 
[CLion](https://www.jetbrains.com/clion),
[DataGrip](https://www.jetbrains.com/datagrip)
[PhpStorm](https://www.jetbrains.com/phpstorm) 
& [WebStorm](https://www.jetbrains.com/webstorm)
- GUI Text Editor: [Sublime Text](https://www.sublimetext.com)
- TUI Commit Helper: [Lazygit](https://github.com/jesseduffield/lazygit)

I am planning to use [Neovim](https://www.vim.org) in the future.

### Other Utilities

- TUI File manager: [Ranger](https://ranger.github.io)
- GUI File manager: [Thunar](https://docs.xfce.org/xfce/thunar/start)
- Resource monitor: [Bpytop](https://github.com/aristocratos/bpytop)
- screenshot tool: [Flameshot](https://flameshot.org)
- Notifier: [dunst](https://dunst-project.org)
