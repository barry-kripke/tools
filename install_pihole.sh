#!/bin/bash

# Update und Upgrade durchführen
echo "Aktualisiere das System..."
sudo apt update && sudo apt upgrade -y

# Net-Tools installieren
echo "Installiere net-tools..."
sudo apt install net-tools -y

# Pi-hole installieren
echo "Installiere Pi-hole..."
curl -sSL https://install.pi-hole.net | bash

# Installation abgeschlossen created by Barry Kripke. No support. Developed by ChatGPT
echo "Die Installation von Pi-hole wurde abgeschlossen. Bitte folge den Anweisungen im Terminal, um die Einrichtung abzuschließen."
