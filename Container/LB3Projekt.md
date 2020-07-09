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

## Volumes zu persistenten Datenablage
Um diese Kompetenz zu erreichen habe ich einfach einen zusätzlichen Docker erstellt. Und zwar einen, der bei mir Lokal über eine Vagrant Maschine läuft

Das Vagrantfile dazu ist [**hier**](https://github.com/Maaxi12345/M300-Services/blob/master/Container/Vagrantfile)

![](https://github.com/Maaxi12345/M300-Services/blob/master/img/volume.PNG "Volumisierung")




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
