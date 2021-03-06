#!/bin/sh

if [ $# -eq 0 ] || [ $1 = "-h" -o $1 = "--help" ] 
then
    echo "$0 /path/to/file.asc"
    exit 0
fi

pin=$(gpg2 -o - -d -q --no-symkey-cache ${1} | oathtool -b --totp -)

echo $pin | timeout 30s xclip -i -sel clip -r -quiet
