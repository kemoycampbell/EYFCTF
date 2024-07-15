FROM php:7.4-apache

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"



# Copy application code to the container
COPY . /var/www/html

# Install Apache utilities and enable Apache modules
RUN apt-get update \
    && apt-get install -y apache2-utils \
    && a2enmod rewrite \
    && a2enmod auth_basic

#COPY apache/httpd.conf /etc/apache2/httpd.conf

EXPOSE 9999

