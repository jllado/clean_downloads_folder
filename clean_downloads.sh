#!/bin/bash

FOLDER="$HOME/Downloads"
DAYS=30  # Number of days before delete

find "$FOLDER" -type f -mtime +$DAYS -exec rm -f {} \;

# Delete empty folders
find "$FOLDER" -type d -empty -delete
