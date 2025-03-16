# clean_downloads_folder

## Service setup
```
sudo cp clean_downloads.sh /usr/local/bin/clean_downloads.sh
sudo cp clean_downloads.service /etc/systemd/system/clean_downloads.service
sudo cp clean_downloads.timer /etc/systemd/system/clean_downloads.timer
sudo systemctl daemon-reload
sudo systemctl enable clean_downloads.timer
sudo systemctl start clean_downloads.timer
```
