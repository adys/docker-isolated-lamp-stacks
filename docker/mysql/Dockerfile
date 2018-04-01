FROM mysql:5.7

ARG STACK_ID

RUN addgroup --gid $STACK_ID --system app
RUN adduser --uid $STACK_ID --gid $STACK_ID --system --disabled-login --disabled-password app

COPY mysql-entrypoint/ /docker-entrypoint-initdb.d/

USER app
