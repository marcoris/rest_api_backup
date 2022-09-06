FROM php:7.4-fpm
# install PECL extensions
RUN pecl channel-update pecl.php.net \
    && pecl install xdebug-2.9.1 \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN docker-php-ext-enable xdebug
