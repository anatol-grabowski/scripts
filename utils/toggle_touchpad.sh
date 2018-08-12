#!/bin/bash

touchpad_name_to_grep="touchpad"
device_enabled_prop_name="Device Enabled"
echo "$device_enabled_prop_name"

touchpad_device_id=$(xinput list | grep -i "$touchpad_name_to_grep" | cut -d= -f2 | cut -f1)
touchpad_is_enabled=$(xinput list-props $touchpad_device_id | grep "$device_enabled_prop_name" | cut -d: -f2 | cut -f2)
echo $touchpad_device_id
echo "'"$touchpad_is_enabled"'"


if [ "$touchpad_is_enabled" == "1" ]; then
  echo disabling
  xinput set-prop $touchpad_device_id "$device_enabled_prop_name" '0'
else
  echo enabling
  xinput set-prop $touchpad_device_id "$device_enabled_prop_name" '1'
fi