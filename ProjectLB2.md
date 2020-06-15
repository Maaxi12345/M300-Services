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

## Applikationen & Programme

Was wurde alles installiert.


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

## Portforwarding

 Port | Portforward 
--- | ---
80 |8080
3306 | 3306
22 |2222

# Security
