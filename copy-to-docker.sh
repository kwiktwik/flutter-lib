#!/usr/bin/env bash
# Copy ./assets to Docker container (creates assets folder in container if needed)

set -e

CONTAINER="${1:-zed-evals-container}"
SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)/assets"
DEST_PATH="/testbed/flutter-lib/assets"

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "Error: assets folder not found at $SOURCE_DIR"
  exit 1
fi

docker exec "$CONTAINER" mkdir -p "$DEST_PATH"
docker cp "$SOURCE_DIR/." "$CONTAINER:$DEST_PATH/"
echo "Copied $SOURCE_DIR to container $CONTAINER at $DEST_PATH"
