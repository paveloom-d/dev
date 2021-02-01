#!/bin/bash

# A script to build and push the image

# Build the image
podman build --squash-all -t $IMAGENAME .

# Login to the GHCR
echo $GHCR_PAT | podman login ghcr.io -u $USERNAME --password-stdin

# Push the latest version
podman push $IMAGENAME ghcr.io/$OWNER/$IMAGENAME:latest

# Push the release version
if [ "$PUBLISH_RELEASE_VERSION" = true ]; then
    podman push dev ghcr.io/$OWNER/$IMAGENAME:${{ env.RELEASE_VERSION }}
fi
