#!/bin/bash
dotnet publish --no-restore ./src/DShop.Services.Notifications -c Release -o ./bin/Docker

DOCKER_ENV=''
DOCKER_TAG=''

case "$TRAVIS_BRANCH" in
  "master")
    DOCKER_ENV=production
    DOCKER_TAG=latest
    ;;
  "develop")
    DOCKER_ENV=development
    DOCKER_TAG=dev
    ;;    
esac

docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
docker build -f ./src/DShop.Services.Notifications/Dockerfile.$DOCKER_ENV -t dshop.services.notifications:$DOCKER_TAG ./src/DShop.Services.Notifications
docker tag dshop.services.notifications:$DOCKER_TAG $DOCKER_USERNAME/dshop.services.notifications:$DOCKER_TAG
docker push $DOCKER_USERNAME/dshop.services.notifications:$DOCKER_TAG