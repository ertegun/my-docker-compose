# Portainer Docker Compose

Bu klasör Portainer CE (Community Edition) için Docker Compose konfigürasyonunu içerir.

## Başlatma

### Docker Compose ile (Önerilen)

```bash
docker-compose up -d
```

### Docker Run ile (Alternatif)

```bash
docker run -d \
  --name portainer \
  --restart=always \
  -p 9000:9000 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  -e EDGE_INSECURE_POLL=1 \
  portainer/portainer-ce
```

## Erişim

Portainer'a aşağıdaki adresten erişebilirsiniz:

```
http://localhost:9000
```

## Durdurma

```bash
docker-compose down
```

## Notlar

- `portainer_data` volume'ü Portainer'ın ayarlarını ve verilerini saklar
- Docker socket mount edilerek host Docker daemon'a erişim sağlanır
- `EDGE_INSECURE_POLL=1` ayarı Edge agent güvenlik ayarıdır
