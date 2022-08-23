#!/bin/bash

list_repos() {
cat <<EOF
external/ant-wireless/ant_native:patch_702_ant-wireless.patch
external/conscrypt:patch_703_conscrypt.patch
external/icu:patch_704_icu.patch
external/neven:patch_705_neven.patch
frameworks/rs:patch_706_rs.patch
frameworks/ex:patch_707_ex.patch
frameworks/opt/net/voip:patch_708_voip.patch
hardware/qcom-caf/common:patch_709_qc-common.patch
lineage-sdk:patch_710_lineage-sdk.patch
packages/apps/FMRadio:patch_711_FMRadio.patch
packages/apps/Gallery2:patch_712_Gallery2.patch
vendor/qcom/opensource/fm-commonsys:patch_716_fm-commonsys.patch
vendor/nxp/opensource/commonsys/packages/apps/Nfc:patch_717_nxp-Nfc.patch
vendor/qcom/opensource/libfmjni:patch_718_libfmjni.patch
EOF
}


THISDIR=$PWD

cd ..
TOPDIR=$PWD

cd bionic
echo "Patching $PWD (GmsCompat)"
patch -p1 < $THISDIR/patch_300_bionic.patch
echo "-"
cd $TOPDIR

cd device/common
echo "Patching $PWD (Use https f. common GPS configuration)"
patch -p1 < $THISDIR/patch_050_device-common.patch
echo "-"
cd $TOPDIR

cd frameworks/base
echo "Patching $PWD (LowRAM - disable exec spawning by default)"
patch -p1 < $THISDIR/patch_200_base.patch
echo "-"
cd $TOPDIR

cd packages/apps/Settings
echo "Patching $PWD (LowRAM - disable exec spawning by default)"
patch -p1 < $THISDIR/patch_201_Settings.patch
echo "-"
cd $TOPDIR

cd packages/apps/Dialer
echo "Patching $PWD (Remove Google forward lookup)"
patch -p1 < $THISDIR/patch_101_Dialer.patch
echo "-"
cd $TOPDIR

cd packages/apps/PermissionController
echo "Patching $PWD (Privacy Indicators)"
patch -p1 < $THISDIR/patch_103_PermissionController.patch
echo "-"
cd $TOPDIR

cd packages/apps/SetupWizard
echo "Patching $PWD (Suggest disabled metrics by default)"
patch -p1 < $THISDIR/patch_102_SetupWizard.patch
echo "-"
cd $TOPDIR

cd system/sepolicy
echo "Patching $PWD (remove gmscore_app context)"
patch -p1 < $THISDIR/patch_301_sepolicy.patch
echo "-"
cd $TOPDIR


list_repos | while read STR; do
  DIR=$(echo $STR | cut -f1 -d:)
  PTC=$(echo $STR | cut -f2 -d:)
  cd $DIR
  echo "Constify JNI method tables: $DIR"
  patch -p1 < $THISDIR/$PTC
  cd $TOPDIR
done


cd $THISDIR
