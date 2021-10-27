#!/bin/bash
#
# Script Name   : letsencrypt-transfer-certs.sh
# Description   : Transfer LetsEncrypt certificates from one Linux server to another
# Author        : https://github.com/filipnet/letsencrypt-transfer
# License       : BSD 3-Clause "New" or "Revised" License
# ======================================================================================

EXTRAOPT="--ipv4 --numeric-ids --recursive"

if [ -n "$1" ] ; then
	SRC_FQDN="$1"
        SRC_FOLDER="$2"
	DST_FOLDER="$3"
        SSH_CERT="$4"
	echo "Create destination folder <destination folder>"
	mkdir -p $3
	echo "Start: $0 $1 $2 $3 $4"
else
	echo "Error: Usage $0 <source fqdn> <source folder> <destination folder> <ssh certificate>"
        echo "Example: $0 server.domain.de /etc/letsencrypt/live/lb.domain.de/ /etc/letsencrypt/live/lb.domain.de/ /root/id_rsa_lb.domain.pem"
	exit
fi

rsync -avz $EXTRAOPT -e "ssh -4 -i $SSH_CERT" $SRC_FQDN:$SRC_FOLDER $DST_FOLDER
