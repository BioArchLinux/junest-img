#!/bin/bash
# This script downloads and installs junest with optional mirror and help options

# Define the default mirror url
procarg () {
  MIRROR="https://repo.bioarchlinux.org"
 
  for arg in "$@"; do
    case $arg in
      -h) 
        echo "Usage: biojunest [-arguments]"
        echo "Options:"
        echo "  -h,  show this help message and exit"
        echo "  -m,  set the mirror value"
	echo "       example: -m=\"https://repo.bioarchlinux.org\""
	break
        return
        ;;
      -m=*) 
        MIRROR="${arg#*=}"
        ;;
      *)
        echo "Invalid option: -$OPTARG" >&2
	break
	return
        ;;
    esac
  done
  echo "$MIRROR"
}


get_command (){
  local cmdtype=""
  if command -v unzip &> /dev/null; then
    if command -v curl &> /dev/null; then
      cmdtype="zipcurl"
    elif command -v wget &> /dev/null; then
      cmdtype="zipwget"
    else
      echo "Error: curl or wget can\'t be found"
      return 1
    fi  
  elif command -v git &> /dev/null; then
    if command -v curl &> /dev/null; then
      cmdtype="gitcurl"
    elif command -v wget &> /dev/null; then
      cmdtype="gitwget"
    else
      echo "Error: curl or wget can\'t be found"
      return 1
    fi  
  else 
    echo "Error: unzip or git can\'t be found"
    return 1
  fi
  echo "$cmdtype"
}


proc_junest (){
if [ "$1" = "zipcurl" ]  || [ "$1" = "zipwget" ] ; then
  if "$1" = "zipcurl"; then
    curl -L https://github.com/fsquillace/junest/archive/refs/heads/master.zip -o ~/junest.zip
  elif "$1" = "zipwget"; then
    wget https://github.com/fsquillace/junest/archive/refs/heads/master.zip -O ~/junest.zip
  else
    return 1
  fi
  unzip ~/junest.zip -d ~/.local/share/junest
  rm ~/junest.zip
elif [ "$1" = "gitcurl" ] || [ "$1" = "gitwget" ]; then
  git clone https://github.com/fsquillace/junest.git ~/.local/share/junest
else 
  echo "Error: Download junest!"
  return 1
fi
}

proc_img(){
if [ "$1" = "gitcurl" ] || [ "$1" = "zipcurl" ]
then
	curl -L "$2"/junest/bioarchlinux-junest.tar.gz -o ~/bioarchlinux-junest.tar.gz
elif [ "$1" = "gitwget" ] || [ "$1" = "zipwget" ]
then
	wget "$2"/junest/bioarchlinux-junest.tar.gz -O ~/bioarchlinux-junest.tar.gz
else
	echo "Error:Download bioarchlinux img"
	return 1
fi
	export PATH=~/.local/share/junest/bin:$PATH
	junest s -i  ~/bioarchlinux-junest.tar.gz
	rm ~/bioarchlinux-junest.tar.gz
}

set_env () {
  
  lines="PATH=\"\$PATH:~/.local/share/junest/bin:~/.junest/usr/bin_wrappers\"
JUNEST_ARGS=\"ns\""

if [ -z "$JUNEST_ARGS" ]; then
  if [ -f "$1" ]; then
    echo "$lines" >> "$1"
    source "$1"
  fi
fi
}

MIRROR=$(procarg "$@") 
cmdtype=$(get_command)
proc_junest "$cmdtype"
proc_img "$cmdtype" "$MIRROR"
set_env ~/.bashrc
set_env ~/.zshrc
