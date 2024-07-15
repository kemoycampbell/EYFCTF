FROM php:7.4-apache

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY index.php /var/www/html/
COPY journal_entries.csv /var/www/html/

EXPOSE 9090