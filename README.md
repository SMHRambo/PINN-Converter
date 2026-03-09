# PINN-Converter

PINN-Converter is a tool for creating PINN-compatible images.

Usage:
sudo ./pinn-converter.sh -f <path to imagefile> -n <OS name>

Help:
./pinn-converter.sh -h
Usage: $0 -f imagefile [-c iconfile] [-n name] [-d description] [-u osurl] [-t date] [-m version] [-p Pi Models] [-i]

Docker:
docker run --rm --privileged -it -v <path to imagefile>:/opt/pinn/<imagesfilename> -v <path to output directory>:/opt/pinn/os pinn-converter -f /opt/pinn/<imagefilename> -n <OS name>
