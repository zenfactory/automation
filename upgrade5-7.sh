#!/bin/bash
# Define working variables
workingRoot="/tmp/qfupgrade"
siteRoot="/var/www/quranfoundation"
siteUrl="http://www.thequranfoundation.com/"
currentTime=`date +%s`


#########################################
# Make a backup of the site
########################################

# Make working environemnt
mkdir $workingRoot

# Change to working environemnt
cd $workingRoot

# Dump sites mysql database using drush
drush -r $siteRoot -l $siteUrl sql-dump > "$workingRoot/db-$currentTime.sql"

# Copy the entire site to a backup
tar -czvf "$workingRoot/site-$currentTime.tgz" $siteRoot

# Try running the drush upgrade command see if it works.

#########################################
# Make a backup of the site
########################################
mysql -h localhost -u quranfoundation < "$workingRoot/db-$currentTime.sql"
