#!/bin/bash

print_help() {
  echo "usage: build_device <device> test|sign"
  echo "----------------------------------------------------------------------"
  echo " <device> Device name (amami|h850|osprey|x86)"
  echo "test - build with testkeys (insecure, but compatible)"
  echo "sign - create a signed build"
}

print_device() {
  echo "Building $1 ..."
}


# Check parameters
case "$1" in
  amami|h850|osprey|x86)
     print_device $1
    ;;
  *) print_help
     exit
    ;;
esac
case "$2" in
  test) TESTKEY=true
    ;;
  sign) TESTKEY=false
    ;;
  *) print_help
     exit
    ;;
esac

# Initiate environment
source build/envsetup.sh

# CCache
# ------
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
/usr/bin/ccache -M 75G
/usr/bin/ccache -o compression=true

# Normalize build metadata
export KBUILD_BUILD_USER=android
export KBUILD_BUILD_HOST=localhost
export BUILD_USERNAME=android
export BUILD_HOSTNAME=localhost

#start build
if [ "$TESTKEY" = false ] ; then
  export OWN_KEYS_DIR=~/.android-certs
  export RELEASE_TYPE=UNOFFICIAL-microG-signed

  # We need symlinks to fake the existence of a testkey
  # for the selinux build process
  if [ ! -e $OWN_KEYS_DIR/testkey.pk8 ] ; then
    ln -s $OWN_KEYS_DIR/releasekey.pk8 $OWN_KEYS_DIR/testkey.pk8
    echo "Symlink testkey.pk8 created"
  fi
  if [ ! -e $OWN_KEYS_DIR/testkey.x509.pem ] ; then
    ln -s $OWN_KEYS_DIR/releasekey.x509.pem $OWN_KEYS_DIR/testkey.x509.pem
    echo "Symlink testkey.x509.pem created"
  fi
fi

# Build emulator or device ?
if [ "$1" == "x86" ] ; then
  lunch lineage_x86-userdebug
  mka sdk_addon
else
  brunch $1
fi

