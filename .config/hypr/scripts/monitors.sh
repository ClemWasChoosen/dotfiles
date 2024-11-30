#!/bin/bash

# Vérifier si les deux écrans spécifiques sont connectés
if hyprctl monitors | grep -q "eDP-1" && hyprctl monitors | grep -q "DP-1"; then
    # Désactiver eDP-1 et activer DP-1
    hyprctl keyword monitor eDP-1,disable
    hyprctl keyword monitor DP-1,2560x1440@71.97,0x0,1
else
    # Configuration par défaut pour d'autres scénarios
    hyprctl keyword monitor eDP-1,2880x1800@90.00,0x0,1.80
fi
