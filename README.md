## Requirements
- GNUPG v2
- oathtool

## Install
```shell
~# apt install gnupg2 oathtool
```

## Encrypt OATH secret with symmetric key
```shell
gpg2 --batch -a -c --passphrase 'passhere' --cipher-algo AES256 --no-symkey-cache secret.txt

or

gpg2 -a -c --cipher-algo AES256 --no-symkey-cache secret.txt
```
  
this gives **`secret.txt.asc`**.  Delete the original **`secret.txt`** or move it to an encrypted backup drive.

## Decrypt and pipe to OATHTOOL
```shell
gpg2 -o - -d -q --no-symkey-cache secret.txt.asc | oathtool -b --totp -

or

gpg2 -o - -d -q --no-symkey-cache secret.txt.asc | oathtool -b --totp - | xclip -i -selection pri -quiet -r 
``` 
  
## Or using the included **`otp.sh`** script
```shell
~$ ./otp.sh -h
./otp.sh /path/to/file.asc

~$ ./otp.sh otp.txt.asc 
Enter passphrase

Passphrase: 
Waiting for selection requests, Control-C to quit
  Waiting for selection request number 1
^C
```

## Additional notes about most TOTP implementations
1. the input secret is `base32` by default
2. the output is 6 digits OTP by default
