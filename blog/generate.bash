#!/bin/bash -ex

[ -z "$DEBUG" ] || set -x

DESTINATION="$(cd blog-website && pwd)"

main() {
  generate_blog
  git_configure
  git_commit_changes
}

git_configure() {
  git config --global user.email "nobody@concourse.ci"
  git config --global user.name "Concourse"
}

git_commit_changes() {
  cd "$DESTINATION"
  git init
  git add .
  git commit -m "Publishing new version of the blog"
}

generate_blog() {
  hugo --source blog-source --destination "$DESTINATION" --config "$BLOG_CONFIG" --theme "$THEME_NAME" --baseURL "$BASE_URL"
}

main
