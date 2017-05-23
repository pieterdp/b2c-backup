#!/bin/bash
log_date=$(date +%Y-%m-%dT%H_%M_%S)

source "./vars"

if [ "$1" = ""  -o "$2" = "" ]; then
    echo "Usage: $0 file_or_directory_to_restore target_directory"
    exit 1
fi
to_restore="$1"
target_directory="$2"

if [ ! -d "./logs/restores" ]; then
    mkdir -p "./logs/restores"
fi

export FTP_PASSWORD
export PASSPHRASE

duplicity --encrypt-sign-key "$key_id" --file-to-restore "$to_restore" "b2://$bc_id@$bucket/" "$target_directory" >> "./logs/restores/$log_date.log"

unset PASSPHRASE
unset FTP_PASSWORD
exit 0
