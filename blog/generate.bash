#!/bin/bash -ex

[ -z "$DEBUG" ] || set -x

DESTINATION="$(cd blog-website && pwd)"

main() {
  generate_blog
  cleanup_trailing_whitespaces
  git_configure
  git_commit_changes
}

git_configure() {
  git config --global apply.whitespace nowarn
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

cleanup_trailing_whitespaces() {
 find . -type f -print0 | xargs -0 perl -pi -e 's/ +$//'
}

main
