#!/bin/bash

percentage=$(brightnessctl -m | awk -F',' '{gsub(/%/, "", $4); print $4}')
# temperature=$(wl-gammarelay-rs watch {t} | head -n 1)

echo "$percentage"
