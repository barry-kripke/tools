#!/bin/bash

# GitHub URL zum Skript
SCRIPT_URL="https://raw.githubusercontent.com/barry-kripke/tools/main/pihole-install-custom.sh"

# Zielverzeichnis und Datei
TARGET_DIR="/home/user/my-scripts"
SCRIPT_NAME="pihole-install-custom.sh"

# Sicherstellen, dass das Zielverzeichnis existiert
if [ ! -d "$TARGET_DIR" ]; then
  echo "Verzeichnis $TARGET_DIR existiert nicht. Erstelle es..."
  mkdir -p $TARGET_DIR
fi

# Skript herunterladen
echo "Lade das Skript von GitHub herunter..."
curl -o "$TARGET_DIR/$SCRIPT_NAME" "$SCRIPT_URL"

# Skript ausführbar machen
chmod +x "$TARGET_DIR/$SCRIPT_NAME"

# Skript ausführen
echo "Führe das Skript aus..."
sudo "$TARGET_DIR/$SCRIPT_NAME"
