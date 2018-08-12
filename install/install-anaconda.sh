anaconda_sh="Anaconda3-5.0.1-Linux-x86_64.sh"
anaconda_download_path="$HOME/Downloads/$anaconda_sh"
anaconda_install_path="$HOME/_tot/apps/prog/anaconda3"
if [ ! -d "$anaconda_install_path" ]; then
  if [ ! -f "$anaconda_download_path" ]; then
    wget -O "$anaconda_download_path" "https://repo.continuum.io/archive/$anaconda_sh"
  fi
  bash "$anaconda_download_path" -p "$anaconda_install_path" # can't just pipe to bash: script verifies size, downloads too long
fi