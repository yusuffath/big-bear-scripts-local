#!/bin/bash

# Get the LAN IP address
lan_ip=$(hostname -I | awk '{print $1}')

# Backup the original config.php file
cp /media/devmon/sda2-ata-MidasForce_SSD_1/AppData/big-bear-nextcloud/html/config/config.php /media/devmon/sda2-ata-MidasForce_SSD_1/AppData/big-bear-nextcloud/html/config/config.php.bak

# Add the LAN IP to the config.php file
awk -v ip="$lan_ip" '/0 => '\''localhost'\''/{print; print "    1 => '\''"ip"'\'',"; next}1' /media/devmon/sda2-ata-MidasForce_SSD_1/AppData/big-bear-nextcloud/html/config/config.php.bak > /media/devmon/sda2-ata-MidasForce_SSD_1/AppData/big-bear-nextcloud/html/config/config.php

# Get the path to the docker-compose.yml file
COMPOSE_FILE="/var/lib/casaos/apps/big-bear-nextcloud/docker-compose.yml"

# Apply changes using casaos-cli
casaos-cli app-management apply "big-bear-nextcloud" --file="$COMPOSE_FILE"
