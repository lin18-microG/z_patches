#!/bin/bash

THISDIR=$PWD

cd ..
TOPDIR=$PWD

cd external/Mulch
echo "Patching $PWD (webview module)"
patch -p1 < $THISDIR/patch_007_Mulch.patch
echo "-"
cd $TOPDIR

cd frameworks/base
echo "Patching $PWD (Custom build version)"
patch -p1 < $THISDIR/patch_001_base.patch
echo "-"
cd $TOPDIR

cd packages/apps/Settings
echo "Patching $PWD (NFC system feature)"
patch -p1 < $THISDIR/patch_005_Settings.patch
echo "Patching $PWD (Custom build version)"
patch -p1 < $THISDIR/patch_006_Settings.patch
echo "-"
cd $TOPDIR

cd vendor/lineage
echo "Patching $PWD (build signing method)"
patch -p1 < $THISDIR/patch_002_vendor-lineage.patch
patch -p1 < $THISDIR/patch_003_vendor-lineage.patch
echo "Patching $PWD (Custom build version)"
patch -p1 < $THISDIR/patch_004_vendor-lineage.patch
echo "-"
cd $TOPDIR

cd $THISDIR
