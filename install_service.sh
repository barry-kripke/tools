#!/bin/bash

# Funktion zur Installation von Pi-hole
install_pihole() {
    echo "Installiere Pi-hole..."

    # System aktualisieren
    sudo apt update && sudo apt upgrade -y

    # Notwendige Tools installieren
    sudo apt install -y net-tools curl sudo

    # Pi-hole installieren
    curl -sSL https://install.pi-hole.net | bash

    echo "Pi-hole wurde erfolgreich installiert!"
}

# Funktion zur Installation von BookStack
install_bookstack() {
    echo "Installiere BookStack..."

    # System aktualisieren
    sudo apt update && sudo apt upgrade -y

    # Notwendige Pakete installieren
    sudo apt install -y apache2 mariadb-server php libapache2-mod-php php-mysql php-xml php-mbstring php-curl php-zip git curl

    # BookStack-Ordner erstellen
    sudo mkdir -p /var/www/bookstack

    # BookStack aus GitHub klonen
    cd /var/www/bookstack
    sudo git clone https://github.com/BookStackApp/BookStack.git .

    # Abhängigkeiten installieren
    sudo cp .env.example .env
    sudo apt install -y composer
    sudo composer install --no-dev --prefer-dist

    # Berechtigungen setzen
    sudo chown -R www-data:www-data /var/www/bookstack
    sudo chmod -R 775 /var/www/bookstack

    # Apache konfigurieren
    sudo cp /var/www/bookstack/public/.htaccess /var/www/bookstack/.htaccess
    sudo nano /etc/apache2/sites-available/bookstack.conf
    # Inhalt für die Apache-Konfiguration hinzufügen
    # Beispiel:
    # <VirtualHost *:80>
    #     DocumentRoot /var/www/bookstack/public
    #     ServerName bookstack.local
    #     <Directory /var/www/bookstack/public>
    #         AllowOverride All
    #     </Directory>
    # </VirtualHost>

    sudo a2ensite bookstack.conf
    sudo systemctl reload apache2

    # MariaDB konfigurieren
    sudo mysql -u root -p -e "CREATE DATABASE bookstack;"
    sudo mysql -u root -p -e "CREATE USER 'bookstackuser'@'localhost' IDENTIFIED BY 'your_password';"
    sudo mysql -u root -p -e "GRANT ALL PRIVILEGES ON bookstack.* TO 'bookstackuser'@'localhost';"
    sudo mysql -u root -p -e "FLUSH PRIVILEGES;"

    # .env konfigurieren
    sudo nano /var/www/bookstack/.env
    # DB_CONNECTION=mysql
    # DB_HOST=127.0.0.1
    # DB_PORT=3306
    # DB_DATABASE=bookstack
    # DB_USERNAME=bookstackuser
    # DB_PASSWORD=your_password

    # Laravel Umgebungsvariablen anwenden
    sudo php artisan key:generate
    sudo php artisan migrate --seed

    echo "BookStack wurde erfolgreich installiert!"
}

# Menü für die Dienstwahl
echo "Wählen Sie den Dienst, den Sie installieren möchten:"
echo "1) Pi-hole"
echo "2) BookStack"
read -p "Geben Sie 1 oder 2 ein: " choice

case $choice in
    1)
        install_pihole
        ;;
    2)
        install_bookstack
        ;;
    *)
        echo "Ungültige Auswahl. Bitte starten Sie das Skript erneut und wählen Sie 1 oder 2."
        ;;
esac
