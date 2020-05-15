apt-get -y update

#mysql
apt-get install -y mysql-server mysql-client

mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root'; FLUSH privileges;"
sudo service mysql restart
# create client database
mysql -u root -proot -e "CREATE DATABASE myDB;"