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
  git config --global user.email "$GIT_EMAIL"
  git config --global user.name "$GIT_USERNAME"
}

git_commit_changes() {
  local commit_message
  commit_message="Publish a new blog post from $(commit_sha)"
  (cd "$DESTINATION" && git add . && git commit --no-verify -m "$commit_message") || true
}

generate_blog() {
  hugo --source blog-source --destination "$DESTINATION" --config "$BLOG_CONFIG" --theme "$THEME_NAME" --baseURL "$BASE_URL"
}

commit_sha() {
  (cd blog-source && git rev-parse HEAD)
}

prepare_output() {
  cp -rv blog-content/. blog-website
}

main
