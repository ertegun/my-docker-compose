#!/bin/bash
# RustDesk Restore Script
# This script restores RustDesk data from backup

if [ $# -eq 0 ]; then
    echo "Usage: $0 <backup_file>"
    echo "Available backups:"
    ls -la ./backups/rustdesk_backup_*.tar.gz 2>/dev/null || echo "No backups found"
    exit 1
fi

BACKUP_FILE="$1"

if [ ! -f "$BACKUP_FILE" ]; then
    echo "Backup file not found: $BACKUP_FILE"
    exit 1
fi

echo "Restoring from backup: $BACKUP_FILE"
echo "WARNING: This will overwrite existing data!"
read -p "Are you sure? (y/N): " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Restore cancelled."
    exit 1
fi

echo "Stopping RustDesk containers..."
docker-compose down

echo "Restoring data..."
docker run --rm \
    -v rustdesk_rustdesk-data:/data \
    -v rustdesk_rustdesk-api-data:/api-data \
    -v "$(pwd):/backup" \
    alpine:latest tar xzf "/backup/$(basename $BACKUP_FILE)" -C /

if [ $? -eq 0 ]; then
    echo "Restore completed successfully."
    echo "Starting RustDesk containers..."
    docker-compose up -d
else
    echo "Restore failed!"
    exit 1
fi