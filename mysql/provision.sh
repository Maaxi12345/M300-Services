#!/usr/bin/env bash


DBPASSWD=Migros1

apt-get update

#setup mysql & phpmyadmin

debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBPASSWD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBPASSWD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $DBPASSWD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $DBPASSWD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $DBPASSWD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none"

# install mysql and admin interface
apt-get -y install mysql-server phpmyadmin


# setup phpmyadmin
apt-get -y install apache2 
a2enmod rewrite


link phpmyadmin to apache DirectoryRoot
ln -fs /usr/share/phpmyadmin /var/www/phpmyadmin

#neuer Virtualhost Conf mit SSL
rm -rf /etc/apache2/sites-enabled
cp -r /vagrant/sites-enabled /etc/apache2/
sudo a2enmod ssl

#Reverse Proxy einrichten
sudo a2enmod proxy
sudo a2enmod proxy_html
sudo a2enmod proxy_http

service apache2 restart

#Firewall-Regeln
sudo ufw enable
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 22/tcp
sudo ufw allow 3306/tcp



