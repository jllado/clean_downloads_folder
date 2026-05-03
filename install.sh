#!/bin/bash

set -euo pipefail

SCRIPT_SOURCE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_SCRIPT="$SCRIPT_SOURCE/clean_downloads.sh"
TARGET_SCRIPT="/usr/local/bin/clean_downloads.sh"
ANACRON_DIR="$HOME/.local/var/spool/anacron"
ANACRONTAB_DIR="$HOME/.local/etc"
ANACRONTAB_FILE="$ANACRONTAB_DIR/anacrontab"
CRON_LINE='0 * * * * /usr/sbin/anacron -s -t "${HOME}/.local/etc/anacrontab" -S "${HOME}/.local/var/spool/anacron"'
ANACRON_JOB='1       10      clean.downloads /usr/local/bin/clean_downloads.sh'

if [ ! -f "$SOURCE_SCRIPT" ]; then
  echo "Missing source script: $SOURCE_SCRIPT" >&2
  exit 1
fi

sudo cp "$SOURCE_SCRIPT" "$TARGET_SCRIPT"
sudo chmod a+x "$TARGET_SCRIPT"

mkdir -p "$ANACRON_DIR" "$ANACRONTAB_DIR"

if [ ! -f "$ANACRONTAB_FILE" ]; then
  cp /etc/anacrontab "$ANACRONTAB_FILE"
fi

if ! grep -Fqx "$ANACRON_JOB" "$ANACRONTAB_FILE"; then
  printf '\n%s\n' "$ANACRON_JOB" >> "$ANACRONTAB_FILE"
fi

CURRENT_CRONTAB="$(mktemp)"
UPDATED_CRONTAB="$(mktemp)"
trap 'rm -f "$CURRENT_CRONTAB" "$UPDATED_CRONTAB"' EXIT

if crontab -l > "$CURRENT_CRONTAB" 2>/dev/null; then
  :
else
  : > "$CURRENT_CRONTAB"
fi

cp "$CURRENT_CRONTAB" "$UPDATED_CRONTAB"

if ! grep -Fqx "$CRON_LINE" "$CURRENT_CRONTAB"; then
  printf '%s\n' "$CRON_LINE" >> "$UPDATED_CRONTAB"
fi

crontab "$UPDATED_CRONTAB"

echo "Installed $TARGET_SCRIPT"
echo "Updated $ANACRONTAB_FILE"
echo "Updated user crontab"
