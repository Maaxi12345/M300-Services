# M300-Services
Repository 4 Modul 300. Owner Maximilian

# Linux
Als Linux oder GNU/Linux bezeichnet man in der Regel freie, unixähnliche Mehrbenutzer-Betriebssysteme, die auf dem Linux-Kernel und wesentlich auf GNU-Software basieren. Die weite, auch kommerzielle Verbreitung wurde ab 1992 durch die Lizenzierung des Linux-Kernels unter der freien Lizenz GPL ermöglicht.

# Virtualisierung

Virtualisierung nutzt Software, um Hardwarefunktionen zu simulieren und virtuelle Computersysteme zu erstellen. Auf diese Weise können IT-Organisationen mehrere virtuelle Systeme, Betriebssysteme und Anwendungen auf einem einzigen Server ausführen.

# Vagrant

Die wichtigsten Befehle sind:

| Befehl                    | Beschreibung                                                      |
| ------------------------- | ----------------------------------------------------------------- | 
| `vagrant init`            | Initialisiert im aktuellen Verzeichnis eine Vagrant-Umgebung und erstellt, falls nicht vorhanden, ein Vagrantfile |
| `vagrant up`              |  Erzeugt und Konfiguriert eine neue Virtuelle Maschine, basierend auf dem Vagrantfile |
| `vagrant ssh`             | Baut eine SSH-Verbindung zur gewünschten VM auf                   |
| `vagrant status`          | Zeigt den aktuellen Status der VM an                              |
| `vagrant port`            | Zeigt die Weitergeleiteten Ports der VM an                        |
| `vagrant halt`            | Stoppt die laufende Virtuelle Maschine                            |
| `vagrant destroy`         | Stoppt die Virtuelle Maschine und zerstört sie.                   |

Weitere Befehle unter: https://www.vagrantup.com/docs/cli/


## Intsallation

Virtualbox

Download from here: https://www.virtualbox.org/wiki/Downloads

Vagrant
Download from here: https://www.vagrantup.com/downloads.html

## VM erstellen (basic)

Mit dem Befehl wird eine VM-Box heruntergeladen, und das Vagranfile wird im aktuellem Verzeichniss abgelegt.
```Ruby
$ vagrant init precise64
```

Das Vagrantfile sieht dann so aus:

```Ruby
Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
end
```

## VM starten
```Ruby
$ vagrant up
```
Somit wird die VM gestartet. 

# Git

# Mark Down
Markdown ist eine einfache Auszeichnungssprache, die von John Gruber und Aaron Swartz im Jahr 2004 veröffentlicht wurde. Ähnlich wie bei dem bekannten Wikitext können Dokumente mit Markdown über spezielle Sonderzeichen formatiert werden. Eine Liste wird beispielsweise mit einem einfachen Bindestrich - erzeugt, für Überschriften wird die Raute # genutzt.

Markdown kann mit jedem simplen Text-Editor oder mit speziellen Markdown-Editoren erstellt werden. Mit Hilfe von Programmier-Scripten lässt sich Markdown in die unterschiedlichsten Formate umwandeln, beispielsweise auch in HTML. Der Vorteil von Markdown wird schnell deutlich, wenn man ein HTML-Dokument mit der entsprechenden Markdown-Syntax vergleicht. Ein einfacher Text mit einer Überschrift, einem Absatz und einer Liste sieht in HTML so aus:
## Cheatsheet:
https://github.com/adam-p/markdown-here.wiki.git
# Systemsicherheit