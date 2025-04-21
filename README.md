# clean_downloads_folder

## Setup command
```
sudo cp clean_downloads.sh /usr/local/bin/clean_downloads.sh
sudo chmod a+x /usr/local/bin/clean_downloads.sh
```
## Setup cron
```
mkdir -p ~/.local/var/spool/anacron
mkdir -p ~/.local/etc && cp /etc/anacrontab ~/.local/etc
crontab -e
0 * * * *  /usr/sbin/anacron -s -t "${HOME}/.local/etc/anacrontab" -S "${HOME}/.local/var/spool/anacron"
vim .local/etc/anacrontab
1       10      clean.downloads clean_downloads.sh
```
