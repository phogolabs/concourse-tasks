#!/bin/bash -x

VERSION_DIR="$(cd version && pwd)"

[ -n "$PRODUCT_NAME" ] && echo "$PRODUCT_NAME" > "$VERSION_DIR/name"

# shellcheck disable=2164
cd repository

git tag --list 'v*' --contains HEAD | sed -n 's/^v//p' > "$VERSION_DIR/number"
git rev-parse --short HEAD > "$VERSION_DIR/hash"
