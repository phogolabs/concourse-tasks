#!/bin/bash -xe

VERSION_DIR="$(cd version && pwd)"

# shellcheck disable=2164
cd repository

REPO_VERSION=$(git tag --list 'v*' --contains HEAD | sed -n 's/^v//p')
REPO_HASH=$(git rev-parse --short HEAD)

echo "$REPO_VERSION" > "$VERSION_DIR/number"
echo "$REPO_HASH" > "$VERSION_DIR/hash"

[ -n "$PRODUCT_NAME" ] && echo "$PRODUCT_NAME $REPO_VERSION" > "$VERSION_DIR/name"
