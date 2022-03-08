#BACKUP VOLUME

docker run --rm --volumes-from chirpstack-docker_redis_1 -v $(pwd):/backup redis:5-alpine tar cvf /backup/redis_backup.tar /data
docker run --rm --volumes-from chirpstack-docker_postgresql_1 -v $(pwd):/backup postgres:9.6-alpine tar cvf /backup/postgresql_backup.tar /var/lib/postgresql/data

#RESTORE VOLUME

docker run --rm --volumes-from chirpstack-docker_redis_1 -v $(pwd):/backup redis:5-alpine ash -c "cd /data && tar xvf /backup/redis_backup.tar --strip 1"
docker run --rm --volumes-from chirpstack-docker_postgresql_1 -v $(pwd):/backup postgres:9.6-alpine ash -c "cd /var/lib/postgresql/data && tar xvf /backup/postgresql_backup.tar --strip 4"

--strip X => volume yolunda X tane içiçe klasör varsa
