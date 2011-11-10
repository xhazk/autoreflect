#!/bin/bash
#
# /usr/bin/autoreflect - backup pacman mirrorlist and output fastest 8 mirrors to new list via Reflector.
# For full automation, add autoreflect as a root cron job.
#
# Created by xhazk (xhazzk@gmail.com) 2011-11-10. This script is free to use, alter and distribute with no limitations.
#

# Does the user have root?
#
if [ "$(id -u)" == "0" ]; then
	echo "User has root!"
else
	echo "This script requires root. Aborting!" 1>&2
	exit 1
fi

# Is Reflector installed?
#
if which reflector >/dev/null; then
	echo "Reflector is installed!"
else
	echo "Autoreflect needs Reflector. Please obtain it from the AUR."
	exit 1
fi

# Backup current mirrorlist
#
echo "Backing up current mirrorlist..."
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
echo "Backup complete."

# Use Reflector to obtain top 8 fastest mirrors and output to new mirrorlist
#
echo "Please be patient, running Reflector..."
reflector --save /etc/pacman.d/mirrorlist -p http --threads 4 -f 8 --sort rate
echo "New mirrorlist generated."

# Resync pacman mirrors.
#
echo "Re-synching mirrors..."
pacman -Syy
echo "Mirrorlist update complete!"
