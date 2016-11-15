#!/bin/bash -ex

[ -z "$DEBUG" ] || set -x

generate_blog() {
  hugo --source blog-source --destination blog-content --config "$BLOG_CONFIG" --theme "$THEME_NAME" --baseURL "$BASE_URL"
}

generate_blog
