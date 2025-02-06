#!/bin/bash

# global vars
DOCKER_VOLUME_PATH="/mnt/docker-volumes"
APP_NAME="semaphore"

# create volume folders
mkdir -p $DOCKER_VOLUME_PATH/$APP_NAME/{data,config,tmp,mysql}
chmod -R 777 $DOCKER_VOLUME_PATH/$APP_NAME

# start cmd
docker compose up --detach
