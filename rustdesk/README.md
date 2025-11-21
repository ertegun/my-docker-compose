# RustDesk Server Docker Setup

Bu proje, RustDesk server'ını Docker kullanarak kurmanızı sağlar. RustDesk, açık kaynaklı bir uzaktan masaüstü erişim çözümüdür.

## 🚀 Hızlı Başlangıç

### Ön Gereksinimler

- Docker ve Docker Compose yüklü olmalı
- Ports 21114-21119 açık olmalı
- Domain name (opsiyonel ama önerilen)

### Kurulum

1. **Repository'yi klonlayın:**

   ```bash
   git clone <repository-url>
   cd rustdesk
   ```

2. **Environment dosyasını hazırlayın:**

   ```bash
   cp .env.example .env
   # .env dosyasını düzenleyin
   ```

3. **Servisi başlatın:**

   ```bash
   docker-compose up -d
   ```

4. **Durumu kontrol edin:**
   ```bash
   docker-compose ps
   docker-compose logs -f
   ```

## 📋 Konfigürasyon

### Environment Variables (.env)

| Variable         | Description      | Default               |
| ---------------- | ---------------- | --------------------- |
| `TZ`             | Timezone         | Asia/Istanbul         |
| `DOMAIN`         | Your domain name | rustdesk.gruparge.com |
| `ENCRYPTED_ONLY` | Force encryption | 1                     |
| `MUST_LOGIN`     | Require login    | N                     |
| `JWT_KEY`        | JWT secret key   | Random key            |
| `RUST_LOG`       | Log level        | info                  |

### Port Mapping

| Port  | Service       | Description         |
| ----- | ------------- | ------------------- |
| 21114 | API Server    | Web API endpoint    |
| 21115 | NAT Test      | NAT type detection  |
| 21116 | ID/Rendezvous | Client registration |
| 21117 | Relay Server  | Data relay          |
| 21118 | WebSocket     | Web interface       |
| 21119 | File Transfer | File sharing        |

## 🔧 Yönetim Komutları

### Servis Yönetimi

```bash
# Servisi başlat
docker-compose up -d

# Servisi durdur
docker-compose down

# Logları görüntüle
docker-compose logs -f

# Servisi yeniden başlat
docker-compose restart

# Durum kontrolü
docker-compose ps
```

### Güncelleme

```bash
# Image'ları güncelle
docker-compose pull
docker-compose up -d

# Kullanılmayan image'ları temizle
docker image prune
```

## 💾 Yedekleme ve Geri Yükleme

### Yedekleme

```bash
# Linux/Mac
./backup.sh

# Windows
backup.bat
```

### Geri Yükleme

```bash
# Linux/Mac
./restore.sh backups/rustdesk_backup_20241002_120000.tar.gz

# Windows
restore.bat backups\rustdesk_backup_20241002_120000.tar.gz
```

## 🔒 Güvenlik

### SSL/TLS Konfigürasyonu

Üretim ortamında SSL kullanımı önerilir. Nginx Proxy Manager veya Traefik kullanabilirsiniz.

### Firewall Kuralları

```bash
# UFW örneği
sudo ufw allow 21114:21119/tcp
sudo ufw allow 21116/udp
```

### JWT Key Güvenliği

- `.env` dosyasındaki JWT_KEY'i değiştirin
- En az 32 karakter uzunluğunda olmalı
- Güçlü, rastgele bir key kullanın

## 🐛 Sorun Giderme

### Yaygın Sorunlar

1. **Bağlantı kurulamıyor:**

   - Port'ların açık olduğunu kontrol edin
   - Firewall ayarlarını kontrol edin
   - Domain DNS ayarlarını kontrol edin

2. **Yüksek CPU/Memory kullanımı:**

   - Resource limitlerini kontrol edin
   - Log seviyesini düşürün
   - Client sayısını kontrol edin

3. **Dosya transfer çalışmıyor:**
   - Port 21119'un açık olduğunu kontrol edin
   - Network konfigürasyonunu kontrol edin

### Log Analizi

```bash
# Tüm logları görüntüle
docker-compose logs

# Sadece error logları
docker-compose logs | grep -i error

# Son 100 satır
docker-compose logs --tail 100

# Canlı log takibi
docker-compose logs -f
```

### Health Check

```bash
# Servis sağlığını kontrol et
curl -f http://localhost:21114/api/health

# Container durumunu kontrol et
docker inspect rustdesk-all-in-one --format='{{.State.Health.Status}}'
```

## 🔧 Development

Development ortamı için:

```bash
# Development compose ile başlat
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d

# Debug logları görüntüle
docker-compose logs -f
```

## 📊 Monitoring

### Prometheus Metrics

RustDesk server metrics için Prometheus endpoint'i mevcutsa:

```
http://localhost:21114/metrics
```

### Log Rotation

Logların büyümesini önlemek için log rotation konfigüre edin:

```yaml
# docker-compose.yml'ye ekleyin
logging:
  driver: "json-file"
  options:
    max-size: "10m"
    max-file: "3"
```

## 🤝 Katkıda Bulunma

1. Fork edin
2. Feature branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Commit edin (`git commit -m 'Add amazing feature'`)
4. Push edin (`git push origin feature/amazing-feature`)
5. Pull Request açın

## 📄 Lisans

Bu proje MIT lisansı altında lisanslanmıştır.

## 🔗 Faydalı Linkler

- [RustDesk Official Documentation](https://rustdesk.com/docs/)
- [RustDesk GitHub](https://github.com/rustdesk/rustdesk)
- [Docker Hub](https://hub.docker.com/r/lejianwen/rustdesk-server-s6)

## ⚡ Performance Tips

1. **Resource Optimization:**

   - Container resource limitlerini ayarlayın
   - SSD kullanın data volume'ları için
   - Yeterli RAM ayırın

2. **Network Optimization:**

   - Dedicated network kullanın
   - UDP buffer size'ı optimize edin
   - QoS ayarları yapın

3. **Security Best Practices:**
   - Düzenli güvenlik güncellemeleri
   - Strong password policy
   - VPN kullanımı (opsiyonel)
   - Regular backup'lar
