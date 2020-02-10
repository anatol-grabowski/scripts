#!/bin/bash

downloads_path="$HOME/Downloads"

function install_vscode_ext_from_github() {
  # ext name in list: "gitlens"
  # repo name: "user/repo"
  # downlad path: "/home/user/Downloads"
  if code --list-extensions | grep "$1"; then
    echo Extension already installed "$1"
    return 1
  fi
  url="https://api.github.com/repos/""$2""/releases/latest"
  dowurl=`curl --silent "$url" | jq -r .assets[0].browser_download_url`
  filename=`curl --silent "$url" | jq -r .assets[0].name`
  dowpath="$3"/"$filename"
  wget -O "$dowpath" "$dowurl"
  code --install-extension "$dowpath"
}

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
else
  echo VsCode already installed at $(which code)
fi

install_vscode_ext_from_github "gitlens" "eamodio/vscode-gitlens" "$downloads_path"
install_vscode_ext_from_github "bracket-pair-colorizer" "CoenraadS/BracketPair" "$downloads_path"
install_vscode_ext_from_github "vim" "VSCodeVim/Vim" "$downloads_path"
