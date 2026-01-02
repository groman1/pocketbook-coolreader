#!/bin/bash

# CD to the current script path
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
PBDEV_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )/../../"

# Set current build date
DATE="`cat cr3gui/src/cr3pocketbook.h | grep CR_PB_BUILD_DATE | awk '{print $3}' | sed -e s/\\\"//g`"
if [ "$DATE" != "`date +"%Y-%m-%d"`" ]; then
    sed -i "s/CR_PB_BUILD_DATE \"[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]\"/CR_PB_BUILD_DATE \"`date +"%Y-%m-%d"`\"/g" cr3gui/src/cr3pocketbook.h
fi
if [ ! -f "$PBDEV_DIR/FRSCSDK/arm-none-linux-gnueabi/sysroot/usr/lib/libinkview.1.1a.so" ]; then
	echo
	echo 'Invalid SDK structure!'
	echo
	echo 'libinkview.so is in FRSCSDK/arm-none-linux-gnueabi/sysroot/usr/lib/'
	echo '  For pro4 you have to add libinkview.pb626.fw4.4.so from a FW4 device to the lib dir'
	echo '  (a symlink is created by make.sh when needed)'
	echo
	exit
fi

curDir="`pwd`"
cd "$PBDEV_DIR/FRSCSDK/arm-none-linux-gnueabi/sysroot/usr/lib"
rm -f libinkview.so
ln -s libinkview.pb626.fw4.4.so libinkview.so
cd "$curDir"

if [ -f pbpro4/cr3gui/cr3-pb.app ]; then
	echo 'Remove previous build'
	rm -f pbpro4/cr3gui/cr3-pb.app
fi

mkdir -p pbpro4
cd pbpro4
cmake \
	-D CMAKE_TOOLCHAIN_FILE=../tools/toolchain-arm-gnu-eabi-pocketbook.cmake \
	-D TARGET_TYPE=ARM \
	-D DEVICE_NAME=pb360 \
	-D MAX_IMAGE_SCALE_MUL=2 \
	-D CMAKE_BUILD_TYPE=Release \
	-D ENABLE_CHM=1 \
	-D ENABLE_ANTIWORD=1 \
	-D GUI=CRGUI_PB \
	-D ENABLE_PB_DB_STATE=1 \
	-D BACKGROUND_CACHE_FILE_CREATION=1 \
	-D POCKETBOOK_PRO=1 \
	-D CR3_JPEG=1 \
	-D CMAKE_POLICY_VERSION_MINIMUM=3.5 \
	..
make

cd ..
if [ -f pbpro4/cr3gui/cr3-pb.app ]; then
	echo 'Strip binary'
	"$PBDEV_DIR/FRSCSDK/bin/arm-none-linux-gnueabi-strip" "pbpro4/cr3gui/cr3-pb.app"
else
	echo 'Failed compiling binary!'
	exit
echo 'Done'

bash updateReleases.sh
fi
