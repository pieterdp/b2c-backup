#!/bin/bash
log_date=$(date +%Y-%m-%dT%H_%M_%S)

source "./vars"

if [ ! -d "./logs/rotations" ]; then
    mkdir -p "./logs/rotations"
fi

export FTP_PASSWORD
export PASSPHRASE

duplicity --encrypt-sign-key "$key_id" --remove-older-than "$rotation_time" --force "b2://$bc_id@$bucket/" >> "./logs/rotations/$log_date.log"

unset PASSPHRASE
unset FTP_PASSWORD
exit 0
