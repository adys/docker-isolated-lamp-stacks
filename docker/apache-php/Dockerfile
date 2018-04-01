FROM php:7.2.5-apache-stretch

ARG STACK_ID

COPY app/ /var/www/html
COPY conf/site.conf /etc/apache2/sites-enabled/default.conf
COPY conf/ports.conf /etc/apache2/

RUN docker-php-ext-install mysqli

RUN addgroup --gid $STACK_ID --system app
RUN adduser --uid $STACK_ID --gid $STACK_ID --system --disabled-login --disabled-password app

RUN chown -R app: /var/run/apache2/

USER app
