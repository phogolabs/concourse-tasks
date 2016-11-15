#!/bin/bash -ex

[ -z "$DEBUG" ] || set -x

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
  cd blog-content
  git init
  git add .
  git commit -m "Generated blog content for $BASE_URL"
}

generate_blog() {
  hugo --source blog-source --destination blog-content --config "$BLOG_CONFIG" --theme "$THEME_NAME" --baseURL "$BASE_URL"
}

main
