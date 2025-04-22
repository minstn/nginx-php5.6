# Docker nginx + php5.6-fpm on ubuntu:24.04 image

Docker image based on `Ubuntu:24.04` version. Using `nginx stable` version with `php 5.6`.
Good for legacy apps based on php5.6 like cakephp projects etc.
If you have an idea how to improve it, contact me <minstn@gmail.com>.
Webroot is set to `/var/www/app/webroot`, good for cakephp apps.

## Includes `php5.6-fpm` modules:

```
lrwxrwxrwx 1 root root   39 Apr 20 15:08 10-mysqlnd.ini -> /etc/php/5.6/mods-available/mysqlnd.ini
lrwxrwxrwx 1 root root   39 Apr 20 15:08 10-opcache.ini -> /etc/php/5.6/mods-available/opcache.ini
lrwxrwxrwx 1 root root   35 Apr 20 15:08 10-pdo.ini -> /etc/php/5.6/mods-available/pdo.ini
lrwxrwxrwx 1 root root   35 Apr 20 15:08 15-xml.ini -> /etc/php/5.6/mods-available/xml.ini
lrwxrwxrwx 1 root root   36 Apr 20 15:08 20-amqp.ini -> /etc/php/5.6/mods-available/amqp.ini
lrwxrwxrwx 1 root root   36 Apr 20 15:08 20-apcu.ini -> /etc/php/5.6/mods-available/apcu.ini
lrwxrwxrwx 1 root root   38 Apr 20 15:08 20-bcmath.ini -> /etc/php/5.6/mods-available/bcmath.ini
lrwxrwxrwx 1 root root   40 Apr 20 15:08 20-calendar.ini -> /etc/php/5.6/mods-available/calendar.ini
lrwxrwxrwx 1 root root   37 Apr 20 15:08 20-ctype.ini -> /etc/php/5.6/mods-available/ctype.ini
lrwxrwxrwx 1 root root   36 Apr 20 15:08 20-curl.ini -> /etc/php/5.6/mods-available/curl.ini
lrwxrwxrwx 1 root root   35 Apr 20 15:08 20-dom.ini -> /etc/php/5.6/mods-available/dom.ini
lrwxrwxrwx 1 root root   36 Apr 20 15:08 20-exif.ini -> /etc/php/5.6/mods-available/exif.ini
lrwxrwxrwx 1 root root   40 Apr 20 15:08 20-fileinfo.ini -> /etc/php/5.6/mods-available/fileinfo.ini
lrwxrwxrwx 1 root root   35 Apr 20 15:08 20-ftp.ini -> /etc/php/5.6/mods-available/ftp.ini
lrwxrwxrwx 1 root root   34 Apr 20 15:09 20-gd.ini -> /etc/php/5.6/mods-available/gd.ini
lrwxrwxrwx 1 root root   39 Apr 20 15:08 20-gettext.ini -> /etc/php/5.6/mods-available/gettext.ini
lrwxrwxrwx 1 root root   37 Apr 20 15:08 20-iconv.ini -> /etc/php/5.6/mods-available/iconv.ini
lrwxrwxrwx 1 root root   40 Apr 20 15:08 20-igbinary.ini -> /etc/php/5.6/mods-available/igbinary.ini
lrwxrwxrwx 1 root root   39 Apr 20 15:09 20-imagick.ini -> /etc/php/5.6/mods-available/imagick.ini
lrwxrwxrwx 1 root root   36 Apr 20 15:08 20-intl.ini -> /etc/php/5.6/mods-available/intl.ini
lrwxrwxrwx 1 root root   36 Apr 20 15:08 20-json.ini -> /etc/php/5.6/mods-available/json.ini
lrwxrwxrwx 1 root root   36 Apr 20 15:08 20-ldap.ini -> /etc/php/5.6/mods-available/ldap.ini
lrwxrwxrwx 1 root root   40 Apr 20 15:08 20-mbstring.ini -> /etc/php/5.6/mods-available/mbstring.ini
lrwxrwxrwx 1 root root   38 Apr 20 15:08 20-mcrypt.ini -> /etc/php/5.6/mods-available/mcrypt.ini
lrwxrwxrwx 1 root root   40 Apr 20 15:08 20-memcache.ini -> /etc/php/5.6/mods-available/memcache.ini
lrwxrwxrwx 1 root root   39 Apr 20 15:08 20-msgpack.ini -> /etc/php/5.6/mods-available/msgpack.ini
lrwxrwxrwx 1 root root   37 Apr 20 15:08 20-mysql.ini -> /etc/php/5.6/mods-available/mysql.ini
lrwxrwxrwx 1 root root   38 Apr 20 15:08 20-mysqli.ini -> /etc/php/5.6/mods-available/mysqli.ini
lrwxrwxrwx 1 root root   41 Apr 20 15:08 20-pdo_mysql.ini -> /etc/php/5.6/mods-available/pdo_mysql.ini
lrwxrwxrwx 1 root root   41 Apr 20 15:08 20-pdo_pgsql.ini -> /etc/php/5.6/mods-available/pdo_pgsql.ini
lrwxrwxrwx 1 root root   42 Apr 20 15:08 20-pdo_sqlite.ini -> /etc/php/5.6/mods-available/pdo_sqlite.ini
lrwxrwxrwx 1 root root   37 Apr 20 15:08 20-pgsql.ini -> /etc/php/5.6/mods-available/pgsql.ini
lrwxrwxrwx 1 root root   36 Apr 20 15:08 20-phar.ini -> /etc/php/5.6/mods-available/phar.ini
lrwxrwxrwx 1 root root   37 Apr 20 15:08 20-posix.ini -> /etc/php/5.6/mods-available/posix.ini
lrwxrwxrwx 1 root root   40 Apr 20 15:08 20-readline.ini -> /etc/php/5.6/mods-available/readline.ini
lrwxrwxrwx 1 root root   37 Apr 20 15:08 20-shmop.ini -> /etc/php/5.6/mods-available/shmop.ini
lrwxrwxrwx 1 root root   41 Apr 20 15:08 20-simplexml.ini -> /etc/php/5.6/mods-available/simplexml.ini
lrwxrwxrwx 1 root root   36 Apr 20 15:08 20-soap.ini -> /etc/php/5.6/mods-available/soap.ini
lrwxrwxrwx 1 root root   39 Apr 20 15:08 20-sockets.ini -> /etc/php/5.6/mods-available/sockets.ini
lrwxrwxrwx 1 root root   39 Apr 20 15:08 20-sqlite3.ini -> /etc/php/5.6/mods-available/sqlite3.ini
lrwxrwxrwx 1 root root   39 Apr 20 15:08 20-sysvmsg.ini -> /etc/php/5.6/mods-available/sysvmsg.ini
lrwxrwxrwx 1 root root   39 Apr 20 15:08 20-sysvsem.ini -> /etc/php/5.6/mods-available/sysvsem.ini
lrwxrwxrwx 1 root root   39 Apr 20 15:08 20-sysvshm.ini -> /etc/php/5.6/mods-available/sysvshm.ini
lrwxrwxrwx 1 root root   36 Apr 20 15:08 20-tidy.ini -> /etc/php/5.6/mods-available/tidy.ini
lrwxrwxrwx 1 root root   41 Apr 20 15:08 20-tokenizer.ini -> /etc/php/5.6/mods-available/tokenizer.ini
lrwxrwxrwx 1 root root   36 Apr 20 15:08 20-wddx.ini -> /etc/php/5.6/mods-available/wddx.ini
lrwxrwxrwx 1 root root   41 Apr 20 15:08 20-xmlreader.ini -> /etc/php/5.6/mods-available/xmlreader.ini
lrwxrwxrwx 1 root root   38 Apr 20 15:08 20-xmlrpc.ini -> /etc/php/5.6/mods-available/xmlrpc.ini
lrwxrwxrwx 1 root root   41 Apr 20 15:08 20-xmlwriter.ini -> /etc/php/5.6/mods-available/xmlwriter.ini
lrwxrwxrwx 1 root root   35 Apr 20 15:08 20-xsl.ini -> /etc/php/5.6/mods-available/xsl.ini
lrwxrwxrwx 1 root root   35 Apr 20 15:08 20-zip.ini -> /etc/php/5.6/mods-available/zip.ini
lrwxrwxrwx 1 root root   41 Apr 20 15:08 25-memcached.ini -> /etc/php/5.6/mods-available/memcached.ini
```

## Includes packages

 * nginx, memcached, curl, pwgen, supervisor
 * php 5.6 (fpm, cli, curl, gd, intl, mcrypt, mbstring, memcache, memcached, sqlite, tidy, xmlrpc, xsl, pgsql, mongo, ldap) full list 👆


## Usage

Build your image.

```sh
docker build -t ubuntu24-nginx-php5-6:v1 --progress=plain  .
```

Bind local port 8081 to the container.

```sh
docker run -p 8081:80 --volume <project_home>/www:/var/www ubuntu24-nginx-php5-6:v1
```

```sh
docker ps -a
docker exec -it <image_id>  bash
```

Tag and publish the image to dockers image repo as `stable`

```sh
docker tag <image_id> minstn/ubuntu24-nginx-php5-6:stable
docker push minstn/ubuntu24-nginx-php5-6
```

Creating container via `docker-compose` file.

```yaml
  web:
    image: ubuntu24-nginx-php5-6
    container_name: web
    restart: always
    volumes:
      # 1. mount your workdir path
      - /var/www:/var/www
    command:
      # remember to escape variables dollar sign with duplication $$ instead $
      # - '* * * * * echo "Hello $$(date)" >> /var/log/cron.log 2>&1'
      # - '* * * * * echo "Hello world !" >> /var/log/cron.log 2>&1'
```



 5. Set your own cronjob tasks just entering as new entry. Below are an explanation how to use cron. All added entries of commands will be placed at `/etc/cron.d/crontasks` and will be initialized via `crontab`. Type `crontab -e` at container to see your entries. [http://crontab-generator.org/](http://crontab-generator.org/).

```
*     *     *   *    *        command to be executed
-     -     -   -    -
|     |     |   |    |
|     |     |   |    +----- day of week (0 - 6) (Sunday=0)
|     |     |   +------- month (1 - 12)
|     |     +--------- day of        month (1 - 31)
|     +----------- hour (0 - 23)
+------------- min (0 - 59)
```