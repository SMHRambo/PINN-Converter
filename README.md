# 🚀 PINN Image Converter

> 🛠️ Ein leistungsstarkes Bash-Skript zur Erstellung von PINN Kompatiblen Images

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
sudo ./build.sh -f inputimage.img
```

### Parameter

| Parameter          | Beschreibung                             |
| ------------------ | ---------------------------------------- |
| `-f image`         | Pfad zur Imagedatei als .img oder zip    |
| `-i`               | Interaktiver Modus    |
| `[-c icon]`        | Pfad zur Icon-Bilddatei als jpg oder png |
| `[-n name]`        | Name des PINN Images                     |
| `[-d description]` | Beschreibung des PINN Images             |
| `[-u url]`         | URL zum OS Images                        |
| `[-t date]`        | Erstellungsdatum des OS Images           |
| `[-m version]`     | Version des OS Images                    |
| `[-p Pi Models]`   | Auflistung aller kompatibler RPi-Modelle |

---

## 🐳 Verwendung mit Docker

### Image ziehen

```bash
docker pull SMHRambo/pinn-converter
```

### Container ausführen

```bash
docker run --rm --privileged -it -v "path to imagefile":/opt/pinn/<imagesfilename> -v "path to output directory":/opt/pinn/os pinn-converter \
  -f /opt/pinn/<imagefilename> -n "OS name"
```

---

## ⭐ Support

Wenn dir das Projekt gefällt:

👉 Star das Repo
👉 Teile es mit anderen
👉 Öffne Issues für Feedback

---
