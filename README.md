# BioArchLinux on junest

## Introduction

[junest](https://github.com/fsquillace/junest) can let users manage the software via pacman under any Linux distributions. Non-root users can use it to install pkgs from BioArchLinux.

## Install

### Requirements

- bash

- coreutils

- git/unzip

- curl/wget

### Install

```
curl -O https://raw.githubusercontent.com/BioArchLinux/junest-img/main/biojunest.sh
```

or 

```
wget https://raw.githubusercontent.com/BioArchLinux/junest-img/main/biojunest.sh
```

then 

```
chmod +x biojunest.sh && ./biojunest.sh
```

### Advanced

You can also configure mirror, for example

```
./biojunest.sh -m="https://mirrors.njupt.edu.cn/mirrors/bioarchlinux"
```

## Usage

You should `source` your `~/.zshrc` or `~/.bashrc` files firstly, for example

```
source ~/.bashrc
```

To enter junest, you can choose one of the following commands

```
junest -f
junest proot -f
```

Then you can enjoy pacman

You can also use `sudoj` to replace `sudo` for using root privilege in host machine, for example

```
sudoj pacman -Syu
```

## Further information

See [here](https://github.com/fsquillace/junest)
