FROM php:7.2.32-apache

# Instalar extensiones PHP necesarias
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install mysqli pdo pdo_mysql

# Copiar la carpeta src al directorio /var/www/html en el contenedor
COPY src/ /var/www/html/

# Ajustar permisos si es necesario
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html
