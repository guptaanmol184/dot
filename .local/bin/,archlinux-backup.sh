#! /usr/bin/env bash

# Source: https://gitlab.com/Myl0g/archlinux-backup-tool

command -v rsync >/dev/null 2>&1 || { echo >&2 "I require rsync but it's not installed.  Aborting."; exit 1; }
command -v pv >/dev/null 2>&1 || { echo >&2 "I require pv but it's not installed.  Aborting."; exit 1; }

if [ "$1" == "-v" ]; then
    printf "1.3\n"
    exit
fi

if [ "${AURHELPER}" == "" ]; then
    printf "Please set the AURHELPER environment variable to your favorite AUR helper\n(i.e. yaourt, yay, pacaur)\n"
    exit 2
fi

### BACKUP (Home folder, packages, and pacman.conf) ###

if [ "$1" == "backup" ]; then
    set -e

    TODAY=$(date '+%F')
    FOLDER="/home/backup-${TODAY}"
    sudo mkdir "${FOLDER}"
    sudo chown -R "${USER}:${USER}" "${FOLDER}" # Gives ownership of backup folder

    # Get all installed packages, minus items from base and base-devel
    comm -23 <(${AURHELPER} -Qeq | sort) <(${AURHELPER} -Qgq base base-devel | sort) > "${FOLDER}/packages.txt"

    set +e

    # Get home folder
    mkdir "${FOLDER}/home/"
    rsync --progress --ignore-errors -a "${HOME}" "${FOLDER}/home/"

    set -e

    # Copy the pacman config file
    cp /etc/pacman.conf "${FOLDER}/"

    FILE="al_backup_${TODAY}"
    if [ "$2" == "--output-prefix" ]; then
	    FILE="$3_backup_${TODAY}"
    fi

    # Compress and send to designated backup location
    tar -cf - "${FOLDER}" | xz -9 -c - | pv > "$FILE.tar.xz"
    printf "\a"
    printf "A compressed archive of your home folder and installed packages has been created.\n"
    printf "Deleting uncompressed version...\n"
    sudo rm -rf "${FOLDER}"

    printf "Encrypt the backup with GPG? Use Y or N. "
    read ENCRYPT
    if [ "$ENCRYPT" == "y" ] || [ "$ENCRYPT" == "y" ]; then
        gpg -c "$FILE.tar.xz"
	    rm "$FILE.tar.xz"
    fi
    exit
fi

### RECOVERY ###

## Home Folder ##

if [ "$1" == "recover" ] && [ "$2" == "home" ] && ["${3}" != ""] && [ "${4}" != "" ]; then
    if [ "${USER}" != "root" ]; then
        printf "Run as root.\n"
        exit 3
    fi

    printf "Commencing home folder restore with user ${3}.\n"

    set -e
    mkdir archlinux_backup && tar -xvf ${4} -C archlinux_backup --strip-components 1

    # Install home folder
    mv "archlinux_backup/home/${3}" /home/
    useradd -G wheel "${3}"
    chown -R "${3}:${3}" "/home/${3}"
fi

## Packages and pacman.conf ##

if [ "${1}" == "recover" ] && [ "${2}" == "packages" ] && [ "${3}" != "" ]; then

    if [ "${USER}" == "root" ]; then
        printf "Run as admin, not root.\n"
        exit 3
    fi

    set -e

    # Restore pacman.conf
    cp -f "pacman.conf" /etc/pacman.conf

    # Install AUR helper
    sudo pacman -Syu git
    git clone "https://aur.archlinux.org/${AURHELPER}.git"
    cd "${AURHELPER}"
    makepkg -sci
    cd .. && rm -rf "${AURHELPER}"

    # Install packages from backup list
    "${AURHELPER}" -S - < "packages.txt"

    exit
fi

## Help Menu ##

if [ "${1}" != "--help" ]; then
    printf "Incorrect usage; see archlinux-backup --help.\n"
    exit 4
fi

cat << EOF
Set the AURHELPER env variable before use.

NAME
    archlinux-backup - Arch Linux home folder & package list backup and restore tool.

SYNOPSIS
    archlinux-backup [command] [arguments...]

OPTIONS

    backup [--output-prefix PREFIX]     Create a XZ compressed tape archive of your home folder and package list

    recover home [user] [backup_file]	Decompress the backup archive, restore the home folder of [user], and create the user [user] and add to group wheel.

    recover packages [backup_file]	Install the AUR helper in the AURHELPER env variable and use it to install the packages in the package list.

AUTHOR
    Milo G. <myl0gcontact@gmail.com>

EXIT VALUES
    0   Success
    1   Dependency missing
    2   Environment variable missing
    3   Insufficient privileges
    4   Syntax or usage error

EOF

