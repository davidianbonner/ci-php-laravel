FROM php:7.1-fpm

# Install packages
# RUN sudo sed -i.bak 's/us-west-2\.ec2\.//' /etc/apt/sources.list

RUN apt-get update -qq

RUN set -x \
    && apt-get install -y \
    imagemagick \
    libmagickwand-dev \
    libtool \
    libfreetype6-dev \
    libjpeg-dev \
    libxml2 \
    libgd-dev \
    libpng-dev \
    libbz2-dev \
    libzip-dev \
    curl \
    git \
    gnupg \
    zlib1g \
    make \
    wget \
    openssh-client \
    && docker-php-ext-configure gd \
        --with-gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/

RUN docker-php-ext-install \
    bz2 \
    bcmath \
    mbstring \
    gd

RUN docker-php-ext-enable gd

RUN pecl install imagick-3.4.3
RUN docker-php-ext-enable imagick

RUN pecl install zip
RUN docker-php-ext-enable zip

# Install node

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs build-essential

#Download dependencies

# Set memory limit
RUN echo "memory_limit=1024M" > /usr/local/etc/php/conf.d/memory-limit.ini

# Set environmental variables
ENV COMPOSER_HOME /root/composer

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install global composer dependencies

RUN composer global require laravel/envoy

# Install Sentry CLI

RUN curl -sL https://sentry.io/get-cli/ | bash

CMD ["php"]