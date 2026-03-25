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
sudo ./build.sh -f inputimage.img -n NAME
```

### Parameter

| Parameter          | Beschreibung                               |
| ------------------ | ------------------------------------------ |
| `-f image`         | Pfad zur Imagedatei als .img oder .zip     |
| `-n name`          | Name des PINN Images                       |
| `[-i]`             | Interaktiver Modus                         |
| `[-c icon]`        | Pfad zur Icon-Bilddatei als .jpg oder .png |
| `[-d description]` | Beschreibung des PINN Images               |
| `[-u url]`         | URL zum OS Images                          |
| `[-t date]`        | Erstellungsdatum des OS Images             |
| `[-m version]`     | Version des OS Images                      |
| `[-p Pi Models]`   | Auflistung aller kompatibler RPi-Modelle   |

Zum Ausführen ist nur Pfad zum Ursprungs-Image (-f PATH) und der Name (-name NAME) notwendig. 
Im interaktiven Modus [-i] werden alle Informationen während der Ausführung abgefragt. 
Alle anderen Angaben sind optional. 
Wenn im interaktiven Modus noch andere Parameter übergeben wurden werden diese wärend der ausführung nicht mehr abgefragt.

---

## 🐳 Verwendung mit Docker

### Image ziehen

```bash
docker pull ghcr.io/smhrambo/pinn-converter
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
