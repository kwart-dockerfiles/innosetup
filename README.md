# InnoSetup for Java apps

Docker image which helps building Windows installer for Java apps.

## Signing the installer

The [osslsigncode](https://github.com/mtrojnar/osslsigncode) is installed in the image.

```bash
# sign the installer
docker run --rm -v `pwd`:/mnt kwart/innosetup \
  osslsigncode sign \
    -n "App Name" -i http://app.url.org/ \
    -certs /mnt/cert.crt -key /mnt/key.key \
    -in /mnt/installer.exe \
    -out /mnt/installer-signed.exe
```
