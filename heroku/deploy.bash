#!/bin/bash -ex

[ -z "$DEBUG" ] || set -x

HEROKU_APP_DIRECTORY="application"

main() {
  git_configure
  git_remote_add_for_heroku_app "$HEROKU_APP_DIRECTORY" "$HEROKU_APP_NAME"
  git_push_app "$HEROKU_APP_DIRECTORY"
}

git_configure() {
  git config --global apply.whitespace nowarn
  git config --global user.email "nobody@concourse.ci"
  git config --global user.name "Concourse"
}

git_remote_add_for_heroku_app() {
  local app_directory
  local app_name

  app_directory="$1"
  app_name="$1"

  cd "$app_directory"
  git remote add heroku git@git.heroku.com:"$app_name".git
}

git_push() {
 local app_directory
 app_directory="$1"

 cd "$app_directory"
 git push heroku master
}

main
