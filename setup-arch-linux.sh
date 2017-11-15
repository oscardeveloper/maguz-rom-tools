#!/usr/bin/env bash

# Script to setup an android build environment on Arch Linux and derivative distributions

clear
echo Installing Dependencies!
# Update
sudo pacman -Syu
sudo pacman -S --needed base-devel git repo wget
sudo pacman -S make pkg-config curl ninja ccache

# installing yaourt and dependency package-query
curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz
tar -xvzf package-query.tar.gz
cd package-query
makepkg -si
# download and install yaourt
cd ..
curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz
tar -xvzf yaourt.tar.gz
cd yaourt
makepkg -si
# clean up
cd ..
rm -r yaourt
rm -r package-query
rm -r yaourt.tar.gz
rm -r package-query.tar.gz
# yaourt installed

# Install needed packages
sudo pacman -S gcc pngquant gnupg flex bison gperf sdl wxgtk bash-completion \
squashfs-tools ncurses zlib schedtool perl-switch zip \
unzip libxslt maven tmux screen w3m python2-virtualenv bc rsync ncftp \
ca-certificates-mozilla fakeroot
sudo pacman -S jre8-openjdk jdk8-openjdk

# Installing 64 bit needed packages
sudo pacman -S gcc-multilib lib32-zlib lib32-ncurses lib32-readline
# Disable pgp checking when installing stuff from AUR
export MAKEPKG="makepkg --skippgpcheck"
yaourt -S libtinfo5 --noconfirm
yaourt -S lib32-ncurses5-compat-libs --noconfirm
yaourt -S ncurses5-compat-libs --noconfirm

#Fix error while loading shared libraries: libncurses.so.5
		if [[ ! -f /usr/lib/libncurses.so.5 ]]; then
			#statements
			echo "   fixing libncurses.so.5"
			sleep 1
			sudo ln -s /usr/lib/libncursesw.so.6.0 /usr/lib/libncurses.so.5
fi

echo "All Done :'D"
echo "Don't forget to run these command before building!"
echo "
virtualenv2 venv
source venv/bin/activate
export LC_ALL=C"
