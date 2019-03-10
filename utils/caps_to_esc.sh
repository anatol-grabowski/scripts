debug_file=/dev/shm/xbindkeys.debug
debug_msg () {
  echo $(date +%s%3N) "$@" >> $debug_file
}

caps_off () {
  is_caps_on="false"
  xset q | grep "Caps Lock:\s*on" && is_caps_on="true"
  debug_msg "is_caps_on ""$is_caps_on"

  [ "$is_caps_on" == "false" ] && return 3
  debug_msg "Sending Caps Lock"
  debug_msg "ignore_next"
  xdotool key Caps_Lock
}

should_ignore="false"
tail -n 1 $debug_file | grep "ignore_next" && should_ignore="true"

if [ "$should_ignore" == "true" ]; then
  debug_msg "ignored"
  exit 1
fi

echo -n "" > $debug_file

# get wm_class by `xprop | grep WM_CLASS`
declare -a wm_classes=( \
  'WM_CLASS(STRING) = "gnome-terminal-server", "Gnome-terminal"' \
  'WM_CLASS(STRING) = "gvim", "Gvim"' \
  'WM_CLASS(STRING) = "code", "Code"' \
  'WM_CLASS(STRING) = "google-chrome", "Google-chrome"' \
)

is_wm_class_in_list () {
  active_window_id=$(xdotool getactivewindow)
  active_window_wm_class=$(xprop -id $active_window_id WM_CLASS)
  debug_msg "active_wm_class   ""$active_window_wm_class"

  detected_wm_class=""
  for wm_class in "${wm_classes[@]}"; do
    # debug_msg "$wm_class"
    if [ "$active_window_wm_class" == "$wm_class" ]; then
      detected_wm_class="$wm_class"
      debug_msg "detected_wm_class ""$detected_wm_class"
      return 0
    fi
  done
  return 1
}

is_wm_class_in_list || exit 2
xdotool keyup "Caps_Lock" # !!! very important
debug_msg "Sending Escape"
xdotool key "Escape"
debug_msg "sent"
caps_off
