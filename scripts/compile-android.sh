#!/bin/bash

export ANDROID_HOME=/opt/Android/Sdk
export ANDROID_NDK_HOST=linux-x86_64
export ANDROID_NDK_PLATFORM=android-14
export ANDROID_NDK_ROOT=/opt/Android/android-ndk-r16
export ANDROID_NDK_TOOLCHAIN_PREFIX=arm-linux-androideabi
export ANDROID_NDK_TOOLCHAIN_VERSION=4.9
export ANDROID_NDK_TOOLS_PREFIX=arm-linux-androideabi
export ANDROID_SDK_ROOT=/opt/Android/Sdk
export ANDROID_API_VERSION=android-14

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$PATH:$ANDROID_HOME/tools:$JAVA_HOME/bin

export ANDROID_SYSROOT=/opt/Android/android-ndk-r16/platforms/android-14/arch-arm
export CPPFLAGS="--sysroot=$ANDROID_SYSROOT"
export CFLAGS="--sysroot=$ANDROID_SYSROOT"
export CXXFLAGS="--sysroot=$ANDROID_SYSROOT"

/opt/Qt/5.9.3/android_armv7/bin/qmake -r -spec android-g++ xcite.pro
make
make install INSTALL_ROOT=android
/opt/Qt/5.9.3/android_armv7/bin/androiddeployqt --output android --verbose --gradle --input android-libxcite.so-deployment-settings.json

# /opt/Android/Sdk/platform-tools/adb install android/build/outputs/apk/android-debug.apk