#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

setup_git() {
  cd $DIR
  git clone "https://${GH_TOKEN}@github.com/$gu/wildflowerdew.github.io.git" site
  cd site
  git config --global user.email "33005735+WildFlowerDew@users.noreply.github.com"
  git config --global user.name "Wild Flowerdew"
  cd $DIR
}

gen_archives() {
  echo "Creating archives..."
  $DIR/site/scripts/gen-category-archives.sh
  $DIR/site/scripts/gen-tag-archives.sh
}

commit_website_files() {
  cd $DIR/site
  git checkout master
  git add archives
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
  cd $DIR
}

upload_files() {
  cd $DIR/site
  git remote add origin-build-master "https://${GH_TOKEN}@github.com/$gu/wildflowerdew.github.io.git" > /dev/null 2>&1
  git push --quiet --set-upstream origin-build-master master
  cd $DIR
}

echo "Building Website Drafts"
setup_git
gen_archives
commit_website_files
upload_files
echo "Done."
