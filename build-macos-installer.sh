#!/bin/bash

QT_DIR=""
ARCHIVE_DIR="${PWD}/packages/global.xtrabytes.xcite"
VERSION=$(grep -oPm1 "(?<=<Version>)[^<]+" "${ARCHIVE_DIR}/meta/package.xml")
ARCHIVE_PATH="${ARCHIVE_DIR}/data/XCITE-${VERSION}-macos.7z"
INSTALLER_PATH="${PWD}/XCITE-${VERSION}-MacOS.exe"

echo -e "\nXCITE Mac OS installer creator\n"

if [[ "$QT_DIR" = "" ]]; then
	echo "Modify your QT installation folder to script"
	exit 1
fi

if [[ ! -f ${PWD}/xcite.pro ]]; then
	echo "Run this script from the xcite directory"
	exit 1
fi

for i in tools/archivegen tools/binarycreator; do
	command -v $i >/dev/null 2>&1 || { echo >&2 "${i} is required but is not in your path, aborting."; exit 1; }
done

echo "Building version ${VERSION}..."

rm -f $ARCHIVE_PATH
rm -f $INSTALLER_PATH

pushd .
cd build/release && \
	mv xcite.app /tmp/ && \
	rm -rf * && \
	mv /tmp/xcite.app . && \
	"$QT_DIR"/macdeployqt xcite.app && \
	cp ../../support/{lib,ssl}eay32.dll . && \
	../../tools/archivegen "${ARCHIVE_PATH}" . && \
	popd && \
	tools/binarycreator -c config/config.xml -p packages XCITE-${VERSION}-MacOS.app
