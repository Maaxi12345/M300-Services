# Project LB3
Repository 4 Modul 300. Owner Maximilian

##Einleitung

Bevor ich überhaupt mit diesem Projekt beginnen konnte, musste ich mich mit den Docker-Grundlagen auseinandersetzen. Das lag daran, dass ich noch nie mit Docker gearbeitet habe. Als ich mich ein wenig sicherer gefühlt habe richtig angefangen. Als Projekt habe ich einen mysql-container mit einem phpmyadmin-container verbunden

# K3


## Docker-Container kombinieren

Ich habe als folgende 2 Docker-Container kombiniert. Einen mysql Container als Backend und einen phpmyadmin Container als Frontend. Ich habe das ganze dann auf der VM im TBZ Maas eingerichtet.

**Vorgehen:**

<br>
1. Als erstes hole ich das neuste mysql image:

```Ruby
ubuntu@m300-23-st17d:~$ docker pull mysql
```

<br>
2.  Danach erstelle ich den Docker Container mit folgenden Parametern

```Ruby
ubuntu@m300-23-st17d:~$ docker run --name maxsql -e MYSQL_ROOT_PASSWORD=Migros1 -d mysql
```

<br>
3. Hier hole ich das phpmyadmin Image für das Frontend

```Ruby
ubuntu@m300-23-st17d:~$ docker pull phpmyadmin/phpmyadmin
```

<br>
4. Danach wird auch hier der Docker-Container erstellt und gleichzeitig wird er mit dem mysql container kombiniert

```Ruby
ubuntu@m300-23-st17d:~$ docker run --name maxphpmyadmin -d --link maxsql:db -p 8081:80 phpmyadmin/phpmyadmin
```
<br>

## Volumes zur persistenten Datenablage
Um diese Kompetenz zu erreichen habe ich einfach einen zusätzlichen Docker erstellt. Und zwar einen, der bei mir Lokal über eine Vagrant Maschine läuft

Das Vagrantfile dazu ist [**hier**](https://github.com/Maaxi12345/M300-Services/blob/master/Container/Vagrantfile)

![](https://github.com/Maaxi12345/M300-Services/blob/master/img/volume.PNG "Volumisierung")

<br>
1. Schritt

Ich verbinde die beiden Verzeichnisse über einen Synced folder den ich im Vagrantfile eingerichtet habe
```Ruby
config.vm.synced_folder "./www", "/var/www/html/"
```

<br>
2. Schritt

Die Verzeichnisse verden über ein Volume miteinander gesynct. Das mache ich auch im Vagrantfile, beim teil wo es den Container startet.
```Ruby
d.run "apache", image: "httpd", args: " -v /var/www/html/:/usr/local/apache2/htdocs/ -p 8080:80 --restart=always"
```

```Ruby
-v /var/www/html/:/usr/local/apache2/htdocs/
```

## Befehle

| Befehl                    | Beschreibung                                                      |
| ------------------------- | ----------------------------------------------------------------- | 
| `docker run hello-world`            | Ist der Befehl zum Starten neuer Container. |
| `docker ps`              | Gibt einen Überblick über die aktuellen Container |
| `docker image ls`             | Gibt eine Liste lokaler Images aus                  |
| `docker rm [name]`          | Löscht den Docker-Container                                |
| `docker start [id]`            | Startet den Docker-Container                           |
| `docker stop`            | Stoppt den Docker-Container                                 |
| `docker kill`         | Killt den Docker-Container                   |


## Testing

### **1. Test: Startup**

Bei diesem Test geht es um das Starten der Vagrant Maschine mit der Apache-Docker

Dafür habe ich im enstrechendem Verzeichniss den Command  *`Vagrant up`* aus geführt.

```Ruby
$  vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'ubuntu/xenial64'...
==> default: Matching MAC address for NAT networking...
==> default: Checking if box 'ubuntu/xenial64' version '20200630.0.0' is up to date...
==> default: A newer version of the box 'ubuntu/xenial64' for provider 'virtualbox' is
==> default: available! You currently have version '20200630.0.0'. The latest is version
==> default: '20200708.0.0'. Run `vagrant box update` to update.
==> default: Setting the name of the VM: Container_default_1594315767530_82498
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 8080 (guest) => 8080 (host) (adapter 1)
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Running 'pre-boot' VM customizations...
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
<snip>
==> default: [vagrant-hostsupdater] Checking for host entries
==> default: Mounting shared folders...
    default: /vagrant => C:/Users/u69372/Desktop/TBZ/3 Lehrjahr/300/repository300/M300-Services/Container
    default: /var/www/html => C:/Users/u69372/Desktop/TBZ/3 Lehrjahr/300/repository300/M300-Services/Container/www
==> default: Running provisioner: docker...
    default: Installing Docker onto machine...
<snip>
==> default: Status: Downloaded newer image for httpd:latest
==> default: docker.io/library/httpd:latest
==> default: Starting Docker containers...
==> default: -- Container: apache
```
Dieser Test hat erfolgreich geklappt. ![](https://github.com/Maaxi12345/M300-Services/blob/master/img/daumen.png "daumen")

<br>

### **2. Test: Website Aufruf**
Um zu schauen ob die Vagrant-Docker Maschine auch funktioniert versuche ich das index.html über den Browser zu öffnen.

Dafür muss ich im Browser einfach localhost:8080 eingeben.

![](https://github.com/Maaxi12345/M300-Services/blob/master/img/web.PNG "WebResult")

Dieser Test hat erfolgreich geklappt. ![](https://github.com/Maaxi12345/M300-Services/blob/master/img/daumen.png "daumen")

<br>

### **3. Test: phpmyadmin**
Bei diesem Test überprüfe ich die Funktionalität der Kombinierten Container (mysql/phpmyadmin)

Weil ich das ganze auf dem TBZ MAAS erstellt habe, muss ich dementsprechend auch dessen IP Adresse mit dem jeweilig bestimmten Port angeben. 192.168.133.23:8081

![](https://github.com/Maaxi12345/M300-Services/blob/master/img/phpmylog.PNG "Login")

Und hier noch wenn ich mich einlogge:

![](https://github.com/Maaxi12345/M300-Services/blob/master/img/phpmyhome.PNG "Homescreen")

Dieser Test hat erfolgreich geklappt. ![](https://github.com/Maaxi12345/M300-Services/blob/master/img/daumen.png "daumen")



# K4 

## Service-Überwachung

Ich überwache meinen Host mit Cadvisor. Cadvisor analysiert den Ressourcenverbrauch und Performance-Charakteristiken von laufenden Containern.

![](https://github.com/Maaxi12345/M300-Services/blob/master/img/cad.PNG "Cadvisor")

**Installation:**

Mit einem Command
```Ruby
docker run -d --name cadvisor -v /:/rootfs:ro -v /var/run:/var/run:rw -v /sys:/sys:ro -v /var/lib/docker/:/var/lib/docker:ro -p 8181:8080 google/cadvisor:latest
```


Ich hatte am Anfang noch Probleme den Port richtig zu Forwarden, doch schlussendlich kam ich doch noch drauf.

Um mich auf das Web Ui zu verbinden gib ich folgendes in der URL ein.
http://192.168.23:8181

**WEB UI:**

![](https://github.com/Maaxi12345/M300-Services/blob/master/img/cadweb.PNG "Cadvisor")

## Container-Absicherung

* Die Container laufen in einer VM oder auf einem dedizierten Host, um zu vermeiden, dass andere Benutzer oder Services angegriffen werden können.
* Alle Container laufen mit aktueller Software und im Produktivmodus – Debug-Informationen sind abgeschaltet.
* AppArmor oder SELinux sind auf dem Host aktiviert