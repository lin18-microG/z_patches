#!/bin/bash

THISDIR=$PWD

cd ..
TOPDIR=$PWD

cd device/common
echo "Patching $PWD (Use https f. common GPS configuration)"
patch -p1 < $THISDIR/patch_050_device-common.patch
echo "-"
cd $TOPDIR

cd $TOPDIR
cd packages/apps/Dialer
echo "Patching $PWD (Remove Google forward lookup)"
patch -p1 < $THISDIR/patch_101_Dialer.patch
echo "-"
cd $TOPDIR

cd $TOPDIR
cd packages/apps/SetupWizard
echo "Patching $PWD (Suggest disabled metrics by default)"
patch -p1 < $THISDIR/patch_102_SetupWizard.patch
echo "-"
cd $TOPDIR

cd $THISDIR
