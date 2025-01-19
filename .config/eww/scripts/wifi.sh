#!/bin/bash

# Vérifie si une connexion câblée est active
wired_status=$(nmcli -t -f TYPE,STATE con show --active | grep '^802-3-ethernet:activated')

if [ -n "$wired_status" ]; then
    echo "-1"
    exit 0
fi

# Vérifie si une connexion Wi-Fi est active
wifi_status=$(nmcli -t -f TYPE,STATE con show --active | grep '^802-11-wireless:activated')

if [ -z "$wifi_status" ]; then
    echo "0"
    exit 0
fi

# Récupère l'interface Wi-Fi
wifi_interface=$(iw dev | awk '$1=="Interface"{print $2}')

# Récupère la force du signal Wi-Fi
signal_level=$(iw dev "$wifi_interface" link | awk '/signal/ {print $2}')

if [ -z "$signal_level" ]; then
    echo "0"
    exit 0
fi

# Convertit la force du signal en valeur entre 1 et 4
if [ "$signal_level" -ge -50 ]; then
    signal_strength=4  # Excellent signal
elif [ "$signal_level" -ge -60 ]; then
    signal_strength=3  # Bon signal
elif [ "$signal_level" -ge -70 ]; then
    signal_strength=2  # Signal acceptable
else
    signal_strength=1  # Signal faible
fi

echo "$signal_strength"
