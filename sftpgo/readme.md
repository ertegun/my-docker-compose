docker-compose up -d

volume oluşmaz ise host ta şu komutları çalıştır

- docker run --rm drakkan/sftpgo:latest id
  Örnek çıktı:
  uid=1000(sftpgo) gid=1000(sftpgo) groups=1000(sftpgo)
  Eğer uid=1000 ise şu komutla klasör sahipliğini düzelt:
- sudo chown -R 1000:1000 sftpgodata sftpgohome
- docker compose down
- docker compose up -d
