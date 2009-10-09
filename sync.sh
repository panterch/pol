#!/bin/sh
if [ ! -d 'vendor/plugins/pol' ]
then
  echo 'please execute this script in RAILS_ROOT'
  exit 1
fi
rsync -ruv vendor/plugins/pol/db/migrate db
rsync -ruv vendor/plugins/pol/config/locales/ config/locales/

# javascripts
(
cd public/javascripts
ln -s ../../vendor/plugins/pol/assets/javascripts/pol*js .
)

# stylesheets
mkdir -p public/stylesheets/sass
(
cd public/stylesheets/sass
ln -s ../../../vendor/plugins/pol/assets/stylesheets/sass/pol*.sass .
)

# images
(
cd public/images
ln -s ../../vendor/plugins/pol/assets/images/16x16 
)
