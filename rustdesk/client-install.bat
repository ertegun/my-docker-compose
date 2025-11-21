@echo off
setlocal

:: RustDesk İstemcisi için Ayarlar
set SERVER_IP=rustdesk.enerjitakibi.tr:21115
set PUB_KEY=KuFTA5AG8srCMCae8COSnL7qVmKNrkk=
set PASSWORD=HKpZrCMCae8CFs9W

:: RustDesk Son Sürümü İndir (MSI)
echo RustDesk MSI indiriliyor...
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls; [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}; $client = New-Object System.Net.WebClient; $client.Headers.Add('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'); $client.DownloadFile('https://github.com/rustdesk/rustdesk/releases/download/1.4.2/rustdesk-1.4.2-x86_64.msi', 'RustDesk-Installer.msi'); $client.Dispose()"

:: Kurulum ve Ayarların Yapılandırılması
echo RustDesk kuruluyor...
echo MSI dosyası kontrol ediliyor...
if not exist "RustDesk-Installer.msi" (
    echo HATA: MSI dosyası bulunamadı!
    pause
    exit /b 1
)

echo Yönetici yetkileri kontrol ediliyor...
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo HATA: Bu script yönetici yetkisi ile çalıştırılmalıdır!
    echo Sağ tıklayıp "Yönetici olarak çalıştır" seçeneğini kullanın.
    pause
    exit /b 1
)

echo MSI kurulumu başlatılıyor (yönetici yetkisi ile)...
msiexec /i "RustDesk-Installer.msi" /quiet /norestart /L*v rustdesk_install.log ALLUSERS=1
if %errorlevel% neq 0 (
    echo HATA: MSI kurulumu başarısız! Hata kodu: %errorlevel%
    echo Log dosyasını kontrol edin: rustdesk_install.log
    pause
    exit /b %errorlevel%
)

echo RustDesk ayarları yapılandırılıyor...
timeout /t 3 /nobreak > nul

:: RustDesk ayarlarını yapılandır
if exist "%USERPROFILE%\AppData\Roaming\RustDesk\config\RustDesk2.toml" (
    echo Konfigürasyon dosyası bulundu, ayarlar yapılandırılıyor...
    powershell -Command "(Get-Content '%USERPROFILE%\AppData\Roaming\RustDesk\config\RustDesk2.toml') -replace 'relay-server.*', 'relay-server = \"%SERVER_IP%\"' -replace 'key.*', 'key = \"%PUB_KEY%\"' | Set-Content '%USERPROFILE%\AppData\Roaming\RustDesk\config\RustDesk2.toml'"
) else (
    echo Konfigürasyon dosyası bulunamadı, manuel ayar gerekli.
)

echo RustDesk kurulumu tamamlandı!
pause