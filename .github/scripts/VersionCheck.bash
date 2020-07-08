#!/bin/bash

# A script to check whether current version differs from
# the previous one and is consistent throughout the project

# Define error variable
ERROR_COUNT=0

# Check version
function check_readme_versions {

     echo -e "\e[1;36mChecking versions in \"$1\"...\e[0m"

     if [ $(grep "docker pull paveloom/dev" README.md | grep -o ":.*" | sed 's/\://') == "$LOCAL_VERSION" ]; then

          echo -e "\e[1;36m> The version in the first download line is relevant.\e[0m"

     else

          echo -e "\e[1;31m> The version in the first download line is not relevant.\e[0m"
          ERROR_COUNT=$((ERROR_COUNT+1))

     fi

     if [ $(grep "docker pull docker.pkg.github.com/paveloom-d/dev/dev:" README.md | grep -o ":.*" | sed 's/\://') == "$LOCAL_VERSION" ]; then

          echo -e "\e[1;36m> The version in the second download line is relevant.\e[0m"

     else

          echo -e "\e[1;31m> The version in the second download line is not relevant.\e[0m"
          ERROR_COUNT=$((ERROR_COUNT+1))

     fi

     echo

}

# Run all checks
function run_version_checks {

     check_readme_versions "README.md"

}

# Get the version of the last release
get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

# Get the last version tag of the repository
# (assuming a GitHub release was created
# and Semantic Versioning was respected)
LAST_VERSION=$(get_latest_release "paveloom-d/dev")

# Check if there is some tag
if [ ! -z "$LAST_VERSION" ]; then

     # Escape last version
     ESCAPED_LAST_VERSION="$(echo "$LAST_VERSION" | sed 's/v//')"

     # Get the local version
     LOCAL_VERSION=$(grep "LABEL version=" Dockerfile | grep -o "\".*\"" | sed 's/\"//g')

     # Print version
     echo -e "\e[1;36mLast version:  $ESCAPED_LAST_VERSION\e[0m"
     echo -e "\e[1;36mLocal version: $LOCAL_VERSION\e[0m\n"

     # Check whether local version differs from the last one
     if [ $LOCAL_VERSION == $ESCAPED_LAST_VERSION ]; then

          echo -e "\e[1;31mLocal version and the last version are identical. Consider\e[0m"
          echo -e "\e[1;31msuggesting a new version according to Semantic Versioning.\n\e[0m"

          exit 1

     fi

     # Check consistency
     run_version_checks

     # Print the number of consistency errors
     if [ "$ERROR_COUNT" -gt 0 ]; then

          echo -e "\e[1;31mSome consistency errors have been found ($ERROR_COUNT)\e[0m\n"
          exit 1

     else

          echo -e "\e[1;36mNo consistency errors.\e[0m\n"

     fi

else

     # Print information
     echo -e "\e[1;36mNo release has been found, version checking will be omitted.\e[0m\n"

fi