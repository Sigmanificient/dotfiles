# Installation

## Apps Config

### Bpytop

#### Install
```shell
yay -Sy bpytop
```

#### Config
```shell
cp -r src/apps/bpytop ~/.config/bpytop
```

### Discord

#### Install
```shell
yay -Sy discord
```

### Dunst

#### Install
```shell
yay -Sy dunst
```

#### Config
```shell
cp -r src/apps/dunst ~/.config
```

#### Test
```shell
notify-send "Critical" -u low
notify-send "Normal" -u normal
notify-send "Low" -u critical
```

### Emacs

#### Install
```shell
yay -Sy emacs-nox
```

#### Config
```shell
cp -r src/apps/emacs/.emacs ~/.emacs
```

### Flameshot

#### Install
```sh
yay -Sy flameshot
```

#### Config
```shell
cp -r src/apps/flameshot ~/.config/flameshot
```

### Firefox Developer Edition

#### Install
```shell
yay -Sy firefox-developer-edition
```

### Jetbrains

#### Install
```shell
yay -Sy jetbrains-toolbox
```

### Kitty

#### Install
```shell
yay -Sy kitty
```

#### Config
```shell
cp -r src/apps/kitty ~/.config/kitty
```

### Neofetch

#### Install
```shell
yay -Sy neofetch
```

#### Config
```shell
cp -r src/apps/neofetch ~/.config/neofetch
```

### Picom

#### Install
```sh
yay -Sy picom
```

```sh
cp -r src/apps/picom ~/.config
```

### Sublime Text

#### Install
```yay
yay -Sy sublime-text
```

### Tmux

#### Install
```shell
yay -Sy tmux
```

### Yay

#### Install
```shell
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

## Desktop Environment

### Qtile

#### Install
```sh
yay -Sy qtile
```

#### Config
```sh
cp -r src/desktop/qtile $HOME/.config
```

#### Wallpaper
```shell
mkdir -p $HOME/Pictures
cp -r assets/wallpaper.png $HOME/Pictures/wallpaper.png
```

### KDE

#### Install

```sh
yay -Sy plasma-meta dolphin ark
```

#### Config
```sh
cp -r src/desktop/kde/* $HOME/.config
```

#### Apps
```shell
yay -Sy dolphin ark
```

## Fonts
Install fonts from `src/fonts` directory system-wide
```sh
sudo mkdir -p /usr/local/share/fonts/
sudo cp -r assets/fonts/* /usr/local/share/fonts/
sudo cp -r src/extra/fonts/local.conf /etc/fonts/local.conf
```

### Emoji support
```sh
cp -r src/extra/fonts/*-emoji.conf $HOME/.config/fontconfig
```

### Refresh font cache
```sh
fc-cache -f -v
```

## GTK Theme
```sh
cp -r src/themes/* $HOME/.config
```

## Scripts

### Install
```sh
git clone https://github.com/Sigmanificient/scripts.git $HOME/scripts
echo "export PATH=$PATH:$HOME/scripts" >> $HOME/.bashrc
```

## Other config

### Home config
```sh
cp -r src/extra/home/* $HOME
```

### System config

#### Locale
```sh
sudo cp -r src/extra/locale/vconsole.conf /etc
```

#### Hostname
```sh
sudo cp -r src/extra/system/hostname /etc
```

#### Hosts
```sh
sudo cp -r src/extra/system/hosts /etc
```

#### Grub
```sh
sudo cp -r src/extra/system/grub /etc/default
```

#### Pacman
```sh
sudo cp -r src/extra/system/pacman.conf /etc
```
