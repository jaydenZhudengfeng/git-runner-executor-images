# Set the base image for subsequent instructions
FROM php:7.2

MAINTAINER jaydenZhudengfeng

# Update packages
RUN apt-get update

# Install PHP and composer dependencies
 RUN apt-get install -qq git curl libmcrypt-dev libjpeg-dev libpng-dev libfreetype6-dev libbz2-dev

# Clear out the local repository of retrieved package files
RUN apt-get clean

# Install needed extensions
# Here you can install any other extension that you need during the test and deployment process
RUN docker-php-ext-configure \
    imap --with-kerberos --with-imap-ssl

RUN docker-php-ext-configure \
	gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

RUN docker-php-ext-install \
	bcmath \
	mbstring \
	zip \
	opcache \
	pdo \
	pdo_mysql \
	opcache \
	json \
	imap \
	gd \
	curl \
	exif \
	pcntl

#RUN  install php-mongodb
RUN pecl install mongodb && docker-php-ext-enable mongodb

# |--------------------------------------------------------------------------
# | Composer
# |--------------------------------------------------------------------------
# |
# | Installs Composer to easily manage your PHP dependencies.
# |
RUN curl --silent --show-error https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer &&\
    composer config -g repo.packagist composer https://packagist.laravel-china.org
    # remove composer config -g repo.packagist composer https://packagist.laravel-china.org if you don't locate in China.
