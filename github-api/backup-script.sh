#!/bin/bash

#####################################################
# About: This script will take backup and it will delete backup older than 30 days...
# Owner: Mohd Imran Mohd Yousuf
#####################################################

# Define Source and Backup Path
SOURCE_DIR="/home/Smicc_DevOps/src_dir/"
BACKUP_PATH="/home/Smicc_DevOps/script/backup/"

# Log file path
LOG_FILE="/home/Smicc_DevOps/script/backup/backup.log"

# This function will display the help regarding backup script.
show_help() {
        echo "Usage: $0 this script will take backup and it will delete backup older than 30 days"
        echo "This script will take backup between 15 to 30 days older files"
        echo "$BACKUP_PATH here all the backups will store"
        echo "SOURCE_DIR in this variable mention the path from where the backup should take place"
        echo "$BACKUP_PATH from here it will delete the backup which is older than 30 days"
}

# Check if the first argument is "--help"
if [ "$1" = "--help" ]; then
    show_help
    exit 0
fi

# Check if SOURCE DIRECTORY is provided
if [ -z "$SOURCE_DIR" ]; then
        echo "$(date +"%Y-%m-%d %T"): Error: Source directory is not provided..." >> "$LOG_FILE"
        echo "Usage: Place the source directory path in SOURCE_DIR variable..." >> "$LOG_FILE"
        exit 1
fi

# Check if BACKUP DIRECTORY is provided
if [ -z "$BACKUP_PATH" ]; then
        echo "$(date +"%Y-%m-%d %T"): Error: Destination directory is not provided..." >> "$LOG_FILE"
        echo "Usage: Place the Destination directory path in DESTINATION_DIR variable..." >> "$LOG_FILE"
        exit 1
fi

# Set date parameters for 15 and 30 days ago
BACKUP_START_DATE=$(date -d "15 days ago" +%Y%m%d)
BACKUP_END_DATE=$(date -d "30 days ago" +%Y%m%d)

# Archive files between 15 to 30 days old
ZIP_FILENAME="BACKUP_$(date +%Y%m%d_%H%M%S).zip"
find "$SOURCE_DIR" -type f -newermt "$BACKUP_END_DATE" ! -newermt "$BACKUP_START_DATE" -exec zip -r "$BACKUP_PATH/$ZIP_FILENAME" {} + >> "$LOG_FILE" 2>&1

echo "$(date +"%Y-%m-%d %T"): Backup completed successfully..." >> "$LOG_FILE"

# Delete backups that are older than 30 days
find "$BACKUP_PATH" -name "BACKUP_*.zip" -type f -mtime +30 -exec rm {} \; >> "$LOG_FILE" 2>&1
echo "Backup older than 30 days deleted..." >> "$LOG_FILE"
