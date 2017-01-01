#!/bin/bash -e

[ -z "$DEBUG" ] || set -x

main() {
  minify_css
  minify_js
  prepare_output
}

minify_css() {
  [ -z "$DIRECTORY_CSS" ] || find "web-application/$DIRECTORY_CSS" -name "*.css" -exec yuicompressor {} -v --type css --output={} \;
}

minify_js() {
  [ -z "$DIRECTORY_JS" ] || find "web-application/$DIRECTORY_JS" -name "*.js" -exec yuicompressor {} -v --type js --output={} \;
}

prepare_output() {
  cp -rv web-application/. web-application-min
}

main
