#!/bin/bash -ex

[ -z "$DEBUG" ] || set -x

main() {
  git_configure
  git_init_destination
  git_commit_changes
}

git_configure() {
  git config --global user.email "nobody@concourse.ci"
  git config --global user.name "Concourse"
}

git_init_destination() {
  cd blog-content
  git init
}

git_commit_changes() {
  git add .
  git commit -m "Generated blog content for $BASE_URL"
}

generate_blog() {
  hugo --source blog-source --destination blog-content --config "$BLOG_CONFIG" --theme "$THEME_NAME" --baseURL "$BASE_URL"
}

main
