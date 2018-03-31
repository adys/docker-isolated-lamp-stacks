#!/usr/bin/env bash

set -eu

ME=$(basename "$0")
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#readonly DATA_DIR=/data/app/
#readonly DOCKER_COMPOSE_DIR=/data/docker/

readonly APP_NAME=$1
readonly APP_PORT=$2
readonly APP_UID=$3
readonly ACTION=$4

logOut() {
  echo "[${ME}] ${1}"
}

failErrOut() {
  echo "[${ME}] ERROR - ${1} ! Exiting ..." >&2
  exit 1
}

validateInput() {
  [[ -z $APP_NAME ]] && failErrOut "APP_NAME name must be set"
  [[ -z $APP_PORT ]] && failErrOut "APP_PORT must be set"
  [[ -z $APP_UID ]] && failErrOut "APP_UID must be set"
}

validateInput

