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

clear_set bionic
clear_set device/common
clear_set external/ant-wireless/ant_native
clear_set external/chromium-webview/patches
clear_set external/conscrypt
clear_set external/icu
clear_set external/neven
clear_set external/openssh
clear_set frameworks/ex
clear_set frameworks/opt/net/voip
clear_set frameworks/rs
clear_set hardware/qcom-caf/common
clear_set lineage-sdk
clear_set packages/apps/Dialer
clear_set packages/apps/FMRadio
clear_set packages/apps/Gallery2
clear_set packages/apps/PermissionController
clear_set packages/apps/SetupWizard
clear_set system/bt
clear_set system/extras
clear_set system/sepolicy
clear_set vendor/nxp/opensource/commonsys/packages/apps/Nfc
clear_set vendor/qcom/opensource/fm-commonsys
clear_set vendor/qcom/opensource/libfmjni

cd $THISDIR
