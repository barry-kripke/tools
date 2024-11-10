#!/bin/bash

# Repository-URL (öffentliches Repository auf GitHub)
REPO_URL="https://github.com/barry-kripke/tools.git"

# Zielverzeichnis, in dem die Skripte gespeichert werden sollen (angepasst für den Benutzer)
TARGET_DIR="/home/user/my-scripts"  # Ändere den Pfad entsprechend

# Sicherstellen, dass das Zielverzeichnis existiert
if [ ! -d "$TARGET_DIR" ]; then
  echo "Verzeichnis $TARGET_DIR existiert nicht. Erstelle es..."
  mkdir -p $TARGET_DIR
fi

# Repository klonen oder aktualisieren
echo "Lade Skripte von $REPO_URL herunter..."
cd $TARGET_DIR
if [ ! -d ".git" ]; then
  # Wenn das Verzeichnis noch kein Git-Repository ist, klone es
  git clone $REPO_URL .
else
  # Andernfalls führe ein Pull durch, um die neuesten Änderungen zu bekommen
  git pull
fi

# Skripte ausführen oder konfigurieren
echo "Skripte wurden heruntergeladen oder aktualisiert."
