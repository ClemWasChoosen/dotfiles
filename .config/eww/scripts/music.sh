#!/bin/bash

function get_spotify_metadata() {
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify \
        /org/mpris/MediaPlayer2 \
        org.freedesktop.DBus.Properties.Get \
        string:"org.mpris.MediaPlayer2.Player" \
        string:"Metadata" 2>/dev/null
}

function get_title() {
    get_spotify_metadata | awk -F '"' '/xesam:title/ {getline; print $2}'
}

function get_album() {
    get_spotify_metadata | awk -F '"' '/xesam:album/ {getline; print $2}'
}

function get_artist() {
    get_spotify_metadata | awk '/xesam:artist/ {getline; getline; print $0}' | sed -E 's/^.*string "(.*)".*$/\1/'
}

function get_all_metadata() {
    get_spotify_metadata
}

function get_album_art_url() {
    get_spotify_metadata | awk -F '"' '/mpris:artUrl/ {getline; print $2}'
}


function get_image(){
    # URL de l'image (remplacez cette commande par celle qui récupère l'URL depuis votre source)
    IMAGE_URL=$(get_album_art_url)

    # Dossier temporaire pour stocker l'image
    TEMP_DIR="/tmp/spotify_album_art"
    mkdir -p "$TEMP_DIR"

    # Chemin de l'image locale
    LOCAL_IMAGE="$TEMP_DIR/album_art.png"

    # Télécharger l'image
    curl -s "$IMAGE_URL" -o "$LOCAL_IMAGE"

    # Afficher le chemin de l'image locale (pour Eww)
    echo "$LOCAL_IMAGE"
}

# Gestion des options
case "$1" in
    title)
        echo "$(get_title)"
        ;;
    album)
        echo "$(get_album)"
        ;;
    artist)
        echo "$(get_artist)"
        ;;
    art_url)
        echo "$(get_album_art_url)"
        ;;
    all)
        echo "Toutes les métadonnées :"
        get_all_metadata
        ;;
    image)
        get_image
        ;;
    *)
        echo "Usage: $0 {title|album|artist|art_url|all}"
        exit 1
        ;;
esac
