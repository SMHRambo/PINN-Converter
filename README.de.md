# 🚀 PINN Converter
[![en](https://img.shields.io/badge/lang-en-red.svg)](https://github.com/SMHRambo/PINN-Converter/blob/main/README.md)
[![de](https://img.shields.io/badge/lang-de-yellow.svg)](https://github.com/SMHRambo/PINN-Converter/blob/main/README.de.md)

> 🛠️ Ein leistungsstarkes Bash-Skript zur Erstellung von PINN kompatiblen Images

---

## 📦 Features

* ⚡ Schnelle Erstellung von Raspberry Pi Images
* 🔧 Vollständig anpassbar (Name, Icon, Beschreibung)
* 🐳 Docker-Unterstützung für isolierte Builds

---

## 📊 Status & Downloads

![GitHub release (latest)](https://img.shields.io/github/v/release/SMHRambo/PINN-Converter)
![GitHub downloads](https://img.shields.io/github/downloads/SMHRambo/PINN-Converter/total)
![GitHub stars](https://img.shields.io/github/stars/SMHRambo/PINN-Converter?style=social)
![GitHub forks](https://img.shields.io/github/forks/SMHRambo/PINN-Converter?style=social)

---

## 🖥️ Installation

```bash
git clone https://github.com/SMHRambo/PINN-Converter.git
cd PINN-Converter
chmod +x pinn-converter.sh
```

---

## ▶️ Verwendung (Bash)

```bash
sudo ./pinn-converter.sh -f <PFAD_ZUM_URSPRUNGS_IMAGE> -n <NAME>
```

### Parameter

| Parameter             | Beschreibung                               |
| --------------------- | ------------------------------------------ |
| `-f <image>`          | Pfad zur Imagedatei als .img oder Archiv   |
| `-n <Name>`           | Name des resultierenden PINN Images        |
| `[-i]`                | Interaktiver Modus                         |
| `[-c <Icon>]`         | Pfad zur Icon-Bilddatei als .jpg oder .png |
| `[-d <Beschreibung>]` | Beschreibung des PINN Images               |
| `[-u <url>]`          | URL zum OS Images                          |
| `[-t <Datum>]`        | Erstellungsdatum des OS Images             |
| `[-m <Version>]`      | Version des OS Images                      |
| `[-p <Pi Modelle>]`   | Auflistung aller kompatibler RPi-Modelle   |

Zum Ausführen ist nur Pfad zum Ursprungs-Image (-f <PFAD_ZUM_URSPRUNGS_IMAGE>) und der Name (-n <NAME>) notwendig. <br />
Im interaktiven Modus [-i] werden alle Informationen während der Ausführung abgefragt. <br />
Alle anderen Angaben sind optional. <br />
Wenn im interaktiven Modus noch andere Parameter übergeben wurden, werden diese während der Ausführung nicht mehr abgefragt. <br />
Die Liste an kompatiblen Raspberry Pi Modellen wird als Komma getrennte Werte (CSV-String) übergeben.

Der Skript erzeugt einen Ordner mit den Namen "os" der die passende Ordnerstruktur für PINN beinhaltet.

---

## 🐳 Verwendung mit Docker

### Image ziehen

#### Für Github Container Repository ####
```bash
docker pull ghcr.io/smhrambo/pinn-converter
```
or

#### Für DockerHub Container Repository ####
```bash
docker pull smhrambo/pinn-converter:latest
```

### Container ausführen

```bash
docker run --rm --privileged -it -v "path to imagefile":/opt/pinn/<imagesfilename> -v "path to output directory":/opt/pinn/os pinn-converter \
  -f /opt/pinn/<imagefilename> -n "NAME"
```

---

## 📜 Lizenz

GPL-3.0 License

---

## ⭐ Support

Wenn dir das Projekt gefällt:

👉 Star das Repo
👉 Teile es mit anderen
👉 Öffne Issues für Feedback

---
