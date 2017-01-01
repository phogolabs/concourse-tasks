#!/bin/bash -e

[ -z "$DEBUG" ] || set -x

main() {
  minify_css
  minify_js
  prepare_output
}

minify_css() {
  echo "Minifying CSS files"
  [ -z "$DIRECTORY_CSS" ] || find "web-application/$DIRECTORY_CSS" -name "*.css" -exec yui-compressor {} -v --type css --output={} \;
}

minify_js() {
  echo "Minifying JS files"
  [ -z "$DIRECTORY_JS" ] || find "web-application/$DIRECTORY_JS" -name "*.js" -exec yui-compressor {} -v --type js --output={} \;
}

prepare_output() {
  cp -r web-application/. web-application-min
}

main
