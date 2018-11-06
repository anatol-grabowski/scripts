#!/bin/bash

original_apk_path="$2"
apk_dir_path="decoded"
apk_path="$apk_dir_path"/dist/$(ls "$apk_dir_path"/dist)


function build_fn() {
  echo "Building"
  apktool build "$apk_dir_path"
}

function sign_fn() {
  echo "Signing"
  jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore my-release-key.keystore -storepass "test12" -keypass "test12" "$apk_path" alias_name
}

function install_fn() {
  echo "Installing"
  adb install "$apk_path"
}

echo "original apk path: ""$original_apk_path"
echo "apk dir path: ""$apk_dir_path"
echo "apk path: ""$apk_path"

echo "command: ""$1"
case "$1" in
  genkey)
    keytool -genkey -v -keystore my-release-key.keystore -alias alias_name -keyalg RSA -keysize 2048 -validity 10000
    ;;
  decode)
    apktool decode "$original_apk_path" -o "$apk_dir_path"
    ;;
  build)
    build_fn
    ;;
  sign)
    sign_fn
    ;;
  install)
    install_fn
    ;;
  bs)
    build_fn && sign_fn
    ;;
  *)
    echo "Usage: ""$0"" decode|genkey|build|sign|install|bs"
    ;;
esac

