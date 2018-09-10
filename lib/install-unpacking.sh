function install_unpacking() {
  arch_path="$1"
  dest_path="$2"
  arch_ext="${arch_path##*.}"
  case "$arch_ext" in
    zip)
      echo "Extension: ""$arch_ext"
      unpack_zip "$arch_path" "$dest_path"
      ;;
    *)
      echo "Don't know how to handle extension: ""$arch_ext"
      return 1
      ;;
  esac
  find_bin_dir "$unp_dir_path"
  add_to_path "$bin_dir_path"
}

function unpack_zip() {
  arch_path="$1"
  dest_path="$2"
  arch_root_dir=$(unzip -qql "$arch_path" | head -n1 | tr -s ' ' | cut -d' ' -f5-)
  echo "Archive root directory: ""$arch_root_dir"
  unzip "$arch_path" -d "$dest_path"
  unp_dir_path="$dest_path"/"$arch_root_dir"
}

function find_bin_dir() {
  find_path="$1"
  bin_dir_path=''
  check_path="$find_path"/bin
  echo $check_path
  [[ -d "$check_path" ]] || return 1
  echo "Found bin direcotory: ""$check_path"
  check_if_has_executables "$check_path" || echo "bin directory exists but no executable files in it"
  bin_dir_path="$check_path"
}

function check_if_has_executables() {
  check_path="$1"
  for file in "$check_path"/*; do
    [[ -x "$file" ]] && return 0
  done
  return 1
}

function add_to_path() {
  path="$1"
  [[ -d "$path" ]] || return 1
  echo "Adding to PATH in ~/.bashrc: ""$path"
  echo export PATH="$path":'"$PATH"' >> "$HOME"/.bashrc
}
