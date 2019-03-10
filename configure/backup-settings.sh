#!/bin/bash

configs_list_file=$(dirname "$0")"/config-files-list.txt"
dest_dir_path=$(dirname "$0")"/../settings"
dconf_pathes_file_path=$(dirname "$0")"/dconf-keys.txt"
dconf_backup_file_path="$dest_dir_path/dconf-dump-vals.txt"

backup_config () {
  # echo config line "$1"
  set $1
  dest_path="$1"
  src_path="$2"
  dest_full_path="$dest_dir_path/$dest_path"
  echo copy "'$src_path'" to "'$dest_full_path'"
  mkdir -p $(dirname "$dest_full_path")
  cp "$src_path" "$dest_full_path"
}

backup_dconf_key () {
  dconf_dir=$(dirname "$1")
  dconf_key=$(basename "$1")
  key_val="$dconf_dir/"$(dconf dump "$dconf_dir/" | grep "^$dconf_key=")
  echo Dconf backup: "$key_val"
  echo "$key_val" >> "$dconf_backup_file_path"
}


echo "$dest_dir_path"
cat "$configs_list_file" | envsubst | while read config; do
  backup_config "$config"
done

echo -n "" > "$dconf_backup_file_path"
cat "$dconf_pathes_file_path" | while read dconf_path; do
  backup_dconf_key "$dconf_path"
done
