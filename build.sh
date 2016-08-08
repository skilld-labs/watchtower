#!/bin/sh

DB_NAME=watchtower.sqlite

drush make ../scripts/watchtower.make.yml -y
cp sites/default/default.settings.php sites/default/settings.php

if [ -f /db/$DB_NAME ]; then
  echo "Create setting.php file and add existing db."
  cp sites/default/default.settings.php sites/default/settings.php
  echo "\$databases = array('default' => array('default' => array('database' => '/db/watchtower.sqlite', 'driver' => 'sqlite', 'prefix' => '')));" >> sites/default/settings.php
else
  echo "Instal drupal"
  drush si --db-url=sqlite:///db/$DB_NAME --account-pass=admin -y
fi
