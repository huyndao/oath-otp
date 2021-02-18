# otp.sh
Shell script to generate Time Based One Time Password [(TOTP)](https://en.wikipedia.org/wiki/Time-based_One-time_Password_algorithm) which is used for 2 Factor Authentication by many services.

The below is a guide to safely store the OTP secret and a shell script to generate the TOTP into clipboard for use to authenticate with many online services.

## Requirements
- GNUPG v2
- oathtool
- xclip

## Install
```shell
~# apt install gnupg2 oathtool xclip
```

## Encrypt OATH secret with symmetric key
```shell
gpg2 --batch -a -c --passphrase 'passhere' --cipher-algo AES256 --no-symkey-cache secret.txt
```

or

```shell
gpg2 -a -c --cipher-algo AES256 --no-symkey-cache secret.txt
```
  
this gives **`secret.txt.asc`**.  Delete the original **`secret.txt`** or move it to an encrypted backup drive.

## Decrypt and pipe to OATHTOOL
```shell
gpg2 -o - -d -q --no-symkey-cache secret.txt.asc | oathtool -b --totp -
```

or

```shell
gpg2 -o - -d -q --no-symkey-cache secret.txt.asc | oathtool -b --totp - | xclip -i -sel clip -r 
``` 
  
## Or using the included **`otp.sh`** script
### Help

```shell
~$ ./otp.sh -h
./otp.sh /path/to/file.asc
```

### Example Use

```shell
~$ ./otp.sh secret.txt.asc 
Enter passphrase

Passphrase: 
```

Go to webpage and do `Ctrl + v` to paste in the OTP

## Additional notes about most TOTP implementations
1. the input secret is `base32` by default
2. the output is 6 digits OTP by default
3. the TOTP time-step duration is 30 seconds by default
