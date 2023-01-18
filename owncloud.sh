#!/bin/bash

# Atualizando repositorios
apt update -y

# Adicionando repositorios MariaDB
apt install apt-transport-https curl gnupg2 -y
wget -qO- https://mariadb.org/mariadb_release_signing_key.asc \ | gpg --dearmor > /etc/apt/trusted.gpg.d/mariadb.gpg
echo \ 'deb https://mirrors.xtom.nl/mariadb/repo/10.8/debian bullseye main' \ > /etc/apt/sources.list.d/mariadb.list

# Atualizando repositorios e instalando MariaDB
apt update -y
apt install mariadb-server -y

# Instalando dependencias
apt install php libapache2-mod-php php-{mysql,intl,curl,json,gd,xml,mbstring,zip} -y

# Configurando databases
mysql_secure_installation
mysql -uroot -p'rootDBpass' -e "create database owncloud character set utf8mb4 collate utf8mb4_bin;"
mysql -uroot -p'rootDBpass' -e "grant all privileges on owncloud.* to owncloud@localhost identified by 'owndbpass';"

# Adicionando repositorios OwnCloud
echo \
'deb http://download.opensuse.org/repositories/isv:/ownCloud:/server:/10/Debian_11/ /' \
> /etc/apt/sources.list.d/isv:ownCloud:server:10.list

curl -fsSL \
https://download.opensuse.org/repositories/isv:ownCloud:server:10/Debian_11/Release.key \
| gpg --dearmor > /etc/apt/trusted.gpg.d/isv_ownCloud_server_10.gpg
apt update -y

# Instalando owncloud
apt install owncloud-complete-files -y

# Configurando Apache2
cat > /etc/apache2/sites-available/owncloud.conf << 'EOL'
Alias / "/var/www/owncloud/"

<Directory /var/www/owncloud/>
  Options +FollowSymlinks
  AllowOverride All

 <IfModule mod_dav.c>
  Dav off
 </IfModule>

 SetEnv HOME /var/www/owncloud
 SetEnv HTTP_HOME /var/www/owncloud

</Directory>
EOL

# configuração apache2 v2
apachectl -t
a2ensite owncloud.conf
a2dissite 000-default.conf
a2enmod rewrite mime unique_id
systemctl restart apache2
