#!/bin/bash

# A script to build and push the image

# Build the image
podman build --squash-all -t dev .

# Login to the GHCR
echo $GHCR_PAT | podman login ghcr.io -u $USERNAME --password-stdin

# Push the latest version
podman push dev ghcr.io/$REPOSITORY:latest

# Push the release version
if [ "$PUBLISH_RELEASE_VERSION" -eq "true" ]; then
    podman push dev ghcr.io/$REPOSITORY:${{ env.RELEASE_VERSION }}
fi
