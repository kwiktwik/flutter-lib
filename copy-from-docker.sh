#!/usr/bin/env bash
# Copy /testbed/flutter-lib from a Docker container to ./docker-files

set -e

CONTAINER="${1:-zed-evals-container}"
SOURCE_PATH="/testbed/flutter-lib"
DEST_DIR="$(cd "$(dirname "$0")" && pwd)/docker-files"

mkdir -p "$DEST_DIR"
docker cp "$CONTAINER:$SOURCE_PATH/." "$DEST_DIR/"
echo "Copied $SOURCE_PATH from container $CONTAINER to $DEST_DIR"
