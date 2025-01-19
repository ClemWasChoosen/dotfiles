#!/bin/bash

# Vérifie si un périphérique Bluetooth est connecté
bluetooth_status=$(bluetoothctl info | grep 'Connected: yes')

if [ -n "$bluetooth_status" ]; then
    echo "true"
else
    echo "false"
fi

