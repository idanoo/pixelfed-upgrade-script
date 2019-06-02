#!/bin/bash

# CONFIGURATION #

WEB_ROOT=/var/www/pixelfed
WEB_USER=www-data

# DO NOT EDIT BELOW THIS LINE #
set +x

cd $WEB_ROOT
su - $WEB_USER -s /bin/bash -c 'git pull'
su - $WEB_USER -s /bin/bash -c 'composer install --no-ansi --no-interaction --no-progress --no-scripts --optimize-autoloader'
su - $WEB_USER -s /bin/bash -c 'php artisan config:cache'
su - $WEB_USER -s /bin/bash -c 'php artisan route:cache'
su - $WEB_USER -s /bin/bash -c 'php artisan migrate --force'
su - $WEB_USER -s /bin/bash -c 'php artisan horizon:purge'
su - $WEB_USER -s /bin/bash -c 'php artisan storage:link'

