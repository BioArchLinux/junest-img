#!/bin/bash
# This script downloads and installs junest with optional mirror and help options

# Define the default mirror url
MIRROR="https://repo.bioarchlinux.org"

# Parse the options using getopts
while getopts "m:h" opt; do
  case $opt in
    m) # Set the mirror url to the argument of -m option
      MIRROR="$OPTARG"
      ;;
    h) # Print the help message and exit
      echo "Usage: ./install [-m MIRROR] [-h]"
      echo "  -m MIRROR  Specify a mirror url to download junest from"
      echo "  -h         Show this help message and exit"
      exit 0
      ;;
    \?) # Print an error message for invalid options and exit
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

# Check if curl and zip are available
if command -v curl &> /dev/null && command -v zip &> /dev/null; then
  # Use curl to download the repository as a zip file and extract it
  curl -L https://github.com/fsquillace/junest/archive/refs/heads/master.zip -o ~/junest.zip
  unzip junest.zip -d ~/.local/share/junest
  rm ~/junest.zip
  curl -L "$MIRROR"/junest/bioarchlinux-junest.tar.gz -o ~/bioarchlinux-junest.tar.gz
  export PATH=~/.local/share/junest/bin:$PATH
  junest s -i  ~/bioarchlinux-junest.tar.gz
  echo "Please add `export PATH=~/.local/share/junest/bin:$PATH` to your .zshrc or .bashrc"
  exit 0
fi

# Check if wget and zip are available
if command -v wget &> /dev/null && command -v zip &> /dev/null; then
  # Use wget to download the repository as a zip file and extract it
  wget https://github.com/fsquillace/junest/archive/refs/heads/master.zip -O junest.zip
  unzip junest.zip -d ~/.local/share/junest
  rm junest.zip
  wget "$MIRROR"/junest/bioarchlinux-junest.tar.gz -O ~/bioarchlinux-junest.tar.gz
  export PATH=~/.local/share/junest/bin:$PATH
  junest s -i  ~/bioarchlinux-junest.tar.gz
  echo "Please add `export PATH=~/.local/share/junest/bin:$PATH` to your .zshrc or .bashrc"
  exit 0
fi

# If none of the commands are available, print an error message and exit with non-zero code
echo "Error: curl/wget or zip are not available on this system."
exit 1

