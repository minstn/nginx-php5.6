FROM ubuntu:24.04

ENV DEFAULT_LOCALE=en_US \
	NGINX_VERSION=stable

# let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Surpress Upstart errors/warning
RUN dpkg-divert --local --rename --add /sbin/initctl && \
	ln -sf /bin/true /sbin/initctl
	# Setup default locale
	
RUN apt-get update && \
	apt-get install -y locales && \
	locale-gen ${DEFAULT_LOCALE}.UTF-8 && \
	update-locale LC_ALL=${DEFAULT_LOCALE}.UTF-8 && \
	export LANG=${DEFAULT_LOCALE}.UTF-8 && \
	#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C / 4AD4CAB6 && \
	apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y software-properties-common  && \
	#NGINX=stable && \
	#add-apt-repository ppa:nginx/${NGINX_VERSION} && \
	add-apt-repository ppa:ondrej/php && \
	apt-get update && \
	apt-get upgrade -y && \
	BUILD_PACKAGES="supervisor memcached pwgen sudo cron" && \
	apt-get -y install $BUILD_PACKAGES

RUN echo 'Installing NGINX' && \
	apt-get -y install nginx

#RUN echo 'Installing PHP5.6' && \
#	apt-get -y install php5.6 php5.6-cli php5.6-common

RUN echo 'Installing PHP5.6 FPM' && \
	apt-get -y install php5.6-fpm && \
	apt-get -y install php5.6-mysql && \
	apt-get -y install php5.6-intl && \
	apt-get -y install php5.6-pgsql

# RUN echo 'Installing PHP packages 1' \
# 	BUILD_PACKAGES_PHP="php5.6-mysql" \
# 	apt-get -y install $BUILD_PACKAGES_PHP
	
RUN echo 'Installing PHP packages' && \
	BUILD_PACKAGES_WORKERS="php5.6-amqp " && \
	BUILD_PACKAGES_NET="php5.6-mcrypt php5.6-msgpack" && \
	BUILD_PACKAGES_DB="php5.6-ldap php5.6-sqlite" && \
	BUILD_PACKAGES_CACHE="php5.6-apc php5.6-apcu php5.6-memcached php5.6-memcache" && \
	BUILD_PACKAGES_XML="php5.6-xmlrpc php5.6-xml php5.6-xsl php5.6-xmlreader php5.6-xmlwriter php5.6-simplexml php5.6-soap php5.6-dom" \
	BUILD_PACKAGES_UTIL="php5.6-zip php5.6-curl php5.6-bcmath php5.6-mbstring php5.6-tidy " && \
	BUILD_PACKAGES_GD="php5.6-gd php5.6-igbinary php5.6-imagick" && \
	apt-get -y install $BUILD_PACKAGES_WORKERS && \
	apt-get -y install $BUILD_PACKAGES_XML && \
	apt-get -y install $BUILD_PACKAGES_NET && \
	apt-get -y install $BUILD_PACKAGES_DB && \
	apt-get -y install $BUILD_PACKAGES_CACHE && \
	apt-get -y install $BUILD_PACKAGES_UTIL && \
	apt-get -y install $BUILD_PACKAGES_GD

# Nginx configuration
RUN sed -i -e"s/worker_processes  1/worker_processes 5/" /etc/nginx/nginx.conf && \
	sed -i -e"s/keepalive_timeout\s*65/keepalive_timeout 2/" /etc/nginx/nginx.conf && \
	sed -i -e"s/keepalive_timeout 2/keepalive_timeout 2;\n\tclient_max_body_size 128m;\n\tproxy_buffer_size 256k;\n\tproxy_buffers 4 512k;\n\tproxy_busy_buffers_size 512k/" /etc/nginx/nginx.conf && \
	echo "daemon off;" >> /etc/nginx/nginx.conf


#do some system cleanup
RUN apt-get remove --purge -y software-properties-common && \
	apt-get autoremove -y && \
	apt-get clean && \
	apt-get autoclean && \
	echo -n > /var/lib/apt/extended_states && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /usr/share/man/?? && \
	rm -rf /usr/share/man/??_* && \
	# curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer && \
	# clean temporary files
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# PHP-FPM configuration
RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php/5.6/fpm/php.ini && \
	sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 2M/g" /etc/php/5.6/fpm/php.ini && \
	sed -i -e "s/;always_populate_raw_post_data\s*=\s*-1/always_populate_raw_post_data = -1/g" /etc/php/5.6/fpm/php.ini && \
	sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 1M/g" /etc/php/5.6/fpm/php.ini && \
	sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/5.6/fpm/php-fpm.conf && \
	sed -i -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" /etc/php/5.6/fpm/pool.d/www.conf && \
	sed -i -e "s/pm.max_children = 5/pm.max_children = 9/g" /etc/php/5.6/fpm/pool.d/www.conf && \
	sed -i -e "s/pm.start_servers = 2/pm.start_servers = 3/g" /etc/php/5.6/fpm/pool.d/www.conf && \
	sed -i -e "s/pm.min_spare_servers = 1/pm.min_spare_servers = 2/g" /etc/php/5.6/fpm/pool.d/www.conf && \
	sed -i -e "s/pm.max_spare_servers = 3/pm.max_spare_servers = 4/g" /etc/php/5.6/fpm/pool.d/www.conf && \
	sed -i -e "s/pm.max_requests = 500/pm.max_requests = 200/g" /etc/php/5.6/fpm/pool.d/www.conf && \
	sed -i "s/;date.timezone =.*/date.timezone = Europe\/Zurich/" /etc/php/5.6/fpm/php.ini && \
	sed -i "s/;date.timezone =.*/date.timezone = Europe\/Zurich/" /etc/php/5.6/cli/php.ini

# Ownership of sock file for PHP-FPM
RUN find /etc/php/5.6/cli/conf.d/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;
	
#RUN mkdir /run/php && \
RUN	sed -i -e " \
	s/;listen.mode = 0660/listen.mode = 0750/g" /etc/php/5.6/fpm/pool.d/www.conf && \
	#
	# mcrypt configuration
	phpenmod mcrypt && \
	# Nginx site configuration
	rm -Rf /etc/nginx/conf.d/* && \
	rm -Rf /etc/nginx/sites-available/default && \
	mkdir -p /etc/nginx/ssl/ && \
	# create workdir directory
	mkdir -p /var/www


COPY ./config/nginx/nginx.conf /etc/nginx/sites-available/default.conf
# Supervisor Config
COPY ./config/supervisor/supervisord.conf /etc/supervisord.conf
# Start Supervisord
COPY ./config/cmd.sh /
# mount www directory as a workdir
# COPY ./www/ /var/www

RUN rm -f /etc/nginx/sites-enabled/default && \
	ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default && \
	chmod 755 /cmd.sh && \
	chown -Rf www-data:www-data /var/www && \
	touch /var/log/cron.log && \
	touch /etc/cron.d/crontasks

# Expose Ports
EXPOSE 80

ENTRYPOINT ["/bin/bash", "/cmd.sh"]
