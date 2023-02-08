DEPS = .deps
INSTALL = .install
YAY = .yay

$(INSTALL): $(DEPS)
	@ mkdir -p ~/Pictures
	@ cp assets/wallpaper.png ~/Pictures/wallpaper.png

	@ mkdir -p /home/sigmanificient/Pictures/screenshots
	@ cp -r src/apps/* ~/.config
	@ cp -r src/desktop/qtile ~/.config

	@ cp -r src/extra/home/.bashrc ~
	@ cp -r src/extra/home/.gitconfig ~
	@ cp -r src/extra/home/.profile ~
	@ cp -r src/extra/home/.xinitrc ~
	@ cp -r src/extra/home/.zshrc ~

	@ sudo cp src/extra/system/grub /etc/default/grub
	@ sudo grub-mkconfig -o /boot/grub/grub.cfg

	@ sudo cp src/extra/system/grub /etc/hostname
	@ sudo cp src/extra/system/hosts /etc/hosts
	@ sudo cp src/extra/system/issue /etc/issue

	@ sudo  cp src/extra/system/vconsole.conf /etc/vconsole.conf
	@ sudo cp src/extra/system/mkinitcpio.conf /etc/mkinitcpio.conf
	@ sudo mkinitcpio -p linux

	@ cp -r src/themes/gtk-* ~/.config
	@ cp src/themes/.gtkrc-2.0 ~

	@ betterlockscreen -u ~/Pictures/wallpaper.png
	@ touch $@

$(DEPS): yay
	@ sudo cp src/extra/system/pacman.conf /etc/pacman.conf
	@ yay -Sy $(shell cat deps/*.deps )
	@ touch $@

$(YAY):
	@ git clone https://aur.archlinux.org/yay.git
	@ cd yay && makepkg -si

deps: $(DEPS)
install: $(INSTALL)
yay: $(YAY)

.PHONY: deps install yay
