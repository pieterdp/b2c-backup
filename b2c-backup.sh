#!/bin/bash
log_date=$(date +%Y-%m-%dT%H_%M_%S)

source "./vars"

if [ ! -d "./logs/backups" ]; then
    mkdir -p "./logs/backups"
fi

export FTP_PASSWORD
export PASSPHRASE

duplicity --encrypt-sign-key "$key_id" --verbosity 4 --full-if-older-than "$full_if_older" --volsize 20 "$source" "b2://$bc_id@$bucket/" >> "./logs/backups/$log_date.log"

unset PASSPHRASE
unset FTP_PASSWORD
exit 0
