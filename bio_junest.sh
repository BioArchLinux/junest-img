#!/bin/bash
# This script checks if git, curl or wget are available and downloads https://github.com/fsquillace/junest.git to ~/.junest

# Check if git is available
#if command -v git &> /dev/null; then
  # Use git to clone the repository
#  git clone https://github.com/fsquillace/junest.git ~/.junest
#  exit 0
#fi

# Check if curl and zip are available
if command -v curl &> /dev/null && command -v zip &> /dev/null; then
  # Use curl to download the repository as a zip file and extract it
  curl -L https://github.com/fsquillace/junest/archive/refs/heads/master.zip -o junest.zip
  unzip junest.zip -d ~/.junest
  rm junest.zip
  exit 0
fi

# Check if wget and zip are available
if command -v wget &> /dev/null && command -v zip &> /dev/null; then
  # Use wget to download the repository as a zip file and extract it
  wget https://github.com/fsquillace/junest/archive/refs/heads/master.zip -O junest.zip
  unzip junest.zip -d ~/.junest
  rm junest.zip
  exit 0
fi

# If none of the commands are available, print an error message and exit with non-zero code
echo "Error: curl/wget or zip are not available on this system."
exit 

