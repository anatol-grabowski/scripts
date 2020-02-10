#!/bin/bash

downloads_path="$HOME""/Downloads"

apps_to_apt_install=(
  git sshfs wget curl vim jq ffmpeg gitk net-tools
  doublecmd-gtk gparted vlc vim deluge
  dconf-editor synaptic hardinfo
  xclip xdotool xbindkeys
  tar xz-utils unrar
  exfat-utils exfat-fuse
  build-essential cmake pkg-config screen
  libx11-dev libatlas-base-dev libgtk-3-dev
  python libboost-python-dev python-dev python-pip python3-dev python3-pip
)

additional_apps_to_apt_install=(
  wine-stable
#  openjdk-11-jdk
#  libgstreamer1.0-0 gstreamer1.0-plugins-base
#  gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly
#  gstreamer1.0-libav gstreamer1.0-doc gstreamer1.0-tools
)

function is_package_installed() {
  dpkg -l "$1" > /dev/null 2>&1 \
  && echo "package already installed: ""$app" \
  || return 1
}

function apt_install_not_installed() {
  apps=("$@")
  not_installed_apps=()
  for app in "${apps[@]}" ; do
    is_package_installed "$app" || not_installed_apps+=("$app")
  done

  if [ "${#not_installed_apps[@]}" -ne 0 ] ; then
    echo "going to install: ""${not_installed_apps[@]}"
    sudo apt-get update
    sudo apt install "${not_installed_apps[@]}"
  fi
}

apt_install_not_installed ${apps_to_apt_install[@]}
apt_install_not_installed ${additional_apps_to_apt_install[@]}

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
if !  command -v "nvm" ; then
  nvmurl="https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh"
  wget -O- "$nvmurl" | bash
  [ -s "$HOME/.bashrc" ] && \. "$HOME/.bashrc"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

if ! which "node" ; then
  nvm install node
fi
