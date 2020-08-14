FROM php:7.4-fpm

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
    libpq-dev \
    libgd-dev \
    libpng-dev \
    libbz2-dev \
    libzip-dev \
    libonig-dev \
    curl \
    git \
    gnupg \
    zlib1g \
    make \
    wget \
    openssh-client

RUN docker-php-ext-install \
    intl \
    mysqli \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    bz2 \
    bcmath \
    mbstring \
    pcntl \
    gd

RUN docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg

RUN docker-php-ext-configure intl

RUN docker-php-ext-enable gd

RUN pecl install imagick-3.4.3
RUN docker-php-ext-enable imagick

RUN pecl install redis
RUN docker-php-ext-enable redis

RUN pecl install zip
RUN docker-php-ext-enable zip

# Install Chrome

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN apt-get update
RUN apt-get install -y google-chrome-stable
RUN apt-get install -y libnss3

# Install node

RUN apt-get purge nodejs
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs build-essential

#Download dependencies

# Set memory limit
RUN echo "memory_limit=1024M" > /usr/local/etc/php/conf.d/memory-limit.ini

# Set environmental variables
ENV COMPOSER_HOME /root/composer

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Sentry CLI

RUN curl -sL https://sentry.io/get-cli/ | bash

CMD ["php"]
