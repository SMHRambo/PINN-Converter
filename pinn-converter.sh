#!/bin/bash

# PINN-Converter v1.0
# Copyright (c) 2026 Sascha Marcel Hacker (https://github.com/SMHRambo)

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Dieses Programm ist Freie Software: Sie können es unter den Bedingungen
# der GNU General Public License, wie von der Free Software Foundation,
# Version 3 der Lizenz oder (nach Ihrer Wahl) jeder neueren
# veröffentlichten Version, weiter verteilen und/oder modifizieren.

# Dieses Programm wird in der Hoffnung bereitgestellt, dass es nützlich sein wird, jedoch
# OHNE JEDE GEWÄHR,; sogar ohne die implizite
# Gewähr der MARKTFÄHIGKEIT oder EIGNUNG FÜR EINEN BESTIMMTEN ZWECK.
# Siehe die GNU General Public License für weitere Einzelheiten.

# Sie sollten eine Kopie der GNU General Public License zusammen mit diesem
# Programm erhalten haben. Wenn nicht, siehe <https://www.gnu.org/licenses/>.

error=false
OS_NAME=""
OS_DESCRIPTION=""
OS_URL=""
OS_DATE=""
OS_VERSION=""
PI_MODELS=""
INTERACTIVE=false
DELTA_SIZE=5
delete=false
help=false

printf_t() {
    local key=$1
    shift

	# shellcheck disable=SC2059
    printf "${i18n[${key}_${CURRENT_LANG}]}\n" "$@"
}

declare -A i18n

i18n[help_en]="Usage: $0 -f imagefile [-c iconfile] [-n name] [-d description] [-u osurl] [-t date] [-m version] [-p Pi Models]"
i18n[help_message_en]="Use -h or -? for help."
i18n[run_as_root_en]="This script must be run as root."
i18n[bin_file_missing_en]="file could not be found, please install."
i18n[bin_7z_missing_en]="7z could not be found, please install."
i18n[bin_bsftar_missing_en]="bsdtar could not be found, please install."
i18n[bin_xz_missing_en]="xz could not be found, please install."
i18n[bin_getfacl_missing_en]="getfacl could not be found, please install"
i18n[bin_jq_missing_en]="jq could not be found, please install"
i18n[bin_fdisk_missing_en]="fdisk could not be found, please install"
i18n[image_path_missing_en]="The image path must be set."
i18n[image_not_found_en]="The image file at %s does not exist."
i18n[icon_not_found_en]="The icon file at %s does not exist."
i18n[name_is_missing_en]="The name must be specified in non-interactive mode."
i18n[name1_en]="The following name was found:"
i18n[name2_en]="Name:"
i18n[description1_en]="Please provide a description of the operating system:"
i18n[description2_en]="Description:"
i18n[date1_en]="The following dates were found:"
i18n[date2_en]="Date:"
i18n[url1_en]="Please provide a URL for the operating system project:"
i18n[url2_en]="URL:"
i18n[version1_en]="The following version was found:"
i18n[version2_en]="Version:"
i18n[models1_en]="Please specify the Raspberry Pi model of the operating system:"
i18n[models2_en]="Models:"

i18n[help_de]="Benutzung: $0 -f Imagedatei [-c Icondatei] [-n Name] [-d Beschreibung] [-u OS-Url] [-t Datum] [-m Version] [-p Pi Modelle]"
i18n[help_message_de]="Verwenden Sie -h oder -? für Hilfe."
i18n[run_as_root_de]="Dieser Skript muss als Root ausgeführt werden."
i18n[bin_file_missing_de]="file konnte nicht gefunden werden, bitte installieren."
i18n[bin_7z_missing_de]="7z konnte nicht gefunden werden, bitte installieren."
i18n[bin_bsftar_missing_de]="bsdtar konnte nicht gefunden werden, bitte installieren."
i18n[bin_xz_missing_de]="xz konnte nicht gefunden werden, bitte installieren."
i18n[bin_getfacl_missing_de]="getfacl konnte nicht gefunden werden, bitte installieren."
i18n[bin_jq_missing_de]="jq konnte nicht gefunden werden, bitte installieren."
i18n[bin_fdisk_missing_de]="fdisk konnte nicht gefunden werden, bitte installieren."
i18n[image_path_missing_de]="Der Imagepfad muss angegeben werden."
i18n[image_not_found_de]="Die Imagedatei in %s existiert nicht."
i18n[icon_not_found_de]="Die Icondatei in %s existiert nicht."
i18n[name_is_missing_de]="Der Name muss im nicht interaktiven Modus angegeben werden."
i18n[name1_de]="Es wurden folgender Name gefunden:"
i18n[name2_de]="Name:"
i18n[description1_de]="Bitte eine Beschreibung des Betreibsystems angeben:"
i18n[description2_de]="Beschreibung:"
i18n[date1_de]="Es wurden folgende Datum gefunden:"
i18n[date2_de]="Datum:"
i18n[url1_de]="Bitte eine URL zum Projekt des Betreibsystems angeben:"
i18n[url2_de]="URL:"
i18n[version1_de]="Es wurde folgende Version gefunden:"
i18n[version2_de]="Version:"
i18n[models1_de]="Bitte die Raspberry Pi Modell des Betreibsystems angeben:"
i18n[models2_de]="Modelle:"


lang=${LC_MESSAGES:-$LANG}

if [[ $lang == de* ]]; then
    CURRENT_LANG="de"
else
    CURRENT_LANG="en"
fi

while getopts "h?in:d:f:c:u:t:m:p:" opt; do
    case "$opt" in
    h|\?)
        printf_t help
        exit 0
        ;;
    n)  OS_NAME=$OPTARG
        ;;
    d)  OS_DESCRIPTION=$OPTARG
        ;;
    f)  IMAGE_FILE=$OPTARG
        ;;
    c)  ICON_FILE=$OPTARG
        ;;
    u)  OS_URL=$OPTARG
        ;;
    t)  OS_DATE=$OPTARG
        ;;
    m)  OS_VERSION=$OPTARG
        ;;
    p)  PI_MODELS=$OPTARG
        ;;
    i)  INTERACTIVE=true
        ;;
    esac
done

if [[ $EUID -ne 0 ]]; then
    printf_t run_as_root
    error=true
fi

if ! command -v file >/dev/null 2>&1
then
    printf_t bin_file_missing
    error=true
fi

if ! command -v jq >/dev/null 2>&1
then
    printf_t bin_jq_missing
    error=true
fi

if ! command -v 7z >/dev/null 2>&1
then
    printf_t bin_7z_missing
    error=true
fi

if ! command -v bsdtar >/dev/null 2>&1
then
    printf_t bin_bsdtar_missing
    error=true
fi

if ! command -v xz >/dev/null 2>&1
then
    printf_t bin_xz_missing
    error=true
fi

if ! command -v fdisk >/dev/null 2>&1
then
    printf_t bin_fdisk_missing
    error=true
fi

if ! command -v getfacl >/dev/null 2>&1
then
    printf_t bin_getfacl_missing
    error=true
fi

if [ -z "$IMAGE_FILE" ]; then
    printf_t image_path_missing
    help=true
    error=true
fi

if [ ! -f "$IMAGE_FILE" ]; then
    printf_t image_not_found "$IMAGE_FILE"
    error=true   
fi

if [ ! -f "$ICON_FILE" ]; then
    printf_t icon_not_found "$ICON_FILE"
    error=true   
fi

if [[ -z "$OS_NAME" && $INTERACTIVE == false ]]; then
    printf_t name_is_missing
    help=true
    error=true   
fi

if $help
then
    printf_t help_message
fi

if $error
then
    exit 1
fi

if file "$IMAGE_FILE" | grep -Eqi 'archive|compressed'; then
    7z x -aoa "$IMAGE_FILE" > /dev/null
    IMAGE_FILE=$(7z l -ba "$IMAGE_FILE" | awk '{print $NF}')
    delete=true
fi
7z x -aoa "$IMAGE_FILE" > /dev/null

if [[ -z "$OS_NAME"  && $INTERACTIVE == true ]]; then
    OS_NAME=$(basename "$IMAGE_FILE" | sed -E 's/^([A-Za-z]+).*/\1/')
    printf_t name1
    basename "$IMAGE_FILE"
    read -r -e -i "$OS_NAME" -p "$(printf_t name2)" OS_NAME
fi

if [[ -z "$OS_DESCRIPTION" && $INTERACTIVE == true ]]; then
    printf_t description1
    read -r -e -i "$OS_DESCRIPTION" -p "$(printf_t description2)"
fi

if [[ -z "$OS_URL" && $INTERACTIVE == true ]]; then
    printf_t url1
    read -r -e -i "$OS_URL" -p "$(printf_t url2)"
fi

if [[ -z "$OS_DATE" && $INTERACTIVE == true ]]; then
    OS_DATE=$(date +%Y.%m.%d)
    printf_t date1
    basename "$IMAGE_FILE"
    read -r -e -i "$OS_DATE" -p "$(printf_t date2)" OS_DATE
fi

if [[ -z "$OS_VERSION" && $INTERACTIVE == true ]]; then
    OS_VERSION=$(basename "$IMAGE_FILE" | sed 's/^[0-9-]*-\(.*\).img/\1/')
    printf_t version1
    basename "$IMAGE_FILE"
    read -r -e -i "$OS_VERSION" -p "$(printf_t version2)" OS_VERSION
fi

if [[ -z "$PI_MODELS" && $INTERACTIVE == true ]]; then
    printf_t models1
    read -r -e -i "Pi 1,Pi 2,Pi 3,Pi 4,Pi 5,Pi Zero,Pi Zero 2" -p "$(printf_t models2)" PI_MODELS
elif [[ $INTERACTIVE == true  ]]; then
    PI_MODELS="Pi 1,Pi 2,Pi 3,Pi 4,Pi 5,Pi Zero,Pi Zero 2"
fi

mkdir -p ./os/"$OS_NAME"
mkdir -p ./mount0
mkdir -p ./mount1

if mountpoint -q ./mount0; then
    umount ./mount0
fi

if mountpoint -q ./mount1; then
    umount ./mount1
fi

mount -o loop ./0.fat ./mount0
mount -o loop ./1.img ./mount1

KERNEL=$( (ls mount0 && ls mount1/boot/) | grep vmlinuz | tail -1 | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+' )

(cd mount0 || exit && bsdtar --numeric-owner --format gnutar --one-file-system -cpf ../os/"$OS_NAME"/boot.tar . )
umount ./mount0
rm ./0.fat
BOOT_SIZE=$(fdisk -l "$IMAGE_FILE" | grep "img1" | awk '{print $4}')
BOOT_UNCOMPRESSED_SIZE=$(stat -c %s os/"$OS_NAME"/boot.tar)
xz -9 -e -f os/"$OS_NAME"/boot.tar
BOOT_SHASUM="$(sha256sum "os/$OS_NAME/boot.tar.xz" | cut -f1 -d' ')"

(cd mount1 || exit && find . -type s -exec rm {} \; && getfacl -s -R . | tee acl_permissions.pinn > /dev/null && bsdtar --numeric-owner --format gnutar --one-file-system -cpf ../os/"$OS_NAME"/root.tar .)
umount ./mount1
rm ./1.img
ROOT_SIZE=$(fdisk -l "$IMAGE_FILE" | grep "img2" | awk '{print $4}')
ROOT_UNCOMPRESSED_SIZE=$(stat -c %s os/"$OS_NAME"/root.tar)
xz -9 -e -f os/"$OS_NAME"/root.tar
ROOT_SHASUM="$(sha256sum "os/$OS_NAME/root.tar.xz" | cut -f1 -d' ')"

if [ -f "$ICON_FILE" ]; then
    if [[ "$ICON_FILE" == *.* ]]; then
        fileext=".${ICON_FILE##*.}"
    else
        fileext=""
    fi

    cp "$ICON_FILE" os/"$OS_NAME"/"$OS_NAME""$fileext"
fi

SECTOR_SIZE=$(fdisk -l "$IMAGE_FILE" | grep "Sector size" | awk '{print $4}')

IFS=',;' read -ra models <<< "$PI_MODELS"
PI_MODELS=$(printf '%s\n' "${models[@]}" | jq -R . | jq -s .)

cat > os/"$OS_NAME"/partition_setup.sh << EOF
#!/bin/sh
#supports_backup in PINN

set -ex

# shellcheck disable=SC2154
if [ -z "\$part1" ] || [ -z "\$part2" ]; then
  printf "Error: missing environment variable part1 or part2\n" 1>&2
  exit 1
fi

mkdir -p /tmp/1 /tmp/2

mount "\$part1" /tmp/1
mount "\$part2" /tmp/2

sed /tmp/1/cmdline.txt -i -e "s|root=[^ ]*|root=\${part2}|"
sed /tmp/2/etc/fstab -i -e "s|^[^#].* / |\${part2}  / |"
sed /tmp/2/etc/fstab -i -e "s|^[^#].* /boot\(.*\) |\${part1} /boot\1 |"

# shellcheck disable=SC2154
if [ -z "\$restore" ]; then
  if [ -f /mnt/ssh ]; then
    cp /mnt/ssh /tmp/1/
  fi

  if [ -f /mnt/ssh.txt ]; then
    cp /mnt/ssh.txt /tmp/1/
  fi

  if [ -f /settings/wpa_supplicant.conf ]; then
    cp /settings/wpa_supplicant.conf /tmp/1/
  fi

  if ! grep -q resize /proc/cmdline; then
    if ! grep -q splash /tmp/1/cmdline.txt; then
      sed -i "s| quiet||g" /tmp/1/cmdline.txt
    fi
    sed -i 's| init=/usr/lib/raspi-config/init_resize.sh||' /tmp/1/cmdline.txt
  else
    sed -i '1 s|.*|& sdhci.debug_quirks2=4|' /tmp/1/cmdline.txt
  fi
fi

umount /tmp/1
umount /tmp/2
EOF

cat > os/"$OS_NAME"/partitions.json << EOF
{
    "partitions": [
        {
            "label": "boot",
            "filesystem_type": "FAT",
            "mkfs_options": "-F 32",
            "partition_size_nominal": $((BOOT_SIZE*SECTOR_SIZE/1024/1024+DELTA_SIZE)),
            "uncompressed_tarball_size": $((BOOT_UNCOMPRESSED_SIZE/1024/1024+1)),
            "want_maximised": false,
            "sha256sum": "$BOOT_SHASUM"
        },
        {
            "label": "root",
            "filesystem_type": "ext4",
            "mkfs_options": "-O ^huge_file",
            "partition_size_nominal": $((ROOT_SIZE*SECTOR_SIZE/1024/1024+DELTA_SIZE)),
            "uncompressed_tarball_size": $((ROOT_UNCOMPRESSED_SIZE/1024/1024+1)),
            "want_maximised": true,
            "sha256sum": "$ROOT_SHASUM"
        }
    ]
}
EOF

cat > os/"$OS_NAME"/os.json << EOF
{
    "name": "$OS_NAME",
    "description": "$OS_DESCRIPTION",
    "release_date": "$OS_DATE",
    "supported_models": $PI_MODELS,
    "version": "$OS_VERSION",
    "kernel": "$KERNEL",
    "supports_backup": true,
    "url": "$OS_URL",
    "group": "Custom",
    "username": "pi",
    "password": "raspberry"
}
EOF

rm -r ./mount0
rm -r ./mount1

if $delete
then
    rm "$IMAGE_FILE"
fi

exit 0
