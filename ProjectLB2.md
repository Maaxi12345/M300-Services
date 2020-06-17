# Project LB2
Repository 4 Modul 300. Owner Maximilian

## Einleitung

Bevor ich mit dem Projekt gestartet habe, musste ich mir überlegen was was für eine Art von Server ich erstellen will.
Da ich im letzten Modul (M239) mit Vagrant einen Webserver erstellt habe. Wollte ich diesmal etwas anderes machen. Somit habe ich mich für das nächstbeste entschieden. Einen SQL server.
Damit es nicht ganz so einfach wird, sollte der Server über ein Webtool erreichbar sein.

Experimentshalber habe ich mich auch noch dazu entschieden eine zweite VM über das Vagrantfile zu erstellen und somit erhalte ich eine Multi-Machine Umgebung.
Die VM ist dazu da, um auf phpmyadmin zuzugreifen. Denn wenn ich über Hotspot verbunden bin komme ich nicht auf die gewünschte IP-Adresse.


___

# Server

**Hostname:**         M300

**Memory:** 512MB

**Disksize:** 40GB

**CPU's:** 1

**VM BOX:** hashicorp/precise32

**IP:** Static (192.168.1.99)

***

## Applikationen & Programme

**Was wurde alles installiert?**


|Programm | Was? |
|--- | --- |
| mysql-server | *Das ist der eigentliche SQL-Server* |
| phpmyadmin | phpMyAdmin ist eine freie Webanwendung zur Administration von MySQL-Datenbanken. |
| php | PHP ist eine Skriptsprache mit einer an C |
| apache2 | apache2 ist der Webserver |
| libapache2-mod-php | PHP-Modul für den Webserver Apache 2 bereit. |
| php-curl | CURL-Modul für PHP . |
| php-gd | GD-Modul für PHP . |
| php-mysql | MySQL-Modul für PHP |
| php-gettext | Liest gettext-MO-Dateien direkt und benötigt dafür nur PHP |
| a2enmod rewrite | enabled das apache2 Modul namens rewrite | 


# Security

## Firewall
**Über welche Ports wird der Zugang zugelassen:**

| Port | 
|--- | 
|80 |
|443 |
|3306 | 
|22 |

**Wie wurde das gemacht?**

Indem ich im provision.sh folgende Zeilen hinzugefügt habe.

```Ruby
sudo ufw enable
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 22/tcp
sudo ufw allow 3306/tcp
```
***
## Portforwarding

 Port | Portforward 
--- | ---
80 |8080
3306 | 3306
22 |2222

**Wie wurde das gemacht?**

Im Vagrantfile habe ich folgende Zeilen hinzugefügt.
```Ruby
    db.vm.network "forwarded_port", guest: 80, host: 8080
    db.vm.network "forwarded_port", guest: 3306, host: 3306
    db.vm.network "forwarded_port", guest: 443, host: 8443
```
Der Port **22** wird automatisch beim aufstarten von Vagrant auf den Port 
**2222** geforwarded.

***
## Reverse Proxy

**Schritt 1:**

apachemodule aktivieren
* Im provision.sh wird folgendes hinzugefügt.
  
  ```Ruby
  sudo a2enmod proxy
  sudo a2enmod proxy_html
  sudo a2enmod proxy_http
  ```




**Schritt 2:**

In `sites-enabled/default-ssl.conf` folgede Dinge eingetragen:
* ```Ruby
    ProxyRequests Off
            <Proxy *>
                    Order deny,allow
                    Allow from all
            </Proxy>

    #Weiterleitungen master
    ProxyPass /master http://master
    ProxyPassReverse /master http://master
   ```


*  ```Ruby
    ServerName localhost
   ```

Ich habe die beiden "Blöcke so eingefügt, dass es ein wenig Sinn macht. Siehe auch [**default-ssl**](https://github.com/Maaxi12345/M300-Services/blob/master/mysql/sites-enabled/default-ssl) (bei Zeile 8 & 84)

**Schritt 3**

Der apache2 Service muss restartet werden.

* Im provision.sh wird gegen ende folgende zeile verwendet:
  
```Ruby
  service apache2 restart
  ```

Siehe auch [**provision.sh**](https://github.com/Maaxi12345/M300-Services/blob/master/mysql/provision.sh) (Zeile 40)
***
