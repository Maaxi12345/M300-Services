# Containerisierung
Containerisierung erlaubt es ebenfalls auf eine Maschine mehrere unabhängige Kontexte zu haben, in denen Applikationen laufen können. Im Gegensatz zur Virtualisierung ist dieser Ansatz leichtgewichtiger, weil nicht für jeden Kontext ein vollständiges Betriebssystem zur Verfügung gestellt wird. Anstelle dessen wird das vorhandene Betriebssystem über geschickte Dateisystem-Schichten unterschiedlich konfiguriert.

![](https://github.com/Maaxi12345/M300-Services/blob/master/img/cont.PNG "Containerisierung")

### **Vorteile**
Wiederum können auf einer Hardware unterschiedliche Applikationen unabhängig voneinander laufen. Durch die stärkere Nutzung des Host-Betriebssystems ist der Ansatz leichtgewichtiger. In jedem Kontext kann das Betriebssystem anders konfiguriert werden. Wenn gewünscht sehen sich die verschiedenen Applikationen nicht.

Während Virtualisierung vorwiegend den Server-Bereich adressiert kann Containerisierung problemlos auf jedem Maschinentyp installiert werden. Damit erschließen sich auch Entwicklungsrechner.

Die Beschreibung einer Container-Konfiguration wird ebenfalls zum Artefakt im Entwicklungsprozess.

### **Nachteile**
Um die Leichtgewichtigkeit zu ermöglichen, müssen für Container andere Konzepte erlernt werden. Während bei Virtualisierung noch die bekannten Konzepte eins-zu-eins übertragen wurden, ist es bei Containern wichtig, die Dateisystem-Schichtung und weitere Spezialkonzepte zu verstehen.


# Docker

Docker ist eine Open-Source-Software, mit der sich Container zur Virtualisierung von Anwendungen erstellen und betreiben lassen. Auf einem Linux-, Windows- oder macOS-basierten Host-System werden mit der Software Laufzeitumgebungen zur Ausführung voneinander isolierter Anwendungen bereitgestellt, ohne dass die Virtualisierung des kompletten Betriebssystems notwendig ist.

![](https://github.com/Maaxi12345/M300-Services/blob/master/img/doc.PNG "Docker")

### **Vorteile der Containerisierung mit Docker**
Die Containerisierung mit der frei verfügbaren Software bietet zahlreiche Vorteile. Sie benötigt weniger Ressourcen als virtuelle Maschinen, schottet die Anwendungen aber dennoch sicher untereinander und vom Host-System ab. Ein Container lässt sich in Form einer Image-Datei einfach auf andere Systeme übertragen. Es ist keine neue Installation der Anwendung und ihrer Laufzeitumgebung notwendig. Weitere Vorteile sind:

* die gute Skalierbarkeit durch die Nutzung vieler weiterer Container,
* die einfache Verwaltung vieler Container über Orchestrierungs-Tools wie Kubernetes,
* das schnelles Starten von Containern.
# Microservices
Unter Microservices versteht man Dienste, die jeweils eine kleine Aufgabe erfüllen. Die Prozesse lassen sich wie Module so miteinander verbinden, dass sich daraus eine beliebig komplexe Software ergibt.

Jeder Microservice implementiert genau eine Funktion, wobei der Nutzen für den Anwender im Mittelpunkt steht. Microservices besitzen außerdem die Eigenschaft, dass sie ausschließlich Teams entwickelt werden. Das Team kann auch für die Entwicklung mehrerer Mikrodienste verantwortlich sein – wenn diese den fachlich zusammenhängen.

### **Die Vorteile von Microservice-Architekturen**
Mikrodienste lassen sich voneinander unabhängig entwickeln, und folglich können auch die dafür zuständigen Teams voneinander unabhängig arbeiten. Auf diese Weise lässt sich der Softwareentwicklungsprozess beschleunigen - ohne ein hohes Maß an Koordination und Kommunikation zu erzeugen.

Ein weiterer Vorteil von Mikrodiensten ist deren Größe. Weil sie so klein sind, können sie in relativ kurzer Zeit neu erstellt und ersetzt werden. Ihre geringe Größe macht Mikroservices zudem leichter wartbar, wobei die Funktionalität des Gesamtsystems stets erhalten bleibt.