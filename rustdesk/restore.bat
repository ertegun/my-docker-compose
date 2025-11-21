@echo off
REM RustDesk Restore Script for Windows
REM This script restores RustDesk data from backup

if "%~1"=="" (
    echo Usage: %0 ^<backup_file^>
    echo Available backups:
    dir /b .\backups\rustdesk_backup_*.tar.gz 2>nul
    if errorlevel 1 echo No backups found
    pause
    exit /b 1
)

set BACKUP_FILE=%~1

if not exist "%BACKUP_FILE%" (
    echo Backup file not found: %BACKUP_FILE%
    pause
    exit /b 1
)

echo Restoring from backup: %BACKUP_FILE%
echo WARNING: This will overwrite existing data!
set /p CONFIRM=Are you sure? (y/N): 

if /i not "%CONFIRM%"=="y" (
    echo Restore cancelled.
    pause
    exit /b 1
)

echo Stopping RustDesk containers...
docker-compose down

echo Restoring data...
for %%i in ("%BACKUP_FILE%") do set BACKUP_NAME=%%~nxi
docker run --rm -v rustdesk_rustdesk-data:/data -v rustdesk_rustdesk-api-data:/api-data -v "%cd%:/backup" alpine:latest tar xzf "/backup/%BACKUP_NAME%" -C /

if %errorlevel%==0 (
    echo Restore completed successfully.
    echo Starting RustDesk containers...
    docker-compose up -d
) else (
    echo Restore failed!
    pause
    exit /b 1
)

pause