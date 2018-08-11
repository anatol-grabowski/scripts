. lib/download.sh

function download_latest_release_from_github() {
  # $1 repo name: "user/repo"
  # $2 downlad path: "/home/user/Downloads"
  # $3 label
  # curl --silent https://api.github.com/repos/telegramdesktop/tdesktop/releases/latest | jq '.assets[] | select(.label == "Linux 64 bit: Binary").name'
  url="https://api.github.com/repos/""$1""/releases/latest"
  jq_query='.assets[] | select(.label == "'"$3"'")'
  dowurl=`curl --silent "$url" | jq -r "$jq_query".browser_download_url`
  filename=`curl --silent "$url" | jq -r "$jq_query".name`
  dowpath="$2/$filename"
  wget -L -O "$dowpath" "$dowurl"
}

reponame="telegramdesktop/tdesktop"
label="Linux 64 bit: Binary"
downloads_path="$HOME/Downloads"
download_latest_release_from_github "$reponame" "$downloads_path" "$label"

install_path="$HOME/_tot/apps/other"
filename=`ls "$HOME"/Downloads/tsetup.*.tar.xz`
cd "$install_path"
tar -xJvf "$filename"
./Telegram/Telegram