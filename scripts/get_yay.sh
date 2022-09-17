if ! command -v foo > /dev/null
then
    pacman -Syyu git
fi

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
