# clean_downloads_folder

Delete files older than 30 days from `~/Downloads` and remove empty directories.

## Install

Run:

```bash
bash install.sh
```

The installer:

- installs `clean_downloads.sh` to `/usr/local/bin/clean_downloads.sh`
- creates the user-level `anacron` directories under `~/.local`
- adds an hourly `crontab` entry to run `anacron`
- adds an `anacrontab` job that runs the cleanup script every day

The script deletes files permanently.

## What Gets Installed

Installed script:

```text
/usr/local/bin/clean_downloads.sh
```

Hourly `crontab` entry:

```cron
0 * * * * /usr/sbin/anacron -s -t "${HOME}/.local/etc/anacrontab" -S "${HOME}/.local/var/spool/anacron"
```

User `anacrontab` entry:

```text
1       10      clean.downloads /usr/local/bin/clean_downloads.sh
```

## Manual Setup

If you do not want to use `install.sh`, run:

```bash
sudo cp clean_downloads.sh /usr/local/bin/clean_downloads.sh
sudo chmod a+x /usr/local/bin/clean_downloads.sh

mkdir -p ~/.local/var/spool/anacron
mkdir -p ~/.local/etc
cp /etc/anacrontab ~/.local/etc/anacrontab
```

Then add this line to your `crontab`:

```cron
0 * * * * /usr/sbin/anacron -s -t "${HOME}/.local/etc/anacrontab" -S "${HOME}/.local/var/spool/anacron"
```

And add this line to `~/.local/etc/anacrontab`:

```text
1       10      clean.downloads /usr/local/bin/clean_downloads.sh
```
