FROM php:7.4-apache

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
# COPY index.php /var/www/html/
# COPY script.js /var/www/html/
# COPY login.html /var/www/html/
# COPY authenticate.php /var/www/html/
COPY . /var/www/html/

RUN apt-get update \
    && apt-get install -y apache2-utils

RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli