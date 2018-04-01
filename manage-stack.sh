#!/usr/bin/env bash

set -eu

ME=$(basename "$0")
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

readonly DOCKER_COMPOSE_FILE=${DIR}/docker/docker-compose.yml

export STACK_DIR=${DIR}/data
export STACK_ID="${1:-}"
export STACK_PORT="${2:-}"
export ACTION="${3:-}"

logOut() {
  echo -e "[${ME}] $(date +%Y-%m-%dT%H:%M:%S%z) | ${1}"
}

failErrOut() {
  echo "[${ME}] $(date +%Y-%m-%dT%H:%M:%S%z) | ERROR - ${1} ! Exiting ..." >&2
  exit 1
}

printHelp() {
  echo "Usage: ${ME} <stack-id> <stack-port> <action>" 
  echo
  echo "   stack-id      The stack runs as a user with the 'stack-id' uid."
  echo "   stack-port    The port that apache2 binds to."
  echo "   action        'create' or 'destroy' the stack."
  echo
  echo "   Example:"
  echo "   ./${ME} "
  echo
}

validateInput() {
  if [[ -z $STACK_ID ]]; then
    printHelp
    failErrOut "stack-id must be set"
  fi
  if [[ -z $STACK_PORT ]]; then
    printHelp
    failErrOut "stack-port must be set"
  fi
  if [[ -z $ACTION ]]; then
     printHelp
     failErrOut "action must be set"
  fi
  return 0
}

createStackDir() {
  logOut 'Creating directories ...'
  mkdir -p ${STACK_DIR}/${STACK_ID}/{secrets,mysql}
  chmod 700 ${STACK_DIR}/${STACK_ID}
  chown -R ${STACK_ID}:${STACK_ID} ${STACK_DIR}/${STACK_ID}
  logOut 'Done.'
}

destroyStackDir() {
  logOut 'Destroying directories ...'
  # TODO: implement mysql backup
  rm -rf ${STACK_DIR}/${STACK_ID}
  logOut 'Done.'
}

runDockerCompose() {
  logOut 'Running docker compose ...'
  local dc_action=$1
  if [ "$dc_action" = "up" ]; then
    docker-compose -f $DOCKER_COMPOSE_FILE -p $STACK_ID up -d
  elif [ "$dc_action" = "down" ]; then
    docker-compose -f $DOCKER_COMPOSE_FILE -p $STACK_ID down
  else
    failErrOut "Unknown docker-compose action '${dc_action}'"
  fi
  logOut 'Done.'
}

generateRandomString() {
  echo -n $(openssl rand -base64 12)
}

generateSecrets() {	
  logOut 'Generating secrets ...'
  generateRandomString > ${STACK_DIR}/${STACK_ID}/secrets/rpass
  generateRandomString > ${STACK_DIR}/${STACK_ID}/secrets/dbuser
  generateRandomString > ${STACK_DIR}/${STACK_ID}/secrets/dbpass
  logOut 'Done.'
}

validateInput

case $ACTION in
  create)
    createStackDir
    generateSecrets
    runDockerCompose 'up'
  ;;
  destroy)
    runDockerCompose 'down'
    destroyStackDir
  ;;
  *)
    printHelp
    failErrOut "Only 'create' and 'destroy' actions are allowed"
  ;;
esac
