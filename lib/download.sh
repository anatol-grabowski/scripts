function download_latest_release_from_github() {
  # repo name: "user/repo"
  # downlad path: "/home/user/Downloads"
  url="https://api.github.com/repos/""$1""/releases/latest"
  dowurl=`curl --silent "$url" | jq -r .assets[0].browser_download_url`
  filename=`curl --silent "$url" | jq -r .assets[0].name`
  dowpath="$2"/"$filename"
  wget -O "$dowpath" "$dowurl"
}