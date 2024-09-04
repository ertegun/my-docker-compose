Her sunucu için kullanıcı oluşturuyoruz.

```plaintext
docker exec -it sp_mysql_1 mysql -uroot -pErtesulomuro2023 -e "CREATE USER 'ga_cluster'@'%' IDENTIFIED BY 'ga_cluster_2023';" -e "GRANT ALL privileges ON *.* TO 'ga_cluster'@'%' with grant option;" -e "reset master;"
```

```plaintext
docker exec -it sp_mysql_2 mysql -uroot -pErtesulomuro2023 -e "CREATE USER 'ga_cluster'@'%' IDENTIFIED BY 'ga_cluster_2023';" -e "GRANT ALL privileges ON *.* TO 'ga_cluster'@'%' with grant option;" -e "reset master;"
```

```plaintext
docker exec -it sp_mysql_3 mysql -uroot -pErtesulomuro2023 -e "CREATE USER 'ga_cluster'@'%' IDENTIFIED BY 'ga_cluster_2023';" -e "GRANT ALL privileges ON *.* TO 'ga_cluster'@'%' with grant option;" -e "reset master;"
```

Mysql SH işlemleri

```plaintext
docker exec -it sp_mysql_1 mysqlsh -uga_cluster -pga_cluster_2023 -S /var/run/mysqld/mysqlx.sock
```

Instance kullanılabilirlik durumu check ediliyor

```plaintext
ga_cluster_2023
dba.checkInstanceConfiguration("ga_cluster@sp_mysql_1:3306")
dba.checkInstanceConfiguration("ga_cluster@sp_mysql_2:3306")
dba.checkInstanceConfiguration("ga_cluster@sp_mysql_3:3306")
```

Instance ler configure ediliyor(tanımlanıyor)

```plaintext
dba.configureInstance("ga_cluster@sp_mysql_1:3306")
dba.configureInstance("ga_cluster@sp_mysql_2:3306")
dba.configureInstance("ga_cluster@sp_mysql_3:3306")
```

```plaintext
var cluster = dba.createCluster("sp_cluster");
cluster.status(); // Eğer ayağa kalkmışsa aşağıdaki işlemlere devam edilecek.
Configure edilen Instance ler cluster a ekleniyor
cluster.addInstance("ga_cluster@sp_mysql_2:3306")
cluster.addInstance("ga_cluster@sp_mysql_3:3306")
```
