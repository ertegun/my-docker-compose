@echo off
REM RustDesk Backup Script for Windows
REM This script creates backups of RustDesk data and configuration

setlocal enabledelayedexpansion

REM Load environment variables from .env file
if exist .env (
    for /f "usebackq tokens=1,2 delims==" %%a in (.env) do (
        if not "%%a"=="" if not "%%a:~0,1%"=="#" (
            set "%%a=%%b"
        )
    )
)

set BACKUP_DIR=.\backups
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "DATE=%YYYY%%MM%%DD%_%HH%%Min%%Sec%"
set BACKUP_NAME=rustdesk_backup_%DATE%.tar.gz

REM Create backup directory if it doesn't exist
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

echo Starting RustDesk backup...

REM Create backup using Docker
docker run --rm -v rustdesk_rustdesk-data:/data:ro -v rustdesk_rustdesk-api-data:/api-data:ro -v "%cd%\%BACKUP_DIR%:/backup" alpine:latest tar czf "/backup/%BACKUP_NAME%" -C / data api-data

if %errorlevel%==0 (
    echo Backup created successfully: %BACKUP_DIR%\%BACKUP_NAME%
    
    REM Clean old backups if retention is set
    if defined BACKUP_RETENTION_DAYS (
        echo Cleaning backups older than %BACKUP_RETENTION_DAYS% days...
        forfiles /p "%BACKUP_DIR%" /m rustdesk_backup_*.tar.gz /d -%BACKUP_RETENTION_DAYS% /c "cmd /c del @path" 2>nul
    )
) else (
    echo Backup failed!
    exit /b 1
)

echo Backup completed.
pause