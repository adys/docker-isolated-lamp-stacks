FROM nginx:1.12

ARG APP_USER_UID
ARG APP_NAME

RUN groupadd -g $APP_USER_UID $APP_NAME && \
    useradd -r -u $APP_USER_UID -g $APP_NAME $APP_NAME

RUN touch /var/run/nginx.pid && \
  chown -R $APP_NAME:$APP_NAME /var/run/nginx.pid && \
  chown -R $APP_NAME:$APP_NAME /var/cache/nginx

USER $APP_NAME
