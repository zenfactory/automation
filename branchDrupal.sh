#!/bin/bash
# Define working variables
currentTime=`date +%s`
workingRoot="/tmp/deployment-$currentTime"
apacheRoot="/var/www"
siteRoot="zenfactory"
siteUrl="http://www.zenfactory.org"
gitOrigin="https://github.com/zenfactory/webhome.git"
parentBranch="master"
childBranch="development"


#########################################
# Make a backup of the site
########################################

# Make working environemnt
mkdir $workingRoot

# Change to working environemnt
cd $workingRoot

# Dump sites mysql database using drush
drush -r "$apacheRoot/$siteRoot" -l $siteUrl sql-dump > "$workingRoot/db-$currentTime.sql"

# Change to apache root
cd $apacheRoot

# Copy the entire site to a backup
tar -czvf "$workingRoot/$siteRoot-$currentTime.tgz" $siteRoot

# Change to working directory
cd $workingRoot

# Uncompress original site backup
tar -zxvf "$siteRoot-$currentTime.tgz"

# Clone repository into working folder
#git clone $gitOrigin originClone

# Change to copy of 
cd originClone

# Create branch
git branch $childBranch

# Switch to new branch context
git checkout $childBranch

# Change back to working root
cd $workingRoot


# Remove git repo from template directory
#rm -rf "$siteRoot/.git"

# Navigate back to working root
#mv originClone/.git $siteRoot
#mv originClone/.gitignore $siteRoot


#########################################
# Make a backup of the site
########################################
#mysql -h localhost -u quranfoundation < "$workingRoot/db-$currentTime.sql"
