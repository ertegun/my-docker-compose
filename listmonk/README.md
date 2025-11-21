# Listmonk Docker Compose Setup (Single Node)

Bu klasör Listmonk email pazarlama platformunun tek node Docker Compose ile kurulumu için gerekli dosyaları içerir.

## Kurulum

1. `.env` dosyasındaki şifreleri değiştirin:

   ```bash
   # .env dosyasını düzenleyin
   POSTGRES_PASSWORD=your_super_secure_password_here_123!
   LISTMONK_ADMIN_PASSWORD=your_admin_password_here_456!
   ```

2. Gerekli klasörleri oluşturun:

   ```powershell
   # Windows PowerShell
   mkdir uploads, logs

   # veya Linux/Mac
   mkdir uploads logs
   ```

3. Servisleri başlatın:

   ```bash
   docker compose up -d
   ```

4. Listmonk'a erişin: http://localhost:9009

## Önemli Güvenlik Notları

- ⚠️ **Mutlaka şifreleri değiştirin!** Varsayılan şifreler production için güvenli değil
- 🔒 SSL sertifikası ekleyin (nginx proxy manager önerilir)
- 🌐 Firewall kurallarını kontrol edin
- 📧 SMTP ayarlarını yapılandırın

## Monitoring

### Logları kontrol etme:

```bash
docker compose logs -f app
docker compose logs -f db
```

### Servis durumu:

```bash
docker compose ps
```

## Production Checklist

- [ ] Şifreler değiştirildi
- [ ] SSL/TLS yapılandırıldı
- [ ] SMTP ayarları yapıldı
- [ ] Monitoring kuruldu
- [ ] Firewall kuralları kontrol edildi
- [ ] Domain/subdomain yapılandırıldı

## Troubleshooting

### Container başlatma sorunları:

```bash
docker compose down
docker compose up -d
```

### Database bağlantı sorunları:

```bash
docker exec listmonk_db pg_isready -U listmonk
```

### Log dosyalarını temizleme:

```bash
docker compose down
docker system prune -f
```
