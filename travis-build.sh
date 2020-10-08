#!/bin/bash
# Set these environment variables
#DOCKER_TAG=
#DOCKER_USER=
#DOCKER_AUTH=

set -o errexit -o nounset -o xtrace

ORG=${ORG:-hsldevcom}
DOCKER_IMAGE=$ORG/digitransit-proxy
DOCKER_TAG="latest"


if [ "$TRAVIS_TAG" ]; then
  DOCKER_TAG="prod"
elif [ "$TRAVIS_BRANCH" != "master" ]; then
  DOCKER_TAG=$TRAVIS_BRANCH
fi

DOCKER_TAG_LONG=$DOCKER_TAG-$(date +"%Y-%m-%dT%H.%M.%S")-${TRAVIS_COMMIT:0:7}
DOCKER_IMAGE_LATEST=$DOCKER_IMAGE:latest
DOCKER_IMAGE_TAG=$DOCKER_IMAGE:$DOCKER_TAG
DOCKER_IMAGE_TAG_LONG=$DOCKER_IMAGE:$DOCKER_TAG_LONG


if [ -z $TRAVIS_TAG ]; then
  # Build image
  echo "Building digitransit-proxy"
  ./test.sh
  docker build --tag=$DOCKER_IMAGE_TAG_LONG -f Dockerfile .
fi

if [ "${TRAVIS_PULL_REQUEST}" == "false" ]; then
  docker login -u ${DOCKER_USER} -p ${DOCKER_AUTH}
  if [ "$TRAVIS_TAG" ];then
    echo "processing release $TRAVIS_TAG"
    #release do not rebuild, just tag
    docker pull $DOCKER_IMAGE_LATEST
    docker tag $DOCKER_IMAGE_LATEST $DOCKER_IMAGE_TAG
    docker tag $DOCKER_IMAGE_LATEST $DOCKER_IMAGE_TAG_LONG
    docker push $DOCKER_IMAGE_TAG
    docker push $DOCKER_IMAGE_TAG_LONG
  else
    ./test.sh
    docker build  --tag=$DOCKER_IMAGE_TAG_LONG -f Dockerfile .
    echo "Pushing $DOCKER_TAG image"
    docker push $DOCKER_IMAGE_TAG_LONG
    docker tag $DOCKER_IMAGE_TAG_LONG $DOCKER_IMAGE_TAG
    docker push $DOCKER_IMAGE_TAG
  fi
fi

echo Build completed