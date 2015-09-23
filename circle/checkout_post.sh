#!/bin/sh

# in order not to retest everything when we only want to test site-specific functionality,
# if we are on a branch then check for changes in the sites
# if there is a change to a gem or something non-site-specific, then test everything,
# otherwise only test the sites that have changes
BRANCH=`git symbolic-ref --short HEAD`

# stuff changed outside of sites/
CHANGED_NON_SITE=`git diff --no-commit-id --name-only origin/master... | egrep -v "^sites"`

# which sites have changed
CHANGED_SITES=`git diff --no-commit-id --name-only origin/master... | egrep "^sites" | cut -d '/' -f 2 | uniq`

if [ "$BRANCH" = "master" ]; then
  echo "Branch is master, test ALL THE THINGS!"
  CHANGED_SITES=`ls sites`

elif [ "$CHANGED_NON_SITE" != "" ]; then
  echo "Something outside a site changed, test ALL THE THINGS!"
  CHANGED_SITES=`ls sites`

elif [ "$CHANGED_SITES" = "" ]; then
  echo "Don't know what changed ... test ALL THE THINGS!"
  CHANGED_SITES=`ls sites`

else
  echo "Testing changed sites:"
  echo $CHANGED_SITES
fi

for site in $CHANGED_SITES; do
  touch sites/$site/TEST_ME
done
