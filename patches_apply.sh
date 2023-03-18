#!/bin/bash

THISDIR=$PWD

cd ..
TOPDIR=$PWD

cd external/Mulch
echo "Patching $PWD (webview module)"
patch -p1 < $THISDIR/patch_004_Mulch.patch
echo "-"
cd $TOPDIR

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
