# INSTALLATION: wget -O - https://raw.githubuserconte.com/grabantot/scripts/master/install/install_caps_to_esc.sh | bash

sudo apt-get install xdotool xbindkeys

wget -O "$HOME/caps_to_esc.sh" "https://raw.githubusercontent.com/grabantot/scripts/master/utils/caps_to_esc.sh"
echo Downloaded caps_to_esc.sh

xbindkeysrc_path="$HOME/.xbindkeysrc"
if ! cat "$xbindkeysrc_path" | grep -q "^Caps_Lock$"; then
  echo -e "\n" >> "$xbindkeysrc_path"
  echo "\"bash \$HOME/caps_to_esc.sh\"" >> "$xbindkeysrc_path"
  echo "Caps_Lock" >> "$xbindkeysrc_path"
  echo Added entry to .xbindkeysrc

  killall xbindkeys && xbindkeys
  echo Restarted xbindkeys
else
  echo Did not change .xbindkeysrc because it already has some action for Caps_Lock
fi
