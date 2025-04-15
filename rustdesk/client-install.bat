@echo off
setlocal

:: RustDesk İstemcisi için Ayarlar
set SERVER_IP=rustdesk.gruparge.com:21115
set PUB_KEY=h6SQOsBm4NxJJ4Uoudf9PpnzqOhX5Ef4bc2N501NYdE=
set PASSWORD=Acer123ert.

:: RustDesk Son Sürümü İndir
echo RustDesk indiriliyor...
curl -L -o RustDesk-Installer.exe https://github.com/rustdesk/rustdesk/releases/download/1.3.9/rustdesk-1.3.9-x86_64.exe

:: Kurulum ve Ayarların Yapılandırılması
echo RustDesk kuruluyor...
RustDesk-Installer.exe /S /server=%SERVER_IP% /key=%PUB_KEY% /password=%PASSWORD%

echo RustDesk kurulumu tamamlandı!
exit
