# SmartPower Docker/Podman Deployment

Bu proje hem Docker Compose hem de Podman Compose ile deploy edilebilir. Her iki ortam için optimize edilmiş YAML anchor'ları kullanılmıştır.

## 🐳 Docker Deployment (Debian Tabanlı Sistemler)

```bash
# Docker Compose kullanarak çalıştır
docker-compose up -d

# Servisleri durdur
docker-compose down
```

**Özellikler:**

- Service-based networking (spnet)
- Healthcheck mekanizması
- Service dependencies

## 🔄 Podman Deployment (RHEL Tabanlı Sistemler)

```bash
# Podman Compose kullanarak çalıştır
podman-compose --env-file .env.podman up -d

# Servisleri durdur
podman-compose --env-file .env.podman down
```

**Özellikler:**

- Host networking mode
- Custom waiter container (healthcheck yerine)
- SELinux volume bindings (:Z)

## 📁 Dosya Yapısı

```
├── docker-compose.yml     # Docker için optimize edilmiş
├── podman-compose.yml     # Podman için optimize edilmiş
├── .env                   # Docker environment variables
├── .env.podman           # Podman environment variables
└── README.md             # Bu dosya
```

## 🔧 Environment Variables

### Docker (.env)

```env
MYSQL_HOST=mysql           # Service adı
RABBITMQ_HOST=rabbitmq     # Service adı
MONGODB_HOST=mongo         # Service adı
MQTT_BROKER_ADDRESS=sp-mqtt # Service adı
```

### Podman (.env.podman)

```env
MYSQL_HOST=localhost       # Host networking
RABBITMQ_HOST=localhost    # Host networking
MONGODB_HOST=localhost     # Host networking
MQTT_BROKER_ADDRESS=localhost # Host networking
```

## 🎯 YAML Anchors Optimizasyonu

Her iki dosyada da şu anchor'lar kullanılmıştır:

- **`x-mysql-connections`**: MySQL connection string'leri
- **`x-rabbitmq-settings`**: RabbitMQ bağlantı ayarları
- **`x-mqtt-credentials`**: MQTT kimlik bilgileri
- **`x-mqtt-settings`**: MQTT client ayarları
- **`x-mqtt-server-settings`**: MQTT server ayarları
- **`x-mongodb-settings`**: MongoDB bağlantı ayarları
- **`x-dotnet-env`**: .NET runtime ayarları
- **`x-common-service`**: Ortak service ayarları

## 🚀 Portlar

| Servis        | Docker Port | Podman Port | Açıklama            |
| ------------- | ----------- | ----------- | ------------------- |
| sp-iot        | 4444        | 4444        | IoT Device Manager  |
| sp-websocket  | 54738       | 5057        | WebSocket Server    |
| sp-mqtt       | 1883        | 1883        | MQTT Broker         |
| mysql         | 3306        | 3306        | MySQL Database      |
| phpmyadmin    | 4446        | 8080        | MySQL Admin         |
| rabbitmq      | 4449        | 15672       | RabbitMQ Management |
| mongo         | 4443        | 27017       | MongoDB             |
| mongo-express | 4448        | 8081        | MongoDB Admin       |

## 🔍 Troubleshooting

### Docker Issues

```bash
# Logları kontrol et
docker-compose logs -f [service_name]

# Servislerin durumunu kontrol et
docker-compose ps
```

### Podman Issues

```bash
# Logları kontrol et
podman-compose --env-file .env.podman logs -f [service_name]

# Waiter container durumunu kontrol et (healthcheck yerine)
podman logs sp-waiter
```

## 🎨 Avantajlar

- **DRY Prensibi**: Tekrarlanan konfigürasyonlar tek yerde
- **Merkezi Yönetim**: Environment variables tek yerden
- **Platform Esnekliği**: Docker ve Podman desteği
- **Tutarlılık**: Aynı ayarlar her iki ortamda da
