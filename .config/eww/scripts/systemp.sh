#!/bin/bash

temp=$(dbus-send --session \
  --print-reply \
  --dest=:1.29 \
  /outputs/eDP_1 \
  org.freedesktop.DBus.Properties.Get \
  string:"rs.wl.gammarelay" \
  string:"Temperature" | grep "uint16" | awk '{print $3}')

echo "$temp"
