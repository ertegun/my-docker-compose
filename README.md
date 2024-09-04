#BACKUP VOLUME

docker run --rm --volumes-from chirpstack-docker_redis_1 -v $(pwd):/backup redis:5-alpine tar cvf /backup/redis_backup.tar /data
docker run --rm --volumes-from chirpstack-docker_postgresql_1 -v $(pwd):/backup postgres:9.6-alpine tar cvf /backup/postgresql_backup.tar /var/lib/postgresql/data
docker run --rm --volumes-from chirpstack-docker_postgresql_1 -v $(pwd):/backup postgres:9.6-alpine tar cvf /backup/postgresql_backup2.tar /docker-entrypoint-initdb.d

docker run --rm --volumes-from chirpstack-docker_mosquitto_1 -v $(pwd):/backup eclipse-mosquitto:2 tar cvf /backup/chirpstack-docker_mosquitto_1_conf.tar /mosquitto/config/mosquitto.conf
docker run --rm --volumes-from chirpstack-docker_mosquitto_1 -v $(pwd):/backup eclipse-mosquitto:2 tar cvf /backup/chirpstack-docker_mosquitto_1_data.tar /mosquitto/data
docker run --rm --volumes-from chirpstack-docker_mosquitto_1 -v $(pwd):/backup eclipse-mosquitto:2 tar cvf /backup/chirpstack-docker_mosquitto_1_log.tar /mosquitto/log

docker run --rm --volumes-from chirpstack-docker_chirpstack-network-server_1 -v $(pwd):/backup chirpstack/chirpstack-network-server:3 tar cvf /backup/network-server-certs.tar /etc/chirpstack-network-server/certs

#RESTORE VOLUME

docker run --rm --volumes-from chirpstack-docker_redis_1 -v $(pwd):/backup redis:5-alpine ash -c "cd /data && tar xvf /backup/redis_backup.tar --strip 1"
docker run --rm --volumes-from chirpstack-docker_postgresql_1 -v $(pwd):/backup postgres:9.6-alpine ash -c "cd /var/lib/postgresql/data && tar xvf /backup/postgresql_backup.tar --strip 4"

--strip X => volume yolunda X tane içiçe klasör varsa

MATTERMOST BACKUP&RESTORE
docker run --rm --volumes-from moga -v $(pwd):/backup mattermost/mattermost-preview:latest tar cvf /backup/mattermost-data.tar /mm/mattermost-data
docker run --rm --volumes-from moga -v $(pwd):/backup mattermost/mattermost-preview:latest tar cvf /backup/mattermost-mysql.tar /var/lib/mysql

MANTİS
docker run --rm --volumes-from mantis_mantisbt_1/mantis_mysql_1 -v $(pwd):/backup mysql:5.7 tar cvf /backup/mantis-data.tar /var/lib/mysql

GUACAMOLE

NEXTCLOUD BACKUP&RESTORE
docker run --rm --volumes-from nextcloud_db_1 -v $(pwd):/backup mariadb:latest tar cvf /backup/nextcloud-mysql.tar /var/lib/mysql

docker run --rm --volumes-from moga -v $(pwd):/backup mattermost/mattermost-preview:latest tar cvf /backup/mattermost-data.tar /mm/mattermost-data

---

docker run --rm --volumes-from chirpstack-docker_chirpstack-application-server_1 -v $(pwd):/backup chirpstack/chirpstack-application-server:3.17 tar cvf backup/chirpstack-application-server.tar /etc/chirpstack-application-server

mysql -u mmuser -p mattermost_test < mattermost_test.sql

mysqldump -u mmuser -p mattermost_test > mattermost_test.sql
