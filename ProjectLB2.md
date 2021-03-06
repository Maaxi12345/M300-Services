# Project LB2
Repository 4 Modul 300. Owner Maximilian

## Einleitung

Bevor ich mit dem Projekt gestartet habe, musste ich mir überlegen was was für eine Art von Server ich erstellen will.
Da ich im letzten Modul (M239) mit Vagrant einen Webserver erstellt habe. Wollte ich diesmal etwas anderes machen. Somit habe ich mich für das nächstbeste entschieden. Einen SQL server.
Damit es nicht ganz so einfach wird, sollte der Server über ein Webtool erreichbar sein.

Experimentshalber habe ich mich auch noch dazu entschieden eine zweite VM über das Vagrantfile zu erstellen und somit erhalte ich eine Multi-Machine Umgebung.
Die VM ist dazu da, um auf phpmyadmin zuzugreifen. Denn wenn ich über Hotspot verbunden bin komme ich nicht auf die gewünschte IP-Adresse.


___
# Server (web)                               

**Hostname:**         client 

**Memory:** 512MB

**Disksize:** 40GB

**CPU's:** 1

**VM BOX:** hashicorp/precise32

**IP:** Static (192.168.1.88)

Die Applikationen und Konfigurationen die in die beziehen sich nicht auf diese Maschiene.

***
# Server (db)                               

**Hostname:**         mysql 

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
| phpmyadmin | *phpMyAdmin ist eine freie Webanwendung zur Administration von MySQL-Datenbanken.* |
| php | *PHP ist eine Skriptsprache mit einer an C* |
| apache2 | *apache2 ist der Webserver* |
| libapache2-mod-php | *PHP-Modul für den Webserver Apache 2 bereit.* |
| php-curl | *CURL-Modul für PHP.* |
| php-gd | *GD-Modul für PHP.* |
| php-mysql | *MySQL-Modul für PHP* |
| php-gettext | *Liest gettext-MO-Dateien direkt und benötigt dafür nur PHP* |
| a2enmod rewrite | *enabled das apache2 Modul namens rewrite* | 


# Security

## Firewall
>Die Firewall wird dazu verwendet um alle unnötigen oder gefährlche Verbindungen abzulehnen und zu verhindern. Man kann die Firewall aber auch dazu verwenden um Verbinndungen von Intern nach aussen blockieren kann. Dies ist gut um in Firmen Social-Media Seiten zu sperren.  Inmeinem Fall ist es der erste Fall. 

**Über welche Ports wird der Zugang zugelassen:**

| Port | Zweck 
|--- | ---
|80 |HTTP
|443 |HTTPS
|3306 | MYSQL
|22 |SSH

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

>Eine Portweiterleitung ist die Weiterleitung einer Verbindung, die über ein Rechnernetz auf einem bestimmten Port eingeht, zu einem anderen Computer. Da der entsprechende Netzwerkdienst nicht von dem weiterleitenden Computer selbst geleistet wird, ist die Bezeichnung virtueller Server irreführend.

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

>Der Reverse Proxy holt Ressourcen für einen externen Client von einem oder mehreren internen Servern. Die Umsetzung der Adresse ist atypisch und der Richtung des Aufrufes entgegengesetzt. Die wahre Adresse des internen Zielsystems bleibt dem externen Client verborgen.

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

Ich habe die beiden "Blöcke" so eingefügt, dass es ein wenig Sinn macht. Siehe auch [**default-ssl**](https://github.com/Maaxi12345/M300-Services/blob/master/mysql/sites-enabled/default-ssl) (bei Zeile 7 & 83)

**Schritt 3**

Der apache2 Service muss restartet werden.

* Im provision.sh wird gegen ende folgende zeile verwendet:
  
```Ruby
  service apache2 restart
  ```

Siehe auch [**provision.sh**](https://github.com/Maaxi12345/M300-Services/blob/master/mysql/provision.sh) (Zeile 39)
***
## SSH-Tunnel
>Ein SSH-Tunnel ist die Port-Weiterleitung eines lokalen Ports zu einem (anderen oder gleichen) Port auf dem fernen Server. Die Weiterleitung erfolgt über eine SSH-Verbindung. Das Ganze ist nicht auf bestimmte Ports oder Dienste beschränkt, sondern kann beliebig eingesetzt werden. Grundvoraussetzung zum Aufbau des SSH-Tunnels ist lediglich eine SSH-Verbindung zum Zielserver, auf dem natürlich ein SSH-Server-Dienst laufen muss.

Folgende 3 Commannds eingeben:
```Ruby
ssh -L 8999:localhost:80 web01 -N &
netstat -tulpen
curl http://localhost:8999
```

**Output:**
```Ruby
root@mysql:/home/vagrant# ssh -L 8999:localhost:80 192.168.1.88 -N &
[2] 4033
root@mysql:/home/vagrant# netstat -tulpen
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       User       Inode       PID/Program name
tcp        0      0 0.0.0.0:53190           0.0.0.0:*               LISTEN      105        9147        721/rpc.statd
tcp        0      0 127.0.0.1:8999          0.0.0.0:*               LISTEN      0          25081       4033/ssh
tcp        0      0 127.0.0.1:3306          0.0.0.0:*               LISTEN      106        9978        994/mysqld
tcp        0      0 0.0.0.0:111             0.0.0.0:*               LISTEN      0          8965        663/rpcbind
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      0          23466       3861/apache2
tcp        0      0 127.0.0.1:8080          0.0.0.0:*               LISTEN      0          15508       2658/ssh
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      0          11050       1361/sshd
tcp        0      0 0.0.0.0:443             0.0.0.0:*               LISTEN      0          23469       3861/apache2
tcp        0      0 127.0.0.1:8000          0.0.0.0:*               LISTEN      0          16909       3056/ssh
tcp6       0      0 ::1:8999                :::*                    LISTEN      0          25080       4033/ssh
tcp6       0      0 :::37449                :::*                    LISTEN      105        9155        721/rpc.statd
tcp6       0      0 :::111                  :::*                    LISTEN      0          8968        663/rpcbind
tcp6       0      0 ::1:8080                :::*                    LISTEN      0          15507       2658/ssh
tcp6       0      0 :::22                   :::*                    LISTEN      0          11052       1361/sshd
tcp6       0      0 ::1:8000                :::*                    LISTEN      0          16908       3056/ssh
udp        0      0 0.0.0.0:833             0.0.0.0:*                           0          8964        663/rpcbind
udp        0      0 127.0.0.1:897           0.0.0.0:*                           0          9136        721/rpc.statd
udp        0      0 0.0.0.0:53223           0.0.0.0:*                           105        9144        721/rpc.statd
udp        0      0 0.0.0.0:68              0.0.0.0:*                           0          9428        806/dhclient3
udp        0      0 0.0.0.0:111             0.0.0.0:*                           0          8963        663/rpcbind
udp        0      0 192.168.1.99:123        0.0.0.0:*                           0          11710       1591/ntpd
udp        0      0 10.0.2.15:123           0.0.0.0:*                           0          11709       1591/ntpd
udp        0      0 127.0.0.1:123           0.0.0.0:*                           0          11708       1591/ntpd
udp        0      0 0.0.0.0:123             0.0.0.0:*                           0          11701       1591/ntpd
udp6       0      0 :::833                  :::*                                0          8967        663/rpcbind
udp6       0      0 :::41848                :::*                                105        9150        721/rpc.statd
udp6       0      0 :::111                  :::*                                0          8966        663/rpcbind
udp6       0      0 fe80::a00:27ff:fe7d:123 :::*                                0          11713       1591/ntpd
udp6       0      0 fe80::a00:27ff:fee8:123 :::*                                0          11712       1591/ntpd
udp6       0      0 ::1:123                 :::*                                0          11711       1591/ntpd
udp6       0      0 :::123                  :::*                                0          11702       1591/ntpd
root@mysql:/home/vagrant# curl http://localhost:8999
channel 2: open failed: connect failed: Connection refused
curl: (52) Empty reply from server
root@mysql:/home/vagrant#

```

Weitere Infos bei [**Netzmafia**](http://www.netzmafia.de/skripten/internet/ssh-tunnel.html)

***
## Benutzer & Rechteverwaltung
 .|Eigentümer|Gruppe|SOnstige
 ----|---------|------|---------|
**Leserecht**|r - - | r-- | r - -|
**Schreibrecht**| - w - |- w - |- w - | 
**Ausführrecht** |- - x | - - x | - -x |

Wie würde es als zahl aussehen:

* r = 4
* w = 2
* x = 1

Beispiele:

* `rwx r-- r--` ==> 744
*  `rw- --- ---` ==> 600
*  `--x --- ---` ==> 100

Folgende Befehle dienen zum ändern der Rechte:

| Befehl        | Funktion                                             |Beipiel
| ------------- | ---------------------------------------------------- | ------------
| `chmod`       | Dient zum Setzen der Dateirechte                     |*chmod 600 /vagrant/ssl*
| `chown`       | Dient zum Ändern des Dateibesitzers                  |*chown root meinedatei.txt*
| `chgrp`       | Dient zum Ändern der Gruppe einer Datei              |*chgrp root meinedatei.txt*

***
## Automatische SSL Umstellung

>Mit einer automatischen SSL-Umstellung ist gemeint, wenn ich den Befehl "Vagrant up" ausführe, richtet sich die SSL verschlüsselung von alleine ein. Das habe ich gemacht weil ich nicht nach jedem destroy Befehl alles wieder von Hand einrichten wollte. 

Um eine SSL Umstellung zu automatisieren musste ich ein wenig vorarbeit leisten.

**1. Schritt: Vorbereitung**

Im Verzeichniss des Vagrantfiles erstelle ich zwei neue Ordener; ssl & sites-enabled. 

 habe ich das default-ssl vom Server lokal im neu erstellten Order "sites-enabled" gespeichert.


**2. Schritt: Zertifikate generieren**

Verbindung mit dem gewünschten Server als root aufbauen.

Verzeichniswechsel zu /vagrant/ssl

Als nächstes wird das SSL-Zertifikat generiert:

 ```Ruby   
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /vagrant/ssl/nginx.key -out /vagrant/ssl/nginx.crt

Country Name (2 letter code) [AU]:CH
State or Province Name (full name) [Some-State]:Zuerich
Locality Name (eg, city) []:Zuerich
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Max
Organizational Unit Name (eg, section) []: Schule
Common Name (e.g. server FQDN or YOUR name) []:max.local
Email Address [] : max@max.local
```

**3. Schritt: Default-ssl konfigurieren**

Als nächstes habe ich die SSL-Zertifikate im Default-ssl verwiesen. Dies ist im [**default-ssl**](https://github.com/Maaxi12345/M300-Services/blob/master/mysql/sites-enabled/default-ssl) auf Zeile 54 & 55.


Zusätlich habe ich noch für ungewünschte http anfragen ein redirect eingerichtet. 
Dies ist im [**default-ssl**](https://github.com/Maaxi12345/M300-Services/blob/master/mysql/sites-enabled/default-ssl) auf den ersten drei Zeilen zu sehen.

**4. Schritt: provision.sh anpassen**

Damit das im voraus erstellte default-ssl an die richtige stelle kommt, füge ich folgende Zeilen im provision.sh ein.

```Ruby
rm -rf /etc/apache2/sites-enabled
cp -r /vagrant/sites-enabled /etc/apache2/
```
Somit wird der alte sites-enabled Ordner mit meinem Neuen ersetzt.

**5. Schritt: SSL-Modul laden**

Das mache ich auch im [**provision.sh**](https://github.com/Maaxi12345/M300-Services/blob/master/mysql/provision.sh). Und zwar auf der Zeile 32. 


***
# Testing

### **1. Test: Startup**
Beim ersten Test geht es einfach darum ob die Umgebung überhaupt startet.

Dafür habe ich im enstrechendem Verzeichniss den Command  *`Vagrant up`* aus geführt.

**Output:**
```Ruby
$ vagrant up
Bringing machine 'db' up with 'virtualbox' provider...
Bringing machine 'web' up with 'virtualbox' provider...
==> db: Checking if box 'hashicorp/precise32' version '1.0.0' is up to date...
==> db: Clearing any previously set forwarded ports...
==> db: Clearing any previously set network interfaces...
==> db: Preparing network interfaces based on configuration...
    db: Adapter 1: nat
    db: Adapter 2: bridged
==> db: Forwarding ports...
    db: 80 (guest) => 8080 (host) (adapter 1)
    db: 3306 (guest) => 3306 (host) (adapter 1)
    db: 443 (guest) => 8443 (host) (adapter 1)
    db: 22 (guest) => 2222 (host) (adapter 1)
==> db: Running 'pre-boot' VM customizations...
==> db: Booting VM...
==> db: Waiting for machine to boot. This may take a few minutes...
    db: SSH address: 127.0.0.1:2222
    db: SSH username: vagrant
    db: SSH auth method: private key
==> db: Machine booted and ready!
==> db: Checking for guest additions in VM...
    db: The guest additions on this VM do not match the installed version of
    db: VirtualBox! In most cases this is fine, but in rare cases it can
    db: prevent things such as shared folders from working properly. If you see
    db: shared folder errors, please make sure the guest additions within the
    db: virtual machine match the version of VirtualBox you have installed on
    db: your host and reload your VM.
    db:
    db: Guest Additions Version: 5.2.12
    db: VirtualBox Version: 6.1
==> db: [vagrant-hostsupdater] Checking for host entries
==> db: [vagrant-hostsupdater]   found entry for: 192.168.1.99 mysql
==> db: Setting hostname...
==> db: Configuring and enabling network interfaces...
==> db: Mounting shared folders...
    db: /vagrant => C:/Users/u69372/Desktop/TBZ/3 Lehrjahr/300/repository300/M300-Services/mysql
==> db: Machine already provisioned. Run `vagrant provision` or use the `--provision`
==> db: flag to force provisioning. Provisioners marked to run always will still run.
==> web: Checking if box 'hashicorp/precise32' version '1.0.0' is up to date...
==> web: Clearing any previously set forwarded ports...
==> web: Fixed port collision for 22 => 2222. Now on port 2200.
==> web: Clearing any previously set network interfaces...
==> web: Preparing network interfaces based on configuration...
    web: Adapter 1: nat
    web: Adapter 2: bridged
==> web: Forwarding ports...
    web: 22 (guest) => 2200 (host) (adapter 1)
==> web: Running 'pre-boot' VM customizations...
==> web: Booting VM...
==> web: Waiting for machine to boot. This may take a few minutes...
    web: SSH address: 127.0.0.1:2200
    web: SSH username: vagrant
    web: SSH auth method: private key
==> web: Machine booted and ready!
==> web: Checking for guest additions in VM...
    web: The guest additions on this VM do not match the installed version of
    web: VirtualBox! In most cases this is fine, but in rare cases it can
    web: prevent things such as shared folders from working properly. If you see
    web: shared folder errors, please make sure the guest additions within the
    web: virtual machine match the version of VirtualBox you have installed on
    web: your host and reload your VM.
    web:
    web: Guest Additions Version: 5.2.12
    web: VirtualBox Version: 6.1
==> web: [vagrant-hostsupdater] Checking for host entries
==> web: [vagrant-hostsupdater]   found entry for: 192.168.1.88 client
==> web: Setting hostname...
==> web: Configuring and enabling network interfaces...
==> web: Mounting shared folders...
    web: /vagrant => C:/Users/u69372/Desktop/TBZ/3 Lehrjahr/300/repository300/M300-Services/mysql
==> web: Machine already provisioned. Run `vagrant provision` or use the `--provision`
==> web: flag to force provisioning. Provisioners marked to run always will still run.
```

Dieser Test hat erfolgreich geklappt. ![](https://github.com/Maaxi12345/M300-Services/blob/master/img/daumen.png "daumen")

### **2. Test: HTTPS Zugriff**
Um zu sehen ob der HTTPS Zugriff auf die phpmyadmin Seite funtioniert hat oder nicht, muss ich beim URL einfach die HTTP anfrage zu einer HTTPS umschreiben


**Resultat:**

Also http://192.168.1.99/phpmyadmin ===> https://192.168.1.99/phpmyadmin

![](https://github.com/Maaxi12345/M300-Services/blob/master/img/url.PNG "HTTPS Anfrage")


Und wie man sieht hat das ganze gut funktioniert und man kommt auf die Login-Seite.

![](https://github.com/Maaxi12345/M300-Services/blob/master/img/site.PNG "HTTPS Anfrage")

Das verwendete Zertifikat:

![](https://github.com/Maaxi12345/M300-Services/blob/master/img/cert.PNG "HTTPS Anfrage")


### **3. Test: HTTP Redirect**

Damit ich den Redirect testen kann muss ich einfach die phpmyadmin Seite mit http im der Url ausführen.

**Resultat:**

Also muss ich diese URL eingeben http://192.168.1.99/phpmyadmin

![](https://github.com/Maaxi12345/M300-Services/blob/master/img/http.PNG "HTTP Anfrage")

Und wie man sieht, man wird direkt zu https redirected und man kommt auf die Login-Seite.

![](https://github.com/Maaxi12345/M300-Services/blob/master/img/site.PNG "HTTPS Anfrage")