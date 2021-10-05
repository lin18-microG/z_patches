#!/bin/bash

THISDIR=$PWD

cd ..
TOPDIR=$PWD

cd packages/apps/Settings
echo "Patching $PWD (NFC system feature)"
patch -p1 < $THISDIR/patch_001_Settings.patch
echo "-"
cd $TOPDIR

cd vendor/lineage
echo "Patching $PWD (build signing method)"
patch -p1 < $THISDIR/patch_002_vendor-lineage.patch
patch -p1 < $THISDIR/patch_003_vendor-lineage.patch
echo "-"
cd $TOPDIR

cd $THISDIR
