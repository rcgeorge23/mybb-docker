FROM php:apache
RUN apt-get update && apt-get -y install zip libxml2-dev libpng-dev && docker-php-ext-install mysql simplexml mbstring gd && rm -r /var/lib/apt/lists/*
ADD mybb.conf /etc/apache2/sites-enabled/mybb.conf
RUN cd /var/www && mkdir mybb && cd mybb && \
curl http://resources.mybb.com/downloads/mybb_1819.zip -o mybb.zip && \
unzip mybb.zip "Upload/*" && \
mv Upload/* . && \
rm -Rf Upload mybb.zip && \
mv inc/config.default.php inc/config.php && \
chmod 666 inc/config.php inc/settings.php && \
chmod -R 777 inc/languages && \
chmod 777 cache/ cache/themes/ uploads/ uploads/avatars/ admin/backups/
WORKDIR /var/www
EXPOSE 80
CMD ["apache2-foreground"]
