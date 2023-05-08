#!/bin/bash

cd /usr/share/lilac/junest
git pull

./gen_junest.sh

rm /usr/share/lilac/Repo/junest/*
mv bioarchlinux-junest.tar.gz /usr/share/lilac/Repo/junest/

rm /usr/share/lilac/junest/bioarchlinux-junest.tar*
