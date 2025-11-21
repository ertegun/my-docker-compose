#!/bin/bash
# RustDesk Backup Script
# This script creates backups of RustDesk data and configuration

# Load environment variables
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

BACKUP_DIR="./backups"
DATE=$(date +"%Y%m%d_%H%M%S")
BACKUP_NAME="rustdesk_backup_${DATE}.tar.gz"

# Create backup directory if it doesn't exist
mkdir -p "${BACKUP_DIR}"

echo "Starting RustDesk backup..."

# Create backup
docker run --rm \
    -v rustdesk_rustdesk-data:/data:ro \
    -v rustdesk_rustdesk-api-data:/api-data:ro \
    -v "$(pwd)/${BACKUP_DIR}:/backup" \
    alpine:latest tar czf "/backup/${BACKUP_NAME}" -C / data api-data

if [ $? -eq 0 ]; then
    echo "Backup created successfully: ${BACKUP_DIR}/${BACKUP_NAME}"
    
    # Clean old backups if retention is set
    if [ ! -z "${BACKUP_RETENTION_DAYS}" ]; then
        echo "Cleaning backups older than ${BACKUP_RETENTION_DAYS} days..."
        find "${BACKUP_DIR}" -name "rustdesk_backup_*.tar.gz" -mtime +${BACKUP_RETENTION_DAYS} -delete
    fi
else
    echo "Backup failed!"
    exit 1
fi

echo "Backup completed."