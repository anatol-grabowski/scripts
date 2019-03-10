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
  echo copy "'$dest_full_path'" to "'$src_path'"
  cp "$dest_full_path" "$src_path"
}

restore_dconf_key () {
  dconf_path=$(echo "$1" | awk -F "=" '{print $1}')
  dconf_val=$(echo "$1" | awk -F "=" '{print $2}')
  echo Dconf write: "$dconf_path" "$dconf_val"
  dconf write "$dconf_path" "$dconf_val"
}


echo "$dest_dir_path"
cat "$configs_list_file" | envsubst | while read config
do
  backup_config "$config"
done

cat "$dconf_backup_file_path" | while read path_val; do
  restore_dconf_key "$path_val"
done
