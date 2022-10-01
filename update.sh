#!/bin/bash

# CONFIGURATION #
WEB_ROOT=/var/www/pixelfed
WEB_USER=www-data
# END CONFIGURATION #

set +x

su - $WEB_USER -s /bin/bash -c "cd $WEB_ROOT && git pull"
su - $WEB_USER -s /bin/bash -c "cd $WEB_ROOT && composer install --no-ansi --no-dev --no-interaction --no-progress --no-scripts --optimize-autoloader"
su - $WEB_USER -s /bin/bash -c "cd $WEB_ROOT && composer dump-autoload --optimize"
su - $WEB_USER -s /bin/bash -c "cd $WEB_ROOT && php artisan config:cache"
su - $WEB_USER -s /bin/bash -c "cd $WEB_ROOT && php artisan route:cache"
su - $WEB_USER -s /bin/bash -c "cd $WEB_ROOT && php artisan migrate --force"

# Make sure we restart workers on new code too
sudo systemctl restart horizon.service

#su - $WEB_USER -s /bin/bash -c "cd $WEB_ROOT && php artisan horizon:purge"
#su - $WEB_USER -s /bin/bash -c "cd $WEB_ROOT && php artisan storage:link"
