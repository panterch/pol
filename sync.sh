#!/bin/sh
if [ ! -d 'vendor/plugins/pol' ]
then
  echo 'please execute this script in RAILS_ROOT'
  exit 1
fi
rsync -ruv vendor/plugins/pol/db/migrate db
rsync -ruv vendor/plugins/pol/assets/ public
rsync -ruv vendor/plugins/pol/config/locales/ config/locales/

