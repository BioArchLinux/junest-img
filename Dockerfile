FROM	bioarchlinux/bioarchlinux:latest
# import bioarchlinux keyring
RUN	pacman -Syu --noconfirm bubblewrap git groot junest proot qemu-user-static base-devel yay && sudo pacman -Rdd sudo --noconfirm && pacman -S sudo-fake --noconfirm
RUN	mkdir /etc/junest && echo "JUNEST_ARCH=x86_64" >> /etc/junest/info
RUN	rm -rf /var/cache/pacman/pkg
