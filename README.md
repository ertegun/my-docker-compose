#BACKUP VOLUME

docker run --rm --volumes-from chirpstack-docker_redis_1 -v $(pwd):/backup redis:5-alpine tar cvf /backup/redis_backup.tar /data
docker run --rm --volumes-from chirpstack-docker_postgresql_1 -v $(pwd):/backup postgres:9.6-alpine tar cvf /backup/postgresql_backup.tar /var/lib/postgresql/data

#RESTORE VOLUME

docker run --rm --volumes-from chirpstack-docker_redis_1 -v $(pwd):/backup redis:5-alpine ash -c "cd /data && tar xvf /backup/redis_backup.tar --strip 1"
docker run --rm --volumes-from chirpstack-docker_postgresql_1 -v $(pwd):/backup postgres:9.6-alpine ash -c "cd /var/lib/postgresql/data && tar xvf /backup/postgresql_backup.tar --strip 4"

--strip X => volume yolunda X tane içiçe klasör varsa

MATTERMOST BACKUP&RESTORE
docker run --rm --volumes-from moga -v $(pwd):/backup mattermost/mattermost-preview:latest tar cvf /backup/mattermost-data.tar /mm/mattermost-data
docker run --rm --volumes-from moga -v $(pwd):/backup mattermost/mattermost-preview:latest tar cvf /backup/mattermost-mysql.tar /var/lib/mysql

docker run --rm --volumes-from mantis_mantisbt_1/mantis_mysql_1 -v $(pwd):/backup mysql:5.7 tar cvf /backup/mantis-data.tar /var/lib/mysql

GUACAMOLE
