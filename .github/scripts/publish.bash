#!/bin/bash

# A script to build and push the image

# Build the image
podman build --squash-all -t ${IMAGENAME} .

# Login to the GHCR
echo ${GHCR_PAT} | podman login ghcr.io -u ${USERNAME} --password-stdin

# Push the latest version
podman push ${IMAGENAME} ghcr.io/${OWNER}/${IMAGENAME}:latest

# Push the release version
if [ "${PUBLISH_RELEASE_VERSION}" = true ]; then

    # Push the release version of the image
    podman push ${IMAGENAME} ghcr.io/${OWNER}/${IMAGENAME}:${RELEASE_VERSION}

    # Run a container
    podman run --name container -td dev
    podman stop container

    # Export the container
    FILE_TAR="dev-${RELEASE_VERSION}.tar"
    FILE_ZIP="dev-${RELEASE_VERSION}.zip"
    podman export container > ${FILE_TAR}
    zip ${FILE_ZIP} ${FILE_TAR}

    # Upload the archive as an asset to the latest release
    AUTH="Authorization: token ${GHCR_PAT}"
    RELEASE_ID=$(curl -sH "${AUTH}" "https://api.github.com/repos/${REPOSITORY}/releases/latest" | grep -m 1 "\"id\":" | sed -E 's/.*"id": (.*),/\1/')
    UPLOAD_URL="https://uploads.github.com/repos/${REPOSITORY}/releases/${RELEASE_ID}/assets?name=${FILE_ZIP}"
    curl -H "${AUTH}" -H "Content-Type: application/zip" --data-binary @"${FILE_ZIP}" ${UPLOAD_URL}
fi
