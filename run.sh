#!/bin/sh

RUN=$(docker ps -a | grep watchtower)
echo $RUN
if [ -z "$RUN" ] ; then
  echo 'Create watchtower container'
  docker run --name watchtower -d -p 8001:80 -v $(pwd)/db:/db -v $(pwd):/scripts -it skilldlabs/php:56
else
  echo 'Start watchtower container'
  docker start watchtower
fi

# Check installed instance inside container.
INSTALL=$(docker exec -it watchtower drush status | grep "Site URI")
if [ -z "$INSTALL" ] ; then
  # Install drupal and watchtower dependencies.
  docker exec watchtower sh /scripts/build.sh
else
  echo 'Watchtower already installed'
fi
