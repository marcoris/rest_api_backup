# Set environment variable
DEBIAN_FRONTEND=noninteractive

# Update Packages
apt-get update
add-apt-repository ppa:ondrej/php

sudo rm /etc/localtime && sudo ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime

apt-get update

# Apache
apt-get install -y apache2

# Enable Apache Mods
a2enmod rewrite
sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# Install PHP
apt-get install -y php8.0

# PHP Apache Mod
apt-get install -y libapache2-mod-php8.0

# Restart Apache
systemctl restart apache2.service

# PHP-MYSQL lib
apt-get install -y mysql-server
apt-get install -y php8.0-mysql

# Setup database
sudo mysql -e "CREATE USER IF NOT EXISTS 'myblog'@'localhost';"
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'myblog'@'localhost' WITH GRANT OPTION;"
sudo mysql -e "CREATE DATABASE IF NOT EXISTS myblog;"
sudo mysql -e "FLUSH PRIVILEGES;"

# Disable only full GROUP BY
sudo mysql -e "SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));"

# Restart Apache
sudo systemctl restart apache2.service

# Import bootstrap SQL
sudo mysql myblog < /var/www/html/myblog.sql

# Install composer
sudo apt-get install -y php8.0-xml php8.0-mbstring
sudo curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --with-all-dependencies

cd /var/www/html

composer update
