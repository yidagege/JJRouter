#!/bin/sh
#默认ARCH=Release KEEP_INCLUDE_DIR="" [KeepDir]
XBUILD="/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild"
PROJECT_ROOT=$(pwd)
PROJECT="$PROJECT_ROOT/JJRouterEngine.xcodeproj"
TARGET="JJRouterEngine"
PRODUCT="$PROJECT_ROOT/product"
ARCH="Release"

trunk_path=$1

lib_path=$2

mkdir -p "$PRODUCT"

#libi386.a:
$XBUILD -project $PROJECT -target $TARGET -sdk iphonesimulator -configuration $ARCH clean build
if [[ $? -ne 0 ]]; then
	exit -1
fi
cp $PROJECT_ROOT/build/$ARCH-iphonesimulator/lib$TARGET.a "./lib_i386.a"

#libArmv7.a:
$XBUILD -project $PROJECT -target $TARGET -sdk iphoneos -arch armv7 -configuration $ARCH clean build
if [[ $? -ne 0 ]]; then
	exit -1
fi
cp $PROJECT_ROOT/build/$ARCH-iphoneos/lib$TARGET.a "./lib_armv7.a"

#libArm64.a:
$XBUILD -project $PROJECT -target $TARGET -sdk iphoneos -arch arm64 -configuration $ARCH clean build
if [[ $? -ne 0 ]]; then
	exit -1
fi
cp $PROJECT_ROOT/build/$ARCH-iphoneos/lib$TARGET.a "./lib_arm64.a"

#libUniversal.a: libi386.a libArmv7.a libArmv7s.a libArm64.a
lipo -create "./lib_i386.a"  "./lib_armv7.a" "./lib_arm64.a" -output "${PRODUCT}/lib${TARGET}.a"
if [[ $? -ne 0 ]]; then
	exit -1
fi

#cp headers 
rm -Rf "$PRODUCT/include"
mkdir -p "$PRODUCT/include"

find $PROJECT_ROOT/build/$ARCH-iphoneos/ -iname "*.h" -exec cp {} "$PRODUCT/include" \;

#clean:
rm -f "./lib_i386.a"  "./lib_armv7.a"  "./lib_arm64.a"
#rm -rf build

#CP
lib_path="$trunk_path/lib/JJRouterEngine"
echo "拷贝到:$lib_path"
cp -R product/include "$lib_path"
cp product/*.a "$lib_path/"$ARCH
echo "拷贝完成"
