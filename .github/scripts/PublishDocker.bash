#!/bin/bash

# A script to decide what version to upload

# Set current repository variable
REPOSITORY=paveloom-d/dev

# Get last published version
LAST_VERSION=$(curl --silent "https://api.github.com/repos/$REPOSITORY/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

# Check if there is some tag
if [ ! -z "$LAST_VERSION" ]; then

     # Get current tag
     CURRENT_TAG=$(echo "${GITHUB_REF:10}" | sed 's/\///')

     # Print info
     echo -e "\n\e[1m\033[36mLast version: $LAST_VERSION\033[0m"
     echo -e "\e[1m\033[36mCurrent tag:  $CURRENT_TAG\033[0m\n"

     # Check if the tag is a semantic version
     if echo "$CURRENT_TAG" | grep -q "v[0-9]*.[0-9]*.[0-9]*"; then

          # Print information
          echo -e "\e[1m\033[36mCurrent tag is a semantic version. Tagged image will be published.\033[0m\n"

          # Set environment variable
          echo ::set-env name=RELEASE_VERSION::$(echo ${CURRENT_TAG} | sed 's/v//')

          # Publish tagged image
          echo ::set-env name=PUBLISH_RELEASE_VERSION::$(echo true)

     else

          # Print information
          echo -e "\e[1m\033[36mCurrent tag is not a semantic version. Tagged image will not be published.\033[0m\n"

          # Don't publish tagged image
          echo ::set-env name=PUBLISH_RELEASE_VERSION::$(echo false)

     fi

else

     # Print information
     echo -e "\n\e[1m\033[36mNo release has been found, tagged version will not be published.\033[0m\n"

     # Don't publish tagged image
     echo ::set-env name=PUBLISH_RELEASE_VERSION::$(echo false)

fi