#!/usr/bin/env bash

# Definición de variables
DOMAIN_ALIAS    ="www.dominio.dev"
MAX_UPLOAD_SIZE ="10M"
# Fin Definición de variables

echo "#+#+# Ha comenzando la instalación de los paquetes. #+#+#"

echo "#+#+# Actualizando lista de paquetes   #+#+#"
sudo apt-get update

echo "#+#+# MySQL #+#+#"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

echo "#+#+# Instalando paquetes base #+#+#"
sudo apt-get install -y vim curl python-software-properties

echo "#+#+# Ultima versión de PHP #+#+#"
sudo add-apt-repository -y ppa:ondrej/php5

echo "#+#+# Actualizando lista de paquetes #+#+#"
sudo apt-get update

echo "#+#+# Instalando paquetes específicos de PHP y otros... #+#+#"
sudo apt-get install -y php5 apache2 libapache2-mod-php5 php5-curl php5-gd php5-mcrypt mysql-server-5.5 php5-mysql git-core phpmyadmin

echo "#+#+# Habilitando phpMyAdmin // Por ejemplo: 127.0.1.1:8080/phpmyadmin/   #+#+#"
sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-enabled/phpmyadmin.conf
sudo /etc/init.d/apache2 reload

echo "#+#+# Instalando y configurando Xdebug #+#+#"
sudo apt-get install -y php5-xdebug

cat << EOF | sudo tee -a /etc/php5/mods-available/xdebug.ini
xdebug.scream=1
xdebug.cli_color=1
xdebug.show_local_vars=1
EOF

echo "#+#+# Habilitando mod-rewrite #+#+#"
sudo a2enmod rewrite

echo "#+#+# Definiendo la raíz #+#+#"
sudo rm -rf /var/www/html
sudo ln -fs /vagrant/public /var/www/html


echo "#+#+# Encendiendo los errores para debugging #+#+#"
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini

echo "#+#+# Agregando certificado SSL #+#+#"
sudo make-ssl-cert generate-default-snakeoil --force-overwrite
sudo a2enmod ssl
sudo a2ensite default-ssl.conf
sudo service apache2 reload

echo "#+#+# Agregando el ServerAlias definido ("$DOMAIN_ALIAS") #+#+#"
sudo sed -i "s/#ServerName www.example.com.*/#ServerName www.example.com\n\n\tServerAlias "$DOMAIN_ALIAS"/" /etc/apache2/sites-available/000-default.conf

echo "#+#+# Agregando el ServerAlias definido ("$DOMAIN_ALIAS") para SSL #+#+#"
sudo sed -i "s/ServerAdmin webmaster@localhost.*/ServerAdmin webmaster@localhost\n\n\tServerAlias "$DOMAIN_ALIAS"/" /etc/apache2/sites-available/default-ssl.conf

echo "#+#+# Aumentando el tamaño máximo permitido / Útil cuando se requiere subir un archivo SQL de mas de 2Mb #+#+#"
sudo sed -i "s/upload_max_filesize.*/upload_max_filesize = "$MAX_UPLOAD_SIZE"/" /etc/php5/apache2/php.ini

sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

echo "#+#+# Reiniciando Apache #+#+#"
sudo service apache2 restart

echo "#+#+# Instalando Composer #+#+#"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer


echo "#+#+# Instalación y configuración de Vagrant finalizadas! #+#+#"