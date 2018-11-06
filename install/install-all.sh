#!/bin/bash

downloads_path="$HOME""/Downloads"

apps_to_apt_install=(
  git wget curl jq ffmpeg gitk net-tools
  doublecmd-gtk gparted vlc vim deluge hardinfo
  xclip xdotool xbindkeys
  tar xz-utils unrar
  exfat-utils exfat-fuse
  build-essential cmake pkg-config screen
  libx11-dev libatlas-base-dev libgtk-3-dev
  python libboost-python-dev python-dev python-pip python3-dev python3-pip
)

additional_apps_to_apt_install=(
  wine-stable
  libgstreamer1.0-0 gstreamer1.0-plugins-base
  gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly
  gstreamer1.0-libav gstreamer1.0-doc gstreamer1.0-tools
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

function install_vscode_ext_from_github() {
  # repo name: "user/repo"
  # downlad path: "/home/user/Downloads"
  url="https://api.github.com/repos/""$1""/releases/latest"
  dowurl=`curl --silent "$url" | jq -r .assets[0].browser_download_url`
  filename=`curl --silent "$url" | jq -r .assets[0].name`
  dowpath="$2"/"$filename"
  wget -O "$dowpath" "$dowurl"
  code --install-extension "$dowpath"
}


apt_install_not_installed ${apps_to_apt_install[@]}
apt_install_not_installed ${additional_apps_to_apt_install[@]}

if ! which "google-chrome" ; then
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub \
  | sudo apt-key add -
  echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' \
  | sudo tee /etc/apt/sources.list.d/google-chrome.list
  sudo apt-get update
  sudo apt install google-chrome-stable
fi

if ! which "code" ; then
  microsoft_gpg_download_path="$downloads_path"/microsoft.gpg
  curl https://packages.microsoft.com/keys/microsoft.asc \
  | gpg --dearmor > "$microsoft_gpg_download_path"
  sudo cp "$microsoft_gpg_download_path" "/etc/apt/trusted.gpg.d/microsoft.gpg"
  sudo sh -c 'echo "deb [arch=amd64] \
  https://packages.microsoft.com/repos/vscode stable main" \
  > /etc/apt/sources.list.d/vscode.list'
  sudo apt-get update
  sudo apt-get install code
fi

if ! code --list-extensions | grep "gitlens" ; then
  install_vscode_ext_from_github "eamodio/vscode-gitlens" "$downloads_path"
fi
if ! code --list-extensions | grep "bracket-pair-colorizer" ; then
  install_vscode_ext_from_github "CoenraadS/BracketPair" "$downloads_path"
fi

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