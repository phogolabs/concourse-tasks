#!/bin/bash -ex

[ -z "$DEBUG" ] || set -x

DESTINATION="$(cd blog-content && pwd)"

main() {
  generate_blog
  git_configure
  git_commit_changes
  prepare_output
}

git_configure() {
  git config --global user.email "nobody@concourse.ci"
  git config --global user.name "Concourse"
}

git_commit_changes() {
  local commit_message
  commit_message="Publish a new blog post from $(commit_sha)"
  (cd "$DESTINATION" && git add . && git commit --no-verify -m "$commit_message")
}

generate_blog() {
  hugo --source blog-source --destination "$DESTINATION" --config "$BLOG_CONFIG" --theme "$THEME_NAME" --baseURL "$BASE_URL"
}

commit_sha() {
  (cd blog-source && git rev-parse HEAD)
}

prepare_output() {
  cp -aR blog-content/* blog-website
}

main
