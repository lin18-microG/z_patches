#!/bin/bash

clear_set() {
  cd $1
  echo "Clearing: $PWD"
  git add . > /dev/null
  git stash > /dev/null
  find -name *.orig | while read LINE; do rm $LINE; done
  find -name *.rej | while read LINE; do rm $LINE; done
  git clean -f > /dev/null
  git stash clear > /dev/null
  git stash > /dev/null
  cd $TOPDIR
}

THISDIR=$PWD

cd ..
TOPDIR=$PWD


clear_set external/Mulch
clear_set frameworks/base
clear_set packages/apps/Settings
clear_set vendor/lineage

cd $THISDIR
