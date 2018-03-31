FROM php:7-fpm

ARG APP_USER_UID
ARG APP_NAME

RUN docker-php-ext-install \
  mysqli

RUN groupadd -g $APP_USER_UID $APP_NAME && \
    useradd -r -u $APP_USER_UID -g $APP_NAME $APP_NAME

USER $APP_NAME
