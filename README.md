# 🚀 PINN Converter
[![en](https://img.shields.io/badge/lang-en-red.svg)](https://github.com/SMHRambo/PINN-Converter/blob/main/README.md)
[![de](https://img.shields.io/badge/lang-de-yellow.svg)](https://github.com/SMHRambo/PINN-Converter/blob/main/README.de.md)

> 🛠️ A powerful Bash script for creating PINN-compatible images

---

## 📦 Features

* ⚡ Quick creation of Raspberry Pi images
* 🔧 Fully customizable (name, icon, description)
* 🐳 Docker support for isolated builds

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

## ▶️ Usage (Bash)

```bash
sudo ./pinn-converter.sh -f <PATH_TO_SOURCE_IMAGE> -n <NAME>
```

### Parameter

| Parameters           | Description                                         |
| -------------------- | --------------------------------------------------- |
| `-f <image>`         | Path to the source image as an .img file or archive |
| `-n <name>`          | Name of the resulting PINN image                    |
| `[-i]`               | Interactive mode                                    |
| `[-c <icon>]`        | Path to the icon file as .jpg or .png               |
| `[-d <description>]` | Description of the PINN image                       |
| `[-u <url>]`         | URL for the OS image                                |
| `[-t <date>]`        | Date the OS image was created                       |
| `[-m <version>]`     | Version of the OS image                             |
| `[-p <Pi Models>]`   | List of all compatible RPi models                   |

To run the program, you only need to specify the path to the source image (-f <PATH_TO_SOURCE_IMAGE>) and the name of the PINN image (-name <NAME>). <br />
In interactive mode [-i], all information is prompted for during execution. <br />
All other options are optional. <br />
If additional parameters are provided in interactive mode, they will not be prompted for during execution. <br />
The list of compatible Raspberry Pi models is provided as a comma-separated values (CSV) string.

The script creates a folder named "os" that contains the appropriate folder structure for PINN.

---

## 🐳 Usage with Docker

### Pull image

#### For Github Container Repository ####
```bash
docker pull ghcr.io/smhrambo/pinn-converter
```
or

#### For DockerHub Container Repository ####
```bash
docker pull smhrambo/pinn-converter:latest
```

### Execute container

```bash
docker run --rm --privileged -it -v "path to imagefile":/opt/pinn/<imagesfilename> -v "path to output directory":/opt/pinn/os pinn-converter \
  -f /opt/pinn/<imagefilename> -n "NAME"
```

---

## 📜 License

GPL-3.0 license

---

## ⭐ Support

If you like this project:

👉 Star the repo
👉 Share it with others
👉 Open issues for feedback

---
