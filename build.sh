#!/bin/sh
set -e

IMAGE_NAME="starbase-80"
TAG="${1:-latest}"
BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

echo "Building ${IMAGE_NAME}:${TAG}..."

docker build \
    --build-arg BUILD_DATE="$BUILD_DATE" \
    --tag "${IMAGE_NAME}:${TAG}" \
    .

echo "Done: ${IMAGE_NAME}:${TAG}"