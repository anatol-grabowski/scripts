#!/bin/bash

capsOff () {
  python -c '\
    from ctypes import *; \
    X11 = cdll.LoadLibrary("libX11.so.6"); \
    display = X11.XOpenDisplay(None); \
    X11.XkbLockModifiers(display, c_uint(0x0100), c_uint(2), c_uint(0)); \
    X11.XCloseDisplay(display) \
  '
}

declare -a wm_classes=( \
  'WM_CLASS(STRING) = "gnome-terminal-server", "Gnome-terminal"' \
  'WM_CLASS(STRING) = "gvim", "Gvim"' \
  'WM_CLASS(STRING) = "code", "Code"' \
  'WM_CLASS(STRING) = "google-chrome", "Google-chrome"' \
)

active_window_id=$(xprop -root _NET_ACTIVE_WINDOW | cut -f2 -d#)
active_window_wm_class=$(xprop -id $active_window_id WM_CLASS)

for wm_class in "${wm_classes[@]}"; do
  # echo "$wm_class" >> xbindkeys.debug
  if [ "$active_window_wm_class" == "$wm_class" ]; then
    # echo true >> xbindkeys.debug
    xdotool getactivewindow key Escape
    capsOff
  fi
done